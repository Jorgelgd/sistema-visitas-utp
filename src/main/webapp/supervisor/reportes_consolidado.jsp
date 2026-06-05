<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        .card-report {
            background-color: #ffffff;
            border: 1px solid #E0E4EC;
            border-radius: 12px;
        }
        .btn-utp {
            background-color: #8B1D2F;
            color: white;
            border: none;
        }
        .btn-utp:hover {
            background-color: #A3263A;
            color: white;
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
                <a class="nav-link" href="dashboard_supervisor.jsp"><i class="bi bi-speedometer2 me-3"></i>Dashboard Control</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="control_geolocalizacion.jsp"><i class="bi bi-map me-3"></i>Monitoreo GPS</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="gestion_usuarios.jsp"><i class="bi bi-people me-3"></i>Gestión de Personal</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="#"><i class="bi bi-bar-chart-line me-3"></i>Reportes de Metas</a>
            </li>
        </ul>
        <div class="p-3 border-top border-white border-opacity-10 text-center">
            <a href="../login.html" class="btn btn-sm btn-outline-light w-100 py-2 rounded-pill"><i class="bi bi-box-arrow-left me-2"></i>Cerrar Sesión</a>
        </div>
    </div>

    <!-- CONTENIDO CENTRAL -->
    <div class="main-content d-flex flex-column">
        <nav class="navbar navbar-expand navbar-light bg-white border-bottom px-4 shadow-sm sticky-top">
            <span class="navbar-brand mb-0 h5 fw-bold d-md-none text-danger">UTP Reportes</span>
            <div class="ms-auto">
                <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-download me-2"></i>Exportar Excel</button>
            </div>
        </nav>

        <div class="container-fluid p-4">
            <div class="mb-4">
                <h3 class="fw-bold mb-1 text-dark">Rendimiento y Metas de Prospección</h3>
                <p class="text-muted mb-0 small">Consolidado estadístico del avance de captación sobre la población objetivo nacional (4,500 alumnos)</p>
            </div>

            <!-- SECCIÓN DE GRÁFICOS Y MÉTRICAS POR FILTRO -->
            <div class="row g-4 mb-4">
                
                <!-- Progreso por Zona Geográfica (Simulación de Barras) -->
                <div class="col-xl-6 col-12">
                    <div class="card-report p-4 shadow-sm h-100">
                        <h5 class="fw-bold text-dark mb-3"><i class="bi bi-pie-chart me-2 text-danger"></i> Avance de Cobertura por Zonas</h5>
                        
                        <div class="mb-4">
                            <div class="d-flex justify-content-between mb-1 small fw-bold">
                                <span>Lima Sur (Meta: 1,800 alumnos)</span>
                                <span class="text-danger">85%</span>
                            </div>
                            <div class="progress" style="height: 12px;">
                                <div class="progress-bar" role="progressbar" style="width: 85%; background-color: #8B1D2F;" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="d-flex justify-content-between mb-1 small fw-bold">
                                <span>Lima Centro (Meta: 1,500 alumnos)</span>
                                <span class="text-primary">70%</span>
                            </div>
                            <div class="progress" style="height: 12px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 70%;" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>

                        <div class="mb-2">
                            <div class="d-flex justify-content-between mb-1 small fw-bold">
                                <span>Lima Norte (Meta: 1,200 alumnos)</span>
                                <span class="text-success">92%</span>
                            </div>
                            <div class="progress" style="height: 12px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 92%;" aria-valuenow="92" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Resumen de Efectividad de Charlas por Prioridad de Colegio -->
                <div class="col-xl-6 col-12">
                    <div class="card-report p-4 shadow-sm h-100">
                        <h5 class="fw-bold text-dark mb-3"><i class="bi bi-building-up me-2 text-danger"></i> Efectividad por Prioridad de Colegio</h5>
                        <div class="row text-center mt-3 g-2">
                            <div class="col-4">
                                <div class="p-3 bg-warning bg-opacity-10 rounded-3 border border-warning border-opacity-25">
                                    <span class="d-block text-muted small fw-bold">Colegios TOP</span>
                                    <h3 class="fw-bold text-dark mt-2 mb-0">94%</h3>
                                    <small class="text-success extra-small"><i class="bi bi-arrow-up-short"></i>Alta Conversión</small>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="p-3 bg-primary bg-opacity-10 rounded-3 border border-primary border-opacity-25">
                                    <span class="d-block text-muted small fw-bold">Prioridad P1</span>
                                    <h3 class="fw-bold text-dark mt-2 mb-0">78%</h3>
                                    <small class="text-muted extra-small">Estable</small>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="p-3 bg-secondary bg-opacity-10 rounded-3 border border-secondary border-opacity-25">
                                    <span class="d-block text-muted small fw-bold">Prioridad P2</span>
                                    <h3 class="fw-bold text-dark mt-2 mb-0">45%</h3>
                                    <small class="text-danger extra-small"><i class="bi bi-dash-circle"></i>Única Visita</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- RANKING DE TRABAJO EN CAMPO POR PROMOTOR -->
            <div class="card-report p-4 shadow-sm">
                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-trophy me-2 text-danger"></i> Historial de Productividad Individual de Promotores</h5>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 text-center">
                        <thead class="table-light">
                            <tr class="small text-uppercase fw-bold text-muted">
                                <th class="text-start">Promotor</th>
                                <th>Charlas Dictadas</th>
                                <th>Fichas Capturadas</th>
                                <th>Efectividad de Prospección</th>
                            </tr>
                        </thead>
                        <tbody class="small">
                            <tr>
                                <td class="fw-bold text-dark text-start">Alexander Carrero</td>
                                <td>34 aulas</td>
                                <td class="fw-bold text-danger">850 fichas</td>
                                <td><span class="badge bg-success bg-opacity-10 text-success px-3 py-1 rounded-pill">91% (Óptimo)</span></td>
                            </tr>
                            <tr>
                                <td class="fw-bold text-dark text-start">Milagros Torres</td>
                                <td>28 aulas</td>
                                <td class="fw-bold text-danger">620 fichas</td>
                                <td><span class="badge bg-primary bg-opacity-10 text-primary px-3 py-1 rounded-pill">84% (Estable)</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>