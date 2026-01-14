package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.ReservationPassager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;

import java.io.IOException;
import java.util.List;

public class ReservationPassagerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) action = "list";
        try {
            if ("list".equals(action)) {
                String idReservationStr = req.getParameter("idReservation");
                List<ReservationPassager> reservationPassagers;
                if (idReservationStr != null && !idReservationStr.isEmpty()) {
                    Integer idReservation = Integer.parseInt(idReservationStr);
                    reservationPassagers = ReservationPassager.fetch(ReservationPassager.class, QueryManager.get_instance(),
                            "SELECT * FROM reservation_passager WHERE id_reservation = ?", idReservation);
                } else {
                    reservationPassagers = ReservationPassager.findAll(ReservationPassager.class, QueryManager.get_instance());
                }
                req.setAttribute("reservationPassagers", reservationPassagers);
                req.getRequestDispatcher("pages/reservation/reservation-passager-list.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
            }
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
