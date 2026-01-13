package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.Billet;
import gestion_compagnie_aerienne.entities.Billet;
import gestion_compagnie_aerienne.entities.VolAvion;
import gestion_compagnie_aerienne.entities.Passager;
import gestion_compagnie_aerienne.entities.Vol;
import gestion_compagnie_aerienne.entities.Avion;
import gestion_compagnie_aerienne.entities.Siege;
import gestion_compagnie_aerienne.entities.ClasseSiege;
import gestion_compagnie_aerienne.entities.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class BilletServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "list":
                    // omena anle jsp ny données ilainy amle filtre
                    List<Passager> passagers = Passager.findAll(Passager.class, QueryManager.get_instance());
                    List<Vol> vols = Vol.findAll(Vol.class, QueryManager.get_instance());
                    List<Avion> avions = Avion.findAll(Avion.class, QueryManager.get_instance());
                    List<Siege> sieges = Siege.findAll(Siege.class, QueryManager.get_instance());
                    List<ClasseSiege> classes = ClasseSiege.findAll(ClasseSiege.class, QueryManager.get_instance());
                    List<Reservation> reservations = Reservation.findAll(Reservation.class, QueryManager.get_instance());

                    req.setAttribute("passagers", passagers);
                    req.setAttribute("vols", vols);
                    req.setAttribute("avions", avions);
                    req.setAttribute("sieges", sieges);
                    req.setAttribute("classes", classes);
                    req.setAttribute("reservations", reservations);

                    // gérer-nleh processfilters ny maka anle filtre rehetra avy any am front
                    Filter[] filters = processFilters(req);
                    // fonction filter bogosy
                    List<Billet> billets = Billet.filter(Billet.class, QueryManager.get_instance(), filters);

                    for(Billet billet: billets) {
                        billet.mount();
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

    public Filter[] processFilters(HttpServletRequest req) throws Exception {
        String idPassagerStr = req.getParameter("idPassager");
        String idVolStr = req.getParameter("idVol");
        String idAvionStr = req.getParameter("idAvion");
        String idSiegeStr = req.getParameter("idSiege");
        String idClasseSiegeStr = req.getParameter("idClasseSiege");
        String idReservationStr = req.getParameter("idReservation");

        Integer idPassager = null;
        Integer idVol = null;
        Integer idAvion = null;
        Integer idSiege = null;
        Integer idClasseSiege = null;
        Integer idReservation = null;

        List<Filter> filters = new java.util.ArrayList<>();
        if(idPassagerStr != null && !idPassagerStr.isEmpty()) {
            idPassager = Integer.parseInt(idPassagerStr);
            filters.add(new Filter("id_passager", Comparator.EQUALS, idPassager));
        }
        if(idVolStr != null && !idVolStr.isEmpty()) {
            idVol = Integer.parseInt(idVolStr);
            filters.add(new Filter("id_vol",Comparator.EQUALS, idVol));
        }
        if(idAvionStr != null && !idAvionStr.isEmpty()) {
            idAvion = Integer.parseInt(idAvionStr);
            String sql = "SELECT b.* FROM billet b " +
                    "JOIN vol_avion va ON b.id_vol_avion = va.id " +
                    "WHERE va.id_avion = ? ";
            List<Billet> billets = Billet.fetch(Billet.class, QueryManager.get_instance(),
                    sql, idAvion);
            List<Integer> ids = new ArrayList<>();
            for(Billet b : billets) {
                ids.add(b.getId().intValue());
            }
            if(!ids.isEmpty()) {
                filters.add(new Filter("id", Comparator.IN, ids));
            }
        }
        if(idSiegeStr != null && !idSiegeStr.isEmpty()) {
            idSiege = Integer.parseInt(idSiegeStr);
            filters.add(new Filter("id_siege", Comparator.EQUALS, idSiege));
        }
        if(idClasseSiegeStr != null && !idClasseSiegeStr.isEmpty()) {
            idClasseSiege = Integer.parseInt(idClasseSiegeStr);
            filters.add(new Filter("id_classe_siege", Comparator.EQUALS, idClasseSiege));
        }
        if(idReservationStr != null && !idReservationStr.isEmpty()) {
            idReservation = Integer.parseInt(idReservationStr);
            List<Billet> Billets = Billet.fetch(Billet.class, QueryManager.get_instance(),
                    "SELECT * FROM reservation_passager WHERE id_reservation = ? ", idReservation);
            List<Long> ids = new java.util.ArrayList<>();
            for(Billet rp : Billets) {
                ids.add(rp.getId());
            }
            if(!ids.isEmpty()) {
                filters.add(new Filter("id_reservation_passager", Comparator.IN, ids));
            }
        }

        return filters.toArray(new Filter[0]);
    }
}
