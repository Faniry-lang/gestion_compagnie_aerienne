package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "forfait_bagage")
public class ForfaitBagage extends BaseEntity {
    public ForfaitBagage() {
        super();
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

    public String getNomForfait() {
        return nomForfait;
    }

    public void setNomForfait(String nomForfait) {
        this.nomForfait = nomForfait;
    }

    public Float getPoidsMin() {
        return poidsMin;
    }

    public void setPoidsMin(Float poidsMin) {
        this.poidsMin = poidsMin;
    }

    public Float getPoidsMax() {
        return poidsMax;
    }

    public void setPoidsMax(Float poidsMax) {
        this.poidsMax = poidsMax;
    }

    public Float getVolumeTotal() {
        return volumeTotal;
    }

    public void setVolumeTotal(Float volumeTotal) {
        this.volumeTotal = volumeTotal;
    }

    public Integer getNbrPiece() {
        return nbrPiece;
    }

    public void setNbrPiece(Integer nbrPiece) {
        this.nbrPiece = nbrPiece;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
