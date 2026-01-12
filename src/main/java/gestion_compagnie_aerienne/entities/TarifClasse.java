package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "tarif_classe")
public class TarifClasse extends BaseEntity {
    public TarifClasse() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_type_avion")
    private Integer idTypeAvion;

    @Column(name = "id_itineraire")
    private Integer idItineraire;

    @Column(name = "id_classe_siege")
    private Integer idClasseSiege;

    @Column(name = "id_forfait_bagage")
    private Integer idForfaitBagage;

    @Column
    private Float montant;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdTypeAvion() {
        return idTypeAvion;
    }

    public void setIdTypeAvion(Integer idTypeAvion) {
        this.idTypeAvion = idTypeAvion;
    }

    public Integer getIdItineraire() {
        return idItineraire;
    }

    public void setIdItineraire(Integer idItineraire) {
        this.idItineraire = idItineraire;
    }

    public Integer getIdClasseSiege() {
        return idClasseSiege;
    }

    public void setIdClasseSiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public Integer getIdForfaitBagage() {
        return idForfaitBagage;
    }

    public void setIdForfaitBagage(Integer idForfaitBagage) {
        this.idForfaitBagage = idForfaitBagage;
    }

    public Float getMontant() {
        return montant;
    }

    public void setMontant(Float montant) {
        this.montant = montant;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
