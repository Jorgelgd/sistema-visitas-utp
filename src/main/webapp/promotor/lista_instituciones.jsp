    <%@page import="java.util.List"%>
<%@page import="com.utp.visitas.model.Instituto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Cartera de Colegios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #F4F6F9;
            color: #212529;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar-utp { background-color: #8B1D2F; }
        .card-colegio {
            background-color: #ffffff;
            border: 1px solid #E0E4EC;
            border-radius: 12px;
            color: #212529;
        }
        .badge-top { background-color: #FFC107; color: #000000; font-weight: bold; } 
        .badge-p1 { background-color: #0D6EFD; color: #ffffff; }  
        .badge-p2 { background-color: #6C757D; color: #ffffff; }  
        
        .search-box {
            background-color: #ffffff;
            border: 1px solid #ced4da;
            color: #212529;
        }
        .search-box:focus {
            background-color: #ffffff;
            color: #212529;
            border-color: #8B1D2F;
            box-shadow: 0 0 0 0.25rem rgba(139, 29, 47, 0.25);
        }
        .text-muted-custom {
            color: #5A626A !important;
        }
        .border-custom {
            border-color: #E0E4EC !important;
        }
    </style>
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-utp shadow-sm sticky-top">
        <div class="container-fluid px-3">
            <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/promotor/inicio_promotor.jsp">
                <i class="bi bi-arrow-left me-2"></i>UTP <span class="fw-light">Cartera</span>
            </a>
        </div>
    </nav>

    <!-- CONTENIDO -->
    <div class="container my-4 px-3">
        
        <div class="mb-4">
            <h4 class="fw-bold mb-1">Mis Colegios Asignados</h4>
            <p class="text-muted-custom small">Mostrando la cartera oficial de instituciones asignadas en tu zona</p>
        </div>

        <!-- BUSCADOR Y FILTROS -->
        <div class="row g-2 mb-4">
            <div class="col-12">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted-custom"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control search-box border-start-0" placeholder="Buscar por nombre o distrito...">
                </div>
            </div>
            <div class="col-12 d-flex gap-1 overflow-x-auto pb-1">
                <button class="btn btn-sm btn-dark rounded-pill px-3 active">Todos</button>
                <button class="btn btn-sm btn-outline-secondary rounded-pill px-3">TOP</button>
                <button class="btn btn-sm btn-outline-secondary rounded-pill px-3">P1</button>
                <button class="btn btn-sm btn-outline-secondary rounded-pill px-3">P2</button>
            </div>
        </div>

        <!-- LISTA DE COLEGIOS -->
        <h6 class="text-uppercase text-muted-custom fw-bold mb-3 small" style="font-size: 0.75rem;">Instituciones (55 asignadas)</h6>
        <div class="row g-3">
            
            <!-- BUCLE DINÁMICO DE JAVA -->
            <% 
                List<Instituto> listaColegios = (List<Instituto>) request.getAttribute("listaColegios");
                
                if (listaColegios != null && !listaColegios.isEmpty()) {
                    for (Instituto inst : listaColegios) {
                        
                        // Lógica para asignar el color de tu diseño según la prioridad
                        String claseBadge = "bg-secondary"; // Por defecto
                        if ("TOP".equalsIgnoreCase(inst.getPrioridad())) claseBadge = "badge-top";
                        else if ("P1".equalsIgnoreCase(inst.getPrioridad())) claseBadge = "badge-p1";
                        else if ("P2".equalsIgnoreCase(inst.getPrioridad())) claseBadge = "badge-p2";
            %>
                        <div class="col-12">
                            <div class="card-colegio p-3 shadow-sm">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <span class="badge <%= claseBadge %> rounded-pill px-3 py-1 text-uppercase"><%= inst.getPrioridad() %></span>
                                    <span class="text-muted-custom small fw-bold">Estado: <%= inst.getEstado() %></span>
                                </div>
                                <h5 class="fw-bold text-dark mb-1"><%= inst.getNombre() %></h5>
                                <p class="text-muted-custom small mb-2"><i class="bi bi-geo-alt me-1"></i><%= inst.getDistrito() %> | <%= inst.getDireccion() %></p>
                                
                                <!-- Sección de métricas simplificada para el bucle -->
                                <div class="row g-0 border-top border-custom pt-2 mt-2 text-center text-muted-custom small">
                                    <div class="col-12">
                                        <span class="d-block text-dark fw-bold">Tipo: <%= inst.getTipo() %></span>
                                    </div>
                                </div>
                                
                                <div class="d-flex gap-2 mt-3">
                                    <a href="promotor/registrar_visita.jsp?id=<%= inst.getId() %>" class="btn btn-sm btn-outline-secondary w-50 py-2">Coordinar Visita</a>
                                    <a href="promotor/registrar_charla.jsp?id=<%= inst.getId() %>" class="btn btn-sm btn-utp w-50 py-2">Dar Charla</a>
                                </div>
                                <div class="mt-2">
                                    <a href="promotor/capturar_evidencia.jsp?id=<%= inst.getId() %>" class="btn btn-sm btn-dark w-100 py-2">
                                        <i class="bi bi-camera-fill me-1"></i> Subir Evidencia
                                    </a>
                                </div>
                            </div>
                        </div>
            <% 
                    } 
                } else { 
            %>
                <div class="col-12 mt-4">
                    <div class="alert alert-warning text-center shadow-sm" role="alert">
                        <i class="bi bi-info-circle fs-4 d-block mb-2 text-danger"></i>
                        Aún no tienes colegios asignados en tu zona.
                    </div>
                </div>
            <% 
                } 
            %>
            <!-- FIN DEL BUCLE -->

        </div>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>