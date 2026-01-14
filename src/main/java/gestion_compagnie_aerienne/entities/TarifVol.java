package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;
import java.util.List;

@Entity(tableName = "tarif_vol")
public class TarifVol extends BaseEntity {
    public TarifVol() {
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

    @Column
    private Float montant;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public Float getMontant() {
        return montant;
    }

    public void setMontant(Float montant) {
        this.montant = montant;
    }

    public Integer getIdClasseSiege() {
        return idClasseSiege;
    }

    public void setIdClasseSiege(Integer idClasseSiege) {
        this.idClasseSiege = idClasseSiege;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public static TarifVol getTarifVol(Integer idVol, Integer idClasseSiege, LocalDateTime date) throws Exception {
        String sql = "SELECT *\n" +
                "    FROM tarif_vol WHERE id_vol = ? AND id_classe_siege = ? OR id_classe_siege IS NULL\n" +
                "                   AND created_on <= ?\n" +
                "ORDER BY created_on DESC LIMIT 1";
        List<TarifVol> tarifVolList = TarifVol.fetch(TarifVol.class, QueryManager.get_instance(), sql, idVol, idClasseSiege, date);
        if (tarifVolList.isEmpty()) {
            return null;
        }
        return tarifVolList.getFirst();
    }
}
