package com.utp.visitas.dao;

import com.utp.visitas.config.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {

    // 1. Visitas de Hoy exclusivas del promotor
    public int getVisitasHoyPorPromotor(int idPromotor) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM visita WHERE fecha_visita = CURDATE() AND id_promotor = ?";
        
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idPromotor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            }
            
        } catch (Exception e) {
            System.out.println("Error en getVisitasHoyPorPromotor: " + e.getMessage());
        }
        return total;
    }

    // 2. Fichas/Colegios gestionados por este promotor
    public int getTotalColegiosPorPromotor(int idPromotor) {
        int total = 0;
        String sql = "SELECT COUNT(DISTINCT id_instituto) FROM visita WHERE id_promotor = ?";
        
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idPromotor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            }
            
        } catch (Exception e) {
            System.out.println("Error en getTotalColegiosPorPromotor: " + e.getMessage());
        }
        return total;
    }

    // 3. Meta General (Total Histórico del promotor)
    public int getTotalVisitasHistoricasPorPromotor(int idPromotor) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM visita WHERE id_promotor = ?";
        
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idPromotor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            }
            
        } catch (Exception e) {
            System.out.println("Error en getTotalVisitasHistoricasPorPromotor: " + e.getMessage());
        }
        return total;
    }
}