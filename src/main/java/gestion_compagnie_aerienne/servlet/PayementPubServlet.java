package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Societe;
import gestion_compagnie_aerienne.entities.PayementPub;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

public class PayementPubServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String moisStr = req.getParameter("mois");
            String anneeStr = req.getParameter("annee");
            String idSocieteStr = req.getParameter("idSociete");

            Integer mois = (moisStr != null && !moisStr.isEmpty()) ? Integer.parseInt(moisStr) : null;
            Integer annee = (anneeStr != null && !anneeStr.isEmpty()) ? Integer.parseInt(anneeStr) : null;
            Integer idSociete = (idSocieteStr != null && !idSocieteStr.isEmpty()) ? Integer.parseInt(idSocieteStr) : null;

            LocalDateTime date = null;
            if (mois != null && annee != null) {
                date = LocalDateTime.of(annee, mois, 1, 0, 0);
            }

            Double reste = PayementPub.getResteAPayer(idSociete, date, null);

            List<Societe> societes = Societe.findAll(Societe.class, QueryManager.get_instance());

            req.setAttribute("societes", societes);
            req.setAttribute("reste", reste);
            req.setAttribute("mois", mois);
            req.setAttribute("annee", annee);
            req.setAttribute("idSociete", idSociete);

            req.getRequestDispatcher("pages/payement-pub/payement-pub-reste.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}