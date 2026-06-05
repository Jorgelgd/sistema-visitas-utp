<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTP+ - Capturar Evidencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #F4F6F9; font-family: 'Segoe UI', sans-serif; }
        .navbar-utp { background-color: #8B1D2F; }
        .card-form { border-radius: 12px; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .btn-utp { background-color: #8B1D2F; color: white; }
    </style>
</head>
<body onload="obtenerUbicacion()">

    <nav class="navbar navbar-expand-lg navbar-dark navbar-utp shadow-sm sticky-top">
        <div class="container-fluid px-3">
            <a class="navbar-brand fw-bold" href="../PromotorController?accion=listarColegios">
                <i class="bi bi-arrow-left me-2"></i>Volver
            </a>
        </div>
    </nav>

    <div class="container my-4 px-3" style="max-width: 600px;">
        <div class="mb-4 text-center">
            <h4 class="fw-bold mb-1 text-dark">Evidencia de Campo</h4>
            <p class="text-muted small">Toma una fotografía de la fachada o evento</p>
        </div>

        <div class="card card-form p-4">
            <form action="../PromotorController" method="POST" enctype="multipart/form-data">
                
                <input type="hidden" name="accion" value="guardarEvidencia">
                <input type="hidden" name="id_instituto" value="<%= request.getParameter("id") %>">
                
                <input type="hidden" name="latitud" id="latitud" value="">
                <input type="hidden" name="longitud" id="longitud" value="">

                <div class="alert alert-info py-2 small text-center" id="mensajeGPS">
                    <div class="spinner-border spinner-border-sm text-info me-2" role="status"></div>
                    Obteniendo coordenadas GPS...
                </div>

                <div class="mb-4 text-center">
                    <label class="form-label small fw-bold text-muted d-block">Fotografía del Colegio</label>
                    <input type="file" class="form-control" name="foto_evidencia" accept="image/*" capture="environment" required>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Comentarios adicionales</label>
                    <textarea class="form-control" name="comentarios" rows="2" placeholder="Ej: Afiche colocado en la puerta principal..."></textarea>
                </div>

                <button type="submit" class="btn btn-utp w-100 py-2 fw-bold shadow-sm" id="btnGuardar" disabled>
                    <i class="bi bi-cloud-arrow-up me-2"></i>Subir Evidencia
                </button>
            </form>
        </div>
    </div>

    <script>
        function obtenerUbicacion() {
            const mensajeGPS = document.getElementById("mensajeGPS");
            const btnGuardar = document.getElementById("btnGuardar");

            if (navigator.geolocation) {
                // Pedimos permiso al usuario para leer su ubicación
                navigator.geolocation.getCurrentPosition(
                    function(posicion) {
                        // Si acepta, llenamos los campos ocultos
                        document.getElementById("latitud").value = posicion.coords.latitude;
                        document.getElementById("longitud").value = posicion.coords.longitude;
                        
                        // Cambiamos el mensaje a éxito y activamos el botón
                        mensajeGPS.className = "alert alert-success py-2 small text-center";
                        mensajeGPS.innerHTML = "<i class='bi bi-geo-alt-fill me-1'></i> GPS Capturado correctamente.";
                        btnGuardar.disabled = false;
                    },
                    function(error) {
                        // Si rechaza o hay error, le avisamos
                        mensajeGPS.className = "alert alert-warning py-2 small text-center";
                        mensajeGPS.innerHTML = "<i class='bi bi-exclamation-triangle-fill me-1'></i> Error al obtener GPS. Active su ubicación.";
                        // Activamos el botón igual para no bloquear su trabajo, pero se irá sin GPS
                        btnGuardar.disabled = false; 
                    },
                    { enableHighAccuracy: true } // Pedimos la máxima precisión posible del celular
                );
            } else {
                mensajeGPS.innerHTML = "Tu navegador no soporta geolocalización.";
                btnGuardar.disabled = false;
            }
        }
    </script>
</body>
</html>