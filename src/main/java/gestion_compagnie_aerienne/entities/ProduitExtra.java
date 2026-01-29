package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;


@Entity(tableName = "produit_extra")
public class ProduitExtra extends BaseEntity {
    public ProduitExtra() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column
    private String descr;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

}
