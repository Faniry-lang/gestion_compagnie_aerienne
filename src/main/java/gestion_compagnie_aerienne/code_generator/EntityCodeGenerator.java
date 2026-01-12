package gestion_compagnie_aerienne.code_generator;

import legacy.utils.EntityGenerator;

public class EntityCodeGenerator {

    public static void main(String[] args) throws Exception {
        String outputFolderPath = "src/main/java";
        String packageName = "gestion_compagnie_aerienne.entities";

        if (args.length > 0 && !args[0].trim().isEmpty() && !args[1].trim().isEmpty()) {
            String tableName = args[0].trim();
            String tableType = args[1].trim();
            if(!tableType.equalsIgnoreCase("table") && !tableType.equalsIgnoreCase("view")) {
                throw new IllegalArgumentException("Invalid table type argument");
            }
            System.out.println("Generating entity for "+tableType+": " + tableName);
            EntityGenerator.generateEntity(tableName, tableType, outputFolderPath, packageName);
        } else {
            System.out.println("No table name specified. Generating entities for all tables...");
            EntityGenerator.generateAllEntities(outputFolderPath, packageName);
        }
    }
}
