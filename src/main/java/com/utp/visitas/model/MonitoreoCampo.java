package com.utp.visitas.model;

public class MonitoreoCampo {
    private int idVisita;
    private String nombrePromotor;
    private String colegioVisitado;
    private String prioridad;
    private boolean tieneEvidencia;

    // Constructor vacío
    public MonitoreoCampo() {
    }

    // Getters y Setters
    public int getIdVisita() { return idVisita; }
    public void setIdVisita(int idVisita) { this.idVisita = idVisita; }

    public String getNombrePromotor() { return nombrePromotor; }
    public void setNombrePromotor(String nombrePromotor) { this.nombrePromotor = nombrePromotor; }

    public String getColegioVisitado() { return colegioVisitado; }
    public void setColegioVisitado(String colegioVisitado) { this.colegioVisitado = colegioVisitado; }

    public String getPrioridad() { return prioridad; }
    public void setPrioridad(String prioridad) { this.prioridad = prioridad; }

    public boolean isTieneEvidencia() { return tieneEvidencia; }
    public void setTieneEvidencia(boolean tieneEvidencia) { this.tieneEvidencia = tieneEvidencia; }
}