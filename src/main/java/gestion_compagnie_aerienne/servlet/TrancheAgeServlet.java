package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.TrancheAge;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;

import java.io.IOException;
import java.util.List;

public class TrancheAgeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if(action == null || action.isEmpty()) {
                action = "list";
            }
            switch (action) {
                case "list":
                    List<TrancheAge> trancheAgeList = TrancheAge.findAll(TrancheAge.class, QueryManager.get_instance());
                    req.setAttribute("trancheAges", trancheAgeList);
                    req.getRequestDispatcher("pages/tranche-age-list.jsp").forward(req, resp);
                    break;
                case "form":
                    req.getRequestDispatcher("pages/tranche-age-form.jsp").forward(req, resp);
                    break;
                default:
                    throw new Exception("Aucune action définie");
            }
        } catch (Exception e) {
            req.setAttribute("error-message", "Erreur TrancheAgeServlet "+ e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String ageMin = req.getParameter("ageMin");
            String ageMax = req.getParameter("ageMax");
            String libelle = req.getParameter("libelle");

            Integer ageMinInt = null;
            Integer ageMaxInt = null;

            if(libelle == null || libelle.isEmpty()) {
                throw new ServletException("Libelle ne peut pas être vide");
            }

            if(ageMin != null && !ageMin.isEmpty()) {
                ageMinInt = Integer.parseInt(ageMin);
            }

            if(ageMax != null && !ageMax.isEmpty()) {
                ageMaxInt = Integer.parseInt(ageMax);
            }

            TrancheAge trancheAge = new TrancheAge();
            trancheAge.setAgeMax(ageMaxInt);
            trancheAge.setAgeMin(ageMinInt);
            trancheAge.setLibelle(libelle);

            trancheAge.save();

            resp.sendRedirect("tranche-age?action=list");
        } catch (Exception e) {
            req.setAttribute("error-message", "Erreur TrancheAgeServlet " + e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
