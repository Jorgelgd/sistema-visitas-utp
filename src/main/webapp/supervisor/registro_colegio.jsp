<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>UTP+ - Registrar Colegio</title>
</head>
<body class="bg-light p-4">
    <div class="container bg-white p-4 rounded shadow-sm" style="max-width: 700px;">
        
        <h4 class="fw-bold text-danger mb-4 border-bottom pb-3">
            <i class="fas fa-school me-2"></i> Nuevo Registro de Colegio
        </h4>
        
        <form action="${pageContext.request.contextPath}/SupervisorController" method="POST">
            <input type="hidden" name="accion" value="registrarColegio">
            <input type="hidden" name="estado" value="Activo">
            
            <div class="row">
                <div class="col-md-8 mb-3">
                    <label class="form-label text-muted fw-bold">Nombre de la Institución</label>
                    <input type="text" name="nombre_instituto" class="form-control" required placeholder="Ej. I.E. 7069 Cesar Vallejo">
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label text-muted fw-bold">Tipo</label>
                    <select name="tipo_instituto" class="form-select" required>
                        <option value="" disabled selected>Seleccione...</option>
                        <option value="Nacional">Nacional</option>
                        <option value="Privado">Privado</option>
                        <option value="Parroquial">Parroquial</option>
                    </select>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Provincia</label>
                    <input type="text" name="provincia" class="form-control" required placeholder="Ej. Lima">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Distrito</label>
                    <input type="text" name="distrito" class="form-control" required placeholder="Ej. San Juan de Miraflores">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Prioridad</label>
                    <select name="prioridad" class="form-select">
                        <option value="TOP">TOP</option>
                        <option value="P1">P1</option>
                        <option value="P2">P2</option>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted fw-bold">Dirección</label>
                <input type="text" name="direccion" class="form-control" placeholder="Avenida / Calle / Referencia">
            </div>
            
            <div class="row border-top pt-3 mt-2">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold"><i class="fas fa-phone me-1"></i> Teléfono</label>
                    <input type="text" name="telefono" class="form-control" placeholder="Ej. 012845678">
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label text-muted fw-bold"><i class="fas fa-envelope me-1"></i> Correo Electrónico</label>
                    <input type="email" name="correo" class="form-control" placeholder="contacto@colegio.edu.pe">
                </div>
            </div>

            <div class="d-flex justify-content-end gap-2 border-top pt-3">
                <a href="${pageContext.request.contextPath}/SupervisorController?accion=verColegios" class="btn btn-outline-secondary px-4">Cancelar</a>
                <button type="submit" class="btn btn-danger px-4">Guardar Institución</button>
            </div>
        </form>
        
    </div>
</body>
</html>