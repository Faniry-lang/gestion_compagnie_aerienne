package gestion_compagnie_aerienne.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.schema.BaseEntity;
import legacy.query.QueryManager;
import gestion_compagnie_aerienne.entities.Aeroport;
import java.io.IOException;
import java.util.List;

public class AeroportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Aeroport> items = Aeroport.findAll(Aeroport.class, QueryManager.get_instance());
            req.setAttribute("aeroports", items);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement de Aeroport : " + e.getMessage());
        }
        req.getRequestDispatcher("aeroport.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
