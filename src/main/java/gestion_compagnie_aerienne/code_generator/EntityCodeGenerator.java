package gestion_compagnie_aerienne.code_generator;

import legacy.utils.EntityGenerator;

/**
 * Code Generator for Entity classes from database schema.
 * Usage:
 *   java EntityCodeGenerator [tableName]
 * 
 * If tableName is provided, generates entity for that specific table.
 * If no argument provided, generates entities for all tables in the database.
 */
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
