package com.utp.visitas.model;

public class Charla {
    private int idCharla;
    private int idVisita; // Volvemos al diseño original purista
    private String fechaCharla;
    private String horaInicio;
    private String horaFin;
    private String tema;
    private String observaciones;

    public Charla() {}

    // Getters y Setters
    public int getIdCharla() { return idCharla; }
    public void setIdCharla(int idCharla) { this.idCharla = idCharla; }

    public int getIdVisita() { return idVisita; }
    public void setIdVisita(int idVisita) { this.idVisita = idVisita; }

    public String getFechaCharla() { return fechaCharla; }
    public void setFechaCharla(String fechaCharla) { this.fechaCharla = fechaCharla; }

    public String getHoraInicio() { return horaInicio; }
    public void setHoraInicio(String horaInicio) { this.horaInicio = horaInicio; }

    public String getHoraFin() { return horaFin; }
    public void setHoraFin(String horaFin) { this.horaFin = horaFin; }

    public String getTema() { return tema; }
    public void setTema(String tema) { this.tema = tema; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }
}