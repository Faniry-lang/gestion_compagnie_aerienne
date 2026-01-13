package gestion_compagnie_aerienne.servlet;

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

public class AeroportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String codeIata = req.getParameter("codeIata");
            String nom = req.getParameter("nom");
            String ville = req.getParameter("ville");
            String pays = req.getParameter("pays");

            List<Filter> filters = new ArrayList<>();
            if(codeIata != null && !codeIata.isEmpty()) {
                filters.add(new Filter("code_iata", Comparator.ILIKE, "%" + codeIata + "%"));
            }
            if(nom != null && !nom.isEmpty()) {
                filters.add(new Filter("nom", Comparator.ILIKE, "%" + nom + "%"));
            }
            if(ville != null && !ville.isEmpty()) {
                filters.add(new Filter("ville", Comparator.ILIKE, "%" + ville + "%"));
            }
            if(pays != null && !pays.isEmpty()) {
                filters.add(new Filter("pays", Comparator.ILIKE, "%" + pays + "%"));
            }

            List<Aeroport> aeroports;
            if(filters.isEmpty()) {
                aeroports = Aeroport.findAll(Aeroport.class, QueryManager.get_instance());
            } else {
                aeroports = Aeroport.filter(Aeroport.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
            }

            for(Aeroport a : aeroports) {
                a.mount();
            }

            req.setAttribute("aeroports", aeroports);
            req.getRequestDispatcher("pages/aeroport/aeroport-list.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if(action == null) action = "create";
            switch(action) {
                case "create":
                    String codeIata = req.getParameter("codeIata");
                    String nom = req.getParameter("nom");
                    String ville = req.getParameter("ville");
                    String pays = req.getParameter("pays");

                    if(codeIata == null || codeIata.isEmpty()) throw new Exception("Code IATA requis");
                    if(nom == null || nom.isEmpty()) throw new Exception("Nom requis");

                    Aeroport a = new Aeroport();
                    a.setCodeIata(codeIata);
                    a.setNom(nom);
                    a.setVille(ville);
                    a.setPays(pays);
                    a.save();

                    resp.sendRedirect("aeroport");
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
            }
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
