package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "escale")
public class EscaleEntity extends BaseEntity {
    public EscaleEntity(QueryManager queryManager) {
        super(queryManager);
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_vol")
    private Integer idVol;

    @Column
    private Integer ordre;

    @Column(name = "id_itineraire")
    private Integer idItineraire;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdvol() {
        return idVol;
    }

    public void setIdvol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getOrdre() {
        return ordre;
    }

    public void setOrdre(Integer ordre) {
        this.ordre = ordre;
    }

    public Integer getIditineraire() {
        return idItineraire;
    }

    public void setIditineraire(Integer idItineraire) {
        this.idItineraire = idItineraire;
    }

}
