package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_avion")
public class HistoriqueStatutAvion extends BaseEntity {
    public HistoriqueStatutAvion() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_avion")
    private Integer idAvion;

    @Column(name = "id_statut_avion")
    private Integer idStatutAvion;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdavion() {
        return idAvion;
    }

    public void setIdavion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public Integer getIdstatutavion() {
        return idStatutAvion;
    }

    public void setIdstatutavion(Integer idStatutAvion) {
        this.idStatutAvion = idStatutAvion;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
