package com.utp.visitas.model;

public class Instituto {
    private int id;
    private String nombre;
    private String tipo;
    private String distrito;
    private String direccion;
    private String prioridad;
    private String estado;
    private int idPromotorAsignado;
    private String telefono;
    private String correo;
    private String provincia;

    public Instituto() {}

    // Getters y Setters
    public int getIdInstituto() { return id; }
    public void setIdInstituto(int id) { this.id = id; }

    public String getNombreInstituto() { return nombre; }
    public void setNombreInstituto(String nombre) { this.nombre = nombre; }
    
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getDistrito() { return distrito; }
    public void setDistrito(String distrito) { this.distrito = distrito; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getPrioridad() { return prioridad; }
    public void setPrioridad(String prioridad) { this.prioridad = prioridad; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public int getIdPromotorAsignado() { return idPromotorAsignado; }
    public void setIdPromotorAsignado(int idPromotorAsignado) { this.idPromotorAsignado = idPromotorAsignado; }
    
    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }
    

    
}