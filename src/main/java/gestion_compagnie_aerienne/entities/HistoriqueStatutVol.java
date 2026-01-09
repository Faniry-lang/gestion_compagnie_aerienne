package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_vol")
public class HistoriqueStatutVol extends BaseEntity {
    public HistoriqueStatutVol() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_vol")
    private Integer idVol;

    @Column(name = "id_statut_vol")
    private Integer idStatutVol;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdvol() {
        return idVol;
    }

    public void setIdvol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getIdstatutvol() {
        return idStatutVol;
    }

    public void setIdstatutvol(Integer idStatutVol) {
        this.idStatutVol = idStatutVol;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
