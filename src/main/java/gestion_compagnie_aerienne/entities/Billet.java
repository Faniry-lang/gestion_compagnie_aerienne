package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "billet")
public class Billet extends BaseEntity {
    public Billet() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_passager")
    private Integer idPassager;

    @Column(name = "id_vol")
    private Integer idVol;

    @Column(name = "id_vol_avion")
    private Integer idVolAvion;

    @Column(name = "id_siege")
    private Integer idSiege;

    @Column
    private Float prix;

    @Column(name = "id_classe_siege")
    private Integer idClasseSiege;

    @Column(name = "id_reservation_passager")
    private Integer idReservationPassager;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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
