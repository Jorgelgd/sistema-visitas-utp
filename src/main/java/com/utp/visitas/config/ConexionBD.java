package com.utp.visitas.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    // Parámetros de acceso local a MySQL Workbench
    private static final String URL = "jdbc:mysql://localhost:3306/sistema_visitas_utp?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";       // Cambiar por tu usuario de MySQL si es diferente
    private static final String PASSWORD = "root";   // Coloca aquí la contraseña de tu MySQL local

    public static Connection getConexion() {
        Connection conexion = null;
        try {
            // Cargar el driver JDBC de MySQL de forma explícita
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("LOG: Conexión exitosa a la base de datos sistema_visitas_utp.");
        } catch (ClassNotFoundException e) {
            System.out.println("ERROR: No se encontró el driver de MySQL: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("ERROR: Fallo al conectar con MySQL: " + e.getMessage());
        }
        return conexion;
    }
}