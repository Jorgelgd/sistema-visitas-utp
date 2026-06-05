<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Registrar Charla</title>
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
            <h4 class="fw-bold mb-1 text-dark">Ejecución de Charla</h4>
            <p class="text-muted small">Registra los detalles del evento informativo</p>
        </div>

        <div class="card card-form p-4">
            <form action="../PromotorController" method="POST">
                
                <input type="hidden" name="accion" value="guardarCharla">
                <input type="hidden" name="id_instituto" value="<%= request.getParameter("id") %>">

                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Fecha del Evento</label>
                    <input type="date" class="form-control" name="fecha_charla" required>
                </div>

                <div class="row g-2 mb-3">
                    <div class="col-6">
                        <label class="form-label small fw-bold text-muted">Hora de Inicio</label>
                        <input type="time" class="form-control" name="hora_inicio" required>
                    </div>
                    <div class="col-6">
                        <label class="form-label small fw-bold text-muted">Hora de Fin</label>
                        <input type="time" class="form-control" name="hora_fin" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Tema Tratado</label>
                    <select class="form-select" name="tema" required>
                        <option value="Charla Informativa UTP+">Charla Informativa UTP+</option>
                        <option value="Taller Vocacional Práctico">Taller Vocacional Práctico</option>
                        <option value="Beneficios, Becas y Convenios">Beneficios, Becas y Convenios</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Observaciones / Incidencias</label>
                    <textarea class="form-control" name="observaciones" rows="3" placeholder="Ej: Proyector malogrado, alumnos muy participativos, se recolectaron 50 fichas..."></textarea>
                </div>

                <button type="submit" class="btn btn-utp w-100 py-2 fw-bold shadow-sm">
                    <i class="bi bi-mic-fill me-2"></i>Registrar Charla
                </button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>