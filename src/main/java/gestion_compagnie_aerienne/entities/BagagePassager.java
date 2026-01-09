package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "bagage_passager")
public class BagagePassager extends BaseEntity {
    public BagagePassager() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_reservation_passager")
    private Integer idReservationPassager;

    @Column(name = "numero_bagage")
    private String numeroBagage;

    @Column
    private Float poids;

    @Column
    private Float longueur;

    @Column
    private Float largeur;

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

    public String getNumeroBagage() {
        return numeroBagage;
    }

    public void setNumeroBagage(String numeroBagage) {
        this.numeroBagage = numeroBagage;
    }

    public Float getPoids() {
        return poids;
    }

    public void setPoids(Float poids) {
        this.poids = poids;
    }

    public Float getLongueur() {
        return longueur;
    }

    public void setLongueur(Float longueur) {
        this.longueur = longueur;
    }

    public Float getLargeur() {
        return largeur;
    }

    public void setLargeur(Float largeur) {
        this.largeur = largeur;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
