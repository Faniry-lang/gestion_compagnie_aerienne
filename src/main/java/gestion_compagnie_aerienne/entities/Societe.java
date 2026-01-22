package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

@Entity(tableName = "societe")
public class Societe extends BaseEntity {
    public Societe() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column
    private String nom;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
