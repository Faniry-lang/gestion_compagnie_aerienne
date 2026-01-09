package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "taxe_aeroport")
public class TaxeAeroportEntity extends BaseEntity {
    public TaxeAeroportEntity(QueryManager queryManager) {
        super(queryManager);
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_aeroport")
    private Integer idAeroport;

    @Column
    private Float montant;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdaeroport() {
        return idAeroport;
    }

    public void setIdaeroport(Integer idAeroport) {
        this.idAeroport = idAeroport;
    }

    public Float getMontant() {
        return montant;
    }

    public void setMontant(Float montant) {
        this.montant = montant;
    }

}
