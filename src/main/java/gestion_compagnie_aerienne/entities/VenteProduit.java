package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "vente_produit")
public class VenteProduit extends BaseEntity {
    public VenteProduit() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "id_produit_extra")
    private Integer idProduitExtra;

    @Column
    private Integer qte;

    @Column(name = "prix_unitaire_du_jour")
    private Float prixUnitaireDuJour;

    @Column(name = "id_vol_avion")
    private Integer idVolAvion;

    @Column(name = "date_vente")
    private LocalDateTime dateVente;

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

    public Integer getQte() {
        return qte;
    }

    public void setQte(Integer qte) {
        this.qte = qte;
    }

    public Float getPrixUnitaireDuJour() {
        return prixUnitaireDuJour;
    }

    public void setPrixUnitaireDuJour(Float prixUnitaireDuJour) {
        this.prixUnitaireDuJour = prixUnitaireDuJour;
    }

    public Integer getIdVolAvion() {
        return idVolAvion;
    }

    public void setIdVolAvion(Integer idVolAvion) {
        this.idVolAvion = idVolAvion;
    }

    public LocalDateTime getDateVente() {
        return dateVente;
    }

    public void setDateVente(LocalDateTime dateVente) {
        this.dateVente = dateVente;
    }

}
