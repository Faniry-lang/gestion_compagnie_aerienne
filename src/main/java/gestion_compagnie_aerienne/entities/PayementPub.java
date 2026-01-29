package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;

import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;

@Entity(tableName = "payement_pub")
public class PayementPub extends BaseEntity {
    public PayementPub() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_societe")
    @ForeignKey(mappedBy = "societe", entity = Societe.class)
    private Integer idSociete;

    @Column
    private Double montant;

    @Column
    private LocalDateTime date;

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

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public static Double getCA(Integer idSociete, LocalDateTime date) throws Exception {
        List<Filter> filters = new ArrayList<>();

        if (idSociete != null) {
            filters.add(new Filter("id_societe", Comparator.EQUALS, idSociete));
        }

        if (date != null) {
            filters.add(new Filter("date", Comparator.GREATER_THAN_OR_EQUALS, LocalDateTime.of(date.getYear(), date.getMonth(), 1, 0, 0)));
            //filters.add(new Filter("date", Comparator.LESS_THAN, LocalDateTime.of(date.getYear(), date.getMonth().plus(1), 1, 0, 0)));
        }

        List<PayementPub> payements = PayementPub.filter(PayementPub.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
        Double ca = 0.0;

        if (payements != null) {
            for (PayementPub pp : payements) {
                ca += pp.getMontant();
            }
        }
        return ca;
    }

    public static Double getResteAPayer(Integer idSociete, LocalDateTime date, Integer idVolAvion) throws Exception {
        // Calculer le CA attendu : nbr_diffusion * cout_pub pour le mois/annee
        List<Filter> filters = new ArrayList<>();
        if (idSociete != null) {
            filters.add(new Filter("id_societe", Comparator.EQUALS, idSociete));
        }

        if (idVolAvion != null) {
            filters.add(new Filter("id_vol_avion", Comparator.EQUALS, idVolAvion));
        }

        if (date != null) {
            filters.add(new Filter("mois", Comparator.EQUALS, date.getMonthValue()));
            filters.add(new Filter("annee", Comparator.EQUALS, date.getYear()));
        }

        List<DiffusionPub> diffusions = DiffusionPub.filter(DiffusionPub.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
        Double coutPub = CoutPub.getLast();
        Double caAttendu = 0.0;

        if (diffusions != null) {
            for (DiffusionPub dp : diffusions) {
                caAttendu += dp.getNbrDiffusion() * coutPub;
            }
        }

        // CA payé
        Double caPaye = getCA(idSociete, date);

        return caAttendu - caPaye;
    }

    public static Double getTotalPayerParVol(LocalDateTime date, Integer idVolAvion) throws Exception {
        // Calculer le CA attendu : nbr_diffusion * cout_pub pour le mois/annee
        List<Filter> filters = new ArrayList<>();

        if (idVolAvion != null) {
            filters.add(new Filter("id_vol_avion", Comparator.EQUALS, idVolAvion));
        }

        if (date != null) {
            filters.add(new Filter("mois", Comparator.EQUALS, date.getMonthValue()));
            filters.add(new Filter("annee", Comparator.EQUALS, date.getYear()));
        }

        List<DiffusionPub> diffusions = DiffusionPub.filter(DiffusionPub.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));

        // CA payé
        Double caPaye = 0.0;

        if (diffusions != null) {
            for (DiffusionPub dp : diffusions) {
                caPaye += getCA(dp.getIdSociete(), date);
            }
        }

        return caPaye;
    }
}