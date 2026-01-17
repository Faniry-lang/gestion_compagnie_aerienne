package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;
import java.util.List;

@Entity(tableName = "remise_age_tarif")
public class RemiseAgeTarif extends BaseEntity {
    public RemiseAgeTarif() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_vol")
    @ForeignKey(mappedBy = "vol", entity = Vol.class)
    private Integer idVol;

    @Column(name = "id_classe_siege")
    @ForeignKey(mappedBy = "classe_siege", entity = ClasseSiege.class)
    private Integer idClasseSiege;

    @Column(name = "id_tranche_age")
    @ForeignKey(mappedBy = "tranche_age", entity = TrancheAge.class)
    private Integer idTrancheAge;

    @Column(name = "montant_pourcentage")
    private Float montantPourcentage;

    @Column(name = "montant_complet")
    private Float montantComplet;

    @Column(name = "est_en_pourcentage")
    private boolean estEnPourcentage;

    public Integer getIdTrancheAgeRef() {
        return idTrancheAgeRef;
    }

    public void setIdTrancheAgeRef(Integer idTrancheAgeRef) {
        this.idTrancheAgeRef = idTrancheAgeRef;
    }

    @Column(name = "id_tranche_age_ref")
    @ForeignKey(mappedBy = "tranche_age", entity = TrancheAge.class)
    private Integer idTrancheAgeRef;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getIdClasseSiege() {
        return idClasseSiege;
    }

    public void setIdClasseSiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public Integer getIdTrancheAge() {
        return idTrancheAge;
    }

    public void setIdTrancheAge(Integer idTrancheAge) {
        this.idTrancheAge = idTrancheAge;
    }

    public Float getMontantPourcentage() {
        return montantPourcentage;
    }

    public void setMontantPourcentage(Float montantPourcentage) {
        this.montantPourcentage = montantPourcentage;
    }

    public Float getMontantComplet() {
        return montantComplet;
    }

    public void setMontantComplet(Float montantComplet) {
        this.montantComplet = montantComplet;
    }

    public boolean getEstEnPourcentage() {
        return estEnPourcentage;
    }

    public void setEstEnPourcentage(boolean estEnPourcentage) {
        this.estEnPourcentage = estEnPourcentage;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public static RemiseAgeTarif getRemise(Integer idVol, Integer idClasseSiege, Integer idTrancheAge, LocalDateTime date) throws Exception {
        String sql = """
                SELECT * FROM remise_age_tarif 
                WHERE id_vol = ? 
                AND (id_classe_siege = ? OR id_classe_siege IS NULL)
                AND id_tranche_age = ?
                AND created_on <= ?
                ORDER BY 
                    CASE WHEN id_classe_siege IS NULL THEN 1 ELSE 0 END,
                    created_on DESC
                LIMIT 1
               """;
        List<RemiseAgeTarif> remiseAgeTarifList = fetch(
                RemiseAgeTarif.class,
                QueryManager.get_instance(),
                sql,
                idVol,
                idClasseSiege,
                idTrancheAge,
                date
                );
        if(remiseAgeTarifList == null || remiseAgeTarifList.isEmpty()) {
            return null;
        }

        return remiseAgeTarifList.get(0);
    }

}
