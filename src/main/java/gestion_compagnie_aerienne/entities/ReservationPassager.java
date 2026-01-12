package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "reservation_passager")
public class ReservationPassager extends BaseEntity {
    public ReservationPassager() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_reservation")
    @ForeignKey(mappedBy = "reservation", entity = Reservation.class)
    private Integer idReservation;

    @Column(name = "id_passager")
    @ForeignKey(mappedBy = "passager", entity = Passager.class)
    private Integer idPassager;

    @Column(name = "id_vol")
    @ForeignKey(mappedBy = "vol", entity = Vol.class)
    private Integer idVol;

    @Column(name = "id_vol_avion")
    @ForeignKey(mappedBy = "vol_avion", entity = VolAvion.class)
    private Integer idVolAvion;

    @Column(name = "id_siege")
    @ForeignKey(mappedBy = "siege", entity = Siege.class)
    private Integer idSiege;

    @Column
    private Float prix;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdReservation() {
        return idReservation;
    }

    public void setIdReservation(Integer idReservation) {
        this.idReservation = idReservation;
    }

    public Integer getIdPassager() {
        return idPassager;
    }

    public void setIdPassager(Integer idPassager) {
        this.idPassager = idPassager;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getIdVolAvion() {
        return idVolAvion;
    }

    public void setIdVolAvion(Integer idVolAvion) {
        this.idVolAvion = idVolAvion;
    }

    public Integer getIdSiege() {
        return idSiege;
    }

    public void setIdSiege(Integer idSiege) {
        this.idSiege = idSiege;
    }

    public Float getPrix() {
        return prix;
    }

    public void setPrix(Float prix) {
        this.prix = prix;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
