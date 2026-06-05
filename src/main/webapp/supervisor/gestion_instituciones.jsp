<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.utp.visitas.model.Instituto" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Gestión de Instituciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body {
            background-color: #F4F6F9;
            color: #212529;
            font-family: 'Segoe UI', sans-serif;
            overflow-x: hidden;
        }
        /* Estilos para el Menú Lateral Fijo */
        .sidebar {
            min-width: 260px;
            max-width: 260px;
            background-color: #8B1D2F; /* Rojo UTP */
            min-height: 100vh;
            transition: all 0.3s;
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            margin: 0.2rem 0.8rem;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: #ffffff;
            background-color: rgba(255, 255, 255, 0.15);
            font-weight: 600;
        }
        .main-content {
            width: 100%;
            min-height: 100vh;
        }
        .table-container {
            background-color: #ffffff;
            border: 1px solid #E0E4EC;
            border-radius: 12px;
            overflow: hidden;
        }
    </style>
</head>
<body class="d-flex">

    <div class="sidebar d-none d-md-flex flex-column text-white shadow">
        <div class="p-4 text-center border-bottom border-white border-opacity-10">
            <h4 class="fw-bold mb-1">UTP <span class="fw-light text-white-50">Intranet</span></h4>
            <span class="badge bg-white text-danger fw-bold rounded-pill px-3 py-1 mt-1 small shadow-sm">Supervisor</span>
        </div>
        <ul class="nav flex-column mt-4 flex-grow-1">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verDashboard">
                    <i class="bi bi-speedometer2 me-3"></i>Dashboard Control
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verMonitoreoGPS">
                    <i class="bi bi-map me-3"></i>Monitoreo GPS
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verPersonal">
                    <i class="bi bi-people me-3"></i>Gestión de Personal
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/SupervisorController?accion=verColegios">
                    <i class="fas fa-school me-3"></i>Gestión de Instituciones
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verReportes">
                    <i class="bi bi-bar-chart-line me-3"></i>Reportes de Metas
                </a>
            </li>
        </ul>
        <div class="p-3 border-top border-white border-opacity-10 text-center">
            <a href="../login.html" class="btn btn-sm btn-outline-light w-100 py-2 rounded-pill"><i class="bi bi-box-arrow-left me-2"></i>Cerrar Sesión</a>
        </div>
    </div>

    <div class="main-content d-flex flex-column">
        
        <nav class="navbar navbar-expand navbar-light bg-white border-bottom px-4 shadow-sm sticky-top">
            <span class="navbar-brand mb-0 h5 fw-bold d-md-none text-danger">UTP Supervisor</span>
            <div class="ms-auto d-flex align-items-center">
                <i class="bi bi-person-circle fs-4 text-secondary me-2"></i>
                <div class="d-none d-sm-block text-end">
                    <div class="fw-bold small lh-1">Supervisión Zonal</div>
                    <small class="text-muted extra-small" style="font-size:0.75rem;">Sede Lima Sur</small>
                </div>
            </div>
        </nav>

        <div class="container-fluid p-4">
            
            <div class="table-container shadow-sm p-4">
                
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <h4 class="fw-bold text-dark mb-0"><i class="fas fa-school text-danger me-2"></i> Catálogo de Instituciones</h4>
                    <a href="${pageContext.request.contextPath}/SupervisorController?accion=prepararRegistro" class="btn btn-danger rounded-pill px-4">
                        <i class="fas fa-plus me-1"></i> Registrar Nuevo
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr class="small text-uppercase fw-bold text-muted">
                                <th>Nombre del Colegio</th>
                                <th>Distrito</th>
                                <th>Contacto</th>
                                <th>Prioridad</th>
                                <th>Estado</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="small align-middle">
                            <% 
                                // Recuperamos la lista que envía el controlador
                                List<Instituto> lista = (List<Instituto>) request.getAttribute("listaCompleta");
                                
                                // Verificamos que la lista no sea nula ni esté vacía
                                if (lista != null && !lista.isEmpty()) {
                                    for(Instituto inst : lista) { 
                            %>
                                <tr>
                                    <td class="fw-bold text-dark"><%= inst.getNombreInstituto() %></td>
                                    <td><%= inst.getDistrito() %></td>
                                    <td>
                                        <small class="d-block text-muted"><i class="fas fa-phone me-1"></i> <%= inst.getTelefono() != null ? inst.getTelefono() : "---" %></small>
                                        <small class="d-block text-muted"><i class="fas fa-envelope me-1"></i> <%= inst.getCorreo() != null ? inst.getCorreo() : "---" %></small>
                                    </td>
                                    <td>
                                        <span class="badge bg-warning text-dark"><%= inst.getPrioridad() %></span>
                                    </td>
                                    <td>
                                        <span class="badge <%= inst.getEstado() != null && inst.getEstado().equals("Activo") ? "bg-success" : "bg-secondary" %>">
                                            <%= inst.getEstado() %>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/SupervisorController?accion=editarColegio&id=<%= inst.getIdInstituto() %>" class="btn btn-sm btn-outline-primary rounded-pill px-3" title="Editar datos completos">
                                            <i class="fas fa-edit"></i> Editar
                                        </a>
                                        
                                        <% if(inst.getEstado() != null && inst.getEstado().equals("Activo")) { %>
                                            <a href="${pageContext.request.contextPath}/SupervisorController?accion=cambiarEstadoColegio&id=<%= inst.getIdInstituto() %>&nuevoEstado=Inactivo" class="btn btn-sm btn-outline-danger rounded-pill px-3" title="Dar de baja temporal">
                                                <i class="fas fa-power-off"></i> Inactivo
                                            </a>
                                        <% } else { %>
                                            <a href="${pageContext.request.contextPath}/SupervisorController?accion=cambiarEstadoColegio&id=<%= inst.getIdInstituto() %>&nuevoEstado=Activo" class="btn btn-sm btn-outline-success rounded-pill px-3" title="Volver a activar">
                                                <i class="fas fa-check"></i> Activo
                                            </a>
                                        <% } %>
                                    </td>
                                </tr>
                            <% 
                                    } 
                                } else { 
                            %>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-5">
                                        <i class="bi bi-inbox fs-3 d-block mb-2"></i>
                                        No hay colegios registrados en el catálogo actualmente.
                                    </td>
                                </tr>
                            <%  } %>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>