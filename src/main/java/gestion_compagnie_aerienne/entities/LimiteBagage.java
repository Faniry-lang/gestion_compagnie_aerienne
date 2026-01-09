package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "limite_bagage")
public class LimiteBagage extends BaseEntity {
    public LimiteBagage() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "volume_max")
    private Float volumeMax;

    @Column(name = "poids_max")
    private Float poidsMax;

    @Column(name = "pieces_max")
    private Integer piecesMax;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Float getVolumeMax() {
        return volumeMax;
    }

    public void setVolumeMax(Float volumeMax) {
        this.volumeMax = volumeMax;
    }

    public Float getPoidsMax() {
        return poidsMax;
    }

    public void setPoidsMax(Float poidsMax) {
        this.poidsMax = poidsMax;
    }

    public Integer getPiecesMax() {
        return piecesMax;
    }

    public void setPiecesMax(Integer piecesMax) {
        this.piecesMax = piecesMax;
    }

}
