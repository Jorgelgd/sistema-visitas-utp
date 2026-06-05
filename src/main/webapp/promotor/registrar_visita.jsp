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
        body { background-color: #F4F6F9; font-family: 'Segoe UI', sans-serif; padding-bottom: 50px; }
        .navbar-utp { background-color: #8B1D2F; }
        .card-form { border-radius: 12px; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .btn-utp { background-color: #8B1D2F; color: white; }
        .btn-utp:hover { background-color: #6a1523; color: white; }
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
        <div class="mb-3 text-center">
            <h5 class="fw-bold text-dark">Registrar Gestión</h5>
        </div>

        <div class="card card-form p-3">
            <form action="<%= request.getContextPath() %>/PromotorController" method="POST">
                <input type="hidden" name="accion" value="guardarVisita">
                <input type="hidden" name="id_instituto" value="<%= request.getParameter("id") %>">

                <div class="form-section-title" style="margin-top: 0;">1. Detalles de la Visita</div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Fecha de la Visita</label>
                    <input type="date" class="form-control form-control-sm" name="fecha_visita" required>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Resultado</label>
                    <select class="form-select form-select-sm" name="estado_visita" required>
                        <option value="" disabled selected>Seleccione...</option>
                        <option value="Aprobado - Día UTP">Aprobado - Día UTP</option>
                        <option value="Interesado - Seguimiento">Interesado - Seguimiento</option>
                        <option value="Rechazado">Rechazado</option>
                    </select>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Fecha Charla Pactada</label>
                    <input type="date" class="form-control form-control-sm" name="fecha_charla_pactada">
                </div>

                <div class="form-section-title">2. Datos del Contacto</div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Director / Coordinador</label>
                    <input type="text" class="form-control form-control-sm" name="nombre_director" placeholder="Nombre...">
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-bold text-muted mb-0">Teléfono</label>
                    <input type="tel" class="form-control form-control-sm" name="telefono_director" placeholder="987654321">
                </div>

                <div class="form-section-title">3. Resumen</div>
                <div class="mb-3">
                    <textarea class="form-control form-control-sm" name="observaciones" rows="2" placeholder="Observaciones y acuerdos..."></textarea>
                </div>

                <button type="submit" class="btn btn-utp w-100 py-2 fw-bold">
                    <i class="bi bi-save me-1"></i>Guardar Registro
                </button>
            </form>
        </div>
    </div>
</body>
</html>