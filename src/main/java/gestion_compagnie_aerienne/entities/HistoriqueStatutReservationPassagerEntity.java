package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_reservation_passager")
public class HistoriqueStatutReservationPassagerEntity extends BaseEntity {
    public HistoriqueStatutReservationPassagerEntity(QueryManager queryManager) {
        super(queryManager);
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_reservation_passager")
    private Integer idReservationPassager;

    @Column(name = "id_statut_reservation")
    private Integer idStatutReservation;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdreservationpassager() {
        return idReservationPassager;
    }

    public void setIdreservationpassager(Integer idReservationPassager) {
        this.idReservationPassager = idReservationPassager;
    }

    public Integer getIdstatutreservation() {
        return idStatutReservation;
    }

    public void setIdstatutreservation(Integer idStatutReservation) {
        this.idStatutReservation = idStatutReservation;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
