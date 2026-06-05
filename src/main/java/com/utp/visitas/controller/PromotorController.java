package com.utp.visitas.controller;

import java.nio.file.Paths;
import java.io.File;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import com.utp.visitas.dao.*;
import com.utp.visitas.model.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "PromotorController", urlPatterns = {"/PromotorController"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class PromotorController extends HttpServlet {

    private final InstitutoDAO institutoDAO = new InstitutoDAO();
    private final VisitaDAO visitaDAO = new VisitaDAO();
    private final CharlaDAO charlaDAO = new CharlaDAO();
    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("login.html");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (!usuario.getRol().equals("Promotor")) {
            response.sendRedirect("login.html?error=acceso_denegado");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listarColegios";

        switch (accion) {
            case "listarColegios": {
                List<Instituto> misColegios = institutoDAO.listarPorPromotor(usuario.getId());
                request.setAttribute("listaColegios", misColegios);
                request.getRequestDispatcher("promotor/lista_instituciones.jsp").forward(request, response);
                break;
            }

            case "guardarVisita": {
                int idInstituto = Integer.parseInt(request.getParameter("id_instituto"));
                String fecha = request.getParameter("fecha_visita");
                String estado = request.getParameter("estado_visita");
                String obs = request.getParameter("observaciones");
                String fechaCharla = request.getParameter("fecha_charla_pactada");
                String nomDir = request.getParameter("nombre_director");
                String telDir = request.getParameter("telefono_director");

                Visita v = new Visita();
                v.setIdPromotor(usuario.getId());
                v.setIdInstituto(idInstituto);
                v.setFechaVisita(fecha);
                v.setResultadoGestion(estado);
                v.setObservaciones(obs);
                v.setFechaCharlaPactada(fechaCharla);

                if (visitaDAO.registrarVisita(v, nomDir, telDir)) {
                    response.sendRedirect("PromotorController?accion=listarColegios&mensaje=exito");
                } else {
                    response.sendRedirect("promotor/registrar_visita.jsp?id=" + idInstituto + "&error=fallo");
                }
                break;
            }

            case "guardarCharla": {
            int idInstCharla = Integer.parseInt(request.getParameter("id_instituto"));
            // Captura de datos de charla
            Charla nuevaCharla = new Charla();
            nuevaCharla.setFechaCharla(request.getParameter("fecha_charla"));
            nuevaCharla.setHoraInicio(request.getParameter("hora_inicio"));
            nuevaCharla.setHoraFin(request.getParameter("hora_fin"));
            nuevaCharla.setTema(request.getParameter("tema"));
            nuevaCharla.setObservaciones(request.getParameter("observaciones"));

            // Captura de datos adicionales
            String nomDocente = request.getParameter("nombre_docente");
            String celDocente = request.getParameter("celular_docente");
            String seccion = request.getParameter("seccion");
            String turno = request.getParameter("turno");
            int cantAlumnos = Integer.parseInt(request.getParameter("cantidad_estudiantes"));

            boolean registrado = charlaDAO.registrarCharlaCompleta(nuevaCharla, idInstCharla, usuario.getId(), 
                                                                   nomDocente, celDocente, seccion, turno, cantAlumnos);

            if (registrado) {
                response.sendRedirect("PromotorController?accion=listarColegios&mensaje=charla_exito");
            } else {
                response.sendRedirect("promotor/registrar_charla.jsp?id=" + idInstCharla + "&error=fallo");
            }
            break;
        }

            case "guardarEvidencia": {
                int idInstEvidencia = Integer.parseInt(request.getParameter("id_instituto"));
                String latitud = request.getParameter("latitud");
                String longitud = request.getParameter("longitud");
                String comentarios = request.getParameter("comentarios");

                Part part = request.getPart("foto_evidencia");
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "evidencias";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                part.write(uploadPath + File.separator + uniqueFileName);

                boolean evRegistrada = visitaDAO.registrarEvidencia(usuario.getId(), idInstEvidencia, latitud, longitud, uniqueFileName, comentarios);
                if (evRegistrada) {
                    response.sendRedirect("PromotorController?accion=listarColegios&mensaje=evidencia_exito");
                } else {
                    response.sendRedirect("promotor/capturar_evidencia.jsp?id=" + idInstEvidencia + "&error=fallo");
                }
                break;
            }

            case "verDashboard": {
                int visitasHoy = dashboardDAO.getVisitasHoyPorPromotor(usuario.getId());
                int totalFichas = dashboardDAO.getTotalColegiosPorPromotor(usuario.getId());
                int metaAvance = dashboardDAO.getTotalVisitasHistoricasPorPromotor(usuario.getId());

                request.setAttribute("visitasHoy", visitasHoy);
                request.setAttribute("totalFichas", totalFichas);
                request.setAttribute("metaAvance", metaAvance);
                request.getRequestDispatcher("promotor/inicio_promotor.jsp").forward(request, response);
                break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}