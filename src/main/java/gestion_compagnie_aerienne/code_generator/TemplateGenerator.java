package gestion_compagnie_aerienne.code_generator;

import java.io.IOException;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import legacy.annotations.Column;
import legacy.annotations.Id;

// code experimental, mbola tsy mandeh

public final class TemplateGenerator {

    public static void main(String[] args) throws Exception {
        if (args.length == 0 || args[0].isBlank()) {
            System.out.println("Usage: TemplateGenerator <EntityName>");
            return;
        }

        String entityName = args[0].trim();
        String lowerName = decapitalize(entityName);

        generateServlet(entityName, lowerName);
        generateJsp(entityName, lowerName);
        updateWebXml(entityName, lowerName);

        System.out.println("Templates generated for entity: " + entityName);
    }

    private static String decapitalize(String name) {
        if (name == null || name.isEmpty()) return name;
        return name.substring(0, 1).toLowerCase(Locale.ROOT) + name.substring(1);
    }

    private static String capitalize(String name) {
        if (name == null || name.isEmpty()) return name;
        return name.substring(0, 1).toUpperCase(Locale.ROOT) + name.substring(1);
    }

    private static void generateServlet(String entityName, String lowerName) throws IOException {
        String template = loadTemplate("servlet-template.txt");
        String content = replace(template, placeholderMap(entityName, lowerName));

        Path servletPath = Path.of("src/main/java/gestion_compagnie_aerienne/servlet/" + entityName + "Servlet.java");
        Files.createDirectories(servletPath.getParent());
        Files.writeString(servletPath, content, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }

    private static void generateJsp(String entityName, String lowerName) throws Exception {
        Class<?> entityClass = Class.forName("gestion_compagnie_aerienne.entities." + entityName);
        ColumnBlocks cols = JspCrudGenerator.buildColumns(entityClass);

        String template = loadTemplate("jsp-template.txt");
        Map<String, String> map = placeholderMap(entityName, lowerName);
        map.put("__COL_HEADERS__", cols.headers);
        map.put("__COL_ROWS__", cols.rows);
        String content = replace(template, map);

        Path jspPath = Path.of("src/main/webapp/" + lowerName + ".jsp");
        Files.createDirectories(jspPath.getParent());
        Files.writeString(jspPath, content, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }

    private static void updateWebXml(String entityName, String lowerName) throws IOException {
        Path webXmlPath = Path.of("src/main/webapp/WEB-INF/web.xml");
        String webXml = Files.readString(webXmlPath, StandardCharsets.UTF_8);

        String servletName = entityName + "Servlet";
        if (webXml.contains("<servlet-name>" + servletName + "</servlet-name>")) {
            System.out.println("web.xml already contains mapping for " + servletName + ". Skipping update.");
            return;
        }

        String block = replace(loadTemplate("webxml-servlet-block.txt"), placeholderMap(entityName, lowerName));

        int insertPos = webXml.lastIndexOf("</web-app>");
        if (insertPos == -1) {
            throw new IllegalStateException("web.xml malformed: missing </web-app>");
        }

        String updated = webXml.substring(0, insertPos) + block + webXml.substring(insertPos);
        Files.writeString(webXmlPath, updated, StandardCharsets.UTF_8, StandardOpenOption.TRUNCATE_EXISTING, StandardOpenOption.CREATE);
    }

    private static Map<String, String> placeholderMap(String entityName, String lowerName) {
        Map<String, String> map = new HashMap<>();
        map.put("__ENTITY__", entityName);
        map.put("__ENTITY_LOWER__", lowerName);
        map.put("__ENTITY_LOWER_PLURAL__", lowerName + "s");
        map.put("__ENTITY_LOWER_CAP__", lowerName.toUpperCase(Locale.ROOT));
        return map;
    }

    private static String loadTemplate(String fileName) throws IOException {
        Path path = Path.of("src/main/resources/templates/" + fileName);
        return Files.readString(path, StandardCharsets.UTF_8);
    }

    private static String replace(String template, Map<String, String> values) {
        String result = template;
        for (Map.Entry<String, String> entry : values.entrySet()) {
            result = result.replace(entry.getKey(), entry.getValue());
        }
        return result;
    }

    private static final class ColumnBlocks {
        final String headers;
        final String rows;

        ColumnBlocks(String headers, String rows) {
            this.headers = headers;
            this.rows = rows;
        }
    }

    private static final class JspCrudGenerator {

        static ColumnBlocks buildColumns(Class<?> entityClass) {
            StringBuilder headers = new StringBuilder();
            StringBuilder rows = new StringBuilder();

            Field[] fields = entityClass.getDeclaredFields();
            for (Field field : fields) {
                if (field.isAnnotationPresent(Id.class)) {
                    continue;
                }

                String label = field.getName();
                Column col = field.getAnnotation(Column.class);
                if (col != null && !col.name().isEmpty()) {
                    label = col.name();
                }

                headers.append("                        <th>").append(label).append("</th>\n");

                String getter = "get" + capitalize(field.getName());
                rows.append("                        <td><%= entity.").append(getter).append("() %></td>\n");
            }

            return new ColumnBlocks(headers.toString(), rows.toString());
        }
    }
}
