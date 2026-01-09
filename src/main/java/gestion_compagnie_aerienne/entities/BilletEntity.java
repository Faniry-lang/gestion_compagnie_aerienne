package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "billet")
public class BilletEntity extends BaseEntity {
    public BilletEntity(QueryManager queryManager) {
        super(queryManager);
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_passager")
    private Integer idPassager;

    @Column(name = "id_vol")
    private Integer idVol;

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

    public Integer getIdpassager() {
        return idPassager;
    }

    public void setIdpassager(Integer idPassager) {
        this.idPassager = idPassager;
    }

    public Integer getIdvol() {
        return idVol;
    }

    public void setIdvol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getIdsiege() {
        return idSiege;
    }

    public void setIdsiege(Integer idSiege) {
        this.idSiege = idSiege;
    }

    public Float getPrix() {
        return prix;
    }

    public void setPrix(Float prix) {
        this.prix = prix;
    }

    public Integer getIdclassesiege() {
        return idClasseSiege;
    }

    public void setIdclassesiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public Integer getIdreservationpassager() {
        return idReservationPassager;
    }

    public void setIdreservationpassager(Integer idReservationPassager) {
        this.idReservationPassager = idReservationPassager;
    }

}
