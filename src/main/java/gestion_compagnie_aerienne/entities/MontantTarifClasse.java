package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "montant_tarif_classe")
public class MontantTarifClasse extends BaseEntity {
    public MontantTarifClasse() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_tarif_classe")
    private Integer idTarifClasse;

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

    public Integer getIdTarifClasse() {
        return idTarifClasse;
    }

    public void setIdTarifClasse(Integer idTarifClasse) {
        this.idTarifClasse = idTarifClasse;
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
