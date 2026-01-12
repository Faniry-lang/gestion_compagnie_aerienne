package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Aeroport;
import gestion_compagnie_aerienne.entities.Vol;
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
        Integer idVol = null;
        try {
            idVol = Integer.parseInt(req.getParameter("idVol"));
            Vol vol = Vol.findById(idVol, Vol.class, QueryManager.get_instance());
            if(vol == null) {
                throw new Exception("Aucun vol trouvé pour l'ID "+idVol);
            }
            List<VolDetails> volsDetails = VolDetails.findByIdVol(idVol);
            for(VolDetails volDetails : volsDetails) {
                volDetails.mount();
            }
            req.setAttribute("vol", vol);
            req.setAttribute("volDetails", volsDetails);
            req.getRequestDispatcher("pages/vol/vol-details.jsp").forward(req, resp);
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
