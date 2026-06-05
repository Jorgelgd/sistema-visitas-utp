<%@page import="java.util.List"%>
<%@page import="com.utp.visitas.model.UbicacionPromotor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Monitoreo GPS Real</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

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
        /* Botones de la lista interactiva */
        .btn-ruta {
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-ruta:hover {
            background-color: #f8f9fa;
            transform: translateX(5px);
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/SupervisorController?accion=verMonitoreoGPS">
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
                <div class="col-xl-4 col-12">
                    <div class="card-map-container p-3 shadow-sm h-100">
                        <h6 class="fw-bold border-bottom pb-2 mb-3 text-dark"><i class="bi bi-person-lines-fill me-2 text-danger"></i>Estado de Ruta Hoy</h6>
                        
                        <div class="list-group">
                            <%
                                List<UbicacionPromotor> ubicaciones = (List<UbicacionPromotor>) request.getAttribute("listaUbicaciones");
                                if (ubicaciones != null && !ubicaciones.isEmpty()) {
                                    for (UbicacionPromotor ubi : ubicaciones) {
                            %>
                            <div class="list-group-item p-3 mb-2 rounded border border-light-subtle btn-ruta" 
                                 onclick="enfocarMapa(<%= ubi.getLatitud() %>, <%= ubi.getLongitud() %>)">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="fw-bold mb-1 text-dark"><%= ubi.getNombreCompleto() %></h6>
                                    <small class="text-danger fw-bold"><%= ubi.getTiempoTranscurrido() %></small>
                                </div>
                                <p class="mb-1 text-muted small"><i class="bi bi-building me-1"></i><%= ubi.getNombreColegio() %></p>
                                <small class="text-muted" style="font-size:0.75rem;">Lat: <%= ubi.getLatitud() %> | Lon: <%= ubi.getLongitud() %></small>
                            </div>
                            <%
                                    }
                                } else {
                            %>
                                <div class="text-center p-4">
                                    <i class="bi bi-geo-slash text-muted fs-1 mb-2 d-block"></i>
                                    <span class="text-muted small">No hay marcas de GPS registradas el día de hoy.</span>
                                </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>

                <div class="col-xl-8 col-12">
                    <div class="card-map-container shadow-sm h-100 d-flex flex-column">
                        <div class="p-3 border-bottom d-flex align-items-center justify-content-between bg-white">
                            <span class="fw-bold text-dark small"><i class="bi bi-geo-fill text-danger me-1"></i> Mapa de Operaciones en Tiempo Real</span>
                            <span class="badge bg-success rounded-pill px-3 py-1">En Línea</span>
                        </div>
                        
                        <div id="miMapa" style="flex-grow: 1; min-height: 450px; z-index: 1;"></div>
                        
                        <div class="p-3 bg-light border-top text-muted small d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-info-circle me-1"></i> El círculo rojo indica un radio de 200 metros (Geocerca) alrededor del punto de captura de evidencia del promotor.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    
    <script>
        // Inicializamos el mapa centrado en Lima Metropolitana por defecto
        var map = L.map('miMapa').setView([-12.0464, -77.0428], 11);

        // Cargamos los "azulejos" (las calles) desde OpenStreetMap (¡Es gratis!)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap UTP'
        }).addTo(map);

        // Array para guardar todas las coordenadas y luego centrar la cámara
        var puntosGPS = [];

        // Inyectamos las coordenadas de Java directamente a Javascript
        <% if (ubicaciones != null && !ubicaciones.isEmpty()) {
            for (UbicacionPromotor ubi : ubicaciones) { %>
                
                var lat = <%= ubi.getLatitud() %>;
                var lon = <%= ubi.getLongitud() %>;
                var promotor = "<%= ubi.getNombreCompleto() %>";
                var colegio = "<%= ubi.getNombreColegio() %>";

                // Creamos el Marcador
                var marker = L.marker([lat, lon]).addTo(map);
                
                // Le ponemos un pequeño globo de texto emergente (Popup)
                marker.bindPopup("<b>" + promotor + "</b><br>" + colegio);
                
                // Dibujamos el perímetro rojo punteado de 200 metros
                L.circle([lat, lon], {
                    color: '#8B1D2F',
                    fillColor: '#8B1D2F',
                    fillOpacity: 0.1,
                    radius: 200,
                    dashArray: '5, 5' // Hace que la línea sea punteada como en tu diseño
                }).addTo(map);

                puntosGPS.push([lat, lon]);
        <%  }
        } %>

        // Si hay puntos en el mapa, ajustamos el zoom automáticamente para que se vean todos
        if (puntosGPS.length > 0) {
            map.fitBounds(puntosGPS);
        }

        // Función que se activa al hacer clic en un promotor de la lista izquierda
        function enfocarMapa(lat, lon) {
            // El mapa "vuela" hacia la coordenada con animación (Nivel de Zoom 16 = Calles)
            map.flyTo([lat, lon], 16, {
                animate: true,
                duration: 1.5
            });
        }
    </script>
</body>
</html>