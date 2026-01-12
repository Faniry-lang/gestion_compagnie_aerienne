package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Vol;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;

import java.io.IOException;
import java.util.List;

public class VolServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Vol> vols = Vol.findAll(Vol.class, QueryManager.get_instance());
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
