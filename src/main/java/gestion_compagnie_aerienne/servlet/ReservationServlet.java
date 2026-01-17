package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.*;
import gestion_compagnie_aerienne.utils.DateParser;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
                    Map<Siege, Boolean> siegesDisponibles = volAvion.getSiegesDisponibles();
                    if(siegesDisponibles == null) {
                        throw new Exception("Plus aucun siege disponible pour le vol N°"+vol.getNumeroVol());
                    }

                    Map<Long, Float> tarifsMap = new HashMap<>();
                    for(Map.Entry<Siege, Boolean> entry : siegesDisponibles.entrySet()) {
                        Siege siege = entry.getKey();
                        Boolean available = entry.getValue();
                        if(available != null && available) {
                            ClasseSiege classeSiege = siege.getForeignKey("id_classe_siege");
                            if(classeSiege != null) {
                                Long classeId = classeSiege.getId();
                                if(!tarifsMap.containsKey(classeId)) {
                                    TarifVol t = TarifVol.getTarifVol(vol.getId().intValue(), classeId.intValue(), volAvion.getDateDepart());
                                    if(t != null && t.getMontant() != null) tarifsMap.put(classeId, t.getMontant());
                                    else tarifsMap.put(classeId, 0f);
                                }
                            }
                        }
                    }

                    req.setAttribute("sieges", siegesDisponibles);
                    req.setAttribute("passagers", passagers);
                    req.setAttribute("idVolAvion", idVolAvion);
                    req.setAttribute("volAvion", volAvion);
                    req.setAttribute("vol", vol);
                    req.setAttribute("avion", avion);
                    req.setAttribute("tarifsMap", tarifsMap);
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
            String action = req.getParameter("action");
            if(action == null || action.isEmpty()) {
                action = "create";
            }
            switch (action) {
                case "create":
                    createReservation(req, resp);
                    break;
                case "pay":
                    payReservation(req, resp);
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

    private Integer getClasseSiegeIdForSiege(Integer idSiege) {
        try {
            Siege s = Siege.findById(idSiege.longValue(), Siege.class, QueryManager.get_instance());
            if(s != null) return s.getIdClasseSiege();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void createReservation(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String[] idPassagers = req.getParameterValues("idPassager");
        String[] idSieges = req.getParameterValues("idSiege");
        String idVolAvionStr = req.getParameter("idVolAvion");
        String dateReservationStr = req.getParameter("dateReservation");
        LocalDateTime dateReservation =
                (dateReservationStr != null && !dateReservationStr.isEmpty())
                        ? DateParser.getLocalDateTime(dateReservationStr, false) : LocalDateTime.now() ;

        if(idPassagers == null || idPassagers.length == 0) {
            throw new Exception("Aucun passager sélectionné");
        }

        Integer idVolAvion = Integer.parseInt(idVolAvionStr);

        VolAvion volAvion = VolAvion.findById(idVolAvion, VolAvion.class, QueryManager.get_instance());
        if(volAvion == null) {
            throw new Exception("VolAvion introuvable pour l'id " + idVolAvion);
        }

        Reservation reservation = new Reservation();
        reservation.setReference("REF-" + System.currentTimeMillis());
        reservation.setCreatedOn(dateReservation);
        Reservation savedReservation = (Reservation)  reservation.save();

        List<StatutReservation> statutReservation = StatutReservation.findBy("libelle", "Creee",
                StatutReservation.class,
                QueryManager.get_instance());

        if(statutReservation.isEmpty()) {
            throw new ServletException("Aucun statut reservation 'Creee' trouve dans la base de donnée");
        }

        HistoriqueStatutReservation hsr = new HistoriqueStatutReservation();
        hsr.setIdReservation(savedReservation.getId().intValue());
        hsr.setIdStatutReservation(statutReservation.getFirst().getId().intValue());
        hsr.setCreatedOn(LocalDateTime.now());
        hsr.save();

        int seatIndex = 0;
        for(String idPassagerStr : idPassagers) {
            Integer idPassager = Integer.parseInt(idPassagerStr);
            Integer idSiege = Integer.parseInt(idSieges[seatIndex]);
            seatIndex++;

            ReservationPassager rp = new ReservationPassager();
            rp.setIdReservation(reservation.getId().intValue());
            rp.setIdPassager(idPassager);
            rp.setIdSiege(idSiege);

            rp.setIdVol(volAvion.getIdVol());
            rp.setIdVolAvion(volAvion.getId().intValue());

            Passager passager = rp.getForeignKey("id_passager");
            TrancheAge trancheAge = passager.getTrancheAge(dateReservation.toLocalDate());

            Siege s = Siege.findById(idSiege.longValue(), Siege.class, QueryManager.get_instance());
            Float montant = 0f;
            if(s != null && s.getIdClasseSiege() != null) {
                TarifVol t = TarifVol.getTarifVol(volAvion.getIdVol(), s.getIdClasseSiege(), volAvion.getDateDepart());
                montant = TarifVol.getMontantTarif(t, trancheAge, dateReservation);
            }
            rp.setPrix(montant);
            rp.setCreatedOn(LocalDateTime.now());

            rp.save();
        }

        resp.sendRedirect("reservation?action=list");
    }

    public void payReservation(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idReservationStr = req.getParameter("idReservation");
        if(idReservationStr == null || idReservationStr.isEmpty()) {
            throw new Exception("L'id de la réservation est requis pour le paiement");
        }

        Reservation reservation = Reservation.findById(Integer.parseInt(idReservationStr), Reservation.class, QueryManager.get_instance());
        if(reservation == null) {
            throw new Exception("Aucune réservation trouvée pour l'id " + idReservationStr);
        }

        List<ReservationPassager> rps = ReservationPassager.findBy("id_reservation", reservation.getId().intValue(),
                ReservationPassager.class, QueryManager.get_instance());

        List<StatutReservation> sr = StatutReservation.findBy("libelle", "Payee",
                StatutReservation.class, QueryManager.get_instance());

        if(sr.isEmpty()) {
            throw new Exception("Aucun statut reservation 'Payee' trouvé dans la base de données");
        }

        for(ReservationPassager rp : rps ) {
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
        HistoriqueStatutReservation hsr = new HistoriqueStatutReservation();
        hsr.setIdReservation(reservation.getId().intValue());
        hsr.setIdStatutReservation(sr.getFirst().getId().intValue());
        hsr.setCreatedOn(LocalDateTime.now());
        hsr.save();

        resp.sendRedirect("billet?action=list&idReservation="+reservation.getId());
    }
}
