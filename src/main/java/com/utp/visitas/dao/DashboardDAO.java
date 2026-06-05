package com.utp.visitas.dao;

import com.utp.visitas.config.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class DashboardDAO {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(DashboardDAO.class);

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
                public List<Object[]> getReporteMetas() {
                List<Object[]> lista = new java.util.ArrayList<>();
                String sql = "SELECT p.nombres, p.apellidos, COUNT(i.id_instituto) as meta_asignada, " +
                             "(SELECT COUNT(*) FROM visita v WHERE v.id_promotor = p.id_promotor) as colegios_auditados " +
                             "FROM promotor p LEFT JOIN instituto i ON p.id_promotor = i.id_promotor " +
                             "GROUP BY p.id_promotor";

                try (Connection con = com.utp.visitas.config.ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql);
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {
                        double meta = rs.getInt("meta_asignada");
                        double avance = (meta > 0) ? ((double)rs.getInt("colegios_auditados") / meta) * 100 : 0.0;
                        lista.add(new Object[]{
                            rs.getString("nombres") + " " + rs.getString("apellidos"),
                            (int)meta,
                            rs.getInt("colegios_auditados"),
                            avance
                        });
                    }
                } catch (Exception e) {
                    log.error("Error al obtener reporte de metas", e);
                }
                return lista;
            }
}