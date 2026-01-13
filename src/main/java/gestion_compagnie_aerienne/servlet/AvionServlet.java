package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Avion;
import gestion_compagnie_aerienne.entities.TypeAvion;
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

public class AvionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) action = "list";
        try {
            if ("list".equals(action)) {
                // filtre am recherche textuelle
                String modele = req.getParameter("modele");
                String constructeur = req.getParameter("constructeur");

                // filtre am liste déroulante
                String idTypeAvionStr = req.getParameter("idTypeAvion");

                List<Filter> filters = new ArrayList<>();
                if (modele != null && !modele.isEmpty()) {
                    filters.add(new Filter("modele", Comparator.ILIKE, "%" + modele + "%"));
                }
                if (constructeur != null && !constructeur.isEmpty()) {
                    filters.add(new Filter("constructeur", Comparator.ILIKE, "%" + constructeur + "%"));
                }
                if (idTypeAvionStr != null && !idTypeAvionStr.isEmpty()) {
                    Integer idType = Integer.parseInt(idTypeAvionStr);
                    filters.add(new Filter("id_type_avion", Comparator.EQUALS, idType));
                }

                List<Avion> avions;
                if (filters.isEmpty()) {
                    avions = Avion.findAll(Avion.class, QueryManager.get_instance());
                } else {
                    avions = Avion.filter(Avion.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
                }

                List<TypeAvion> types = TypeAvion.findAll(TypeAvion.class, QueryManager.get_instance());
                req.setAttribute("avions", avions);
                req.setAttribute("types", types);
                req.getRequestDispatcher("pages/avion/avion-list.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
            }
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}

