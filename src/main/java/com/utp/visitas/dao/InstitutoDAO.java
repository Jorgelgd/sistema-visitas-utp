package com.utp.visitas.dao;

import com.utp.visitas.config.ConexionBD;
import com.utp.visitas.model.Instituto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class InstitutoDAO {
    
    private static final Logger log = LoggerFactory.getLogger(InstitutoDAO.class);

    // Método para listar colegios asignados a un promotor específico
    public List<Instituto> listarPorPromotor(int idPromotor) {
        List<Instituto> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConexionBD.getConexion();
            // Filtro estratégico: Trae los colegios asignados a su ID
            String sql = "SELECT * FROM instituto WHERE id_promotor_asignado = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, idPromotor);
            rs = ps.executeQuery();

            while (rs.next()) {
                Instituto inst = new Instituto();
                inst.setId(rs.getInt("id_instituto"));
                inst.setNombre(rs.getString("nombre_instituto"));
                inst.setTipo(rs.getString("tipo_instituto"));
                inst.setDistrito(rs.getString("distrito"));
                inst.setDireccion(rs.getString("direccion"));
                inst.setPrioridad(rs.getString("prioridad"));
                inst.setEstado(rs.getString("estado"));
                
                lista.add(inst);
            }
        } catch (Exception e) {
            log.error("Error al listar instituciones para el promotor: {}", idPromotor, e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                log.error("Error cerrando conexiones en InstitutoDAO", e);
            }
        }
        return lista;
    }
}