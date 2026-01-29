package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;


@Entity(tableName = "billet")
public class Billet extends BaseEntity {
    public Billet() {
        super();
    }

    @Id
    @Column
    private Integer id;

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

    @Column(name = "id_classe_siege")
    @ForeignKey(mappedBy = "classe_siege", entity = ClasseSiege.class)
    private Integer idClasseSiege;

    @Column(name = "id_reservation_passager")
    @ForeignKey(mappedBy = "reservation_passager", entity = ReservationPassager.class)
    private Integer idReservationPassager;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getIdClasseSiege() {
        return idClasseSiege;
    }

    public void setIdClasseSiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public Integer getIdReservationPassager() {
        return idReservationPassager;
    }

    public void setIdReservationPassager(Integer idReservationPassager) {
        this.idReservationPassager = idReservationPassager;
    }

}
