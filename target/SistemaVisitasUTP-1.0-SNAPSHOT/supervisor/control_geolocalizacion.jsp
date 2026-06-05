<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Monitoreo GPS</title>
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
        .card-map-container {
            background-color: #ffffff;
            border: 1px solid #E0E4EC;
            border-radius: 12px;
            overflow: hidden;
        }
        /* Simulación de la ventana del Mapa Virtual */
        .mock-map {
            background-color: #E5E3DF;
            background-image: radial-gradient(#A1A1A1 1px, transparent 1px), radial-gradient(#A1A1A1 1px, #E5E3DF 1px);
            background-size: 20px 20px;
            background-position: 0 0, 10px 10px;
            height: 450px;
            position: relative;
        }
        .map-marker {
            position: absolute;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.2); opacity: 0.8; }
            100% { transform: scale(1); opacity: 1; }
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
                <a class="nav-link active" href="#"><i class="bi bi-map me-3"></i>Monitoreo GPS</a>
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

    <!-- CONTENIDO CENTRAL -->
    <div class="main-content d-flex flex-column">
        <nav class="navbar navbar-expand navbar-light bg-white border-bottom px-4 shadow-sm sticky-top">
            <span class="navbar-brand mb-0 h5 fw-bold d-md-none text-danger">UTP Auditoría</span>
        </nav>

        <div class="container-fluid p-4">
            <div class="mb-4">
                <h3 class="fw-bold mb-1 text-dark">Rastreo Satelital y Geocercas</h3>
                <p class="text-muted mb-0 small">Audite la validez geográfica de las marcas de asistencia y el despliegue logístico de la fecha</p>
            </div>

            <div class="row g-4">
                <!-- PANEL IZQUIERDO: LISTA DE PROMOTORES ACTIVOS -->
                <div class="col-xl-4 col-12">
                    <div class="card-map-container p-3 shadow-sm h-100">
                        <h6 class="fw-bold border-bottom pb-2 mb-3 text-dark"><i class="bi bi-person-lines-fill me-2 text-danger"></i>Estado de Ruta</h6>
                        
                        <div class="list-group">
                            <button class="list-group-item list-group-item-action p-3 active border-0 bg-danger bg-opacity-10 text-dark mb-2 rounded border-start border-danger border-3 shadow-sm" style="border-left: 4px solid #8B1D2F !important;">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="fw-bold mb-1">Alexander Carrero</h6>
                                    <small class="text-success fw-bold">Hace 5 min</small>
                                </div>
                                <p class="mb-1 text-muted small"><i class="bi bi-building me-1"></i>I.E. Perú Estados Unidos</p>
                                <small class="text-danger fw-bold" style="font-size:0.75rem;">Lat: -12.2120 | Lon: -76.9350</small>
                            </button>

                            <button class="list-group-item list-group-item-action p-3 mb-2 rounded border border-light-subtle">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="fw-bold mb-1">Milagros Torres</h6>
                                    <small class="text-muted small">Hace 25 min</small>
                                </div>
                                <p class="mb-1 text-muted small"><i class="bi bi-building me-1"></i>I.E. Reino Unido Británico</p>
                                <small class="text-muted small" style="font-size:0.75rem;">Lat: -12.2145 | Lon: -76.9312</small>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- PANEL DERECHO: VISOR DEL MAPA SIMULADO -->
                <div class="col-xl-8 col-12">
                    <div class="card-map-container shadow-sm">
                        <div class="p-3 border-bottom d-flex align-items-center justify-content-between bg-white">
                            <span class="fw-bold text-dark small"><i class="bi bi-geo-fill text-danger me-1"></i> Coordenadas del Punto de Captura</span>
                            <span class="badge bg-success rounded-pill px-3 py-1">Geocerca Válida</span>
                        </div>
                        
                        <!-- MAPA INTERACTIVO MOCK -->
                        <div class="mock-map">
                            <!-- Marcador Virtual Alexander Carrero -->
                            <div class="map-marker text-center" style="top: 45%; left: 50%;">
                                <i class="bi bi-geo-alt-fill text-danger fs-1 d-block lh-1"></i>
                                <span class="badge bg-dark text-white shadow-sm p-2 rounded small border border-light">Promotor Activo</span>
                            </div>
                            
                            <!-- Perímetro del colegio simulado -->
                            <div class="position-absolute border border-danger border-2 bg-danger bg-opacity-10 rounded" style="top: 38%; left: 44%; width: 140px; height: 120px; border-style: dashed !important;">
                                <small class="text-danger fw-bold p-1 d-block extra-small" style="font-size:0.65rem;">Radio I.E. Perú EE.UU.</small>
                            </div>
                        </div>
                        
                        <div class="p-3 bg-light border-top text-muted small d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-info-circle me-1"></i> El sistema valida de manera automatizada que el personal se encuentre dentro de un radio de 200 metros del colegio objetivo.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>