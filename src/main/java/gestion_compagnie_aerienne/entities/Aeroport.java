package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;


@Entity(tableName = "aeroport")
public class Aeroport extends BaseEntity {
    public Aeroport() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "code_iata")
    private String codeIata;

    @Column
    private String nom;

    @Column
    private String ville;

    @Column
    private String pays;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCodeIata() {
        return codeIata;
    }

    public void setCodeIata(String codeIata) {
        this.codeIata = codeIata;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

}
