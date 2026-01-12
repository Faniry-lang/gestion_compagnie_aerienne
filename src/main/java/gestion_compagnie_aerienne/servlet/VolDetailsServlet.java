package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Aeroport;
import gestion_compagnie_aerienne.entities.VolDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;

import java.io.IOException;
import java.util.List;

public class VolDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<VolDetails> volsDetails = VolDetails.findAll(VolDetails.class, QueryManager.get_instance());
            for(VolDetails vol : volsDetails) {
                vol.mount();
            }
            req.setAttribute("vol-details", volsDetails);
            req.getRequestDispatcher("vol-details.jsp").forward(req, resp);
        } catch(Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
