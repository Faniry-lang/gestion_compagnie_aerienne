package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;


@Entity(tableName = "itineraire")
public class Itineraire extends BaseEntity {
    public Itineraire() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_aeroport_depart")
    @ForeignKey(mappedBy = "aeroport", entity = Aeroport.class)
    private Integer idAeroportDepart;

    @Column(name = "id_aeroport_arrivee")
    @ForeignKey(mappedBy = "aeroport", entity = Aeroport.class)
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

    public Integer getIdAeroportDepart() {
        return idAeroportDepart;
    }

    public void setIdAeroportDepart(Integer idAeroportDepart) {
        this.idAeroportDepart = idAeroportDepart;
    }

    public Integer getIdAeroportArrivee() {
        return idAeroportArrivee;
    }

    public void setIdAeroportArrivee(Integer idAeroportArrivee) {
        this.idAeroportArrivee = idAeroportArrivee;
    }

    public Float getDistanceKm() {
        return distanceKm;
    }

    public void setDistanceKm(Float distanceKm) {
        this.distanceKm = distanceKm;
    }

    public Integer getDureeMoyenneEstimee() {
        return dureeMoyenneEstimee;
    }

    public void setDureeMoyenneEstimee(Integer dureeMoyenneEstimee) {
        this.dureeMoyenneEstimee = dureeMoyenneEstimee;
    }

}
