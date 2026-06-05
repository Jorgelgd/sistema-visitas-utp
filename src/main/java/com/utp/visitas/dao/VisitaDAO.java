package com.utp.visitas.dao;

import com.utp.visitas.config.ConexionBD;
import com.utp.visitas.model.Visita;
import java.sql.Connection;
import java.sql.PreparedStatement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class VisitaDAO {

    private static final Logger log = LoggerFactory.getLogger(VisitaDAO.class);

    public boolean registrarVisita(Visita visita) {
        Connection con = null;
        PreparedStatement psVisita = null;
        PreparedStatement psInstituto = null;
        boolean exito = false;

        try {
            con = ConexionBD.getConexion();
            // Desactivamos el auto-commit para asegurar que ambas consultas se ejecuten o ninguna
            con.setAutoCommit(false); 

            // 1. Insertar en la tabla visita
            String sqlVisita = "INSERT INTO visita (id_promotor, id_instituto, fecha_visita, tipo_visita, resultado_gestion, observaciones) VALUES (?, ?, ?, 'Presencial', ?, ?)";
            psVisita = con.prepareStatement(sqlVisita);
            psVisita.setInt(1, visita.getIdPromotor());
            psVisita.setInt(2, visita.getIdInstituto());
            psVisita.setString(3, visita.getFechaVisita());
            psVisita.setString(4, visita.getResultadoGestion());
            psVisita.setString(5, visita.getObservaciones());
            psVisita.executeUpdate();

            // 2. Actualizar el estado en la tabla instituto
            String sqlInstituto = "UPDATE instituto SET estado = ? WHERE id_instituto = ?";
            psInstituto = con.prepareStatement(sqlInstituto);
            
            // Simplificamos el estado para la vista del colegio (Ej. de "Aprobado - Día UTP" a "Aprobado")
            String estadoCorto = visita.getResultadoGestion().split(" - ")[0]; 
            psInstituto.setString(1, estadoCorto);
            psInstituto.setInt(2, visita.getIdInstituto());
            psInstituto.executeUpdate();

            // Si todo salió bien, confirmamos los cambios en la base de datos
            con.commit();
            exito = true;
            log.info("Visita registrada correctamente para el instituto ID: {}", visita.getIdInstituto());

        } catch (Exception e) {
            log.error("Error al registrar la visita. Revirtiendo cambios.", e);
            try {
                if (con != null) con.rollback(); // Si hay error, deshacemos todo
            } catch (Exception ex) {
                log.error("Error en el rollback", ex);
            }
        } finally {
            try {
                if (psVisita != null) psVisita.close();
                if (psInstituto != null) psInstituto.close();
                if (con != null) {
                    con.setAutoCommit(true); // Restauramos el comportamiento por defecto
                    con.close();
                }
            } catch (Exception e) {
                log.error("Error cerrando conexiones en VisitaDAO", e);
            }
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