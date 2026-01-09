package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_billet")
public class HistoriqueStatutBillet extends BaseEntity {
    public HistoriqueStatutBillet() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_billet")
    private Integer idBillet;

    @Column(name = "id_statut_billet")
    private Integer idStatutBillet;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdbillet() {
        return idBillet;
    }

    public void setIdbillet(Integer idBillet) {
        this.idBillet = idBillet;
    }

    public Integer getIdstatutbillet() {
        return idStatutBillet;
    }

    public void setIdstatutbillet(Integer idStatutBillet) {
        this.idStatutBillet = idStatutBillet;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
