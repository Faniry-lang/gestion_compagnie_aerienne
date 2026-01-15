package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.schema.BaseView;


@Entity(tableName = "v_avion_siege")
public class V_AvionSiege extends BaseView {
    public V_AvionSiege() {
        super();
    }

    @Column(name = "id_avion")
    @ForeignKey(mappedBy = "avion", entity = Avion.class)
    private Integer idAvion;

    @Column(name = "avion_modele")
    private String avionModele;

    @Column(name = "nbr_siege")
    private Integer nbrSiege;

    @Column(name = "id_classe_siege")
    @ForeignKey(mappedBy = "classe_siege", entity = ClasseSiege.class)
    private Integer idClasseSiege;

    @Column(name = "classe_siege_libelle")
    private String classeSiegeLibelle;

    public Integer getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public String getAvionModele() {
        return avionModele;
    }

    public void setAvionModele(String avionModele) {
        this.avionModele = avionModele;
    }

    public Integer getNbrSiege() {
        return nbrSiege;
    }

    public void setNbrSiege(Integer nbrSiege) {
        this.nbrSiege = nbrSiege;
    }

    public Integer getIdClasseSiege() {
        return idClasseSiege;
    }

    public void setIdClasseSiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public String getClasseSiegeLibelle() {
        return classeSiegeLibelle;
    }

    public void setClasseSiegeLibelle(String classeSiegeLibelle) {
        this.classeSiegeLibelle = classeSiegeLibelle;
    }

}
