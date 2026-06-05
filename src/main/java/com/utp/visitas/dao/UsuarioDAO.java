package com.utp.visitas.dao;

import com.utp.visitas.config.ConexionBD;
import com.utp.visitas.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UsuarioDAO {
    
    // Instanciamos Logback para auditoría profesional
    private static final Logger log = LoggerFactory.getLogger(UsuarioDAO.class);

    public Usuario validarLogin(String correo, String contrasenaPlana) {
        Usuario usuario = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        // Encriptar la contraseña ingresada a SHA-256 usando Apache Commons Codec
        String contrasenaHash = DigestUtils.sha256Hex(contrasenaPlana);

        try {
            con = ConexionBD.getConexion();

            // Consulta unificada usando UNION para buscar en ambas tablas simultáneamente
            String sql = "SELECT id_supervisor AS id, nombres, apellidos, correo, provincia AS zona, 'Supervisor' AS rol " +
                         "FROM supervisor WHERE correo = ? AND contrasena = ? " +
                         "UNION " +
                         "SELECT id_promotor AS id, nombres, apellidos, correo, provincia AS zona, 'Promotor' AS rol " +
                         "FROM promotor WHERE correo = ? AND contrasena = ? AND estado = 'Activo'";

            ps = con.prepareStatement(sql);
            
            // Parámetros para la primera mitad (Supervisor)
            ps.setString(1, correo);
            ps.setString(2, contrasenaHash);
            
            // Parámetros para la segunda mitad (Promotor)
            ps.setString(3, correo);
            ps.setString(4, contrasenaHash);

            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                // Ahora usamos los "Alias" definidos en el SQL para extraer los datos
                usuario.setId(rs.getInt("id"));
                usuario.setNombres(rs.getString("nombres"));
                usuario.setApellidos(rs.getString("apellidos"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setZona(rs.getString("zona"));
                usuario.setRol(rs.getString("rol"));
                
                log.info("Ingreso exitoso - {}: {}", usuario.getRol(), correo);
            } else {
                // Si llega aquí, las credenciales son incorrectas o el promotor no está 'Activo'
                log.warn("Intento de acceso fallido para el correo: {}", correo);
            }

        } catch (Exception e) {
            log.error("Error crítico en la base de datos durante el login", e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                log.error("Error al cerrar conexiones", e);
            }
        }
        return usuario;
    }
}