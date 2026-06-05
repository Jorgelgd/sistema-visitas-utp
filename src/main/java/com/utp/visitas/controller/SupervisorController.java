package com.utp.visitas.controller;

import com.utp.visitas.dao.DashboardDAO;
import org.apache.commons.codec.digest.DigestUtils;
import com.utp.visitas.dao.InstitutoDAO;
import com.utp.visitas.model.ReporteConsolidado;
import com.utp.visitas.model.Promotor;
import com.utp.visitas.model.UbicacionPromotor;
import java.util.List;
import com.utp.visitas.model.MonitoreoCampo;
import com.utp.visitas.dao.SupervisorDAO;
import com.utp.visitas.model.Instituto;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SupervisorController", urlPatterns = {"/SupervisorController"})
public class SupervisorController extends HttpServlet {

    // Instanciamos el motor que acabamos de crear
    private final SupervisorDAO supervisorDAO = new SupervisorDAO();
    private final DashboardDAO dashboardDAO = new DashboardDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "verDashboard"; // Acción por defecto si entran directo
        }

        switch (accion) {
            case "verDashboard":
                // 1. Extraer los 4 indicadores reales de la Base de Datos
                int personalActivo = supervisorDAO.getPersonalActivoHoy();
                int totalColegios = supervisorDAO.getTotalColegiosAuditados();
                int alertasActivas = supervisorDAO.getAlertasActivas();
                int metaGlobal = supervisorDAO.getTotalVisitasGlobales();

                // --- CÁLCULOS GERENCIALES ---
                // Supongamos que la meta total de la empresa es 10,000 visitas
                int metaObjetivo = 10000; 
                double porcentajeMeta = (metaGlobal * 100.0) / metaObjetivo;
                if (porcentajeMeta > 100) porcentajeMeta = 100; // Tope máximo

                // Supongamos que tienes 15 promotores contratados en total (como en tu maqueta "14 / 15")
                int totalPromotores = 15; 

                // 2. Empaquetar los datos para enviarlos a la pantalla
                request.setAttribute("personalActivo", personalActivo);
                request.setAttribute("totalPromotores", totalPromotores);
                request.setAttribute("totalColegios", totalColegios);
                request.setAttribute("alertasActivas", alertasActivas);
                // Enviamos el porcentaje formateado a 1 decimal (ej. "82.4")
                request.setAttribute("porcentajeMeta", String.format("%.1f", porcentajeMeta).replace(",", ".")); 
                
                // Traer la lista de las últimas visitas
                List<MonitoreoCampo> ultimasVisitas = supervisorDAO.getUltimasVisitas();
                request.setAttribute("ultimasVisitas", ultimasVisitas);
                // 3. Redirigir a la vista del supervisor
                request.getRequestDispatcher("supervisor/dashboard_supervisor.jsp").forward(request, response);
                break;
                
                //Monitoreo de promotores
                case "verMonitoreoGPS":
                // 1. Extraemos la lista de coordenadas del motor (DAO)
                List<UbicacionPromotor> listaUbicaciones = supervisorDAO.getUbicacionesHoy();
                
                // 2. Empaquetamos la lista para enviarla a la vista
                request.setAttribute("listaUbicaciones", listaUbicaciones);
                
                // 3. Redirigimos a la pantalla del mapa
                request.getRequestDispatcher("supervisor/control_geolocalizacion.jsp").forward(request, response);
                break;
                
                case "verPersonal":
                List<Promotor> listaPersonal = supervisorDAO.getListaPromotores();
                request.setAttribute("listaPersonal", listaPersonal);
                request.getRequestDispatcher("supervisor/gestion_usuarios.jsp").forward(request, response);
                break;
                
                case "verReportes":
                List<ReporteConsolidado> listaReportes = supervisorDAO.getReporteMetas();
                request.setAttribute("listaReportes", listaReportes);
                request.getRequestDispatcher("supervisor/reportes_consolidado.jsp").forward(request, response);
                break;
                
                case "verAsignacion":
                // 1. Obtenemos el ID del promotor que viene del enlace del maletín
                int idPromotor = Integer.parseInt(request.getParameter("idPromotor"));
                
                // 2. Traemos al promotor (para mostrar su nombre) y los colegios libres
                Promotor p = supervisorDAO.getPromotorPorId(idPromotor); // Necesitarás este método en DAO
                List<Instituto> colegiosLibres = supervisorDAO.getColegiosLibres();
                
                request.setAttribute("promotor", p);
                request.setAttribute("listaColegios", colegiosLibres);
                request.getRequestDispatcher("supervisor/asignar_colegios.jsp").forward(request, response);
                break;  
                
                case "guardarAsignacion":
                int idPro = Integer.parseInt(request.getParameter("idPromotor"));
                String[] colegiosSeleccionados = request.getParameterValues("idColegios");

                if (colegiosSeleccionados != null) {
                    for (String idCol : colegiosSeleccionados) {
                        // Usa el DAO para actualizar cada colegio seleccionado
                        supervisorDAO.asignarColegio(idPro, Integer.parseInt(idCol));
                    }
                }

                // REDIRECCIÓN CORREGIDA
                response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verPersonal");
                break;
                
                case "verColegios":
                InstitutoDAO daoColegios = new InstitutoDAO();
                List<Instituto> listaColegios = daoColegios.listarTodo();
                request.setAttribute("listaCompleta", listaColegios);
                request.getRequestDispatcher("supervisor/gestion_instituciones.jsp").forward(request, response);
                break;
                
                case "prepararRegistro":
                // Esta línea le indica al servidor que entregue el archivo JSP al usuario
                request.getRequestDispatcher("supervisor/registro_colegio.jsp").forward(request, response);
                break;
                
                case "cambiarEstadoColegio":
                    // 1. Capturamos los datos que vienen desde el botón en el JSP
                    int idEstado = Integer.parseInt(request.getParameter("id"));
                    String nuevoEstado = request.getParameter("nuevoEstado");

                    // 2. Instanciamos el DAO y llamamos al método que hará el UPDATE
                    InstitutoDAO daoEstado = new InstitutoDAO();
                    daoEstado.cambiarEstado(idEstado, nuevoEstado); // *Nota: Deberás crear este método en tu DAO

                    // 3. Recargamos la vista del catálogo para que el supervisor vea el cambio inmediatamente
                    response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verColegios");
                    break;

                case "editarColegio":
                    // 1. Capturamos el ID del colegio que el supervisor seleccionó
                    int idEditar = Integer.parseInt(request.getParameter("id"));

                    // 2. Buscamos todos los datos de ese colegio usando el método que creamos en el DAO
                    InstitutoDAO daoEditar = new InstitutoDAO();
                    Instituto colegioAEditar = daoEditar.obtenerPorId(idEditar);

                    // 3. Empaquetamos el colegio y lo enviamos a la vista
                    request.setAttribute("colegio", colegioAEditar);

                    // 4. Abrimos la pantalla de edición (¡CON LA RUTA CORREGIDA!)
                    request.getRequestDispatcher("supervisor/editar_colegio.jsp").forward(request, response);
                    break;
                    
                case "actualizarColegio":
                // 1. Capturamos los datos que vienen desde editar_colegio.jsp
                int idActualizar = Integer.parseInt(request.getParameter("id_instituto"));
                String nomEdit = request.getParameter("nombre_instituto");
                String tipoEdit = request.getParameter("tipo_instituto");
                String provEdit = request.getParameter("provincia");
                String distEdit = request.getParameter("distrito");
                String dirEdit = request.getParameter("direccion");
                String telEdit = request.getParameter("telefono");
                String corrEdit = request.getParameter("correo");
                String prioEdit = request.getParameter("prioridad");
                String estEdit = request.getParameter("estado");

                // 2. Empaquetamos todo en el objeto
                Instituto instEditado = new Instituto();
                instEditado.setIdInstituto(idActualizar);
                instEditado.setNombreInstituto(nomEdit);
                instEditado.setTipo(tipoEdit);
                instEditado.setProvincia(provEdit);
                instEditado.setDistrito(distEdit);
                instEditado.setDireccion(dirEdit);
                instEditado.setTelefono(telEdit);
                instEditado.setCorreo(corrEdit);
                instEditado.setPrioridad(prioEdit);
                instEditado.setEstado(estEdit);

                // 3. Enviamos a la base de datos usando nuestro nuevo método
                InstitutoDAO daoActualizar = new InstitutoDAO();
                boolean editado = daoActualizar.actualizar(instEditado);

                // 4. Si se edita bien, volvemos a la lista de colegios
                if (editado) {
                    response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verColegios");
                } else {
                    System.out.println("Error al intentar hacer el UPDATE en la BD");
                    // Si hay error, regresamos al catálogo para evitar que la pantalla se quede en blanco
                    response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verColegios");
                }
                break;
                    
                    case "registrarColegio":
                    // 1. Capturar los datos enviados por el formulario JSP
                    String nombre = request.getParameter("nombre_instituto");
                    String tipo = request.getParameter("tipo_instituto");
                    String distrito = request.getParameter("distrito");
                    String direccion = request.getParameter("direccion");
                    String telefono = request.getParameter("telefono");
                    String correo = request.getParameter("correo");
                    String prioridad = request.getParameter("prioridad");
                    String provincia = request.getParameter("provincia");

                    // Como acordamos, el estado al registrar siempre será "Activo" por defecto
                    String estado = "Activo"; 

                    // 2. Empaquetar la información en nuestro objeto
                    Instituto nuevoInst = new Instituto();
                    nuevoInst.setNombreInstituto(nombre);
                    nuevoInst.setTipo(tipo);
                    nuevoInst.setDistrito(distrito);
                    nuevoInst.setDireccion(direccion);
                    nuevoInst.setTelefono(telefono);
                    nuevoInst.setCorreo(correo);
                    nuevoInst.setPrioridad(prioridad);
                    nuevoInst.setEstado(estado);
                    nuevoInst.setProvincia(provincia);

                    // 3. Enviar a la base de datos usando el DAO
                    InstitutoDAO daoGuardar = new InstitutoDAO();
                    boolean exito = daoGuardar.registrar(nuevoInst);

                    // 4. Redirigir según el resultado
                    if (exito) {
                        // Si se guardó, volvemos a la tabla para ver el nuevo colegio
                        response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verColegios");
                    } else {
                        // Si falló, lo imprimimos en consola para depurar y volvemos al formulario
                        System.out.println("Ocurrió un error al intentar hacer el INSERT en la base de datos.");
                        response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=prepararRegistro");
                    }
                    break;
                    
                    case "registrarPromotor":
                    // 1. Capturar los datos del JSP
                    String dniPromotor = request.getParameter("dni");
                    String nomPromotor = request.getParameter("nombres");
                    String apePromotor = request.getParameter("apellidos");
                    String celPromotor = request.getParameter("celular");
                    String correoPromotor = request.getParameter("correo");
                    String provPromotor = request.getParameter("provincia");

                    // --- NUEVO: Extraer el ID del supervisor de la sesión ---
                    // (Le ponemos 1 por defecto por si haces pruebas sin iniciar sesión)
                    int idSupLogueado = 1; 
                    if (request.getSession().getAttribute("idSupervisor") != null) {
                        idSupLogueado = (int) request.getSession().getAttribute("idSupervisor");
                    }
                    // --------------------------------------------------------

                    // 2. Empaquetar en el objeto Promotor
                    Promotor nuevoPromotor = new Promotor();

                    nuevoPromotor.setIdSupervisor(idSupLogueado); // <-- ¡Aquí le asignamos el jefe!

                    nuevoPromotor.setDni(dniPromotor);
                    nuevoPromotor.setNombres(nomPromotor);
                    nuevoPromotor.setApellidos(apePromotor);
                    nuevoPromotor.setCelular(celPromotor);
                    nuevoPromotor.setCorreo(correoPromotor);
                    nuevoPromotor.setProvincia(provPromotor);
                    nuevoPromotor.setEstado("Activo");
                    // Por defecto, su primera contraseña será su DNI
                    String contrasenaHasheada = DigestUtils.sha256Hex(dniPromotor);
                    nuevoPromotor.setContrasena(contrasenaHasheada);

                    // 3. Mandar a guardar a la BD
                    SupervisorDAO daoRegistro = new SupervisorDAO();
                    boolean promotorGuardado = daoRegistro.registrarPromotor(nuevoPromotor);

                    // 4. Redirigir para ver los cambios
                    if (promotorGuardado) {
                        response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verPersonal");
                    } else {
                        System.out.println("Error al intentar registrar promotor en la base de datos.");
                        response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verPersonal");
                    }
                    break;
                        
                        case "cambiarEstadoPromotor":
                        // 1. Capturamos el ID del promotor y el estado al que queremos pasarlo
                        int idPromotorEst = Integer.parseInt(request.getParameter("id"));
                        String nuevoEst = request.getParameter("nuevoEstado");

                        // 2. Llamamos al método del DAO
                        SupervisorDAO daoEstadoPro = new SupervisorDAO();
                        daoEstadoPro.cambiarEstadoPromotor(idPromotorEst, nuevoEst);

                        // 3. Recargamos la tabla de personal
                        response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verPersonal");
                        break;
                        
                        case "editarPromotor":
                        // 1. Capturar ID
                        int idEditPro = Integer.parseInt(request.getParameter("id"));

                        // 2. Traer datos del DAO
                        SupervisorDAO daoEditPro = new SupervisorDAO();
                        Promotor promotorAEditar = daoEditPro.getPromotorPorId(idEditPro);

                        // 3. Enviar a la vista
                        request.setAttribute("promotor", promotorAEditar);
                        request.getRequestDispatcher("supervisor/editar_promotor.jsp").forward(request, response);
                        break;

                    case "actualizarPromotor":
                        // 1. Capturar los datos del formulario de edición
                        int idActPro = Integer.parseInt(request.getParameter("id_promotor"));
                        String dniAct = request.getParameter("dni");
                        String nomAct = request.getParameter("nombres");
                        String apeAct = request.getParameter("apellidos");
                        String celAct = request.getParameter("celular");
                        String correoAct = request.getParameter("correo");
                        String provAct = request.getParameter("provincia");

                        // 2. Empaquetar
                        Promotor proAct = new Promotor();
                        proAct.setIdPromotor(idActPro);
                        proAct.setDni(dniAct);
                        proAct.setNombres(nomAct);
                        proAct.setApellidos(apeAct);
                        proAct.setCelular(celAct);
                        proAct.setCorreo(correoAct);
                        proAct.setProvincia(provAct);

                        // 3. Actualizar BD
                        SupervisorDAO daoActPro = new SupervisorDAO();
                        daoActPro.actualizarPromotor(proAct);

                        // 4. Volver a la tabla
                        response.sendRedirect(request.getContextPath() + "/SupervisorController?accion=verPersonal");
                        break;
                        
                        case "exportarExcel":
                        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                        response.setHeader("Content-Disposition", "attachment; filename=Reporte_Metas.xlsx");

                        ListList<Object[]> data = dashboardDAO.getReporteMetas(); // Tu método que trae los datos
                        ExportadorExcel.generarReportePromotores(response.getOutputStream(), data);
                        break;
                
            default:
                request.getRequestDispatcher("supervisor/dashboard_supervisor.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}