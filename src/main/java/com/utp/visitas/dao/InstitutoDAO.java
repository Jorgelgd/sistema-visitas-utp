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
        String sql = "SELECT * FROM instituto WHERE id_promotor_asignado = ?";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, idPromotor);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Instituto inst = new Instituto();
                    inst.setIdInstituto(rs.getInt("id_instituto"));
                    inst.setNombreInstituto(rs.getString("nombre_instituto"));
                    inst.setTipo(rs.getString("tipo_instituto"));
                    inst.setProvincia(rs.getString("provincia"));
                    inst.setDistrito(rs.getString("distrito"));
                    inst.setDireccion(rs.getString("direccion"));
                    inst.setTelefono(rs.getString("telefono"));
                    inst.setCorreo(rs.getString("correo"));
                    inst.setPrioridad(rs.getString("prioridad"));
                    inst.setEstado(rs.getString("estado"));
                    
                    lista.add(inst);
                }
            }
        } catch (Exception e) {
            log.error("Error al listar instituciones para el promotor: {}", idPromotor, e);
        }
        return lista;
    }

    // Registrar nuevo colegio
    public boolean registrar(Instituto inst) {
        String sql = "INSERT INTO instituto (nombre_instituto, tipo_instituto, provincia, distrito, direccion, telefono, correo, prioridad, estado) VALUES (?,?,?,?,?,?,?,?,?)";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, inst.getNombreInstituto());
            ps.setString(2, inst.getTipo()); 
            ps.setString(3, inst.getProvincia());
            ps.setString(4, inst.getDistrito());
            ps.setString(5, inst.getDireccion());
            ps.setString(6, inst.getTelefono()); 
            ps.setString(7, inst.getCorreo());   
            ps.setString(8, inst.getPrioridad());
            ps.setString(9, inst.getEstado());

            return ps.executeUpdate() > 0;

        } catch (Exception e) { 
            log.error("Error al registrar colegio", e);
            return false; 
        }
    }

    // Eliminar un colegio (Físico)
    public boolean eliminar(int id) {
        String sql = "DELETE FROM instituto WHERE id_instituto = ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) { 
            log.error("Error al eliminar colegio", e);
            return false; 
        }
    }
    
    // Método para listar TODOS los colegios registrados (Para el Catálogo)
    public List<Instituto> listarTodo() {
        List<Instituto> lista = new ArrayList<>();
        String sql = "SELECT * FROM instituto";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Instituto inst = new Instituto();
                inst.setIdInstituto(rs.getInt("id_instituto"));
                inst.setNombreInstituto(rs.getString("nombre_instituto"));
                inst.setTipo(rs.getString("tipo_instituto"));
                inst.setProvincia(rs.getString("provincia"));
                inst.setDistrito(rs.getString("distrito"));
                inst.setDireccion(rs.getString("direccion"));
                inst.setTelefono(rs.getString("telefono")); 
                inst.setCorreo(rs.getString("correo"));     
                inst.setPrioridad(rs.getString("prioridad"));
                inst.setEstado(rs.getString("estado"));

                lista.add(inst);
            }
        } catch (Exception e) {
            log.error("Error al listar todos los colegios", e);
        }
        return lista;
    }
    
    // Cambiar estado (Borrado Lógico)
    public void cambiarEstado(int idInstituto, String nuevoEstado) {
        String sql = "UPDATE instituto SET estado = ? WHERE id_instituto = ?";
        try (Connection con = ConexionBD.getConexion(); 
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuevoEstado);
            ps.setInt(2, idInstituto);
            ps.executeUpdate();

        } catch (Exception e) {
            log.error("Error al cambiar estado", e);
        }
    }

    // Obtener un solo colegio por su ID (Para cargar datos al Editar)
    public Instituto obtenerPorId(int idInstituto) {
        Instituto inst = null;
        String sql = "SELECT * FROM instituto WHERE id_instituto = ?";

        try (Connection con = ConexionBD.getConexion(); 
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idInstituto);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    inst = new Instituto();
                    inst.setIdInstituto(rs.getInt("id_instituto"));
                    inst.setNombreInstituto(rs.getString("nombre_instituto"));
                    inst.setTipo(rs.getString("tipo_instituto"));
                    inst.setProvincia(rs.getString("provincia"));
                    inst.setDistrito(rs.getString("distrito"));
                    inst.setDireccion(rs.getString("direccion"));
                    inst.setTelefono(rs.getString("telefono"));
                    inst.setCorreo(rs.getString("correo"));
                    inst.setPrioridad(rs.getString("prioridad"));
                    inst.setEstado(rs.getString("estado"));
                }
            }
        } catch (Exception e) {
            log.error("Error al obtener instituto", e);
        }
        return inst;
    }
    
            // Actualizar datos de un colegio existente
            public boolean actualizar(Instituto inst) {
                // La consulta UPDATE con todos los campos
                String sql = "UPDATE instituto SET nombre_instituto=?, tipo_instituto=?, provincia=?, distrito=?, direccion=?, telefono=?, correo=?, prioridad=?, estado=? WHERE id_instituto=?";

                try (Connection con = ConexionBD.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setString(1, inst.getNombreInstituto());
                    ps.setString(2, inst.getTipo());
                    ps.setString(3, inst.getProvincia());
                    ps.setString(4, inst.getDistrito());
                    ps.setString(5, inst.getDireccion());
                    ps.setString(6, inst.getTelefono());
                    ps.setString(7, inst.getCorreo());
                    ps.setString(8, inst.getPrioridad());
                    ps.setString(9, inst.getEstado());
                    ps.setInt(10, inst.getIdInstituto()); // Importante: el ID es el último parámetro (el número 10)

                    return ps.executeUpdate() > 0;

                } catch (Exception e) { 
                    System.out.println("Error al actualizar colegio: " + e.getMessage());
                    return false; 
                }
            }
}