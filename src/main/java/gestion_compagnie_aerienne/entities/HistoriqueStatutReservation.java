package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_reservation")
public class HistoriqueStatutReservation extends BaseEntity {
    public HistoriqueStatutReservation() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_reservation")
    private Integer idReservation;

    @Column(name = "id_statut_reservation")
    private Integer idStatutReservation;

    @Column(name = "prix_total")
    private Float prixTotal;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdreservation() {
        return idReservation;
    }

    public void setIdreservation(Integer idReservation) {
        this.idReservation = idReservation;
    }

    public Integer getIdstatutreservation() {
        return idStatutReservation;
    }

    public void setIdstatutreservation(Integer idStatutReservation) {
        this.idStatutReservation = idStatutReservation;
    }

    public Float getPrixtotal() {
        return prixTotal;
    }

    public void setPrixtotal(Float prixTotal) {
        this.prixTotal = prixTotal;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
