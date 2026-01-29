package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "stock_produit")
public class StockProduit extends BaseEntity {
    public StockProduit() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "id_produit_extra")
    private Integer idProduitExtra;

    @Column
    private Integer qte;

    @Column(name = "date_stock")
    private LocalDateTime dateStock;

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

    public LocalDateTime getDateStock() {
        return dateStock;
    }

    public void setDateStock(LocalDateTime dateStock) {
        this.dateStock = dateStock;
    }

}
