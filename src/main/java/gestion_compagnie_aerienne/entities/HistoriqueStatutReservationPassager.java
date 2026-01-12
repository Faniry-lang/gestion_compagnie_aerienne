package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "historique_statut_reservation_passager")
public class HistoriqueStatutReservationPassager extends BaseEntity {
    public HistoriqueStatutReservationPassager() {
        super();
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

    public Integer getIdReservationPassager() {
        return idReservationPassager;
    }

    public void setIdReservationPassager(Integer idReservationPassager) {
        this.idReservationPassager = idReservationPassager;
    }

    public Integer getIdStatutReservation() {
        return idStatutReservation;
    }

    public void setIdStatutReservation(Integer idStatutReservation) {
        this.idStatutReservation = idStatutReservation;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
