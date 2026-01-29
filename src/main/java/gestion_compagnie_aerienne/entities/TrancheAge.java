package gestion_compagnie_aerienne.entities;

import legacy.annotations.Column;
import legacy.annotations.Entity;
import legacy.annotations.Id;
import legacy.query.QueryManager;
import legacy.schema.BaseEntity;

import java.util.List;


@Entity(tableName = "tranche_age")
public class TrancheAge extends BaseEntity {
    public TrancheAge() {
        super();
    }

    @Id
    @Column
    private Integer id;

    @Column(name = "age_min")
    private Integer ageMin;

    @Column(name = "age_max")
    private Integer ageMax;

    @Column
    private String libelle;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAgeMin() {
        return ageMin;
    }

    public void setAgeMin(Integer ageMin) {
        this.ageMin = ageMin;
    }

    public Integer getAgeMax() {
        return ageMax;
    }

    public void setAgeMax(Integer ageMax) {
        this.ageMax = ageMax;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public static TrancheAge getTrancheAge(Integer age) throws Exception {
        String sql = """
                SELECT * FROM tranche_age WHERE (age_min <= ? OR age_min IS NULL) AND (age_max > ? OR age_max IS NULL)
               """;
        List<TrancheAge> trancheAgeList = TrancheAge.fetch(TrancheAge.class, QueryManager.get_instance(), sql, age, age);
        if(trancheAgeList == null || trancheAgeList.isEmpty()) {
            return null;
        }
        return trancheAgeList.get(0);
    }

}
