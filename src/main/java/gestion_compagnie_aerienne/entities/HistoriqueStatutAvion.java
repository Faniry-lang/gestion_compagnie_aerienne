package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_avion")
public class HistoriqueStatutAvion extends BaseEntity {
    public HistoriqueStatutAvion() {
        super();
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

    public Integer getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public Integer getIdStatutAvion() {
        return idStatutAvion;
    }

    public void setIdStatutAvion(Integer idStatutAvion) {
        this.idStatutAvion = idStatutAvion;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
