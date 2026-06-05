package com.utp.visitas.model;

public class Usuario {
    private int id;
    private String nombres;
    private String apellidos;
    private String correo;
    private String rol;      // "Supervisor" o "Promotor"
    private String zona;     // Ej. "Lima Sur"

    // Constructor vacío
    public Usuario() {}

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }
    
    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }
    
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    
    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }
    
    public String getZona() { return zona; }
    public void setZona(String zona) { this.zona = zona; }
}