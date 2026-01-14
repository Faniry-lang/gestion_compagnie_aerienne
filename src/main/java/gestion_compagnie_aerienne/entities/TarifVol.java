package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "tarif_vol")
public class TarifVol extends BaseEntity {
    public TarifVol() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Id
    @Column(name = "id_vol")
    @ForeignKey(mappedBy = "vol", entity = Vol.class)
    private Integer idVol;

    @Column(name = "id_classe_siege")
    private Integer idClasseSiege;

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

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public Float getMontant() {
        return montant;
    }

    public void setMontant(Float montant) {
        this.montant = montant;
    }

    public Integer getIdClasseSiege() {
        return idClasseSiege;
    }

    public void setIdClasseSiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }
}
