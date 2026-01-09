package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "itineraire")
public class Itineraire extends BaseEntity {
    public Itineraire() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_aeroport_depart")
    private Integer idAeroportDepart;

    @Column(name = "id_aeroport_arrivee")
    private Integer idAeroportArrivee;

    @Column(name = "distance_km")
    private Float distanceKm;

    @Column(name = "duree_moyenne_estimee")
    private Integer dureeMoyenneEstimee;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdaeroportdepart() {
        return idAeroportDepart;
    }

    public void setIdaeroportdepart(Integer idAeroportDepart) {
        this.idAeroportDepart = idAeroportDepart;
    }

    public Integer getIdaeroportarrivee() {
        return idAeroportArrivee;
    }

    public void setIdaeroportarrivee(Integer idAeroportArrivee) {
        this.idAeroportArrivee = idAeroportArrivee;
    }

    public Float getDistancekm() {
        return distanceKm;
    }

    public void setDistancekm(Float distanceKm) {
        this.distanceKm = distanceKm;
    }

    public Integer getDureemoyenneestimee() {
        return dureeMoyenneEstimee;
    }

    public void setDureemoyenneestimee(Integer dureeMoyenneEstimee) {
        this.dureeMoyenneEstimee = dureeMoyenneEstimee;
    }

}
