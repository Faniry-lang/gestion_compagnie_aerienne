package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.ForeignKey;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;

import java.time.LocalDateTime;

@Entity(tableName = "reservation")
public class Reservation extends BaseEntity {
    public Reservation() {
        super();
    }

    @Id
    @Column
    private Long id;

    @Column
    private String reference;

    // ity ilay olona manao anle reservation
    // ex: Rakoto a reservé 3 places adultes et 2 places enfants
    @Column(name = "id_passager")
    @ForeignKey(mappedBy = "passager", entity = Passager.class)
    private Integer idPassager;

    @Column(name = "created_on")
    private LocalDateTime createdOn;

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

    public Integer getIdPassager() {
        return idPassager;
    }

    public void setIdPassager(Integer idPassager) {
        this.idPassager = idPassager;
    }

}
