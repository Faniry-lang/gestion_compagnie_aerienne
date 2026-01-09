package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;


@Entity(tableName = "escale")
public class Escale extends BaseEntity {
    public Escale() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column(name = "id_vol_avion")
    private Integer idVolAvion;

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

    public Integer getIdVolAvion() {
        return idVolAvion;
    }

    public void setIdVolAvion(Integer idVolAvion) {
        this.idVolAvion = idVolAvion;
    }

    public Integer getOrdre() {
        return ordre;
    }

    public void setOrdre(Integer ordre) {
        this.ordre = ordre;
    }

    public Integer getIdItineraire() {
        return idItineraire;
    }

    public void setIdItineraire(Integer idItineraire) {
        this.idItineraire = idItineraire;
    }

}
