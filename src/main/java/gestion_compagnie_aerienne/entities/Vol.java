package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "vol")
public class Vol extends BaseEntity {
    public Vol() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "numero_vol")
    private String numeroVol;

    @Column(name = "id_aeroport_depart")
    @ForeignKey(mappedBy = "aeroport", entity = Aeroport.class)
    private Integer idAeroportDepart;

    @Column(name = "id_aeroport_arrivee")
    @ForeignKey(mappedBy = "aeroport", entity = Aeroport.class)
    private Integer idAeroportArrivee;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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
