package gestion_compagnie_aerienne.servlet;

import gestion_compagnie_aerienne.entities.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import legacy.query.Comparator;
import legacy.query.Filter;
import legacy.query.QueryManager;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class CAGlobalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            try {
                processList(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void processList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String dateStr = req.getParameter("date"); // yyyy-MM
        LocalDateTime dateFilter = null;
        if (dateStr != null && !dateStr.isEmpty()) {
            dateFilter = LocalDateTime.parse(dateStr + "-01T00:00:00");
        } else {
            // Default to January 2026 as requested in the task, or current date
             dateFilter = LocalDateTime.of(2026, 1, 1, 0, 0);
             dateStr = "2026-01";
        }

        CAGlobal caGlobal = new CAGlobal();
        caGlobal.setDate(dateFilter);

        // 1. CA Billet (Sum of all flights in this month)
        // Find all VolAvion in this month
        /*
         * Note: Since getChiffreAffaire on VolAvion takes a date but seems to sum up all tickets for that flight regardless of date?
         * Let's look at VolAvion.getChiffreAffaire:
         * SELECT SUM(b.prix) ... WHERE va.id = ?
         * It seems VolAvion.getChiffreAffaire returns the total CA for the flight.
         * So we need all VolAvion that DEPARTED in this month/year.
         */
        
        List<Filter> volFilters = new ArrayList<>();
        // Start of month
        LocalDateTime startOfMonth = dateFilter;
        // End of month
        LocalDateTime endOfMonth = dateFilter.plusMonths(1);

        volFilters.add(new Filter("date_depart", Comparator.GREATER_THAN_OR_EQUALS, startOfMonth));
        volFilters.add(new Filter("date_depart", Comparator.LESS_THAN, endOfMonth));

        List<VolAvion> volsInMonth = VolAvion.filter(VolAvion.class, QueryManager.get_instance(), volFilters.toArray(new Filter[0]));

        float caBilletTotal = 0f;
        float caPubTotal = 0f;
        float caExtraTotal = 0f;

        Double coutPub = CoutPub.getLast(); // Simplified
        java.util.Map<Integer, Double> societyRatioMap = new java.util.HashMap<>();

        for (VolAvion va : volsInMonth) {
            caBilletTotal += va.getChiffreAffaire(dateFilter);
            // CA Billet

            // CA Pub for this flight (Actual Revenue / Total Payé logic)
            List<Filter> pubFilters = new ArrayList<>();
            pubFilters.add(new Filter("id_vol_avion", Comparator.EQUALS, va.getId()));
            List<DiffusionPub> diffusions = DiffusionPub.filter(DiffusionPub.class, QueryManager.get_instance(), pubFilters.toArray(new Filter[0]));
            
            java.util.Set<Integer> societiesInFlight = new java.util.HashSet<>();
            for(DiffusionPub dp : diffusions) societiesInFlight.add(dp.getIdSociete());

            for (Integer idSociete : societiesInFlight) {
                 if (!societyRatioMap.containsKey(idSociete)) {
                    double ratio = PayementPub.calculateRatio(idSociete, dateFilter, coutPub);
                    societyRatioMap.put(idSociete, ratio);
                 }
                 
                 double ratio = societyRatioMap.get(idSociete);
                 
                 // Flight Revenue (Expected) for this society in this flight
                 double flightRevenueSociety = 0.0;
                 for (DiffusionPub dpf : diffusions) {
                     if (dpf.getIdSociete().equals(idSociete)) {
                         flightRevenueSociety += dpf.getNbrDiffusion() * coutPub;
                     }
                 }
                 
                 caPubTotal += flightRevenueSociety * ratio;
            }

            // CA Extra
            // Need to sum VenteProduit for this flight
            List<Filter> venteFilters = new ArrayList<>();
            venteFilters.add(new Filter("id_vol_avion", Comparator.EQUALS, va.getId()));
            List<VenteProduit> ventes = VenteProduit.filter(VenteProduit.class, QueryManager.get_instance(), venteFilters.toArray(new Filter[0]));
            
            for(VenteProduit vp : ventes) {
                if(vp.getQte() != null && vp.getPrixUnitaireDuJour() != null) {
                    caExtraTotal += vp.getQte() * vp.getPrixUnitaireDuJour();
                }
            }
        }

        Object[] params = new Object[] {dateFilter.getMonthValue(), dateFilter.getYear()};
        List<VenteProduit> ventesGlobales = VenteProduit.fetch(VenteProduit.class, QueryManager.get_instance(), "SELECT * FROM vente_produit WHERE id_vol_avion IS NULL and EXTRACT(MONTH FROM date_vente) = ? AND EXTRACT(YEAR FROM date_vente) = ? ", params);

        for(VenteProduit vp : ventesGlobales) {
            if(vp.getQte() != null && vp.getPrixUnitaireDuJour() != null) {
                caExtraTotal += vp.getQte() * vp.getPrixUnitaireDuJour();
            }
        }

        // --- CALCUL CA THEORIQUE ---
        float caBilletTheorique = 0f;
        float caPubTheorique = 0f;
        float caExtraTheorique = 0f;

        // 1. Theoretical Billet
        for (VolAvion va : volsInMonth) {
             List<Filter> seatFilters = new ArrayList<>();
             seatFilters.add(new Filter("id_avion", Comparator.EQUALS, va.getIdAvion()));
             List<V_AvionSiege> seats = V_AvionSiege.filter(V_AvionSiege.class, QueryManager.get_instance(), seatFilters.toArray(new Filter[0]));
             
             for(V_AvionSiege s : seats) {
                 TarifVol tarif = TarifVol.getTarifVol(va.getIdVol(), s.getIdClasseSiege(), va.getDateDepart());
                 if(tarif != null && tarif.getMontant() != null) {
                     caBilletTheorique += s.getNbrSiege() * tarif.getMontant();
                 }
             }
        }

        // 2. Theoretical Pub (Total Expected Revenue)
        List<Filter> pubFilters = new ArrayList<>();
        pubFilters.add(new Filter("mois", Comparator.EQUALS, dateFilter.getMonthValue()));
        pubFilters.add(new Filter("annee", Comparator.EQUALS, dateFilter.getYear()));
        List<DiffusionPub> diffusions = DiffusionPub.filter(DiffusionPub.class, QueryManager.get_instance(), pubFilters.toArray(new Filter[0]));
        
        for(DiffusionPub dp : diffusions) {
            caPubTheorique += dp.getNbrDiffusion() * coutPub;
        }

        // 3. Theoretical Extra (Stock)
        List<Filter> stockFilters = new ArrayList<>();
        stockFilters.add(new Filter("date_stock", Comparator.GREATER_THAN_OR_EQUALS, startOfMonth));
        stockFilters.add(new Filter("date_stock", Comparator.LESS_THAN, endOfMonth));
        List<StockProduit> stocks = StockProduit.filter(StockProduit.class, QueryManager.get_instance(), stockFilters.toArray(new Filter[0]));
        
        for(StockProduit sp : stocks) {
             List<PrixVenteProduit> prices = PrixVenteProduit.fetch(PrixVenteProduit.class, QueryManager.get_instance(), "SELECT * FROM prix_vente_produit WHERE id_produit_extra = ? ORDER BY date_mis_a_jour DESC LIMIT 1", new Object[]{sp.getIdProduitExtra()});
             if(!prices.isEmpty()) {
                 caExtraTheorique += sp.getQte() * prices.get(0).getMontant();
             }
        }

        caGlobal.setCaBilletTheorique(caBilletTheorique);
        caGlobal.setCaPubTheorique(caPubTheorique);
        caGlobal.setCaExtraTheorique(caExtraTheorique);

        caGlobal.setCaBillet(caBilletTotal);
        caGlobal.setCaPub(caPubTotal);
        caGlobal.setCaProduitExtra(caExtraTotal);

        List<CAGlobal> list = new ArrayList<>();
        list.add(caGlobal);

        req.setAttribute("caGlobalList", list);
        req.setAttribute("dateStr", dateStr);
        req.getRequestDispatcher("pages/ca-global.jsp").forward(req, resp);
    }
}
