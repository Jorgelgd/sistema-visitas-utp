<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.utp.visitas.model.Instituto"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Editar Colegio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* TUS ESTILOS BASE */
        body { background-color: #F4F6F9; color: #212529; font-family: 'Segoe UI', sans-serif; }
        
        /* ESTILOS DEL MENÚ LATERAL (SIDEBAR) */
        .sidebar { min-width: 260px; max-width: 260px; background-color: #8B1D2F; min-height: 100vh; }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); padding: 0.8rem 1.5rem; border-radius: 8px; margin: 0.2rem 0.8rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #ffffff; background-color: rgba(255, 255, 255, 0.15); font-weight: 600; }
        
        /* ESTILOS DEL CUERPO CENTRAL */
        .main-content { width: 100%; min-height: 100vh; }
        .form-container { background-color: #ffffff; border: 1px solid #E0E4EC; border-radius: 12px; max-width: 800px; margin: 0 auto; }
    </style>
</head>
<body class="d-flex">

    <!-- 1. MENÚ LATERAL (Replicado de tus otras pantallas) -->
    <div class="sidebar d-none d-md-flex flex-column text-white shadow">
        <div class="p-4 text-center border-bottom border-white border-opacity-10">
            <h4 class="fw-bold mb-1">UTP <span class="fw-light text-white-50">Intranet</span></h4>
            <span class="badge bg-white text-danger fw-bold rounded-pill px-3 py-1 mt-1 small shadow-sm">Supervisor</span>
        </div>
        <ul class="nav flex-column mt-4 flex-grow-1">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verDashboard"><i class="bi bi-speedometer2 me-3"></i>Dashboard Control</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verMonitoreoGPS"><i class="bi bi-map me-3"></i>Monitoreo GPS</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verPersonal"><i class="bi bi-people me-3"></i>Gestión de Personal</a></li>
            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/SupervisorController?accion=verColegios"><i class="fas fa-school me-3"></i>Gestión de Instituciones</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/SupervisorController?accion=verReportes"><i class="bi bi-bar-chart-line me-3"></i>Reportes de Metas</a></li>
        </ul>
    </div>

    <!-- 2. CONTENIDO CENTRAL -->
    <div class="main-content d-flex flex-column">
        
        <!-- Barra superior blanca -->
        <nav class="navbar navbar-expand navbar-light bg-white border-bottom px-4 shadow-sm sticky-top">
            <span class="navbar-brand mb-0 h5 fw-bold text-dark"><i class="fas fa-edit text-primary me-2"></i> Actualización de Datos</span>
        </nav>

        <!-- Aquí adentro va tu formulario actual -->
        <div class="container-fluid p-4">
            <div class="form-container p-4 shadow-sm">
                
                <h4 class="fw-bold text-primary mb-4 border-bottom pb-3">
                    Editar Datos del Colegio
                </h4>
        
        <% 
            // Recuperamos el objeto colegio que envió el controlador
            Instituto colegio = (Instituto) request.getAttribute("colegio"); 
            if (colegio != null) {
        %>
        
        <form action="${pageContext.request.contextPath}/SupervisorController" method="POST">
            <input type="hidden" name="accion" value="actualizarColegio">
            <input type="hidden" name="id_instituto" value="<%= colegio.getIdInstituto() %>">
            <input type="hidden" name="estado" value="<%= colegio.getEstado() %>">
            
            <div class="row">
                <div class="col-md-8 mb-3">
                    <label class="form-label text-muted fw-bold">Nombre de la Institución</label>
                    <input type="text" name="nombre_instituto" class="form-control" required value="<%= colegio.getNombreInstituto() %>">
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label text-muted fw-bold">Tipo</label>
                    <select name="tipo_instituto" class="form-select" required>
                        <option value="Nacional" <%= "Nacional".equals(colegio.getTipo()) ? "selected" : "" %>>Nacional</option>
                        <option value="Privado" <%= "Privado".equals(colegio.getTipo()) ? "selected" : "" %>>Privado</option>
                        <option value="Parroquial" <%= "Parroquial".equals(colegio.getTipo()) ? "selected" : "" %>>Parroquial</option>
                    </select>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Provincia</label>
                    <input type="text" name="provincia" class="form-control" required value="<%= colegio.getProvincia() != null ? colegio.getProvincia() : "" %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Distrito</label>
                    <input type="text" name="distrito" class="form-control" required value="<%= colegio.getDistrito() %>">
                </div>
            </div>

            <div class="row">
                <div class="col-md-8 mb-3">
                    <label class="form-label text-muted fw-bold">Dirección</label>
                    <input type="text" name="direccion" class="form-control" value="<%= colegio.getDireccion() != null ? colegio.getDireccion() : "" %>">
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label text-muted fw-bold">Prioridad</label>
                    <select name="prioridad" class="form-select">
                        <option value="TOP" <%= "TOP".equals(colegio.getPrioridad()) ? "selected" : "" %>>TOP</option>
                        <option value="P1" <%= "P1".equals(colegio.getPrioridad()) ? "selected" : "" %>>P1</option>
                        <option value="P2" <%= "P2".equals(colegio.getPrioridad()) ? "selected" : "" %>>P2</option>
                    </select>
                </div>
            </div>
            
            <div class="row border-top pt-3 mt-2">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold"><i class="fas fa-phone me-1"></i> Teléfono</label>
                    <input type="text" name="telefono" class="form-control" value="<%= colegio.getTelefono() != null ? colegio.getTelefono() : "" %>">
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label text-muted fw-bold"><i class="fas fa-envelope me-1"></i> Correo Electrónico</label>
                    <input type="email" name="correo" class="form-control" value="<%= colegio.getCorreo() != null ? colegio.getCorreo() : "" %>">
                </div>
            </div>

            <div class="d-flex justify-content-end gap-2 border-top pt-3">
                <a href="${pageContext.request.contextPath}/SupervisorController?accion=verColegios" class="btn btn-outline-secondary px-4">Cancelar</a>
                <button type="submit" class="btn btn-primary px-4">Actualizar Institución</button>
            </div>
        </form>
        
        <% } else { %>
            <div class="alert alert-danger text-center">
                No se pudo cargar la información del colegio seleccionado.
            </div>
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/SupervisorController?accion=verColegios" class="btn btn-secondary">Volver al catálogo</a>
            </div>
        <% } %>
        
    </div>
</body>
</html>