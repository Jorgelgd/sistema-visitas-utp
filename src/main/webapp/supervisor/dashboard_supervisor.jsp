<%@page import="com.utp.visitas.model.MonitoreoCampo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Panel del Supervisor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #F4F6F9;
            color: #212529;
            font-family: 'Segoe UI', sans-serif;
            overflow-x: hidden;
        }
        /* Estilos para el Menú Lateral Fijo (Computadora) */
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
        .card-dash {
            background-color: #ffffff;
            border: 1px solid #E0E4EC;
            border-radius: 12px;
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

    <!-- SIDEBAR CONTROL (MENÚ LATERAL FIJO) -->
    <div class="sidebar d-none d-md-flex flex-column text-white shadow">
        <div class="p-4 text-center border-bottom border-white border-opacity-10">
            <h4 class="fw-bold mb-1">UTP <span class="fw-light text-white-50">Intranet</span></h4>
            <span class="badge bg-white text-danger fw-bold rounded-pill px-3 py-1 mt-1 small shadow-sm">Supervisor</span>
        </div>
        <ul class="nav flex-column mt-4 flex-grow-1">
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/SupervisorController?accion=verDashboard">
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
                <a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verColegios">
                    <i class="fas fa-school"></i> Gestión de Instituciones
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verReportes">
                    <i class="bi bi-bar-chart-line me-3"></i>Reportes de Metas
                </a>
            </li>
        </ul>
        <div class="p-3 border-top border-white border-opacity-10 text-center">
            <a href="${pageContext.request.contextPath}/login.html" class="btn btn-sm btn-outline-light w-100 py-2 rounded-pill"><i class="bi bi-box-arrow-left me-2"></i>Cerrar Sesión</a>
        </div>
    </div>

    <!-- CONTENIDO CENTRAL DE ESCRITORIO -->
    <div class="main-content d-flex flex-column">
        
        <!-- Navbar Superior de Contexto -->
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

        <!-- CUERPO DEL DASHBOARD -->
        <div class="container-fluid p-4">
            
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <div>
                    <h3 class="fw-bold mb-1 text-dark">Panel de Control de Convocatoria</h3>
                    <p class="text-muted mb-0 small">Auditoría en tiempo real del despliegue logístico nacional y metas de prospección</p>
                </div>
            </div>

            <%
                // Capturamos los datos enviados por el SupervisorController
                int personalActivo = request.getAttribute("personalActivo") != null ? (Integer) request.getAttribute("personalActivo") : 0;
                int totalPromotores = request.getAttribute("totalPromotores") != null ? (Integer) request.getAttribute("totalPromotores") : 15;
                int totalColegios = request.getAttribute("totalColegios") != null ? (Integer) request.getAttribute("totalColegios") : 0;
                int alertasActivas = request.getAttribute("alertasActivas") != null ? (Integer) request.getAttribute("alertasActivas") : 0;
                String porcentajeMeta = request.getAttribute("porcentajeMeta") != null ? (String) request.getAttribute("porcentajeMeta") : "0.0";
            %>
            <!-- TARJETAS DE INDICADORES / ALERTAS DEL SUPERVISOR -->
            <div class="row g-3 mb-4">
                
                <!-- TARJETA 1: Personal Activo -->
            <div class="col-md-3">
                <div class="card p-3 shadow-sm border-0 h-100">
                    <div class="text-muted small">Personal Activo</div>
                    <!-- Reemplazamos el "14 / 15" -->
                    <h2 class="fw-bold mt-2 mb-0"><%= personalActivo %> / <%= totalPromotores %></h2>
                </div>
            </div>

            <!-- TARJETA 2: Colegios Auditados -->
            <div class="col-md-3">
                <div class="card p-3 shadow-sm border-0 h-100">
                    <div class="text-muted small">Colegios Auditados</div>
                    <!-- Reemplazamos el "128" -->
                    <h2 class="fw-bold mt-2 mb-0"><%= totalColegios %></h2>
                </div>
            </div>

            <!-- TARJETA 3: Alertas por Correo -->
            <div class="col-md-3">
                <div class="card p-3 shadow-sm border-0 h-100 border-danger border-start border-4">
                    <div class="text-muted small">Alertas por Correo</div>
                    <!-- Reemplazamos el "3 Activas" -->
                    <h2 class="fw-bold text-danger mt-2 mb-0"><%= alertasActivas %> Activas</h2>
                </div>
            </div>

            <!-- TARJETA 4: Meta Consolidada -->
            <div class="col-md-3">
                <div class="card p-3 shadow-sm border-0 h-100 border-success border-start border-4">
                    <div class="text-muted small">Meta Consolidada</div>
                    <!-- Reemplazamos el "82.4%" -->
                    <h2 class="fw-bold text-success mt-2 mb-0"><%= porcentajeMeta %>%</h2>
                </div>
            </div>

            </div>

            <!-- TABLA DE CONTROL DE RUTAS ACTUALES -->
            <div class="table-container shadow-sm p-4">
                <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-2">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-clock-history me-2 text-danger"></i> Monitoreo de Campo de Promotores</h5>
                    <span class="badge bg-dark rounded-pill px-3 py-1">Hoy</span>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr class="small text-uppercase fw-bold text-muted">
                                <th>Promotor</th>
                                <th>Último Colegio Visitado</th>
                                <th>Hora Registro</th>
                                <th>Prioridad</th>
                                <th>Evidencia</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="small align-middle">
                            <%
                                List<MonitoreoCampo> listaVisitas = (List<MonitoreoCampo>) request.getAttribute("ultimasVisitas");

                                if (listaVisitas != null && !listaVisitas.isEmpty()) {
                                    for (MonitoreoCampo visita : listaVisitas) {
                                        // Lógica de colores para la prioridad
                                        String badgeColor = "bg-secondary"; // Por defecto P2
                                        if ("TOP".equals(visita.getPrioridad())) badgeColor = "bg-warning text-dark";
                                        else if ("P1".equals(visita.getPrioridad())) badgeColor = "bg-primary";
                            %>
                                <tr>
                                    <td class="fw-bold text-dark"><%= visita.getNombrePromotor() %></td>
                                    <td><%= visita.getColegioVisitado() %></td>
                                    <td>12:00 PM</td> <td><span class="badge <%= badgeColor %>"><%= visita.getPrioridad() %></span></td>

                                    <td>
                                        <% if (visita.isTieneEvidencia()) { %>
                                            <span class="text-success"><i class="bi bi-image me-1"></i>Foto Cargada</span>
                                        <% } else { %>
                                            <span class="text-danger fw-bold"><i class="bi bi-exclamation-triangle me-1"></i>Sin Evidencia</span>
                                        <% } %>
                                    </td>

                                    <td>
                                        <button class="btn btn-sm btn-outline-danger rounded-pill px-3">Auditar GPS</button>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-3 d-block mb-2"></i>
                                        No hay visitas registradas el día de hoy.
                                    </td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>