package com.utp.visitas.model;

public class Promotor {
    private int idSupervisor;
    private int idPromotor;
    private String nombres;
    private String apellidos;
    private String dni;
    private String correo;
    private String celular;
    private String provincia;
    private String estado;
    private String contrasena;

    public Promotor() {
    }

    // Getters y Setters
    public int getIdPromotor() { return idPromotor; }
    public void setIdPromotor(int idPromotor) { this.idPromotor = idPromotor; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getCelular() { return celular; }
    public void setCelular(String celular) { this.celular = celular; }

    public String getProvincia() { return provincia; }
    public void setProvincia(String provincia) { this.provincia = provincia; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public int getIdSupervisor() {
        return idSupervisor;
    }

    public void setIdSupervisor(int idSupervisor) {
        this.idSupervisor = idSupervisor;
    }
    
    
}