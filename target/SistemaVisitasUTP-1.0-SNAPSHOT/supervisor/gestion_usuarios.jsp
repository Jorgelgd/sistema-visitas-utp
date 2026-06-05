<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
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
        .table-container {
            background-color: #ffffff;
            border: 1px solid #E0E4EC;
            border-radius: 12px;
            overflow: hidden;
        }
        .btn-utp {
            background-color: #8B1D2F;
            color: white;
            border: none;
        }
        .btn-utp:hover {
            background-color: #A3263A;
            color: white;
        }
        .form-section-title {
            color: #8B1D2F;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            border-bottom: 1px solid #E0E4EC;
            padding-bottom: 0.25rem;
            margin-bottom: 1rem;
            margin-top: 1rem;
        }
    </style>
</head>
<body class="d-flex">

    <!-- MENÚ LATERAL FIJO -->
    <div class="sidebar d-none d-md-flex flex-column text-white shadow">
        <div class="p-4 text-center border-bottom border-white border-opacity-10">
            <h4 class="fw-bold mb-1">UTP <span class="fw-light text-white-50">Intranet</span></h4>
            <span class="badge bg-white text-danger fw-bold rounded-pill px-3 py-1 mt-1 small shadow-sm">Supervisor</span>
        </div>
        <ul class="nav flex-column mt-4 flex-grow-1">
            <li class="nav-item">
                <a class="nav-link" href="dashboard_supervisor.jsp"><i class="bi bi-speedometer2 me-3"></i>Dashboard Control</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="control_geolocalizacion.jsp"><i class="bi bi-map me-3"></i>Monitoreo GPS</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="#"><i class="bi bi-people me-3"></i>Gestión de Personal</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="reportes_consolidado.jsp"><i class="bi bi-bar-chart-line me-3"></i>Reportes de Metas</a>
            </li>
        </ul>
        <div class="p-3 border-top border-white border-opacity-10 text-center">
            <a href="../login.html" class="btn btn-sm btn-outline-light w-100 py-2 rounded-pill"><i class="bi bi-box-arrow-left me-2"></i>Cerrar Sesión</a>
        </div>
    </div>

    <!-- CONTENIDO CENTRAL -->
    <div class="main-content d-flex flex-column">
        <nav class="navbar navbar-expand navbar-light bg-white border-bottom px-4 shadow-sm sticky-top">
            <span class="navbar-brand mb-0 h5 fw-bold d-md-none text-danger">UTP Personal</span>
        </nav>

        <div class="container-fluid p-4">
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <div>
                    <h3 class="fw-bold mb-1 text-dark">Mantenimiento de Promotores (CRUD)</h3>
                    <p class="text-muted mb-0 small">Administre las cuentas institucionales, accesos de campo y asignación de zonas geográficas</p>
                </div>
                <button class="btn btn-utp d-flex align-items-center shadow-sm mt-2 mt-sm-0 px-4 py-2" data-bs-toggle="modal" data-bs-target="#modalUsuario">
                    <i class="bi bi-person-plus-fill me-2"></i> Registrar Promotor
                </button>
            </div>

            <!-- TABLA DE USUARIOS REGISTRADOS -->
            <div class="table-container shadow-sm p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr class="small text-uppercase fw-bold text-muted">
                                <th>Código ID</th>
                                <th>DNI</th>
                                <th>Nombres Completos</th>
                                <th>Celular</th>
                                <th>Correo Institucional</th>
                                <th>Región / Zona</th>
                                <th>Estado</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="small">
                            <tr>
                                <td class="fw-bold text-danger">E30314</td>
                                <td>72145896</td>
                                <td class="fw-bold text-dark">Alexander Carrero</td>
                                <td>987654321</td>
                                <td>acarrero@utp.edu.pe</td>
                                <td><span class="badge bg-light text-dark border px-2">Lima Sur</span></td>
                                <td><span class="badge bg-success bg-opacity-10 text-success px-3 rounded-pill">Activo</span></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-secondary me-1"><i class="bi bi-pencil"></i></button>
                                    <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold text-danger">E30588</td>
                                <td>45896321</td>
                                <td class="fw-bold text-dark">Milagros Torres</td>
                                <td>951236478</td>
                                <td>mtorres@utp.edu.pe</td>
                                <td><span class="badge bg-light text-dark border px-2">Lima Sur</span></td>
                                <td><span class="badge bg-success bg-opacity-10 text-success px-3 rounded-pill">Activo</span></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-secondary me-1"><i class="bi bi-pencil"></i></button>
                                    <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- VENTANA MODAL COMPLETA CON ATRIBUTOS DE BASE DE DATO REAL -->
    <div class="modal fade" id="modalUsuario" tabindex="-1" aria-labelledby="modalUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg"> <!-- Cambiado a modal-lg para dar más espacio horizontal -->
            <div class="modal-content">
                <div class="modal-header" style="background-color: #8B1D2F; color: white;">
                    <h5 class="modal-title fw-bold" id="modalUsuarioLabel"><i class="bi bi-person-plus me-2"></i>Nuevo Promotor de Campo</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <form action="../UsuarioController" method="POST">
                        
                        <div class="form-section-title" style="margin-top:0;">1. Identificación Personal</div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="id_codigo" class="form-label small fw-bold">Código Interno (ID)</label>
                                <input type="text" class="form-control" id="id_codigo" name="id_codigo" placeholder="Ej. E30899" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="dni" class="form-label small fw-bold">Número de DNI</label>
                                <input type="text" class="form-control" id="dni" name="dni" placeholder="8 dígitos" maxlength="8" pattern="[0-9]{8}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="celular" class="form-label small fw-bold">Número de Celular</label>
                                <input type="tel" class="form-control" id="celular" name="celular" placeholder="9 dígitos" maxlength="9" pattern="[0-9]{9}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="nombre" class="form-label small fw-bold">Nombres y Apellidos Completos</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre completo del trabajador" required>
                        </div>

                        <div class="form-section-title">2. Cuenta y Ubicación Logística</div>
                        <div class="mb-3">
                            <label for="email" class="form-label small fw-bold">Correo Electrónico Institucional</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="usuario@utp.edu.pe" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="provincia" class="form-label small fw-bold">Provincia / Región</label>
                                <select class="form-select" id="provincia" name="provincia" required>
                                    <option value="" selected disabled>Seleccione región...</option>
                                    <option value="Lima">Lima Metropolitana</option>
                                    <option value="Callao">Prov. Const. del Callao</option>
                                    <option value="Arequipa">Arequipa Sede Sur</option>
                                    <option value="Chiclayo">Lambayeque Sede Norte</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="zona" class="form-label small fw-bold">Zona Logística Asignada</label>
                                <select class="form-select" id="zona" name="zona" required>
                                    <option value="" selected disabled>Seleccione la zona de colegios...</option>
                                    <option value="Lima Sur">Lima Sur (VES, SJM, VMT)</option>
                                    <option value="Lima Centro">Lima Centro</option>
                                    <option value="Lima Norte">Lima Norte</option>
                                </select>
                            </div>
                        </div>

                        <div class="modal-footer border-top-0 px-0 pb-0 mt-4">
                            <button type="button" class="btn btn-light border px-4" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-utp px-4">Registrar en Sistema</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>