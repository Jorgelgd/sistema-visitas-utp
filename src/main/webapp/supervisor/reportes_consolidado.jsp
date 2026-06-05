<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.utp.visitas.model.ReporteConsolidado" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Reportes Consolidados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #F4F6F9;
            color: #212529;
            font-family: 'Segoe UI', sans-serif;
        }
        .sidebar {
            min-width: 260px;
            max-width: 260px;
            background-color: #8B1D2F;
            min-height: 100vh;
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
        .main-content { width: 100%; min-height: 100vh; }
        .table-container {
            background-color: #ffffff;
            border: 1px solid #E0E4EC;
            border-radius: 12px;
            overflow: hidden;
        }
        .progress-custom {
            height: 8px;
            border-radius: 4px;
            background-color: #E0E4EC;
            margin-top: 5px;
        }
    </style>
</head>
<body class="d-flex">

    <!-- MENÚ LATERAL FIJO -->
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

    <!-- CONTENIDO CENTRAL -->
    <div class="main-content d-flex flex-column">
        <nav class="navbar navbar-expand navbar-light bg-white border-bottom px-4 shadow-sm sticky-top">
            <span class="navbar-brand mb-0 h5 fw-bold d-md-none text-danger">UTP Reportes</span>
        </nav>

        <div class="container-fluid p-4">
            <div class="mb-4">
                <h3 class="fw-bold mb-1 text-dark">Consolidado de Metas por Promotor</h3>
                <p class="text-muted mb-0 small">Métricas de avance y cumplimiento del despliegue logístico asignado a cada trabajador.</p>
            </div>

            <!-- TABLA DE RENDIMIENTO -->
            <div class="table-container shadow-sm p-4">
                <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-2">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-graph-up-arrow me-2 text-danger"></i> Rendimiento de Cartera de Colegios</h5>
                    <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-download me-1"></i> Exportar a Excel</button>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr class="small text-uppercase fw-bold text-muted">
                                <th>Nombres y Apellidos</th>
                                <th class="text-center">Meta Asignada</th>
                                <th class="text-center">Colegios Auditados</th>
                                <th>Nivel de Avance</th>
                            </tr>
                        </thead>
                        <tbody class="small">
                            <%
                                List<ReporteConsolidado> listaReportes = (List<ReporteConsolidado>) request.getAttribute("listaReportes");
                                if (listaReportes != null && !listaReportes.isEmpty()) {
                                    for (ReporteConsolidado rep : listaReportes) {
                                        // Determinar el color de la barra según el avance
                                        String colorBarra = "bg-danger"; // Menos de 30%
                                        if (rep.getPorcentajeAvance() >= 80.0) {
                                            colorBarra = "bg-success";
                                        } else if (rep.getPorcentajeAvance() >= 40.0) {
                                            colorBarra = "bg-warning";
                                        }
                            %>
                                <tr>
                                    <td class="fw-bold text-dark"><i class="bi bi-person-badge text-secondary me-2"></i><%= rep.getNombrePromotor() %></td>
                                    <td class="text-center"><span class="badge bg-light text-dark border px-3"><%= rep.getMetaColegios() %> Colegios</span></td>
                                    <td class="text-center fw-bold text-primary"><%= rep.getColegiosVisitados() %></td>
                                    <td style="min-width: 200px;">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="text-muted" style="font-size: 0.75rem;">Progreso</span>
                                            <span class="fw-bold <%= colorBarra.replace("bg-", "text-") %>"><%= rep.getPorcentajeAvance() %>%</span>
                                        </div>
                                        <div class="progress progress-custom">
                                            <div class="progress-bar <%= colorBarra %>" role="progressbar" style="width: <%= rep.getPorcentajeAvance() %>%;" aria-valuenow="<%= rep.getPorcentajeAvance() %>" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <i class="bi bi-file-earmark-bar-graph fs-3 d-block mb-2"></i>
                                        Aún no hay promotores con colegios asignados para mostrar el reporte.
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