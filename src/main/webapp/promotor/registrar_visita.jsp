<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Registrar Visita</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #F4F6F9; font-family: 'Segoe UI', sans-serif; }
        .navbar-utp { background-color: #8B1D2F; }
        .card-form { border-radius: 12px; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .btn-utp { background-color: #8B1D2F; color: white; }
        .btn-utp:hover { background-color: #6a1523; color: white; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-utp shadow-sm sticky-top">
        <div class="container-fluid px-3">
            <a class="navbar-brand fw-bold" href="../PromotorController?accion=listarColegios">
                <i class="bi bi-arrow-left me-2"></i>Volver
            </a>
        </div>
    </nav>

    <div class="container my-4 px-3" style="max-width: 600px;">
        <div class="mb-4 text-center">
            <h4 class="fw-bold mb-1 text-dark">Registrar Gestión</h4>
            <p class="text-muted small">Completa los datos de la visita realizada</p>
        </div>

        <div class="card card-form p-4">
            <form action="../PromotorController" method="POST">
                
                <input type="hidden" name="accion" value="guardarVisita">
                <input type="hidden" name="id_instituto" value="<%= request.getParameter("id") %>">

                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Fecha de la Visita</label>
                    <input type="date" class="form-control" name="fecha_visita" required>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Resultado de la Gestión</label>
                    <select class="form-select" name="estado_visita" required>
                        <option value="" disabled selected>Seleccione un resultado...</option>
                        <option value="Aprobado - Día UTP">Aprobado - Aceptaron Día UTP</option>
                        <option value="Interesado - Requiere seguimiento">Interesado - Requiere seguimiento</option>
                        <option value="Rechazado">Rechazado / Sin interés</option>
                        <option value="Reprogramado">Reprogramado (Director ausente)</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Observaciones / Acuerdos</label>
                    <textarea class="form-control" name="observaciones" rows="3" placeholder="Ej: El director solicitó que la charla sea dirigida a los padres de familia..."></textarea>
                </div>

                <button type="submit" class="btn btn-utp w-100 py-2 fw-bold shadow-sm">
                    <i class="bi bi-save me-2"></i>Guardar Registro
                </button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>