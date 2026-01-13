package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseView;

import java.time.LocalDateTime;

@Entity(tableName = "reservation_details")
public class ReservationDetails extends BaseView {

    public ReservationDetails() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column
    private String reference;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

    @Column(name = "nbr_passagers")
    private Integer nbrPassagers;

    @Column(name = "montant_total")
    private Float montantTotal;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public Integer getNbrPassagers() {
        return nbrPassagers;
    }

    public void setNbrPassagers(Integer nbrPassagers) {
        this.nbrPassagers = nbrPassagers;
    }

    public Float getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(Float montantTotal) {
        this.montantTotal = montantTotal;
    }
}
