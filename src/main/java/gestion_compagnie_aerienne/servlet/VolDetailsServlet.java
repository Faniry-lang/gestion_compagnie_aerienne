package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Avion;
import gestion_compagnie_aerienne.entities.Vol;
import gestion_compagnie_aerienne.entities.VolDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class VolDetailsServlet extends HttpServlet {

    private LocalDateTime parseToDateTime(String s, boolean startOfDay) {
        if (s == null || s.isEmpty()) return null;
        try {
            return LocalDateTime.parse(s);
        } catch (Exception ex) {
            try {
                LocalDate d = LocalDate.parse(s);
                return startOfDay ? d.atStartOfDay() : d.atTime(LocalTime.MAX);
            } catch (Exception ex2) {
                return null;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idVolStr = req.getParameter("idVol");
            if (idVolStr == null || idVolStr.isEmpty()) {
                throw new Exception("Parametre idVol manquant");
            }
            Integer idVol = Integer.parseInt(idVolStr);

            Vol vol = Vol.findById(idVol, Vol.class, QueryManager.get_instance());
            if (vol == null) {
                throw new Exception("Aucun vol trouve pour l'ID " + idVol);
            }

            List<Filter> filters = new ArrayList<>();

            filters.add(new Filter("id_vol", Comparator.EQUALS, idVol));

            String idAvionStr = req.getParameter("idAvion");
            if (idAvionStr != null && !idAvionStr.isEmpty()) {
                Integer idAvion = Integer.parseInt(idAvionStr);
                filters.add(new Filter("id_avion", Comparator.EQUALS, idAvion));
            }

            LocalDateTime dateDepartMin = parseToDateTime(req.getParameter("dateDepartMin"), true);
            LocalDateTime dateDepartMax = parseToDateTime(req.getParameter("dateDepartMax"), false);
            if (dateDepartMin != null) filters.add(new Filter("date_depart", Comparator.GREATER_THAN_OR_EQUALS, dateDepartMin));
            if (dateDepartMax != null) filters.add(new Filter("date_depart", Comparator.LESS_THAN_OR_EQUALS, dateDepartMax));

            LocalDateTime dateArriveeMin = parseToDateTime(req.getParameter("dateArriveeMin"), true);
            LocalDateTime dateArriveeMax = parseToDateTime(req.getParameter("dateArriveeMax"), false);
            if (dateArriveeMin != null) filters.add(new Filter("date_arrivee", Comparator.GREATER_THAN_OR_EQUALS, dateArriveeMin));
            if (dateArriveeMax != null) filters.add(new Filter("date_arrivee", Comparator.LESS_THAN_OR_EQUALS, dateArriveeMax));

            String placesRestantesMinStr = req.getParameter("placesRestantesMin");
            String placesRestantesMaxStr = req.getParameter("placesRestantesMax");
            if (placesRestantesMinStr != null && !placesRestantesMinStr.isEmpty()) {
                Integer prm = Integer.parseInt(placesRestantesMinStr);
                filters.add(new Filter("places_restantes", Comparator.GREATER_THAN_OR_EQUALS, prm));
            }
            if (placesRestantesMaxStr != null && !placesRestantesMaxStr.isEmpty()) {
                Integer prM = Integer.parseInt(placesRestantesMaxStr);
                filters.add(new Filter("places_restantes", Comparator.LESS_THAN_OR_EQUALS, prM));
            }


            List<VolDetails> filtered = VolDetails.filter(VolDetails.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));

            for (VolDetails vd : filtered) {
                try { vd.mount(); } catch (Exception ignored) {}
            }

            List<Avion> avions = Avion.findAll(Avion.class, QueryManager.get_instance());

            req.setAttribute("vol", vol);
            req.setAttribute("volDetails", filtered);
            req.setAttribute("avions", avions);
            req.setAttribute("idVol", idVol);

            req.getRequestDispatcher("pages/vol/vol-details.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
