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
                <a class="nav-link active" href="#"><i class="bi bi-speedometer2 me-3"></i>Dashboard Control</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="control_geolocalizacion.jsp"><i class="bi bi-map me-3"></i>Monitoreo GPS</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="gestion_usuarios.jsp"><i class="bi bi-people me-3"></i>Gestión de Personal</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="reportes_consolidado.jsp"><i class="bi bi-bar-chart-line me-3"></i>Reportes de Metas</a>
            </li>
        </ul>
        <div class="p-3 border-top border-white border-opacity-10 text-center">
            <a href="../login.html" class="btn btn-sm btn-outline-light w-100 py-2 rounded-pill"><i class="bi bi-box-arrow-left me-2"></i>Cerrar Sesión</a>
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

            <!-- TARJETAS DE INDICADORES / ALERTAS DEL SUPERVISOR -->
            <div class="row g-3 mb-4">
                
                <!-- Promotores Desplegados -->
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card-dash p-3 shadow-sm d-flex align-items-center">
                        <div class="p-3 bg-danger bg-opacity-10 text-danger rounded-3 me-3"><i class="bi bi-person-walking fs-3"></i></div>
                        <div>
                            <div class="text-muted small fw-bold">Personal Activo</div>
                            <h3 class="fw-bold mb-0 text-dark">14 / 15</h3>
                        </div>
                    </div>
                </div>

                <!-- Visitas Realizadas -->
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card-dash p-3 shadow-sm d-flex align-items-center">
                        <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-3 me-3"><i class="bi bi-building-check fs-3"></i></div>
                        <div>
                            <div class="text-muted small fw-bold">Colegios Auditados</div>
                            <h3 class="fw-bold mb-0 text-dark">128</h3>
                        </div>
                    </div>
                </div>

                <!-- Alertas Logísticas (Disparador del Negocio) -->
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card-dash p-3 shadow-sm d-flex align-items-center border border-danger border-opacity-50">
                        <div class="p-3 bg-danger bg-opacity-10 text-danger rounded-3 me-3"><i class="bi bi-envelope-exclamation-fill fs-3"></i></div>
                        <div>
                            <div class="text-muted small fw-bold text-danger">Alertas por Correo</div>
                            <h3 class="fw-bold mb-0 text-danger">3 Activas</h3>
                        </div>
                    </div>
                </div>

                <!-- Cobertura Global (Población de 4.5k objetivo) -->
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card-dash p-3 shadow-sm d-flex align-items-center">
                        <div class="p-3 bg-success bg-opacity-10 text-success rounded-3 me-3"><i class="bi bi-check2-circle fs-3"></i></div>
                        <div>
                            <div class="text-muted small fw-bold">Meta Consolidada</div>
                            <h3 class="fw-bold mb-0 text-success">82.4%</h3>
                        </div>
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
                        <tbody class="small">
                            <tr>
                                <td class="fw-bold text-dark">Alexander Carrero</td>
                                <td>Perú Estados Unidos - VES</td>
                                <td>11:45 AM</td>
                                <td><span class="badge bg-warning text-dark px-2 rounded">TOP</span></td>
                                <td><span class="text-success"><i class="bi bi-image me-1"></i>Foto Cargada</span></td>
                                <td class="text-end"><a href="control_geolocalizacion.jsp" class="btn btn-sm btn-outline-danger px-3 py-1 rounded-pill">Auditar GPS</a></td>
                            </tr>
                            <tr>
                                <td class="fw-bold text-dark">Milagros Torres</td>
                                <td>Reino Unido Británico - VES</td>
                                <td>10:15 AM</td>
                                <td><span class="badge bg-primary px-2 rounded text-white">P1</span></td>
                                <td><span class="text-success"><i class="bi bi-image me-1"></i>Foto Cargada</span></td>
                                <td class="text-end"><a href="control_geolocalizacion.jsp" class="btn btn-sm btn-outline-danger px-3 py-1 rounded-pill">Auditar GPS</a></td>
                            </tr>
                            <tr>
                                <td class="fw-bold text-dark">Christian Palomino</td>
                                <td>Ramiro Prialé Prialé - SJM</td>
                                <td>09:30 AM</td>
                                <td><span class="badge bg-secondary px-2 rounded text-white">P2</span></td>
                                <td><span class="text-danger fw-bold"><i class="bi bi-exclamation-triangle me-1"></i>Sin Evidencia</span></td>
                                <td class="text-end"><a href="control_geolocalizacion.jsp" class="btn btn-sm btn-outline-danger px-3 py-1 rounded-pill">Auditar GPS</a></td>
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