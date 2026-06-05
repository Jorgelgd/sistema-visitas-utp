    package com.utp.visitas.dao;

    import com.utp.visitas.config.ConexionBD;
    import com.utp.visitas.model.Instituto;
    import java.sql.Connection;
    import java.sql.PreparedStatement;
    import java.sql.ResultSet;

    public class SupervisorDAO {

        // 1. Personal Activo Hoy (Cuenta cuántos promotores distintos han registrado al menos 1 visita hoy)
        public int getPersonalActivoHoy() {
            int activos = 0;
            String sql = "SELECT COUNT(DISTINCT id_promotor) FROM visita WHERE fecha_visita = CURDATE()";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) activos = rs.getInt(1);
            } catch (Exception e) {
                System.out.println("Error en getPersonalActivoHoy: " + e.getMessage());
            }
            return activos;
        }

        // 2. Colegios Auditados (Total de colegios únicos visitados a nivel general)
        public int getTotalColegiosAuditados() {
            int total = 0;
            String sql = "SELECT COUNT(DISTINCT id_instituto) FROM visita";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            } catch (Exception e) {
                System.out.println("Error en getTotalColegiosAuditados: " + e.getMessage());
            }
            return total;
        }

        // 3. Alertas por Correo (Visitas registradas SIN foto/evidencia)
            public int getAlertasActivas() {
                int alertas = 0;
                // ¡Corregido! Ahora usamos el nombre real de la columna en tu BD: ruta_foto_evidencia
                String sql = "SELECT COUNT(*) FROM visita WHERE ruta_foto_evidencia IS NULL OR ruta_foto_evidencia = ''";

                try (Connection con = ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql);
                     ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) alertas = rs.getInt(1);

                } catch (Exception e) {
                    System.out.println("Error en getAlertasActivas: " + e.getMessage());
                }
                return alertas;
            }

        // 4. Meta Consolidada (Total de visitas históricas de toda la empresa)
        public int getTotalVisitasGlobales() {
            int total = 0;
            String sql = "SELECT COUNT(*) FROM visita";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            } catch (Exception e) {
                System.out.println("Error en getTotalVisitasGlobales: " + e.getMessage());
            }
            return total;
        }
        // 5. Monitoreo de Campo (Trae las últimas 5 visitas registradas con sus datos cruzados)
        public java.util.List<com.utp.visitas.model.MonitoreoCampo> getUltimasVisitas() {
            java.util.List<com.utp.visitas.model.MonitoreoCampo> lista = new java.util.ArrayList<>();

            String sql = "SELECT v.id_visita, p.nombres, p.apellidos, i.nombre_instituto, i.distrito, i.prioridad, v.ruta_foto_evidencia " +
                         "FROM visita v " +
                         "INNER JOIN promotor p ON v.id_promotor = p.id_promotor " +
                         "INNER JOIN instituto i ON v.id_instituto = i.id_instituto " +
                         "ORDER BY v.id_visita DESC LIMIT 5";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    com.utp.visitas.model.MonitoreoCampo mc = new com.utp.visitas.model.MonitoreoCampo();
                    mc.setIdVisita(rs.getInt("id_visita"));
                    mc.setNombrePromotor(rs.getString("nombres") + " " + rs.getString("apellidos"));
                    mc.setColegioVisitado(rs.getString("nombre_instituto") + " - " + rs.getString("distrito"));
                    mc.setPrioridad(rs.getString("prioridad"));

                    // Verificamos si subió foto o no
                    String evidencia = rs.getString("ruta_foto_evidencia");
                    mc.setTieneEvidencia(evidencia != null && !evidencia.trim().isEmpty());

                    lista.add(mc);
                }
            } catch (Exception e) {
                System.out.println("Error en getUltimasVisitas: " + e.getMessage());
            }
            return lista;
        }

        // 6. Monitoreo GPS (Trae las coordenadas de las visitas de HOY)
        public java.util.List<com.utp.visitas.model.UbicacionPromotor> getUbicacionesHoy() {
            java.util.List<com.utp.visitas.model.UbicacionPromotor> lista = new java.util.ArrayList<>();

            String sql = "SELECT p.id_promotor, p.nombres, p.apellidos, i.nombre_instituto, " +
                         "v.latitud, v.longitud, " +
                         "TIMESTAMPDIFF(MINUTE, v.fecha_hora_registro, NOW()) AS minutos_pasados " +
                         "FROM visita v " +
                         "INNER JOIN promotor p ON v.id_promotor = p.id_promotor " +
                         "INNER JOIN instituto i ON v.id_instituto = i.id_instituto " +
                         "WHERE v.fecha_visita = CURDATE() AND v.latitud IS NOT NULL " +
                         "ORDER BY v.fecha_hora_registro DESC";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    com.utp.visitas.model.UbicacionPromotor ubi = new com.utp.visitas.model.UbicacionPromotor();
                    ubi.setIdPromotor(rs.getInt("id_promotor"));
                    ubi.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));
                    ubi.setNombreColegio(rs.getString("nombre_instituto"));
                    ubi.setLatitud(rs.getDouble("latitud"));
                    ubi.setLongitud(rs.getDouble("longitud"));

                    // Formateamos el texto amigable
                    int mins = rs.getInt("minutos_pasados");
                    if (mins < 60) {
                        ubi.setTiempoTranscurrido("Hace " + mins + " min");
                    } else {
                        ubi.setTiempoTranscurrido("Hace " + (mins / 60) + " h");
                    }

                    lista.add(ubi);
                }
            } catch (Exception e) {
                System.out.println("Error en getUbicacionesHoy: " + e.getMessage());
            }
            return lista;
        }

        // 7. Lista completa de Promotores para el CRUD
        public java.util.List<com.utp.visitas.model.Promotor> getListaPromotores() {
            java.util.List<com.utp.visitas.model.Promotor> lista = new java.util.ArrayList<>();
            String sql = "SELECT * FROM promotor ORDER BY nombres ASC";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    com.utp.visitas.model.Promotor p = new com.utp.visitas.model.Promotor();
                    p.setIdPromotor(rs.getInt("id_promotor"));
                    p.setNombres(rs.getString("nombres"));
                    p.setApellidos(rs.getString("apellidos"));
                    p.setDni(rs.getString("dni"));
                    p.setCorreo(rs.getString("correo"));
                    p.setCelular(rs.getString("celular"));
                    p.setProvincia(rs.getString("provincia"));
                    p.setEstado(rs.getString("estado"));

                    lista.add(p);
                }
            } catch (Exception e) {
                System.out.println("Error en getListaPromotores: " + e.getMessage());
            }
            return lista;
        }

        // 8. Reporte Consolidado de Metas por Promotor
        public java.util.List<com.utp.visitas.model.ReporteConsolidado> getReporteMetas() {
            java.util.List<com.utp.visitas.model.ReporteConsolidado> lista = new java.util.ArrayList<>();

            // SQL que cuenta la meta asignada vs las visitas reales registradas
            String sql = "SELECT p.nombres, p.apellidos, " +
                         "(SELECT COUNT(*) FROM instituto i WHERE i.id_promotor_asignado = p.id_promotor) AS meta_asignada, " +
                         "(SELECT COUNT(*) FROM visita v WHERE v.id_promotor = p.id_promotor) AS visitas_realizadas " +
                         "FROM promotor p " +
                         "HAVING meta_asignada > 0 " + // Solo mostramos a los que tienen colegios asignados
                         "ORDER BY porcentaje_avance DESC, meta_asignada DESC";

            // Adaptamos un poco el SQL para evitar errores de división por cero en bases de datos estrictas
            String sqlSeguro = "SELECT p.nombres, p.apellidos, " +
                         "(SELECT COUNT(*) FROM instituto i WHERE i.id_promotor_asignado = p.id_promotor) AS meta_asignada, " +
                         "(SELECT COUNT(*) FROM visita v WHERE v.id_promotor = p.id_promotor) AS visitas_realizadas " +
                         "FROM promotor p " +
                         "WHERE (SELECT COUNT(*) FROM instituto i WHERE i.id_promotor_asignado = p.id_promotor) > 0";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sqlSeguro);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    com.utp.visitas.model.ReporteConsolidado rep = new com.utp.visitas.model.ReporteConsolidado();
                    rep.setNombrePromotor(rs.getString("nombres") + " " + rs.getString("apellidos"));

                    int meta = rs.getInt("meta_asignada");
                    int visitados = rs.getInt("visitas_realizadas");

                    rep.setMetaColegios(meta);
                    rep.setColegiosVisitados(visitados);

                    // Calculamos el porcentaje
                    double porcentaje = (meta > 0) ? ((double) visitados / meta) * 100 : 0.0;
                    // Redondeamos a 2 decimales
                    rep.setPorcentajeAvance(Math.round(porcentaje * 100.0) / 100.0);

                    lista.add(rep);
                }
            } catch (Exception e) {
                System.out.println("Error en getReporteMetas: " + e.getMessage());
            }
            return lista;
        }

                // 1. REEMPLAZO: Obtener TODOS los datos del promotor para llenar el formulario
            public com.utp.visitas.model.Promotor getPromotorPorId(int id) {
                com.utp.visitas.model.Promotor p = null;
                String sql = "SELECT * FROM promotor WHERE id_promotor = ?";

                try (Connection con = ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            p = new com.utp.visitas.model.Promotor();
                            p.setIdPromotor(rs.getInt("id_promotor"));
                            p.setNombres(rs.getString("nombres"));
                            p.setApellidos(rs.getString("apellidos"));
                            p.setDni(rs.getString("dni"));
                            p.setCelular(rs.getString("celular"));
                            p.setCorreo(rs.getString("correo"));
                            p.setProvincia(rs.getString("provincia"));
                            p.setEstado(rs.getString("estado"));
                        }
                    }
                } catch (Exception e) {
                    System.out.println("Error en getPromotorPorId: " + e.getMessage());
                }
                return p;
            }

            // 2. NUEVO: Actualizar los datos modificados en la Base de Datos
            public boolean actualizarPromotor(com.utp.visitas.model.Promotor p) {
                String sql = "UPDATE promotor SET nombres=?, apellidos=?, dni=?, celular=?, correo=?, provincia=? WHERE id_promotor=?";

                try (Connection con = ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setString(1, p.getNombres());
                    ps.setString(2, p.getApellidos());
                    ps.setString(3, p.getDni());
                    ps.setString(4, p.getCelular());
                    ps.setString(5, p.getCorreo());
                    ps.setString(6, p.getProvincia());
                    ps.setInt(7, p.getIdPromotor()); // El ID va al final por el WHERE

                    return ps.executeUpdate() > 0;

                } catch (Exception e) {
                    System.out.println("Error en actualizarPromotor: " + e.getMessage());
                    return false;
                }
            }

            // 10. Buscar Colegios Libres (Los que no tienen promotor asignado aún y están Activos)
            public java.util.List<com.utp.visitas.model.Instituto> getColegiosLibres() {
                java.util.List<com.utp.visitas.model.Instituto> lista = new java.util.ArrayList<>();

                // Agregamos los paréntesis y la condición AND estado = 'Activo'
                String sql = "SELECT * FROM instituto WHERE (id_promotor_asignado IS NULL OR id_promotor_asignado = 0) AND estado = 'Activo'";

                try (Connection con = ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql);
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {
                        Instituto inst = new Instituto();
                        // Usar el nombre de la columna en lugar del número evita errores estructurales
                        inst.setIdInstituto(rs.getInt("id_instituto")); 
                        inst.setIdPromotorAsignado(rs.getInt("id_promotor_asignado")); 
                        inst.setNombreInstituto(rs.getString("nombre_instituto")); 
                        inst.setTipo(rs.getString("tipo_instituto")); 
                        inst.setDistrito(rs.getString("distrito")); 
                        inst.setDireccion(rs.getString("direccion")); 
                        inst.setPrioridad(rs.getString("prioridad")); 
                        inst.setEstado(rs.getString("estado")); 
                        lista.add(inst);
                    }
                } catch (Exception e) {
                    System.out.println("Error en getColegiosLibres: " + e.getMessage());
                }
                return lista;
            }

        // 3. Guardar la asignación (Actualizar el ID del promotor en la tabla instituto)
        public boolean asignarColegio(int idPromotor, int idInstituto) {
            String sql = "UPDATE instituto SET id_promotor_asignado = ? WHERE id_instituto = ?";

            try (Connection con = ConexionBD.getConexion();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, idPromotor);
                ps.setInt(2, idInstituto);

                int filasAfectadas = ps.executeUpdate();
                return filasAfectadas > 0;

            } catch (Exception e) {
                System.out.println("Error en asignarColegio: " + e.getMessage());
                return false;
            }
        }

                    // Registrar un nuevo promotor
            public boolean registrarPromotor(com.utp.visitas.model.Promotor p) {
                // ¡Aquí está el noveno signo de interrogación agregado al final!
                String sql = "INSERT INTO promotor (id_supervisor, nombres, apellidos, dni, correo, contrasena, celular, provincia, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (Connection con = ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1, p.getIdSupervisor());
                    ps.setString(2, p.getNombres());
                    ps.setString(3, p.getApellidos());
                    ps.setString(4, p.getDni());
                    ps.setString(5, p.getCorreo());
                    ps.setString(6, p.getContrasena()); 
                    ps.setString(7, p.getCelular());
                    ps.setString(8, p.getProvincia());
                    ps.setString(9, p.getEstado());

                    return ps.executeUpdate() > 0;

                } catch (Exception e) {
                    System.out.println("Error en registrarPromotor: " + e.getMessage());
                    return false;
                }
            }

            // Cambiar el estado de un Promotor (Activo / Inactivo)
            public void cambiarEstadoPromotor(int idPromotor, String nuevoEstado) {
                String sql = "UPDATE promotor SET estado = ? WHERE id_promotor = ?";

                try (Connection con = ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setString(1, nuevoEstado);
                    ps.setInt(2, idPromotor);
                    ps.executeUpdate();

                } catch (Exception e) {
                    System.out.println("Error al cambiar estado de promotor: " + e.getMessage());
                }
            }
    }