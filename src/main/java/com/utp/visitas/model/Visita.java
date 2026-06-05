package com.utp.visitas.model;

public class Visita {
    private int idVisita;
    private int idPromotor;
    private int idInstituto;
    private int idDirector; // Agregado para integridad relacional
    private String fechaVisita;
    private String resultadoGestion;
    private String observaciones;
    private String fechaCharlaPactada; // Nuevo campo requerido
    private double latitud;    // Para futura evidencia GPS
    private double longitud;   // Para futura evidencia GPS

    public Visita() {}

    // Getters y Setters
    public int getIdVisita() { return idVisita; }
    public void setIdVisita(int idVisita) { this.idVisita = idVisita; }

    public int getIdPromotor() { return idPromotor; }
    public void setIdPromotor(int idPromotor) { this.idPromotor = idPromotor; }

    public int getIdInstituto() { return idInstituto; }
    public void setIdInstituto(int idInstituto) { this.idInstituto = idInstituto; }
    
    public int getIdDirector() { return idDirector; }
    public void setIdDirector(int idDirector) { this.idDirector = idDirector; }

    public String getFechaVisita() { return fechaVisita; }
    public void setFechaVisita(String fechaVisita) { this.fechaVisita = fechaVisita; }

    public String getResultadoGestion() { return resultadoGestion; }
    public void setResultadoGestion(String resultadoGestion) { this.resultadoGestion = resultadoGestion; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public String getFechaCharlaPactada() { return fechaCharlaPactada; }
    public void setFechaCharlaPactada(String fechaCharlaPactada) { this.fechaCharlaPactada = fechaCharlaPactada; }

    public double getLatitud() { return latitud; }
    public void setLatitud(double latitud) { this.latitud = latitud; }

    public double getLongitud() { return longitud; }
    public void setLongitud(double longitud) { this.longitud = longitud; }
}