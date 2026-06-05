package com.utp.visitas.controller;

import java.nio.file.Paths;
import java.io.File;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import com.utp.visitas.dao.InstitutoDAO;
import com.utp.visitas.model.Instituto;
import com.utp.visitas.model.Usuario;
import com.utp.visitas.dao.VisitaDAO;
import com.utp.visitas.model.Visita;
import com.utp.visitas.dao.CharlaDAO;
import com.utp.visitas.model.Charla;
import com.utp.visitas.dao.DashboardDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PromotorController", urlPatterns = {"/PromotorController"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB memoria temporal
    maxFileSize = 1024 * 1024 * 10,       // 10MB máximo por foto
    maxRequestSize = 1024 * 1024 * 50     // 50MB máximo en total
)
public class PromotorController extends HttpServlet {

    private final InstitutoDAO institutoDAO = new InstitutoDAO();
    private final VisitaDAO visitaDAO = new VisitaDAO();
    private final CharlaDAO charlaDAO = new CharlaDAO();
    private final DashboardDAO dashboardDAO = new DashboardDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Validar que la sesión exista y que el usuario sea realmente un Promotor
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

        // 2. Extraer la acción que el usuario quiere realizar
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listarColegios"; // Acción por defecto

        // 3. Ejecutar la lógica de negocio según la acción
        switch (accion) {
            case "listarColegios":
                // Pedimos al DAO la lista de colegios asignados al ID de este promotor
                List<Instituto> misColegios = institutoDAO.listarPorPromotor(usuario.getId());
                
                // Empaquetamos la lista en la petición HTTP para enviarla a la vista (JSP)
                request.setAttribute("listaColegios", misColegios);
                
                // Redirigimos a la pantalla del celular del promotor
                request.getRequestDispatcher("promotor/lista_instituciones.jsp").forward(request, response);
                break;
            
            case "guardarVisita":
                // 1. Recolectar datos del formulario
                int idInstituto = Integer.parseInt(request.getParameter("id_instituto"));
                String fecha = request.getParameter("fecha_visita");
                String estadoVisita = request.getParameter("estado_visita");
                String observaciones = request.getParameter("observaciones");

                // 2. Llenar el objeto Visita
                Visita nuevaVisita = new Visita();
                nuevaVisita.setIdPromotor(usuario.getId()); // Extraído de la sesión activa
                nuevaVisita.setIdInstituto(idInstituto);
                nuevaVisita.setFechaVisita(fecha);
                nuevaVisita.setResultadoGestion(estadoVisita);
                nuevaVisita.setObservaciones(observaciones);

                // 3. Enviar a MySQL
                boolean registrado = visitaDAO.registrarVisita(nuevaVisita);

                if (registrado) {
                    // Redirigimos a la lista de colegios recargada
                    response.sendRedirect("PromotorController?accion=listarColegios&mensaje=exito");
                } else {
                    response.sendRedirect("promotor/registrar_visita.jsp?id=" + idInstituto + "&error=fallo_registro");
                }
                break;
                
                case "guardarCharla":
                // 1. Recolectar datos del formulario
                int idInstCharla = Integer.parseInt(request.getParameter("id_instituto"));
                String fechaCharla = request.getParameter("fecha_charla");
                String horaInicio = request.getParameter("hora_inicio");
                String horaFin = request.getParameter("hora_fin");
                String tema = request.getParameter("tema");
                String obsCharla = request.getParameter("observaciones");

                // 2. Llenar el objeto Charla
                Charla nuevaCharla = new Charla();
                nuevaCharla.setFechaCharla(fechaCharla);
                nuevaCharla.setHoraInicio(horaInicio);
                nuevaCharla.setHoraFin(horaFin);
                nuevaCharla.setTema(tema);
                nuevaCharla.setObservaciones(obsCharla);

                // 3. Enviar a MySQL usando la transacción doble
                boolean charlaRegistrada = charlaDAO.registrarCharlaConVisita(nuevaCharla, idInstCharla, usuario.getId());

                if (charlaRegistrada) {
                    response.sendRedirect("PromotorController?accion=listarColegios&mensaje=charla_exito");
                } else {
                    response.sendRedirect("promotor/registrar_charla.jsp?id=" + idInstCharla + "&error=fallo_charla");
                }
                break;
                
                case "guardarEvidencia":
                int idInstEvidencia = Integer.parseInt(request.getParameter("id_instituto"));
                String latitud = request.getParameter("latitud");
                String longitud = request.getParameter("longitud");
                String comentarios = request.getParameter("comentarios");

                // 1. Procesar el archivo físico (La Foto)
                Part part = request.getPart("foto_evidencia");
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

                // 2. Definir la carpeta donde se guardarán las fotos (se crea automáticamente en tu Tomcat)
                String uploadPath = getServletContext().getRealPath("") + File.separator + "evidencias";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // Si la carpeta no existe, la crea
                }

                // 3. Generar un nombre único para evitar que las fotos se sobreescriban
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                
                // 4. Guardar la foto en el disco duro del servidor
                part.write(uploadPath + File.separator + uniqueFileName);

                // 5. Guardar los datos y la ruta en MySQL
                boolean evRegistrada = visitaDAO.registrarEvidencia(usuario.getId(), idInstEvidencia, latitud, longitud, uniqueFileName, comentarios);

                if (evRegistrada) {
                    response.sendRedirect("PromotorController?accion=listarColegios&mensaje=evidencia_exito");
                } else {
                    response.sendRedirect("promotor/capturar_evidencia.jsp?id=" + idInstEvidencia + "&error=fallo");
                }
                break;
                
                case "verDashboard":
                // 1. Obtener los totales del DAO usando el ID del promotor logueado
                int visitasHoy = dashboardDAO.getVisitasHoyPorPromotor(usuario.getId());
                int totalFichas = dashboardDAO.getTotalColegiosPorPromotor(usuario.getId());
                int metaAvance = dashboardDAO.getTotalVisitasHistoricasPorPromotor(usuario.getId());

                // 2. Empaquetar los datos para la vista (JSP)
                request.setAttribute("visitasHoy", visitasHoy);
                request.setAttribute("totalFichas", totalFichas);
                request.setAttribute("metaAvance", metaAvance);

                // 3. Redirigir a la pantalla de inicio del promotor
                request.getRequestDispatcher("promotor/inicio_promotor.jsp").forward(request, response);
                break;
            // Aquí agregaremos más casos futuros (ej. registrarCharla, verDetalle)
        }
    }

    // Solución para recibir los datos del formulario web (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirigimos la petición POST hacia nuestro doGet para centralizar la lógica
        doGet(request, response);
    }
}