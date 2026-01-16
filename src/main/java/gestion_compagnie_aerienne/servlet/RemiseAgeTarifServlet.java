package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.ClasseSiege;
import gestion_compagnie_aerienne.entities.RemiseAgeTarif;
import gestion_compagnie_aerienne.entities.TrancheAge;
import gestion_compagnie_aerienne.entities.Vol;
import gestion_compagnie_aerienne.utils.DateParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

public class RemiseAgeTarifServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if(action == null || action.isEmpty()) {
                action = "list";
            }
            switch (action) {
                case "form":
                    processForm(req, resp);
                    break;
                case "list":
                    processList(req, resp);
                    break;
                default:
                    throw new Exception("Aucune action définie");

            }

        } catch (Exception e) {
            req.setAttribute("error-message", "Erreur lors de l'initialisation du formulaire de remise d'age: "+ e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idTrancheAgeStr = req.getParameter("idTrancheAge");
            String idClasseSiegeStr = req.getParameter("idClasseSiege");
            String idVolStr = req.getParameter("idVol");
            String idTrancheAgeRefStr = req.getParameter("idTrancheAgeRef");
            String montantPourcentageStr = req.getParameter("montantPourcentage");
            String montantCompletStr = req.getParameter("montantComplet");
            String dateStr = req.getParameter("date");

            Integer idTrancheAge;
            Integer idClasseSiege;
            Integer idVol;
            Integer idTrancheAgeRef = null;
            Float montantComplet = null;
            Float montantPourcentage = null;
            LocalDateTime date = dateStr != null && !dateStr.isEmpty() ? DateParser.getLocalDateTime(dateStr, false) : LocalDateTime.now();
            boolean estPourcentage = false;

            if(idTrancheAgeStr == null || idTrancheAgeStr.isEmpty()) {
                throw new Exception("Tranche d'age ne peut pas être vide");
            }
            if(idVolStr == null || idVolStr.isEmpty()) {
                throw new Exception("Vol ne peut pas être vide");
            }

            if((montantCompletStr == null || montantCompletStr.isEmpty()) && (montantPourcentageStr == null || montantPourcentageStr.isEmpty())) {
                throw new Exception("Montant complet et montant en pourcentage ne peuvent pas être tous les deux vides");
            }

            if(montantCompletStr != null && !montantCompletStr.isEmpty()) {
                montantComplet = Float.parseFloat(montantCompletStr);
            }

            if(montantPourcentageStr != null && !montantPourcentageStr.isEmpty()) {
                montantPourcentage = Float.parseFloat(montantPourcentageStr);
                estPourcentage = true;
            }

            idTrancheAge = Integer.parseInt(idTrancheAgeStr);
            idVol = Integer.parseInt(idVolStr);

            if(idClasseSiegeStr != null && !idClasseSiegeStr.isEmpty()) {
                idClasseSiege = Integer.parseInt(idClasseSiegeStr);
            } else {
                idClasseSiege = null;
            }

            if(idTrancheAgeRefStr != null && !idTrancheAgeRefStr.isEmpty()) {
                idTrancheAgeRef = Integer.parseInt(idTrancheAgeRefStr);
            }

            RemiseAgeTarif remiseAgeTarif = new RemiseAgeTarif();
            remiseAgeTarif.setMontantComplet(montantComplet);
            remiseAgeTarif.setMontantPourcentage(montantPourcentage);
            remiseAgeTarif.setIdTrancheAge(idTrancheAge);
            remiseAgeTarif.setIdClasseSiege(idClasseSiege);
            remiseAgeTarif.setIdVol(idVol);
            remiseAgeTarif.setIdTrancheAgeRef(idTrancheAgeRef);
            remiseAgeTarif.setCreatedOn(date);
            remiseAgeTarif.setEstEnPourcentage(estPourcentage);

            remiseAgeTarif.save();

            resp.sendRedirect("remise-age?action=list");

        } catch (Exception e) {
            req.setAttribute("error-message", "Erreur lors de l'initialisation du formulaire de remise d'age: "+ e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    private void processForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<TrancheAge> trancheAgeList = TrancheAge.findAll(TrancheAge.class, QueryManager.get_instance());
        List<ClasseSiege> classeSiegeList = ClasseSiege.findAll(ClasseSiege.class, QueryManager.get_instance());
        List<Vol> volList = Vol.findAll(Vol.class, QueryManager.get_instance());

        req.setAttribute("trancheAges", trancheAgeList);
        req.setAttribute("classeSieges", classeSiegeList);
        req.setAttribute("vols", volList);
        req.getRequestDispatcher("pages/remise-age-tarif-form.jsp").forward(req, resp);
    }

    private void processList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<RemiseAgeTarif> remiseAgeTarifList = RemiseAgeTarif.findAll(RemiseAgeTarif.class, QueryManager.get_instance());
        req.setAttribute("remiseAges", remiseAgeTarifList);
        req.getRequestDispatcher("pages/remise-age-list.jsp").forward(req, resp);
    }
}
