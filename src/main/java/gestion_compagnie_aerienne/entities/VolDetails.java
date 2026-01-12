package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.schema.BaseView;

import java.time.LocalDateTime;

@Entity(tableName = "vol_details")
public class VolDetails extends BaseView {
    public VolDetails() {
        super();
    }

    @Column(name = "id_vol")
    private Integer idVol;

    @Column(name = "numero_vol")
    private String numeroVol;

    @Column(name = "id_aeroport_depart")
    @ForeignKey(mappedBy = "aeroport", entity = Aeroport.class)
    private Integer idAeroportDepart;

    @Column(name = "id_aeroport_arrivee")
    @ForeignKey(mappedBy = "aeroport", entity = Aeroport.class)
    private Integer idAeroportArrivee;

    @Column(name = "date_vol")
    private LocalDateTime dateVol;

    @Column(name = "id_vol_avion")
    private Integer idVolAvion;

    @Column(name = "date_depart")
    private LocalDateTime dateDepart;

    @Column(name = "date_arrivee")
    private LocalDateTime dateArrivee;

    @Column(name = "date_vol_avion")
    private LocalDateTime dateVolAvion;

    @Column(name = "id_avion")
    private Integer idAvion;

    @Column(name = "capacite_totale")
    private Integer capaciteTotale;

    @Column(name = "places_reservees")
    private Integer placesReservees;

    @Column(name = "places_restantes")
    private Integer placesRestantes;

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public String getNumeroVol() {
        return numeroVol;
    }

    public void setNumeroVol(String numeroVol) {
        this.numeroVol = numeroVol;
    }

    public Integer getIdAeroportDepart() {
        return idAeroportDepart;
    }

    public void setIdAeroportDepart(Integer idAeroportDepart) {
        this.idAeroportDepart = idAeroportDepart;
    }

    public Integer getIdAeroportArrivee() {
        return idAeroportArrivee;
    }

    public void setIdAeroportArrivee(Integer idAeroportArrivee) {
        this.idAeroportArrivee = idAeroportArrivee;
    }

    public LocalDateTime getDateVol() {
        return dateVol;
    }

    public void setDateVol(LocalDateTime dateVol) {
        this.dateVol = dateVol;
    }

    public Integer getIdVolAvion() {
        return idVolAvion;
    }

    public void setIdVolAvion(Integer idVolAvion) {
        this.idVolAvion = idVolAvion;
    }

    public LocalDateTime getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(LocalDateTime dateDepart) {
        this.dateDepart = dateDepart;
    }

    public LocalDateTime getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(LocalDateTime dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public LocalDateTime getDateVolAvion() {
        return dateVolAvion;
    }

    public void setDateVolAvion(LocalDateTime dateVolAvion) {
        this.dateVolAvion = dateVolAvion;
    }

    public Integer getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public Integer getCapaciteTotale() {
        return capaciteTotale;
    }

    public void setCapaciteTotale(Integer capaciteTotale) {
        this.capaciteTotale = capaciteTotale;
    }

    public Integer getPlacesReservees() {
        return placesReservees;
    }

    public void setPlacesReservees(Integer placesReservees) {
        this.placesReservees = placesReservees;
    }

    public Integer getPlacesRestantes() {
        return placesRestantes;
    }

    public void setPlacesRestantes(Integer placesRestantes) {
        this.placesRestantes = placesRestantes;
    }

}
