package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Itineraire;
import gestion_compagnie_aerienne.entities.Aeroport;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ItineraireServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) action = "list";
        try {
            if ("list".equals(action)) {
                String distanceMinStr = req.getParameter("distanceMin");
                String distanceMaxStr = req.getParameter("distanceMax");
                String idAeroportDepartStr = req.getParameter("idAeroportDepart");
                String idAeroportArriveeStr = req.getParameter("idAeroportArrivee");

                Float distanceMin = (distanceMinStr != null && !distanceMinStr.isEmpty()) ? Float.parseFloat(distanceMinStr) : null;
                Float distanceMax = (distanceMaxStr != null && !distanceMaxStr.isEmpty()) ? Float.parseFloat(distanceMaxStr) : null;

                List<Filter> filters = new ArrayList<>();
                if (distanceMin != null) filters.add(new Filter("distance_km", Comparator.GREATER_THAN_OR_EQUALS, distanceMin));
                if (distanceMax != null) filters.add(new Filter("distance_km", Comparator.LESS_THAN_OR_EQUALS, distanceMax));
                if (idAeroportDepartStr != null && !idAeroportDepartStr.isEmpty()) filters.add(new Filter("id_aeroport_depart", Comparator.EQUALS, Integer.parseInt(idAeroportDepartStr)));
                if (idAeroportArriveeStr != null && !idAeroportArriveeStr.isEmpty()) filters.add(new Filter("id_aeroport_arrivee", Comparator.EQUALS, Integer.parseInt(idAeroportArriveeStr)));

                List<Itineraire> itineraires;
                if (filters.isEmpty()) {
                    itineraires = Itineraire.findAll(Itineraire.class, QueryManager.get_instance());
                } else {
                    itineraires = Itineraire.filter(Itineraire.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
                }

                for (Itineraire it : itineraires) {
                    try { it.mount(); } catch (Exception ignored) {}
                }

                List<Aeroport> aeroports = Aeroport.findAll(Aeroport.class, QueryManager.get_instance());
                req.setAttribute("itineraires", itineraires);
                req.setAttribute("aeroports", aeroports);
                req.getRequestDispatcher("pages/itineraire/itineraire-list.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
            }
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}

