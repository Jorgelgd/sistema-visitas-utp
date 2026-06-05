package com.utp.visitas.dao;

import com.utp.visitas.config.ConexionBD;
import com.utp.visitas.model.Visita;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class VisitaDAO {

    private static final Logger log = LoggerFactory.getLogger(VisitaDAO.class);

        public boolean registrarVisita(Visita visita, String nomDirector, String telDirector) {
        Connection con = null;
        PreparedStatement psVisita = null;
        PreparedStatement psDirector = null;
        PreparedStatement psInstituto = null;
        boolean exito = false;

        try {
            con = ConexionBD.getConexion();
            con.setAutoCommit(false); 

            // 1. Insertar Director si se proporcionan datos
            int idDirectorGenerado = 0;
            if (nomDirector != null && !nomDirector.isEmpty()) {
                String sqlDir = "INSERT INTO director (id_instituto, nombres, celular) VALUES (?, ?, ?)";
                psDirector = con.prepareStatement(sqlDir, PreparedStatement.RETURN_GENERATED_KEYS);
                psDirector.setInt(1, visita.getIdInstituto());
                psDirector.setString(2, nomDirector);
                psDirector.setString(3, telDirector);
                psDirector.executeUpdate();

                ResultSet rs = psDirector.getGeneratedKeys();
                if (rs.next()) idDirectorGenerado = rs.getInt(1);
            }

            // 2. Insertar Visita
            String sqlVisita = "INSERT INTO visita (id_promotor, id_instituto, id_director, fecha_visita, tipo_visita, resultado_gestion, observaciones, fecha_charla_pactada) VALUES (?, ?, ?, ?, 'Presencial', ?, ?, ?)";
            psVisita = con.prepareStatement(sqlVisita);
            psVisita.setInt(1, visita.getIdPromotor());
            psVisita.setInt(2, visita.getIdInstituto());
            if(idDirectorGenerado > 0) psVisita.setInt(3, idDirectorGenerado); else psVisita.setNull(3, java.sql.Types.INTEGER);
            psVisita.setString(4, visita.getFechaVisita());
            psVisita.setString(5, visita.getResultadoGestion());
            psVisita.setString(6, visita.getObservaciones());
            psVisita.setString(7, visita.getFechaCharlaPactada());
            psVisita.executeUpdate();

            // 3. Actualizar Instituto
            String sqlInstituto = "UPDATE instituto SET estado = ? WHERE id_instituto = ?";
            psInstituto = con.prepareStatement(sqlInstituto);
            psInstituto.setString(1, visita.getResultadoGestion().split(" - ")[0]);
            psInstituto.setInt(2, visita.getIdInstituto());
            psInstituto.executeUpdate();

            con.commit();
            exito = true;
        } catch (Exception e) {
            log.error("Error en transacción de visita", e);
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
        } finally {
            // Cerrar recursos...
        }
        return exito;
    }
    
    // Nuevo método para guardar la evidencia con GPS y Foto
    public boolean registrarEvidencia(int idPromotor, int idInstituto, String latitud, String longitud, String rutaFoto, String comentarios) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean exito = false;

        try {
            con = ConexionBD.getConexion();
            
            String sql = "INSERT INTO visita (id_promotor, id_instituto, fecha_visita, tipo_visita, observaciones, latitud, longitud, ruta_foto_evidencia) "
                       + "VALUES (?, ?, CURDATE(), 'Evidencia Fotográfica', ?, ?, ?, ?)";
            
            ps = con.prepareStatement(sql);
            ps.setInt(1, idPromotor);
            ps.setInt(2, idInstituto);
            ps.setString(3, comentarios);
            
            // Validamos si el promotor aceptó el GPS o si viene vacío
            if (latitud != null && !latitud.isEmpty() && longitud != null && !longitud.isEmpty()) {
                ps.setDouble(4, Double.parseDouble(latitud));
                ps.setDouble(5, Double.parseDouble(longitud));
            } else {
                ps.setNull(4, java.sql.Types.DECIMAL);
                ps.setNull(5, java.sql.Types.DECIMAL);
            }
            
            ps.setString(6, rutaFoto);

            int filas = ps.executeUpdate();
            if (filas > 0) exito = true;

        } catch (Exception e) {
            log.error("Error al registrar evidencia", e);
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                log.error("Error cerrando conexiones", e);
            }
        }
        return exito;
    } 
}