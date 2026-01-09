package gestion_compagnie_aerienne.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.schema.BaseEntity;
import legacy.query.QueryManager;
import gestion_compagnie_aerienne.entities.BagagePassager;
import java.io.IOException;
import java.util.List;

@WebServlet("/bagagePassager")
public class BagagePassagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<BagagePassager> items = BaseEntity.findAll(BagagePassager.class, QueryManager.get_instance());
            req.setAttribute("bagagePassagers", items);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement de BagagePassager : " + e.getMessage());
        }
        req.getRequestDispatcher("bagagePassager.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
