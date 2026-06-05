<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Auditoría de Alertas Mail</title>
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
        .badge-critico { background-color: #DC3545; color: white; font-weight: bold; }
        .badge-advertencia { background-color: #FFC107; color: black; font-weight: bold; }
        .badge-atendido { background-color: #198754; color: white; }
    </style>
</head>
<body class="d-flex">

    <!-- MENÚ LATERAL FIJO (Actualizado con el nuevo acceso de alertas) -->
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
                <a class="nav-link" href="gestion_usuarios.jsp"><i class="bi bi-people me-3"></i>Gestión de Personal</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="reportes_consolidado.jsp"><i class="bi bi-bar-chart-line me-3"></i>Reportes de Metas</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="#"><i class="bi bi-envelope-exclamation me-3"></i>Bandeja de Alertas</a>
            </li>
        </ul>
        <div class="p-3 border-top border-white border-opacity-10 text-center">
            <a href="../login.html" class="btn btn-sm btn-outline-light w-100 py-2 rounded-pill"><i class="bi bi-box-arrow-left me-2"></i>Cerrar Sesión</a>
        </div>
    </div>

    <!-- CONTENIDO CENTRAL -->
    <div class="main-content d-flex flex-column">
        <nav class="navbar navbar-expand navbar-light bg-white border-bottom px-4 shadow-sm sticky-top">
            <span class="navbar-brand mb-0 h5 fw-bold d-md-none text-danger">UTP Alertas Mail</span>
        </nav>

        <div class="container-fluid p-4">
            <div class="mb-4">
                <h3 class="fw-bold mb-1 text-dark">Historial de Alertas Emitidas (Java Mail API)</h3>
                <p class="text-muted mb-0 small">Registro auditable de correos electrónicos automáticos disparados por incidencias o anomalías en las rutas de campo</p>
            </div>

            <!-- TABLA DE CONTROL DE CORREOS DISPARADOS POR BACKEND -->
            <div class="table-container shadow-sm p-4">
                <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-2">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-mailbox me-2 text-danger"></i> Log de Notificaciones por Correo</h5>
                    <span class="badge bg-danger rounded-pill px-3 py-1">3 Alertas Críticas Recientes</span>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr class="small text-uppercase fw-bold text-muted">
                                <th>Fecha / Hora Emitido</th>
                                <th>Destinatario (Supervisor)</th>
                                <th>Asunto del Correo</th>
                                <th>Origen (Promotor)</th>
                                <th>Severidad</th>
                                <th>Estado de Atención</th>
                            </tr>
                        </thead>
                        <tbody class="small">
                            <!-- Alerta 1 -->
                            <tr>
                                <td class="fw-bold text-dark">Hoy, 11:46 AM</td>
                                <td><code class="text-secondary">jefedifusion_sur@utp.edu.pe</code></td>
                                <td><span class="fw-bold text-dark">[ALERTA LOGÍSTICA] Charla con baja asistencia - I.E. Perú EE.UU.</span></td>
                                <td>Alexander Carrero</td>
                                <td><span class="badge badge-advertencia rounded px-2">Moderada</span></td>
                                <td><span class="badge badge-atendido rounded-pill px-3">Revisado</span></td>
                            </tr>
                            <!-- Alerta 2 -->
                            <tr>
                                <td class="fw-bold text-dark">Hoy, 09:31 AM</td>
                                <td><code class="text-secondary">jefedifusion_sur@utp.edu.pe</code></td>
                                <td><span class="fw-bold text-danger">[ALERTA CRÍTICA] Cierre de visita sin Evidencia Fotográfica</span></td>
                                <td>Christian Palomino</td>
                                <td><span class="badge badge-critico rounded px-2">CRÍTICA</span></td>
                                <td>
                                    <button class="btn btn-xs btn-outline-danger py-1 px-2 rounded-pill font-monospace" style="font-size:0.75rem;">
                                        <i class="bi bi-exclamation-circle me-1"></i>Marcar Atendido
                                    </button>
                                </td>
                            </tr>
                            <!-- Alerta 3 -->
                            <tr>
                                <td class="fw-bold text-dark">Ayer, 04:15 PM</td>
                                <td><code class="text-secondary">jefedifusion_sur@utp.edu.pe</code></td>
                                <td><span class="fw-bold text-danger">[ALERTA CRÍTICA] Desviación de Ruta - GPS fuera de Geocerca</span></td>
                                <td>Christian Palomino</td>
                                <td><span class="badge badge-critico rounded px-2">CRÍTICA</span></td>
                                <td>
                                    <button class="btn btn-xs btn-outline-danger py-1 px-2 rounded-pill font-monospace" style="font-size:0.75rem;">
                                        <i class="bi bi-exclamation-circle me-1"></i>Marcar Atendido
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="p-3 bg-light border rounded-3 mt-4 text-muted small">
                    <div class="d-flex align-items-start">
                        <i class="bi bi-info-square-fill text-danger fs-5 me-2 mt-0"></i>
                        <div>
                            <span class="fw-bold text-dark d-block">Nota para la simulación técnica:</span>
                            Las filas en estado pendiente de atención simulan la inyección de datos del paquete <code>com.utp.visitas.servicio</code> cuando la clase de Java Mail despacha de manera exitosa el protocolo SMTP en el puerto local de pruebas.
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>