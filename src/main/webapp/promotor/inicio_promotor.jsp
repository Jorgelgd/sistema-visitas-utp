<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Promotor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #F4F6F9; /* Fondo claro de alta visibilidad en la calle */
            color: #212529;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar-utp {
            background-color: #8B1D2F; /* Barra roja corporativa */
        }
        .card-menu {
            background-color: #ffffff; /* Tarjetas blancas de alto contraste */
            border: 1px solid #E0E4EC;
            border-radius: 12px;
            color: #212529;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .card-menu:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .indicator-value {
            font-size: 2.2rem;
            font-weight: 700;
            color: #8B1D2F; /* Números legibles en rojo oscuro */
        }
        .text-utp-red {
            color: #8B1D2F;
        }
        .text-muted-custom {
            color: #5A626A !important; /* Gris oscuro para textos secundarios */
        }
        .border-custom {
            border-color: #E0E4EC !important;
        }
    </style>
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN RESPONSIVA -->
    <nav class="navbar navbar-dark navbar-utp shadow-sm sticky-top">
        <div class="container-fluid px-3 d-flex justify-content-between align-items-center">
            <span class="navbar-brand fw-bold mb-0 h1">UTP Promotor</span>
            
            <a href="../login.html" class="btn btn-sm btn-outline-light d-flex align-items-center gap-2">
                <span>Cerrar Sesión</span>
                <i class="bi bi-box-arrow-right"></i>
            </a>
        </div>
    </nav>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container my-4 px-3">
        
        <!-- Saludo e Identificación -->
        <div class="row mb-4 align-items-center">
            <div class="col">
                <h4 class="mb-1 fw-bold text-truncate">Hola, Alexander Carrero</h4>
                <p class="text-muted-custom small mb-0">Zona: Lima Sur | ID: E30314</p>
            </div>
            <div class="col-auto">
                <span class="badge bg-success px-3 py-2 rounded-pill small">Jornada Activa</span>
            </div>
        </div>

        <!-- INDICADORES CLAVE -->
        <h6 class="text-uppercase text-muted-custom fw-bold mb-3 small" style="font-size: 0.75rem;letter-spacing: 0.05em;">Resumen de Hoy</h6>
        <%
            // Capturamos los datos enviados por el PromotorController (ponemos 0 si vienen vacíos)
            int visitasHoy = request.getAttribute("visitasHoy") != null ? (Integer) request.getAttribute("visitasHoy") : 0;
            int totalFichas = request.getAttribute("totalFichas") != null ? (Integer) request.getAttribute("totalFichas") : 0;
            int metaAvance = request.getAttribute("metaAvance") != null ? (Integer) request.getAttribute("metaAvance") : 0;

            // Calculamos el porcentaje real para la barra de progreso (asumiendo tu meta de 4500)
            int metaTotal = 4500;
            int porcentajeMeta = (int) ((metaAvance * 100.0) / metaTotal);
            if(porcentajeMeta > 100) porcentajeMeta = 100; // Para que la barra no se desborde
        %>
        
        <div class="row g-3">
            
            <div class="col-md-4">
                <div class="card p-3 shadow-sm border-0 h-100">
                    <div class="text-muted small"><i class="bi bi-geo-alt text-danger"></i> Visitas del Día</div>
                    <h2 class="fw-bold text-danger mt-2 mb-0"><%= visitasHoy %></h2>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-3 shadow-sm border-0 h-100">
                    <div class="text-muted small"><i class="bi bi-file-earmark-text text-primary"></i> Fichas Clientes</div>
                    <h2 class="fw-bold text-danger mt-2 mb-0"><%= totalFichas %></h2>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-3 shadow-sm border-0 h-100">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="text-muted small"><i class="bi bi-graph-up text-success"></i> Meta General (4.5k)</div>
                        <span class="badge bg-success bg-opacity-25 text-success"><%= porcentajeMeta %>%</span>
                    </div>

                    <div class="progress mt-3" style="height: 6px;">
                        <div class="progress-bar bg-success" role="progressbar" style="width: <%= porcentajeMeta %>%;"></div>
                    </div>
                    <div class="text-muted small mt-2"><%= metaAvance %> prospectos alcanzados</div>
                </div>
            </div>
            
        </div> 

        <!-- OPERACIONES DE RUTA -->
        <h6 class="text-uppercase text-muted-custom fw-bold mb-3 mt-5 small" style="font-size: 0.75rem;">Operaciones de Ruta</h6>
        <div class="row g-3">
            
            <div class="col-12">
                <a href="lista_instituciones.jsp" class="card-menu p-3 d-flex align-items-center text-decoration-none shadow-sm">
                    <div class="bg-danger bg-opacity-10 p-3 rounded-3 text-danger me-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                        <i class="bi bi-journal-bookmark fs-4"></i>
                    </div>
                    <div class="flex-grow-1">
                        <div class="fw-bold text-dark mb-0">Ver mi Cartera de Colegios</div>
                        <div class="text-muted-custom small">Consultar prioridades TOP, P1 y P2</div>
                    </div>
                    <i class="bi bi-chevron-right text-muted-custom fs-5"></i>
                </a>
            </div>

            <div class="col-12">
                <a href="registrar_charla.jsp" class="card-menu p-3 d-flex align-items-center text-decoration-none shadow-sm">
                    <div class="bg-danger bg-opacity-10 p-3 rounded-3 text-danger me-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                        <i class="bi bi-megaphone fs-4"></i>
                    </div>
                    <div class="flex-grow-1">
                        <div class="fw-bold text-dark mb-0">Registrar Charla en Aula</div>
                        <div class="text-muted-custom small">Ingresar datos por secciones de 5to año</div>
                    </div>
                    <i class="bi bi-chevron-right text-muted-custom fs-5"></i>
                </a>
            </div>

            <div class="col-12">
                <a href="capturar_evidencia.jsp" class="card-menu p-3 d-flex align-items-center text-decoration-none shadow-sm">
                    <div class="bg-danger bg-opacity-10 p-3 rounded-3 text-danger me-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                        <i class="bi bi-camera fs-4"></i>
                    </div>
                    <div class="flex-grow-1">
                        <div class="fw-bold text-dark mb-0">Subir Evidencia Fotográfica</div>
                        <div class="text-muted-custom small">Validación obligatoria con coordenadas GPS</div>
                    </div>
                    <i class="bi bi-chevron-right text-muted-custom fs-5"></i>
                </a>
            </div>
            
        </div>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>