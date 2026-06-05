package com.utp.visitas.model;

public class UbicacionPromotor {
    private int idPromotor;
    private String nombreCompleto;
    private String nombreColegio;
    private double latitud;
    private double longitud;
    private String tiempoTranscurrido;

    public UbicacionPromotor() {
    }

    // Getters y Setters
    public int getIdPromotor() { return idPromotor; }
    public void setIdPromotor(int idPromotor) { this.idPromotor = idPromotor; }

    public String getNombreCompleto() { return nombreCompleto; }
    public void setNombreCompleto(String nombreCompleto) { this.nombreCompleto = nombreCompleto; }

    public String getNombreColegio() { return nombreColegio; }
    public void setNombreColegio(String nombreColegio) { this.nombreColegio = nombreColegio; }

    public double getLatitud() { return latitud; }
    public void setLatitud(double latitud) { this.latitud = latitud; }

    public double getLongitud() { return longitud; }
    public void setLongitud(double longitud) { this.longitud = longitud; }

    public String getTiempoTranscurrido() { return tiempoTranscurrido; }
    public void setTiempoTranscurrido(String tiempoTranscurrido) { this.tiempoTranscurrido = tiempoTranscurrido; }
}