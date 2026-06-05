package com.utp.visitas.model;

public class Visita {
    private int idVisita;
    private int idPromotor;
    private int idInstituto;
    private String fechaVisita;
    private String resultadoGestion;
    private String observaciones;

    public Visita() {}

    // Getters y Setters
    public int getIdVisita() { return idVisita; }
    public void setIdVisita(int idVisita) { this.idVisita = idVisita; }

    public int getIdPromotor() { return idPromotor; }
    public void setIdPromotor(int idPromotor) { this.idPromotor = idPromotor; }

    public int getIdInstituto() { return idInstituto; }
    public void setIdInstituto(int idInstituto) { this.idInstituto = idInstituto; }

    public String getFechaVisita() { return fechaVisita; }
    public void setFechaVisita(String fechaVisita) { this.fechaVisita = fechaVisita; }

    public String getResultadoGestion() { return resultadoGestion; }
    public void setResultadoGestion(String resultadoGestion) { this.resultadoGestion = resultadoGestion; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }
}