package gestion_compagnie_aerienne.code_generator;

import gestion_compagnie_aerienne.entities.Aeroport;
import gestion_compagnie_aerienne.entities.VolDetails;
import legacy.query.QueryManager;

import java.util.List;

// classe pour tester la fonction mount de BaseEntity de Legacy orm

public class Test {
    static void main(String[] args) throws Exception {
        List<VolDetails> volsDetails = VolDetails.findAll(VolDetails.class, QueryManager.get_instance());
        Aeroport depTest = (Aeroport) volsDetails.get(0).getForeignKey("id_aeroport_depart");
        System.out.println(depTest.getNom());
    }
}
