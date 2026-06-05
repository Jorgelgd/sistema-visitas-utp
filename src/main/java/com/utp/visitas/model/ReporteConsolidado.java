package com.utp.visitas.model;

public class ReporteConsolidado {
    private String nombrePromotor;
    private int metaColegios;
    private int colegiosVisitados;
    private double porcentajeAvance;

    public ReporteConsolidado() {
    }

    // Getters y Setters
    public String getNombrePromotor() { return nombrePromotor; }
    public void setNombrePromotor(String nombrePromotor) { this.nombrePromotor = nombrePromotor; }

    public int getMetaColegios() { return metaColegios; }
    public void setMetaColegios(int metaColegios) { this.metaColegios = metaColegios; }

    public int getColegiosVisitados() { return colegiosVisitados; }
    public void setColegiosVisitados(int colegiosVisitados) { this.colegiosVisitados = colegiosVisitados; }

    public double getPorcentajeAvance() { return porcentajeAvance; }
    public void setPorcentajeAvance(double porcentajeAvance) { this.porcentajeAvance = porcentajeAvance; }
}