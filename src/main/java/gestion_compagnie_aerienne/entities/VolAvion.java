package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.query.RawObject;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Entity(tableName = "vol_avion")
public class VolAvion extends BaseEntity {
    public VolAvion() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_vol")
    @ForeignKey(mappedBy = "vol", entity = Vol.class)
    private Integer idVol;

    @Column(name = "id_avion")
    @ForeignKey(mappedBy = "avion", entity = Avion.class)
    private Integer idAvion;

    @Column(name = "date_depart")
    private LocalDateTime dateDepart;

    @Column(name = "date_arrivee")
    private LocalDateTime dateArrivee;

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

    public Integer getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public LocalDateTime getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(LocalDateTime dateDepart) {
        this.dateDepart = dateDepart;
    }

    public LocalDateTime getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(LocalDateTime dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public Map<Siege, Boolean> getSiegesDisponibles() throws Exception {
        String sql = """
                SELECT *,
                       CASE
                           WHEN
                               id NOT IN (
                                   SELECT id_siege FROM reservation_passager WHERE id_vol_avion = ?
                               )
                           THEN TRUE
                           ELSE FALSE
                       END AS est_disponible
                FROM siege WHERE id_avion = ?
                """;
        List<RawObject> rawObjects = this.getQueryManager().executeSelect(sql, this.id, this.idAvion);
        Map<Siege, Boolean> siegesDisponibles = new java.util.HashMap<>();
        for(RawObject ro : rawObjects) {
            Long id = ((Integer) ro.getData().get("id")).longValue();
            Integer idAvion = (Integer) ro.getData().get("id_avion");
            String numeroSiege = (String) ro.getData().get("numero_siege");
            Integer idClasseSiege = (Integer) ro.getData().get("id_classe_siege");
            Boolean estDisponible = (Boolean) ro.getData().get("est_disponible");
            Siege siege = new Siege();
            siege.setId(id);
            siege.setIdAvion(idAvion);
            siege.setNumeroSiege(numeroSiege);
            siege.setIdClasseSiege(idClasseSiege);
            siegesDisponibles.put(siege, estDisponible);
        }
        return siegesDisponibles;
    }
}
