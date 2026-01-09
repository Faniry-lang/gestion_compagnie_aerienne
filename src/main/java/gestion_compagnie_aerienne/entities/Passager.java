package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.time.LocalDate;

@Entity(tableName = "passager")
public class Passager extends BaseEntity {
    public Passager() {
        super(QueryManager.get_instance());
    }

    @Id
    @Column
    private Long id;

    @Column
    private String nom;

    @Column
    private String prenom;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column
    private String nationalite;

    @Column(name = "numero_passeport")
    private String numeroPasseport;

    @Column
    private String email;

    @Column
    private String telephone;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public LocalDate getDatenaissance() {
        return dateNaissance;
    }

    public void setDatenaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getNationalite() {
        return nationalite;
    }

    public void setNationalite(String nationalite) {
        this.nationalite = nationalite;
    }

    public String getNumeropasseport() {
        return numeroPasseport;
    }

    public void setNumeropasseport(String numeroPasseport) {
        this.numeroPasseport = numeroPasseport;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

}
