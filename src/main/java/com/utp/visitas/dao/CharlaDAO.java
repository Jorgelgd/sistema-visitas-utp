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

    // Recibimos la charla, pero también el ID del instituto y promotor para armar la visita
    public boolean registrarCharlaConVisita(Charla charla, int idInstituto, int idPromotor) {
        Connection con = null;
        PreparedStatement psVisita = null;
        PreparedStatement psCharla = null;
        ResultSet rsKeys = null;
        boolean exito = false;

        try {
            con = ConexionBD.getConexion();
            con.setAutoCommit(false); // Desactivamos el auto-commit para la transacción doble

            // 1. CREAR LA VISITA "FANTASMA"
            String sqlVisita = "INSERT INTO visita (id_promotor, id_instituto, fecha_visita, tipo_visita, resultado_gestion, observaciones) "
                             + "VALUES (?, ?, ?, 'Presencial', 'Aprobado - Charla Ejecutada', 'Registro automático desde módulo de Charlas')";
            
            // Statement.RETURN_GENERATED_KEYS es la clave para obtener el ID de la visita recién creada
            psVisita = con.prepareStatement(sqlVisita, Statement.RETURN_GENERATED_KEYS);
            psVisita.setInt(1, idPromotor);
            psVisita.setInt(2, idInstituto);
            psVisita.setString(3, charla.getFechaCharla());
            psVisita.executeUpdate();

            // 2. OBTENER EL ID DE LA VISITA
            rsKeys = psVisita.getGeneratedKeys();
            int idVisitaGenerado = 0;
            if (rsKeys.next()) {
                idVisitaGenerado = rsKeys.getInt(1); // Atrapamos el ID
            } else {
                throw new Exception("Fallo al obtener el ID de la visita generada.");
            }

            // 3. REGISTRAR LA CHARLA CON EL ID_VISITA CORRECTO
            String sqlCharla = "INSERT INTO charla (id_visita, fecha_charla, hora_inicio, hora_fin, tema, observaciones) "
                             + "VALUES (?, ?, ?, ?, ?, ?)";
            psCharla = con.prepareStatement(sqlCharla);
            psCharla.setInt(1, idVisitaGenerado);
            psCharla.setString(2, charla.getFechaCharla());
            psCharla.setString(3, charla.getHoraInicio());
            psCharla.setString(4, charla.getHoraFin());
            psCharla.setString(5, charla.getTema());
            psCharla.setString(6, charla.getObservaciones());
            psCharla.executeUpdate();

            // 4. CONFIRMAR TRANSACCIÓN
            con.commit();
            exito = true;
            log.info("Charla y Visita asociadas registradas exitosamente para instituto ID: {}", idInstituto);

        } catch (Exception e) {
            log.error("Error al registrar la charla. Revirtiendo transacción.", e);
            try {
                if (con != null) con.rollback(); // Si algo falla, deshacemos ambos inserts
            } catch (Exception ex) {
                log.error("Error en el rollback", ex);
            }
        } finally {
            try {
                if (rsKeys != null) rsKeys.close();
                if (psVisita != null) psVisita.close();
                if (psCharla != null) psCharla.close();
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (Exception e) {
                log.error("Error cerrando conexiones en CharlaDAO", e);
            }
        }
        return exito;
    }
}