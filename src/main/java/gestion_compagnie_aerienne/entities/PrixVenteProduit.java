package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "prix_vente_produit")
public class PrixVenteProduit extends BaseEntity {
    public PrixVenteProduit() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "id_produit_extra")
    private Integer idProduitExtra;

    @Column
    private Float montant;

    @Column(name = "date_mis_a_jour")
    private LocalDateTime dateMisAJour;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdProduitExtra() {
        return idProduitExtra;
    }

    public void setIdProduitExtra(Integer idProduitExtra) {
        this.idProduitExtra = idProduitExtra;
    }

    public Float getMontant() {
        return montant;
    }

    public void setMontant(Float montant) {
        this.montant = montant;
    }

    public LocalDateTime getDateMisAJour() {
        return dateMisAJour;
    }

    public void setDateMisAJour(LocalDateTime dateMisAJour) {
        this.dateMisAJour = dateMisAJour;
    }

}
