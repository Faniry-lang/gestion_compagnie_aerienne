package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "forfait_bagage")
public class ForfaitBagage extends BaseEntity {
    public ForfaitBagage() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "nom_forfait")
    private String nomForfait;

    @Column(name = "poids_min")
    private Float poidsMin;

    @Column(name = "poids_max")
    private Float poidsMax;

    @Column(name = "volume_total")
    private Float volumeTotal;

    @Column(name = "nbr_piece")
    private Integer nbrPiece;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNomforfait() {
        return nomForfait;
    }

    public void setNomforfait(String nomForfait) {
        this.nomForfait = nomForfait;
    }

    public Float getPoidsmin() {
        return poidsMin;
    }

    public void setPoidsmin(Float poidsMin) {
        this.poidsMin = poidsMin;
    }

    public Float getPoidsmax() {
        return poidsMax;
    }

    public void setPoidsmax(Float poidsMax) {
        this.poidsMax = poidsMax;
    }

    public Float getVolumetotal() {
        return volumeTotal;
    }

    public void setVolumetotal(Float volumeTotal) {
        this.volumeTotal = volumeTotal;
    }

    public Integer getNbrpiece() {
        return nbrPiece;
    }

    public void setNbrpiece(Integer nbrPiece) {
        this.nbrPiece = nbrPiece;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
