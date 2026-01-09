package gestion_compagnie_aerienne.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import gestion_compagnie_aerienne.entities.Reservation;
import legacy.schema.BaseEntity;

import java.io.IOException;
import java.util.List;

public class ReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Reservation> reservations = Reservation.findAll(Reservation.class, legacy.query.QueryManager.get_instance());
            req.setAttribute("reservations", reservations);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement des réservations: " + e.getMessage());
        }
        req.getRequestDispatcher("reservation.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    public void init() throws ServletException {
        super.init();
    }
}
