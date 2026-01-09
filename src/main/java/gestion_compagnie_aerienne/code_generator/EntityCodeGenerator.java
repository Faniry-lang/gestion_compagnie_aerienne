package gestion_compagnie_aerienne.code_generator;

import legacy.utils.EntityGenerator;

public class EntityCodeGenerator {

    public static void main(String[] args) throws Exception {
        String outputFolderPath = "src/main/java";
        String packageName = "gestion_compagnie_aerienne.entities";

        if (args.length > 0 && !args[0].trim().isEmpty()) {
            // Generate for specific table
            String tableName = args[0].trim();
            System.out.println("Generating entity for table: " + tableName);
            EntityGenerator.generateEntity(tableName, outputFolderPath, packageName);
        } else {
            // Generate for all tables
            System.out.println("No table name specified. Generating entities for all tables...");
            EntityGenerator.generateAllEntities(outputFolderPath, packageName);
        }
    }
}
