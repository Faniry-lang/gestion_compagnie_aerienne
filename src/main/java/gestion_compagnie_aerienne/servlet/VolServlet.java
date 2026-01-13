package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Aeroport;
import gestion_compagnie_aerienne.entities.Vol;
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

public class VolServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // mijery raha misy filtres appliqués
            // alaina ny variable ana filtre
            String idAeroportDepartStr = req.getParameter("idAeroportDepart");
            String idAeroportArriveeStr = req.getParameter("idAeroportArrivee");

            Integer idAeroportDepart =
                    (idAeroportDepartStr != null && !idAeroportDepartStr.isEmpty())
                            ? Integer.parseInt(idAeroportDepartStr) : null;
            Integer idAeroportArrivee =
                    (idAeroportArriveeStr != null && !idAeroportArriveeStr.isEmpty())
                            ? Integer.parseInt(idAeroportArriveeStr) : null;

            List<Filter> filters = new ArrayList<>();
            if(idAeroportDepart != null) {
                filters.add(new Filter("id_aeroport_depart", Comparator.EQUALS, idAeroportDepart));
            }
            if(idAeroportArrivee != null) {
                filters.add(new Filter("id_aeroport_arrivee", Comparator.EQUALS, idAeroportArrivee));
            }

            // filter miandy varargs ana Filter, du coup mila preciserna le type
            // filters.toArray() -> tsy mety
            // filters.toArray(new Filter[0]) -> mety
            List<Vol> vols = Vol.filter(Vol.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
            List<Aeroport> aeroports = Aeroport.findAll(Aeroport.class, QueryManager.get_instance());
            req.setAttribute("aeroports", aeroports);
            for(Vol vol : vols) {
                vol.mount();
            }
            req.setAttribute("vols", vols);
            req.getRequestDispatcher("pages/vol/vol.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
