package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.QueryManager;
import legacy.query.Comparator;
import legacy.query.Filter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReservationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null || action.isEmpty()) {
            action = "list";
        }
        try {
            switch (action) {
                case "form":
                    String idVolAvionStr = req.getParameter("idVolAvion");
                    Integer idVolAvion = Integer.parseInt(idVolAvionStr);
                    VolAvion volAvion = VolAvion.findById(idVolAvion, VolAvion.class, QueryManager.get_instance());
                    if(volAvion == null) {
                        throw new Exception("Aucun vol avion trouvé pour l'ID "+idVolAvion);
                    }

                    Vol vol = Vol.findById(volAvion.getIdVol(), Vol.class, QueryManager.get_instance());
                    Avion avion = Avion.findById(volAvion.getIdAvion(), Avion.class, QueryManager.get_instance());

                    List<Passager> passagers = Passager.findAll(Passager.class, QueryManager.get_instance());
                    req.setAttribute("passagers", passagers);
                    req.setAttribute("idVolAvion", idVolAvion);
                    req.setAttribute("volAvion", volAvion);
                    req.setAttribute("vol", vol);
                    req.setAttribute("avion", avion);
                    req.getRequestDispatcher("pages/reservation/reservation-form.jsp").forward(req, resp);
                    break;
                case "list":
                    String montantMinStr = req.getParameter("montantMin");
                    String montantMaxStr = req.getParameter("montantMax");
                    String nbrMinStr = req.getParameter("nbrMin");
                    String nbrMaxStr = req.getParameter("nbrMax");
                    String reference = req.getParameter("reference");

                    Float montantMin = (montantMinStr != null && !montantMinStr.isEmpty()) ? Float.parseFloat(montantMinStr) : null;
                    Float montantMax = (montantMaxStr != null && !montantMaxStr.isEmpty()) ? Float.parseFloat(montantMaxStr) : null;
                    Integer nbrMin = (nbrMinStr != null && !nbrMinStr.isEmpty()) ? Integer.parseInt(nbrMinStr) : null;
                    Integer nbrMax = (nbrMaxStr != null && !nbrMaxStr.isEmpty()) ? Integer.parseInt(nbrMaxStr) : null;

                    List<Filter> filters = new ArrayList<>();
                    if(montantMin != null) {
                        filters.add(new Filter("montant_total", Comparator.GREATER_THAN_OR_EQUALS, montantMin));
                    }
                    if(montantMax != null) {
                        filters.add(new Filter("montant_total", Comparator.LESS_THAN_OR_EQUALS, montantMax));
                    }
                    if(nbrMin != null) {
                        filters.add(new Filter("nbr_passagers", Comparator.GREATER_THAN_OR_EQUALS, nbrMin));
                    }
                    if(nbrMax != null) {
                        filters.add(new Filter("nbr_passagers", Comparator.LESS_THAN_OR_EQUALS, nbrMax));
                    }
                    if(reference != null && !reference.isEmpty()) {
                        filters.add(new Filter("reference", Comparator.ILIKE, "%" + reference + "%"));
                    }

                    List<ReservationDetails> reservations;
                    if(filters.isEmpty()) {
                        reservations = ReservationDetails.findAll(ReservationDetails.class, QueryManager.get_instance());
                    } else {
                        reservations = ReservationDetails.filter(ReservationDetails.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
                    }

                    for(ReservationDetails r : reservations) {
                        r.mount();
                    }

                    req.setAttribute("reservations", reservations);
                    req.getRequestDispatcher("pages/reservation/reservation-list.jsp").forward(req, resp);
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String[] idPassagers = req.getParameterValues("idPassager");
            String idVolAvionStr = req.getParameter("idVolAvion");
            String prixStr = req.getParameter("prix");

            if(idPassagers == null || idPassagers.length == 0) {
                throw new Exception("Aucun passager sélectionné");
            }

            Integer idVolAvion = Integer.parseInt(idVolAvionStr);
            Float prix = prixStr != null && !prixStr.isEmpty() ? Float.parseFloat(prixStr) : 0f;

            VolAvion volAvion = VolAvion.findById(idVolAvion, VolAvion.class, QueryManager.get_instance());
            if(volAvion == null) {
                throw new Exception("VolAvion introuvable pour l'id " + idVolAvion);
            }

            List<Siege> siegesDisponibles = volAvion.getSiegesDisponibles();
            if(siegesDisponibles == null) siegesDisponibles = new ArrayList<>();

            if(idPassagers.length > siegesDisponibles.size()) {
                throw new Exception("Pas assez de sièges disponibles pour le nombre de passagers sélectionnés");
            }

            Reservation reservation = new Reservation();
            reservation.setReference("REF-" + System.currentTimeMillis());
            reservation.setCreatedOn(LocalDateTime.now());
            reservation.save();

            int seatIndex = 0;
            List<ReservationPassager> created = new ArrayList<>();
            for(String idPassagerStr : idPassagers) {
                Integer idPassager = Integer.parseInt(idPassagerStr);

                ReservationPassager rp = new ReservationPassager();
                rp.setIdReservation(reservation.getId().intValue());
                rp.setIdPassager(idPassager);
                if(seatIndex < siegesDisponibles.size()) {
                    Siege assigned = siegesDisponibles.get(seatIndex);
                    rp.setIdSiege(assigned.getId().intValue());
                    seatIndex++;
                } else {
                    throw new Exception("Pas assez de sièges disponibles pour le passager ID " + idPassager);
                }

                rp.setIdVol(volAvion.getIdVol());
                rp.setIdVolAvion(volAvion.getId().intValue());
                rp.setPrix(prix);
                rp.setCreatedOn(LocalDateTime.now());

                rp.save();
                created.add(rp);

                Billet billet = new Billet();
                billet.setIdPassager(rp.getIdPassager());
                billet.setIdVol(rp.getIdVol());
                billet.setIdVolAvion(rp.getIdVolAvion());
                billet.setIdSiege(rp.getIdSiege());
                billet.setPrix(rp.getPrix());
                billet.setIdClasseSiege(rp.getIdSiege() != null ? getClasseSiegeIdForSiege(rp.getIdSiege()) : null);
                billet.setIdReservationPassager(rp.getId().intValue());
                billet.save();
            }

            resp.sendRedirect("billet?action=list&idReservation=" + reservation.getId());

        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    private Integer getClasseSiegeIdForSiege(Integer idSiege) {
        try {
            Siege s = Siege.findById(idSiege.longValue(), Siege.class, QueryManager.get_instance());
            if(s != null) return s.getIdClasseSiege();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
