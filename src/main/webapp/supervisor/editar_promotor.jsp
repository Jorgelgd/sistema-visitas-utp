<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.utp.visitas.model.Promotor"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>UTP+ - Editar Promotor</title>
</head>
<body class="bg-light p-4">
    <div class="container bg-white p-4 rounded shadow-sm" style="max-width: 700px;">
        
        <h4 class="fw-bold text-danger mb-4 border-bottom pb-3">
            <i class="fas fa-user-edit me-2"></i> Editar Datos de Promotor
        </h4>
        
        <% 
            Promotor p = (Promotor) request.getAttribute("promotor"); 
            if (p != null) {
        %>
        
        <form action="${pageContext.request.contextPath}/SupervisorController" method="POST">
            <input type="hidden" name="accion" value="actualizarPromotor">
            <input type="hidden" name="id_promotor" value="<%= p.getIdPromotor() %>">
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Número de DNI</label>
                    <input type="text" name="dni" class="form-control" value="<%= p.getDni() %>" maxlength="8" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Celular</label>
                    <input type="tel" name="celular" class="form-control" value="<%= p.getCelular() %>" maxlength="9" required>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Nombres</label>
                    <input type="text" name="nombres" class="form-control" value="<%= p.getNombres() %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Apellidos</label>
                    <input type="text" name="apellidos" class="form-control" value="<%= p.getApellidos() %>" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted fw-bold">Correo Institucional</label>
                <input type="email" name="correo" class="form-control" value="<%= p.getCorreo() %>" required>
            </div>
            
            <div class="mb-4">
                <label class="form-label text-muted fw-bold">Provincia / Región</label>
                <select name="provincia" class="form-select" required>
                    <option value="Lima Sur" <%= "Lima Sur".equals(p.getProvincia()) ? "selected" : "" %>>Lima Sur</option>
                    <option value="Lima Centro" <%= "Lima Centro".equals(p.getProvincia()) ? "selected" : "" %>>Lima Centro</option>
                    <option value="Callao" <%= "Callao".equals(p.getProvincia()) ? "selected" : "" %>>Callao</option>
                    <option value="Lima" <%= "Lima".equals(p.getProvincia()) ? "selected" : "" %>>Lima Metropolitana</option>
                </select>
            </div>

            <div class="d-flex justify-content-end gap-2 border-top pt-3">
                <a href="${pageContext.request.contextPath}/SupervisorController?accion=verPersonal" class="btn btn-outline-secondary px-4">Cancelar</a>
                <button type="submit" class="btn btn-danger px-4">Guardar Cambios</button>
            </div>
        </form>
        
        <% } else { %>
            <div class="alert alert-danger text-center">No se pudo cargar la información.</div>
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/SupervisorController?accion=verPersonal" class="btn btn-secondary">Volver al personal</a>
            </div>
        <% } %>
        
    </div>
</body>
</html>