package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;


@Entity(tableName = "taxe_aeroport")
public class TaxeAeroport extends BaseEntity {
    public TaxeAeroport() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "id_aeroport")
    private Integer idAeroport;

    @Column
    private Float montant;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdAeroport() {
        return idAeroport;
    }

    public void setIdAeroport(Integer idAeroport) {
        this.idAeroport = idAeroport;
    }

    public Float getMontant() {
        return montant;
    }

    public void setMontant(Float montant) {
        this.montant = montant;
    }

}
