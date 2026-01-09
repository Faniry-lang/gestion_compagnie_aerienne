package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "siege")
public class Siege extends BaseEntity {
    public Siege() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_avion")
    private Integer idAvion;

    @Column(name = "numero_siege")
    private String numeroSiege;

    @Column(name = "id_classe_siege")
    private Integer idClasseSiege;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdavion() {
        return idAvion;
    }

    public void setIdavion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public String getNumerosiege() {
        return numeroSiege;
    }

    public void setNumerosiege(String numeroSiege) {
        this.numeroSiege = numeroSiege;
    }

    public Integer getIdclassesiege() {
        return idClasseSiege;
    }

    public void setIdclassesiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

}
