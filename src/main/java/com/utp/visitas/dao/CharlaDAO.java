package com.utp.visitas.dao;

import com.utp.visitas.config.ConexionBD;
import com.utp.visitas.model.Charla;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CharlaDAO {

    private static final Logger log = LoggerFactory.getLogger(CharlaDAO.class);

    /**
     * Registra toda la jerarquía de una charla: Visita, Charla, Docente y Salón.
     */
    public boolean registrarCharlaCompleta(Charla charla, int idInstituto, int idPromotor, 
                                         String nomDocente, String celDocente, String seccion, 
                                         String turno, int cantidadAlumnos) {
        Connection con = null;
        PreparedStatement psVisita = null, psCharla = null, psDocente = null, psSalon = null;
        ResultSet rsVisita = null, rsCharla = null, rsDocente = null;
        boolean exito = false;

        try {
            con = ConexionBD.getConexion();
            con.setAutoCommit(false); // Iniciamos transacción atómica

            // 1. REGISTRAR VISITA (Automática)
            String sqlVisita = "INSERT INTO visita (id_promotor, id_instituto, fecha_visita, tipo_visita, resultado_gestion, observaciones) VALUES (?, ?, ?, 'Charla', 'Aprobado - Charla Ejecutada', ?)";
            psVisita = con.prepareStatement(sqlVisita, Statement.RETURN_GENERATED_KEYS);
            psVisita.setInt(1, idPromotor);
            psVisita.setInt(2, idInstituto);
            psVisita.setString(3, charla.getFechaCharla());
            psVisita.setString(4, charla.getObservaciones());
            psVisita.executeUpdate();
            rsVisita = psVisita.getGeneratedKeys();
            int idVisita = rsVisita.next() ? rsVisita.getInt(1) : 0;

            // 2. REGISTRAR CHARLA
            String sqlCharla = "INSERT INTO charla (id_visita, fecha_charla, hora_inicio, hora_fin, tema, observaciones) VALUES (?, ?, ?, ?, ?, ?)";
            psCharla = con.prepareStatement(sqlCharla, Statement.RETURN_GENERATED_KEYS);
            psCharla.setInt(1, idVisita);
            psCharla.setString(2, charla.getFechaCharla());
            psCharla.setString(3, charla.getHoraInicio());
            psCharla.setString(4, charla.getHoraFin());
            psCharla.setString(5, charla.getTema());
            psCharla.setString(6, charla.getObservaciones());
            psCharla.executeUpdate();
            rsCharla = psCharla.getGeneratedKeys();
            int idCharla = rsCharla.next() ? rsCharla.getInt(1) : 0;

            // 3. REGISTRAR DOCENTE (Tutor)
            String sqlDocente = "INSERT INTO docente (id_instituto, nombres, celular, cargo) VALUES (?, ?, ?, 'Tutor')";
            psDocente = con.prepareStatement(sqlDocente, Statement.RETURN_GENERATED_KEYS);
            psDocente.setInt(1, idInstituto);
            psDocente.setString(2, nomDocente);
            psDocente.setString(3, celDocente);
            psDocente.executeUpdate();
            rsDocente = psDocente.getGeneratedKeys();
            int idDocente = rsDocente.next() ? rsDocente.getInt(1) : 0;

            // 4. REGISTRAR SALON
            String sqlSalon = "INSERT INTO salon (id_instituto, id_docente, id_charla, seccion, turno, cantidad_estudiantes) VALUES (?, ?, ?, ?, ?, ?)";
            psSalon = con.prepareStatement(sqlSalon);
            psSalon.setInt(1, idInstituto);
            psSalon.setInt(2, idDocente);
            psSalon.setInt(3, idCharla);
            psSalon.setString(4, seccion);
            psSalon.setString(5, turno);
            psSalon.setInt(6, cantidadAlumnos);
            psSalon.executeUpdate();

            con.commit(); // Confirmamos todos los pasos
            exito = true;
            log.info("Charla completa registrada exitosamente para instituto ID: {}", idInstituto);

        } catch (Exception e) {
            log.error("Error crítico al registrar charla completa", e);
            try { if (con != null) con.rollback(); } catch (Exception ex) { log.error("Rollback fallido", ex); }
        } finally {
            try {
                if (rsVisita != null) rsVisita.close();
                if (psVisita != null) psVisita.close();
                if (psCharla != null) psCharla.close();
                if (psDocente != null) psDocente.close();
                if (psSalon != null) psSalon.close();
                if (con != null) { con.setAutoCommit(true); con.close(); }
            } catch (Exception e) {
                log.error("Error cerrando conexiones en CharlaDAO", e);
            }
        }
        return exito;
    }
}