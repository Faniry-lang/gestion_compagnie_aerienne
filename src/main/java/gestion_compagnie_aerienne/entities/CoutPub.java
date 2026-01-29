package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.schema.BaseEntity;
import legacy.query.QueryManager;
import java.util.List;

@Entity(tableName = "cout_pub")
public class CoutPub extends BaseEntity {
    public CoutPub() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column
    private Double montant;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public static Double getLast() throws Exception {
        String sql = "SELECT * FROM cout_pub ORDER BY id DESC LIMIT 1";
        List<CoutPub> cp = CoutPub.fetch(CoutPub.class, QueryManager.get_instance(), sql);

        return !cp.isEmpty() ? cp.get(0).getMontant() : 0f;
    }
}