package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDate;

@Entity(tableName = "avion")
public class Avion extends BaseEntity {
    public Avion() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "id_type_avion")
    @ForeignKey(mappedBy = "type_avion", entity = TypeAvion.class)
    private Integer idTypeAvion;

    @Column
    private String modele;

    @Column(name = "nbr_siege")
    private Integer nbrSiege;

    @Column
    private String constructeur;

    @Column(name = "date_mise_service")
    private LocalDate dateMiseService;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdTypeAvion() {
        return idTypeAvion;
    }

    public void setIdTypeAvion(Integer idTypeAvion) {
        this.idTypeAvion = idTypeAvion;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Integer getNbrSiege() {
        return nbrSiege;
    }

    public void setNbrSiege(Integer nbrSiege) {
        this.nbrSiege = nbrSiege;
    }

    public String getConstructeur() {
        return constructeur;
    }

    public void setConstructeur(String constructeur) {
        this.constructeur = constructeur;
    }

    public LocalDate getDateMiseService() {
        return dateMiseService;
    }

    public void setDateMiseService(LocalDate dateMiseService) {
        this.dateMiseService = dateMiseService;
    }

}
