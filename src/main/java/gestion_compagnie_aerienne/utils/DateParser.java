package gestion_compagnie_aerienne.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class DateParser {
    public static LocalDateTime getLocalDateTime(String s, boolean startOfDay) {
        if (s == null || s.isEmpty()) return null;

        try {
            return LocalDateTime.parse(s, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        } catch (DateTimeParseException ex) {
            try {
                DateTimeFormatter withoutSeconds = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                return LocalDateTime.parse(s, withoutSeconds);
            } catch (DateTimeParseException ex2) {
                try {
                    LocalDate d = LocalDate.parse(s);
                    return startOfDay ? d.atStartOfDay() : d.atTime(LocalTime.MAX);
                } catch (Exception ex3) {
                    return null;
                }
            }
        }
    }
}
