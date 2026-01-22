package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;
import java.util.List;
import java.util.ArrayList;

@Entity(tableName = "diffusion_pub")
public class DiffusionPub extends BaseEntity {
    public DiffusionPub() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_societe")
    @ForeignKey(mappedBy = "societe", entity = Societe.class)
    private Integer idSociete;

    @Column
    private Integer mois;

    @Column
    private Integer annee;

    @Column(name = "nbr_diffusion")
    private Integer nbrDiffusion;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdSociete() {
        return idSociete;
    }

    public void setIdSociete(Integer idSociete) {
        this.idSociete = idSociete;
    }

    public Integer getMois() {
        return mois;
    }

    public void setMois(Integer mois) {
        this.mois = mois;
    }

    public Integer getAnnee() {
        return annee;
    }

    public void setAnnee(Integer annee) {
        this.annee = annee;
    }

    public Integer getNbrDiffusion() {
        return nbrDiffusion;
    }

    public void setNbrDiffusion(Integer nbrDiffusion) {
        this.nbrDiffusion = nbrDiffusion;
    }

    public Double getCA(Integer idSociete, Integer mois, Integer annee) throws Exception {
        List<Filter> filters = new ArrayList<>();

        if(idSociete != null) {
            filters.add(new Filter("id_societe" , Comparator.EQUALS, idSociete));
        }
        if(mois != null && annee != null) {
            filters.add(new Filter("mois" , Comparator.EQUALS, mois));
            filters.add(new Filter("annee" , Comparator.EQUALS, annee));
        }
        List<DiffusionPub> diffusions = DiffusionPub.filter(DiffusionPub.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
        Double coutPub = CoutPub.getLast();
        Double ca = 0.0;
        
        if(diffusions != null) {
            for(DiffusionPub dp : diffusions) {
                ca += dp.getNbrDiffusion() * coutPub;
            }
        }
        return ca;
    }
}