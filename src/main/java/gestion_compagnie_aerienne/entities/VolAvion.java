package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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

    public List<Siege> getSiegesDisponibles() {

        String sql = "SELECT * FROM siege WHERE id_avion = ? AND id NOT IN (\n" +
                "    SELECT id_siege FROM reservation_passager WHERE id_vol_avion = ?\n" +
                "    )";
        try {
            List<Siege> siegeDisponibles = fetch(Siege.class, QueryManager.get_instance(), sql, this.getIdAvion(), this.getId());
            return siegeDisponibles;
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

}
