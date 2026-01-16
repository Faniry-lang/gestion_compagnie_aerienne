package gestion_compagnie_aerienne.code_generator;

import legacy.utils.EntityGenerator;

public class EntityCodeGenerator {

    // commands to run the generator
    // to generate a specific table: mvn exec:java -Dexec.mainClass="gestion_compagnie_aerienne.code_generator.EntityCodeGenerator" -Dexec.args="TABLE_NAME table"
    // to generate all tables: mvn exec:java -Dexec.mainClass="gestion_compagnie_aerienne.code_generator.EntityCodeGenerator"
    public static void main(String[] args) throws Exception {
        String outputFolderPath = "src/main/java";
        String packageName = "gestion_compagnie_aerienne.entities";

        EntityGenerator.generateEntity("remise_age_tarif", "TABLE", outputFolderPath, packageName);
    }
}
