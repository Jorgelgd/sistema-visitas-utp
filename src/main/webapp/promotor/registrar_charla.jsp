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
        body { background-color: #F4F6F9; font-family: 'Segoe UI', sans-serif; padding-bottom: 60px; }
        .navbar-utp { background-color: #8B1D2F; }
        .card-form { border-radius: 12px; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .btn-utp { background-color: #8B1D2F; color: white; }
        .form-section-title {
            color: #8B1D2F; font-size: 0.8rem; font-weight: 700; text-transform: uppercase;
            border-bottom: 1px solid #E0E4EC; padding-bottom: 0.25rem;
            margin-bottom: 1rem; margin-top: 1.2rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark navbar-utp shadow-sm sticky-top">
        <div class="container-fluid px-3">
            <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/PromotorController?accion=listarColegios">
                <i class="bi bi-arrow-left me-2"></i>Volver
            </a>
        </div>
    </nav>

    <div class="container my-3 px-3" style="max-width: 500px;">
        <div class="text-center mb-3">
            <h5 class="fw-bold text-dark">Ejecución de Charla</h5>
        </div>

        <div class="card card-form p-3">
            <form action="<%= request.getContextPath() %>/PromotorController" method="POST">
                <input type="hidden" name="accion" value="guardarCharla">
                <input type="hidden" name="id_instituto" value="<%= request.getParameter("id") %>">

                <div class="form-section-title" style="margin-top:0;">1. Información del Evento</div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Fecha</label>
                    <input type="date" class="form-control form-control-sm" name="fecha_charla" required>
                </div>
                <div class="row g-2 mb-2">
                    <div class="col-6">
                        <label class="form-label small fw-bold text-muted mb-0">Inicio</label>
                        <input type="time" class="form-control form-control-sm" name="hora_inicio" required>
                    </div>
                    <div class="col-6">
                        <label class="form-label small fw-bold text-muted mb-0">Fin</label>
                        <input type="time" class="form-control form-control-sm" name="hora_fin" required>
                    </div>
                </div>

                <div class="form-section-title">2. Datos del Aula y Docente</div>
                <div class="row g-2 mb-2">
                    <div class="col-6">
                        <label class="form-label small fw-bold text-muted mb-0">Sección</label>
                        <input type="text" class="form-control form-control-sm" name="seccion" placeholder="Ej: 5to A" required>
                    </div>
                    <div class="col-6">
                        <label class="form-label small fw-bold text-muted mb-0">Turno</label>
                        <select class="form-select form-select-sm" name="turno">
                            <option value="Mañana">Mañana</option>
                            <option value="Tarde">Tarde</option>
                        </select>
                    </div>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Tutor/Docente</label>
                    <input type="text" class="form-control form-control-sm" name="nombre_docente" placeholder="Nombre del docente..." required>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Celular Docente</label>
                    <input type="tel" class="form-control form-control-sm" name="celular_docente" placeholder="987654321">
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Cantidad de Alumnos</label>
                    <input type="number" class="form-control form-control-sm" name="cantidad_estudiantes" value="0" required>
                </div>

                <div class="form-section-title">3. Notas Finales</div>
                <div class="mb-3">
                    <select class="form-select form-select-sm mb-2" name="tema">
                        <option value="Charla Informativa UTP+">Charla Informativa UTP+</option>
                        <option value="Taller Vocacional">Taller Vocacional</option>
                    </select>
                    <textarea class="form-control form-control-sm" name="observaciones" rows="2" placeholder="Incidencias o acuerdos..."></textarea>
                </div>

                <button type="submit" class="btn btn-utp w-100 py-2 fw-bold">
                    <i class="bi bi-save me-1"></i>Registrar Charla
                </button>
            </form>
        </div>
    </div>
</body>
</html>