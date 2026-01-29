package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.*;
import gestion_compagnie_aerienne.utils.DateParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;

public class VolDetailsServlet extends HttpServlet {

    private LocalDateTime parseToDateTime(String s, boolean startOfDay) {
        return DateParser.getLocalDateTime(s, startOfDay);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            switch (action) {
                case "list" :
                    processList(req, resp);
                    break;
                case "revenu-max":
                    processRevenuMax(req, resp);
                    break;
                case "ca":
                    processChiffreAffaire(req, resp);
                    break;
                case "ca-vols":
                    processCATousVols(req, resp);
                    break;
                default:
                    req.setAttribute("error-message", "Aucune action définie");
                    req.getRequestDispatcher("error.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error-message", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    private void processList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idVolStr = req.getParameter("idVol");
        if (idVolStr == null || idVolStr.isEmpty()) {
            throw new Exception("Parametre idVol manquant");
        }
        Integer idVol = Integer.parseInt(idVolStr);

        Vol vol = Vol.findById(idVol, Vol.class, QueryManager.get_instance());
        if (vol == null) {
            throw new Exception("Aucun vol trouve pour l'ID " + idVol);
        }

        List<Filter> filters = new ArrayList<>();

        filters.add(new Filter("id_vol", Comparator.EQUALS, idVol));

        String idAvionStr = req.getParameter("idAvion");
        if (idAvionStr != null && !idAvionStr.isEmpty()) {
            Integer idAvion = Integer.parseInt(idAvionStr);
            filters.add(new Filter("id_avion", Comparator.EQUALS, idAvion));
        }

        LocalDateTime dateDepartMin = parseToDateTime(req.getParameter("dateDepartMin"), true);
        LocalDateTime dateDepartMax = parseToDateTime(req.getParameter("dateDepartMax"), false);
        if (dateDepartMin != null) filters.add(new Filter("date_depart", Comparator.GREATER_THAN_OR_EQUALS, dateDepartMin));
        if (dateDepartMax != null) filters.add(new Filter("date_depart", Comparator.LESS_THAN_OR_EQUALS, dateDepartMax));

        LocalDateTime dateArriveeMin = parseToDateTime(req.getParameter("dateArriveeMin"), true);
        LocalDateTime dateArriveeMax = parseToDateTime(req.getParameter("dateArriveeMax"), false);
        if (dateArriveeMin != null) filters.add(new Filter("date_arrivee", Comparator.GREATER_THAN_OR_EQUALS, dateArriveeMin));
        if (dateArriveeMax != null) filters.add(new Filter("date_arrivee", Comparator.LESS_THAN_OR_EQUALS, dateArriveeMax));

        String placesRestantesMinStr = req.getParameter("placesRestantesMin");
        String placesRestantesMaxStr = req.getParameter("placesRestantesMax");
        if (placesRestantesMinStr != null && !placesRestantesMinStr.isEmpty()) {
            Integer prm = Integer.parseInt(placesRestantesMinStr);
            filters.add(new Filter("places_restantes", Comparator.GREATER_THAN_OR_EQUALS, prm));
        }
        if (placesRestantesMaxStr != null && !placesRestantesMaxStr.isEmpty()) {
            Integer prM = Integer.parseInt(placesRestantesMaxStr);
            filters.add(new Filter("places_restantes", Comparator.LESS_THAN_OR_EQUALS, prM));
        }


        List<VolDetails> filtered = VolDetails.filter(VolDetails.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
        List<Avion> avions = Avion.findAll(Avion.class, QueryManager.get_instance());

        req.setAttribute("vol", vol);
        req.setAttribute("volDetails", filtered);
        req.setAttribute("avions", avions);
        req.setAttribute("idVol", idVol);

        req.getRequestDispatcher("pages/vol/vol-details.jsp").forward(req, resp);
    }

    private void processRevenuMax(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String date = req.getParameter("date");
        String idClasseSiegeStr = req.getParameter("idClasseSiege");
        String idVolAvion = req.getParameter("idVolAvion");

        LocalDateTime dateTime = LocalDateTime.now();
        Integer idVolAvionInt = null;
        Integer idClasseSiege = null;
        ClasseSiege classeSiege = null;

        if(date != null) {
            dateTime = parseToDateTime(date, false);
        }

        if(idVolAvion.isEmpty() || idVolAvion == null) {
            throw new Exception("Aucun idVolAvion n'a été donné");
        }

        idVolAvionInt = Integer.parseInt(idVolAvion);

        VolAvion volAvion = VolAvion.findById(idVolAvionInt, VolAvion.class, QueryManager.get_instance());

        List<Filter> filters = new ArrayList<>();
        filters.add(new Filter("id_avion", Comparator.EQUALS, volAvion.getIdAvion()));

        if(idClasseSiegeStr != null && !idClasseSiegeStr.isEmpty()) {
            idClasseSiege = Integer.parseInt(idClasseSiegeStr);
            filters.add(new Filter("id_classe_siege", Comparator.EQUALS, idClasseSiege));
        }

        List<V_AvionSiege> avionSiege = V_AvionSiege.filter(V_AvionSiege.class, QueryManager.get_instance(), filters.toArray(new Filter[0]));
                // V_AvionSiege.findBy("id_avion", volAvion.getIdAvion(), V_AvionSiege.class, QueryManager.get_instance());

        Float revenuMax = 0f;

        for(V_AvionSiege as : avionSiege) {
            TarifVol tv = TarifVol.getTarifVol(volAvion.getIdVol(), as.getIdClasseSiege(), dateTime);
            if(tv != null) {
                Float revenuClasseSiege = tv.getMontant() * as.getNbrSiege();
                revenuMax += revenuClasseSiege;
            }
        }

        if(idClasseSiege != null) {
            classeSiege = ClasseSiege.findById(idClasseSiege, ClasseSiege.class, QueryManager.get_instance());
        }

        List<ClasseSiege> classeSieges = ClasseSiege.findAll(ClasseSiege.class, QueryManager.get_instance());

        req.setAttribute("revenuMax", revenuMax);
        req.setAttribute("volAvion", volAvion);
        req.setAttribute("date", dateTime);
        req.setAttribute("classeSiege", classeSiege);
        req.setAttribute("classeSieges", classeSieges);

        req.getRequestDispatcher("pages/vol/vol-details-revenu.jsp").forward(req, resp);
    }

    private void processChiffreAffaire(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String dateStr = req.getParameter("date");
        String idVolAvionStr = req.getParameter("idVolAvion");
        Integer idVolAvion = null;

        if(idVolAvionStr == null || idVolAvionStr.isEmpty()) {
            throw new Exception("L'id du vol_avion est requis pour voir les chiffres d'affaires");
        }

        idVolAvion = Integer.parseInt(idVolAvionStr);

        LocalDateTime date = (dateStr != null && !dateStr.isEmpty()) ? DateParser.getLocalDateTime(dateStr, false) : LocalDateTime.now();

        VolAvion volAvion = VolAvion.findById(idVolAvion, VolAvion.class, QueryManager.get_instance());
        Float chiffreAffare = volAvion.getChiffreAffaire(date);

        req.setAttribute("volAvion", volAvion);
        req.setAttribute("chiffreAffaire", chiffreAffare);
        req.setAttribute("date", date);

        req.getRequestDispatcher("pages/vol/vol-avion-ca.jsp").forward(req, resp);
    }

    private void processCATousVols(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String dateStr = req.getParameter("date");
        LocalDateTime date = (dateStr != null && !dateStr.isEmpty()) ? DateParser.getLocalDateTime(dateStr, false) : LocalDateTime.now();

        List<VolAvion> volAvions = VolAvion.findAll(VolAvion.class, QueryManager.get_instance());
        List<CAGlobalParVolAvion> caGlobalList = new ArrayList<>();
        Double coutPub = CoutPub.getLast();
        Map<Integer, Double> societyRatioMap = new HashMap<>();

        for (VolAvion va : volAvions) {
            CAGlobalParVolAvion dto = new CAGlobalParVolAvion();
            dto.setIdVolAvion(va.getId());
            
            try {
                Vol vol = (Vol) va.getForeignKey("id_vol");
                if (vol != null) {
                    dto.setNumeroVol(vol.getNumeroVol());
                    Aeroport dep = (Aeroport) vol.getForeignKey("id_aeroport_depart");
                    Aeroport arr = (Aeroport) vol.getForeignKey("id_aeroport_arrivee");
                    dto.setAeroportDepart(dep != null ? dep.getNom() : "-");
                    dto.setAeroportArrivee(arr != null ? arr.getNom() : "-");
                } else {
                    dto.setNumeroVol("-");
                    dto.setAeroportDepart("-");
                    dto.setAeroportArrivee("-");
                }

                Avion avion = (Avion) va.getForeignKey("id_avion");
                dto.setModeleAvion(avion != null ? (avion.getModele() != null ? avion.getModele() : "Avion " + avion.getId()) : "-");
            } catch (Exception e) {
                dto.setNumeroVol("Err");
                dto.setAeroportDepart("-");
                dto.setAeroportArrivee("-");
                dto.setModeleAvion("-");
            }
            
            dto.setDateDepart(va.getDateDepart());
            
            // alaina ny CA billet
            dto.setCaBillet(va.getChiffreAffaire(date));
            
            // alaina aloha ny diffusion anah pub hoan'io vol io
            List<Filter> filtersVA = new ArrayList<>();
            filtersVA.add(new Filter("id_vol_avion", Comparator.EQUALS, va.getId()));
            if (date != null) {
                filtersVA.add(new Filter("mois", Comparator.EQUALS, date.getMonthValue()));
                filtersVA.add(new Filter("annee", Comparator.EQUALS, date.getYear()));
            }
            List<DiffusionPub> diffusionsVol = DiffusionPub.filter(DiffusionPub.class, QueryManager.get_instance(), filtersVA.toArray(new Filter[0]));

            double totalCaPubVol = 0.0;
            double totalPayeParVol = 0.0;
            
            
            Set<Integer> societeAyantDiffusePubDansVol = new HashSet<>();
            for(DiffusionPub dp : diffusionsVol) societeAyantDiffusePubDansVol.add(dp.getIdSociete());

            for (Integer idSociete : societeAyantDiffusePubDansVol) {
                if (!societyRatioMap.containsKey(idSociete)) {
                    // calculer facture hoanle societe (globalement)
                    List<Filter> globalFilters = new ArrayList<>();
                    globalFilters.add(new Filter("id_societe", Comparator.EQUALS, idSociete));
                    if (date != null) {
                        globalFilters.add(new Filter("mois", Comparator.EQUALS, date.getMonthValue()));
                        globalFilters.add(new Filter("annee", Comparator.EQUALS, date.getYear()));
                    }
                    List<DiffusionPub> globalDiffusions = DiffusionPub.filter(DiffusionPub.class, QueryManager.get_instance(), globalFilters.toArray(new Filter[0]));

                    double factureGlobal = 0.0;
                    for (DiffusionPub gdp : globalDiffusions) {
                        factureGlobal += gdp.getNbrDiffusion() * coutPub;
                    }


                    Double paiementGlobal = PayementPub.getCA(idSociete, date);


                    double ratio = (factureGlobal > 0) ? (paiementGlobal / factureGlobal) : 0.0;
                    societyRatioMap.put(idSociete, ratio);
                }
                
                double ratio = societyRatioMap.get(idSociete);


                double revenuVolSociete = 0.0;
                for (DiffusionPub dpf : diffusionsVol) {
                    if (dpf.getIdSociete().equals(idSociete)) {
                        revenuVolSociete += dpf.getNbrDiffusion() * coutPub;
                    }
                }

                double sommePäyeParSociete = revenuVolSociete * ratio;
                totalCaPubVol += revenuVolSociete;
                totalPayeParVol += sommePäyeParSociete;
            }

            dto.setCaPub((float) totalCaPubVol);
            dto.setTotalPaye((float) totalPayeParVol);
            dto.setResteAPayer((float) (totalCaPubVol - totalPayeParVol));

            caGlobalList.add(dto);
        }

        req.setAttribute("caGlobalList", caGlobalList);
        req.setAttribute("date", date);

        req.getRequestDispatcher("pages/vol/tous-vols-ca.jsp").forward(req, resp);
    }
}
