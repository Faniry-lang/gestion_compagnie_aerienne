package gestion_compagnie_aerienne.entities;

import java.time.LocalDateTime;

public class CAGlobalParVolAvion {
    private Long idVolAvion;
    private String numeroVol;
    private String aeroportDepart;
    private String aeroportArrivee;
    private String modeleAvion;
    private LocalDateTime dateDepart;
    private Float caBillet;
    private Float caPub;
    private Float totalPaye;
    private Float resteAPayer;

    public CAGlobalParVolAvion() {
    }

    public Long getIdVolAvion() {
        return idVolAvion;
    }

    public void setIdVolAvion(Long idVolAvion) {
        this.idVolAvion = idVolAvion;
    }

    public String getNumeroVol() {
        return numeroVol;
    }

    public void setNumeroVol(String numeroVol) {
        this.numeroVol = numeroVol;
    }

    public String getAeroportDepart() {
        return aeroportDepart;
    }

    public void setAeroportDepart(String aeroportDepart) {
        this.aeroportDepart = aeroportDepart;
    }

    public String getAeroportArrivee() {
        return aeroportArrivee;
    }

    public void setAeroportArrivee(String aeroportArrivee) {
        this.aeroportArrivee = aeroportArrivee;
    }

    public String getModeleAvion() {
        return modeleAvion;
    }

    public void setModeleAvion(String modeleAvion) {
        this.modeleAvion = modeleAvion;
    }

    public LocalDateTime getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(LocalDateTime dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Float getCaBillet() {
        return caBillet;
    }

    public void setCaBillet(Float caBillet) {
        this.caBillet = caBillet;
    }

    public Float getCaPub() {
        return caPub;
    }

    public void setCaPub(Float caPub) {
        this.caPub = caPub;
    }

    public Float getTotalPaye() {
        return totalPaye;
    }

    public void setTotalPaye(Float totalPaye) {
        this.totalPaye = totalPaye;
    }

    public Float getResteAPayer() {
        return resteAPayer;
    }

    public void setResteAPayer(Float resteAPayer) {
        this.resteAPayer = resteAPayer;
    }

    public Float getTotal() {
        return (caBillet != null ? caBillet : 0) + (caPub != null ? caPub : 0);
    }
}
