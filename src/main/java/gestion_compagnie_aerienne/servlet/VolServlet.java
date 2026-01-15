package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Aeroport;
import gestion_compagnie_aerienne.entities.Vol;
import gestion_compagnie_aerienne.entities.Avion;
import gestion_compagnie_aerienne.entities.VolAvion;
import gestion_compagnie_aerienne.utils.DateParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class VolServlet extends HttpServlet {

    private LocalDateTime parseToDateTime(String s, boolean startOfDay) {
        return DateParser.getLocalDateTime(s, startOfDay);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // mijery raha misy filtres appliqués
            // alaina ny variable ana filtre
            String idAeroportDepartStr = req.getParameter("idAeroportDepart");
            String idAeroportArriveeStr = req.getParameter("idAeroportArrivee");

            Integer idAeroportDepart =
                    (idAeroportDepartStr != null && !idAeroportDepartStr.isEmpty())
                            ? Integer.parseInt(idAeroportDepartStr) : null;
            Integer idAeroportArrivee =
                    (idAeroportArriveeStr != null && !idAeroportArriveeStr.isEmpty())
                            ? Integer.parseInt(idAeroportArriveeStr) : null;

            List<Filter> filters = new ArrayList<>();
            if(idAeroportDepart != null) {
                filters.add(new Filter("id_aeroport_depart", Comparator.EQUALS, idAeroportDepart));
            }
            if(idAeroportArrivee != null) {
                filters.add(new Filter("id_aeroport_arrivee", Comparator.EQUALS, idAeroportArrivee));
            }

            // filter miandy varargs ana Filter, du coup mila preciserna le type
            // filters.toArray() -> tsy mety
            // filters.toArray(new Filter[0]) -> mety
            List<Vol> vols = Vol.filter(Vol.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
            List<Aeroport> aeroports = Aeroport.findAll(Aeroport.class, QueryManager.get_instance());

            List<Avion> avions = Avion.findAll(Avion.class, QueryManager.get_instance());

            req.setAttribute("aeroports", aeroports);
            req.setAttribute("avions", avions);
            req.setAttribute("vols", vols);
            req.getRequestDispatcher("pages/vol/vol-list.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if(action == null) action = "create";
            switch(action) {
                case "create":
                    String numeroVol = req.getParameter("numeroVol");
                    String idAeroportDepartStr = req.getParameter("idAeroportDepart");
                    String idAeroportArriveeStr = req.getParameter("idAeroportArrivee");

                    if(numeroVol == null || numeroVol.isEmpty()) throw new Exception("Numero de vol requis");
                    if(idAeroportDepartStr == null || idAeroportDepartStr.isEmpty()) throw new Exception("Aeroport depart requis");
                    if(idAeroportArriveeStr == null || idAeroportArriveeStr.isEmpty()) throw new Exception("Aeroport arrivee requis");

                    Integer idAeroportDepart = Integer.parseInt(idAeroportDepartStr);
                    Integer idAeroportArrivee = Integer.parseInt(idAeroportArriveeStr);

                    Vol vol = new Vol();
                    vol.setNumeroVol(numeroVol);
                    vol.setIdAeroportDepart(idAeroportDepart);
                    vol.setIdAeroportArrivee(idAeroportArrivee);
                    vol.setCreatedOn(LocalDateTime.now());
                    vol.save();

                    resp.sendRedirect("vol");
                    break;
                case "createVolAvion":
                    String idVolStr = req.getParameter("idVol");
                    String idAvionStr = req.getParameter("idAvion");
                    String dateDepartStr = req.getParameter("dateDepart");
                    String dateArriveeStr = req.getParameter("dateArrivee");

                    if(idVolStr == null || idVolStr.isEmpty()) throw new Exception("idVol requis");
                    if(idAvionStr == null || idAvionStr.isEmpty()) throw new Exception("idAvion requis");
                    Integer idVol = Integer.parseInt(idVolStr);
                    Integer idAvion = Integer.parseInt(idAvionStr);

                    VolAvion va = new VolAvion();
                    va.setIdVol(idVol);
                    va.setIdAvion(idAvion);

                    LocalDateTime depart = parseToDateTime(dateDepartStr, true);
                    LocalDateTime arrivee = parseToDateTime(dateArriveeStr, false);
                    if(depart != null) va.setDateDepart(depart);
                    if(arrivee != null) va.setDateArrivee(arrivee);

                    va.setCreatedOn(LocalDateTime.now());
                    va.save();

                    resp.sendRedirect("vol-details?idVol=" + idVol);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
            }
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
