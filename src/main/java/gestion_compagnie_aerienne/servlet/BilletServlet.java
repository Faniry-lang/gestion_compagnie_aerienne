package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Billet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;

import java.io.IOException;
import java.util.List;

public class BilletServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "list":
                    String idReservationStr = req.getParameter("idReservation");
                    List<Billet> billets;
                    if (idReservationStr != null && !idReservationStr.isEmpty()) {
                        Integer idReservation = Integer.parseInt(idReservationStr);
                        String sql = "SELECT * FROM billet WHERE id_reservation_passager IN (SELECT id FROM reservation_passager WHERE id_reservation = ?)";
                        billets = Billet.fetch(Billet.class, QueryManager.get_instance(), sql, idReservation);
                    } else {
                        billets = Billet.findAll(Billet.class, QueryManager.get_instance());
                    }
                    req.setAttribute("billets", billets);
                    req.getRequestDispatcher("pages/billet/billet-list.jsp").forward(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}

