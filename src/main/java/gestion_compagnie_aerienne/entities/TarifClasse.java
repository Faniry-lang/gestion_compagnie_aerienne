package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "tarif_classe")
public class TarifClasse extends BaseEntity {
    public TarifClasse() {
        super(QueryManager.get_instance());
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

    public Integer getIdtypeavion() {
        return idTypeAvion;
    }

    public void setIdtypeavion(Integer idTypeAvion) {
        this.idTypeAvion = idTypeAvion;
    }

    public Integer getIditineraire() {
        return idItineraire;
    }

    public void setIditineraire(Integer idItineraire) {
        this.idItineraire = idItineraire;
    }

    public Integer getIdclassesiege() {
        return idClasseSiege;
    }

    public void setIdclassesiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public Integer getIdforfaitbagage() {
        return idForfaitBagage;
    }

    public void setIdforfaitbagage(Integer idForfaitBagage) {
        this.idForfaitBagage = idForfaitBagage;
    }

    public Float getMontant() {
        return montant;
    }

    public void setMontant(Float montant) {
        this.montant = montant;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
