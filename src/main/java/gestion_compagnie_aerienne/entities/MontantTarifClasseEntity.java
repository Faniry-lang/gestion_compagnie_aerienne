package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "montant_tarif_classe")
public class MontantTarifClasseEntity extends BaseEntity {
    public MontantTarifClasseEntity(QueryManager queryManager) {
        super(queryManager);
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

    public Integer getIdtarifclasse() {
        return idTarifClasse;
    }

    public void setIdtarifclasse(Integer idTarifClasse) {
        this.idTarifClasse = idTarifClasse;
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
