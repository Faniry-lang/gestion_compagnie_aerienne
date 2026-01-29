package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_billet")
public class HistoriqueStatutBillet extends BaseEntity {
    public HistoriqueStatutBillet() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "id_billet")
    private Integer idBillet;

    @Column(name = "id_statut_billet")
    private Integer idStatutBillet;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdBillet() {
        return idBillet;
    }

    public void setIdBillet(Integer idBillet) {
        this.idBillet = idBillet;
    }

    public Integer getIdStatutBillet() {
        return idStatutBillet;
    }

    public void setIdStatutBillet(Integer idStatutBillet) {
        this.idStatutBillet = idStatutBillet;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
