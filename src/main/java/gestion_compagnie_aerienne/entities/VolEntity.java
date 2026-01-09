package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "vol")
public class VolEntity extends BaseEntity {
    public VolEntity(QueryManager queryManager) {
        super(queryManager);
    }

    @Id
    @Column
    private Long id;

    @Column(name = "numero_vol")
    private String numeroVol;

    @Column(name = "id_avion")
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

    public String getNumerovol() {
        return numeroVol;
    }

    public void setNumerovol(String numeroVol) {
        this.numeroVol = numeroVol;
    }

    public Integer getIdavion() {
        return idAvion;
    }

    public void setIdavion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public LocalDateTime getDatedepart() {
        return dateDepart;
    }

    public void setDatedepart(LocalDateTime dateDepart) {
        this.dateDepart = dateDepart;
    }

    public LocalDateTime getDatearrivee() {
        return dateArrivee;
    }

    public void setDatearrivee(LocalDateTime dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public LocalDateTime getCreatedon() {
        return createdOn;
    }

    public void setCreatedon(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

}
