package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;


@Entity(tableName = "siege")
public class Siege extends BaseEntity {
    public Siege() {
        super();
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

    public Integer getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public String getNumeroSiege() {
        return numeroSiege;
    }

    public void setNumeroSiege(String numeroSiege) {
        this.numeroSiege = numeroSiege;
    }

    public Integer getIdClasseSiege() {
        return idClasseSiege;
    }

    public void setIdClasseSiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

}
