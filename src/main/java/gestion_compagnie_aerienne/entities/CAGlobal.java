package gestion_compagnie_aerienne.entities;

import java.time.LocalDateTime;

public class CAGlobal {
    private Float caBillet;
    private Float caPub;
    private Float caProduitExtra;
    private LocalDateTime date;

    public CAGlobal() {
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

    public Float getCaProduitExtra() {
        return caProduitExtra;
    }

    public void setCaProduitExtra(Float caProduitExtra) {
        this.caProduitExtra = caProduitExtra;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    private Float caBilletTheorique;
    private Float caPubTheorique;
    private Float caExtraTheorique;

    public Float getCaBilletTheorique() {
        return caBilletTheorique;
    }

    public void setCaBilletTheorique(Float caBilletTheorique) {
        this.caBilletTheorique = caBilletTheorique;
    }

    public Float getCaPubTheorique() {
        return caPubTheorique;
    }

    public void setCaPubTheorique(Float caPubTheorique) {
        this.caPubTheorique = caPubTheorique;
    }

    public Float getCaExtraTheorique() {
        return caExtraTheorique;
    }

    public void setCaExtraTheorique(Float caExtraTheorique) {
        this.caExtraTheorique = caExtraTheorique;
    }

    public Float getTotalTheorique() {
        return (caBilletTheorique != null ? caBilletTheorique : 0) + 
               (caPubTheorique != null ? caPubTheorique : 0) + 
               (caExtraTheorique != null ? caExtraTheorique : 0);
    }

    public Float getTotal() {
        return (caBillet != null ? caBillet : 0) + 
               (caPub != null ? caPub : 0) + 
               (caProduitExtra != null ? caProduitExtra : 0);
    }
}
