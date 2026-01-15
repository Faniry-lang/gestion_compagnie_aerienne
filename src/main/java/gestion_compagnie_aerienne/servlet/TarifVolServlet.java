package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.TarifVol;
import gestion_compagnie_aerienne.entities.Vol;
import gestion_compagnie_aerienne.entities.ClasseSiege;
import gestion_compagnie_aerienne.utils.DateParser;
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
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

public class TarifVolServlet extends HttpServlet {

    private LocalDateTime parseToDateTime(String s, boolean startOfDay) {
        return DateParser.getLocalDateTime(s, startOfDay);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if (action == null || "list".equals(action)) {
                List<Vol> vols = Vol.findAll(Vol.class, QueryManager.get_instance());
                List<ClasseSiege> classes = ClasseSiege.findAll(ClasseSiege.class, QueryManager.get_instance());

                req.setAttribute("vols", vols);
                req.setAttribute("classes", classes);

                Filter[] filters = processFilters(req);
                List<TarifVol> tarifs = TarifVol.filter(TarifVol.class, QueryManager.get_instance(), filters);
                req.setAttribute("tarifs", tarifs);

                req.getRequestDispatcher("pages/tarif-vol/tarif-vol-list.jsp").forward(req, resp);
                return;
            }

            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idVolStr = req.getParameter("idVol");
        String idClasseStr = req.getParameter("idClasseSiege");
        String montantStr = req.getParameter("montant");

        try {
            if (idVolStr == null || idVolStr.isEmpty()) throw new IllegalArgumentException("idVol requis");
            if (idClasseStr == null || idClasseStr.isEmpty()) throw new IllegalArgumentException("idClasseSiege requis");
            if (montantStr == null || montantStr.isEmpty()) throw new IllegalArgumentException("montant requis");

            int idVol = Integer.parseInt(idVolStr);
            int idClasse = Integer.parseInt(idClasseStr);
            float montant = Float.parseFloat(montantStr);

            LocalDateTime createdOn = LocalDateTime.now();

            TarifVol tarif = new TarifVol();
            tarif.setIdVol(idVol);
            tarif.setIdClasseSiege(idClasse);
            tarif.setMontant(montant);
            tarif.setCreatedOn(createdOn);

            tarif.save();

            resp.sendRedirect("tarif-vol?action=list");
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    private Filter[] processFilters(HttpServletRequest req) {
        String idVolStr = req.getParameter("idVol");
        String idClasseStr = req.getParameter("idClasseSiege");
        String dateMinStr = req.getParameter("dateMin");
        String dateMaxStr = req.getParameter("dateMax");

        List<Filter> filters = new ArrayList<>();

        if (idVolStr != null && !idVolStr.isEmpty()) {
            filters.add(new Filter("id_vol", Comparator.EQUALS, Integer.parseInt(idVolStr)));
        }
        if (idClasseStr != null && !idClasseStr.isEmpty()) {
            filters.add(new Filter("id_classe_siege", Comparator.EQUALS, Integer.parseInt(idClasseStr)));
        }

        LocalDateTime min = parseToDateTime(dateMinStr, true);
        LocalDateTime max = parseToDateTime(dateMaxStr, false);
        if (min != null) {
            filters.add(new Filter("created_on", Comparator.GREATER_THAN_OR_EQUALS, java.sql.Timestamp.valueOf(min)));
        }
        if (max != null) {
            filters.add(new Filter("created_on", Comparator.LESS_THAN_OR_EQUALS, java.sql.Timestamp.valueOf(max)));
        }

        return filters.toArray(new Filter[0]);
    }
}

