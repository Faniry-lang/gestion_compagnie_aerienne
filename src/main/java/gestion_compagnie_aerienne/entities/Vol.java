package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "vol")
public class Vol extends BaseEntity {
    public Vol() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "numero_vol")
    private String numeroVol;

    @Column(name = "id_aeroport_depart")
    private Integer idAeroportDepart;

    @Column(name = "id_aeroport_arrivee")
    private Integer idAeroportArrivee;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumeroVol() {
        return numeroVol;
    }

    public void setNumeroVol(String numeroVol) {
        this.numeroVol = numeroVol;
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

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
