<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="gestion_compagnie_aerienne.entities.VolDetails" %>
<%@ page import="gestion_compagnie_aerienne.entities.Aeroport" %>
<%@ page import="gestion_compagnie_aerienne.entities.Avion" %>
<%@ page import="gestion_compagnie_aerienne.entities.VolAvion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chiffres d'affaires - Tous les vols</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        table { width:100%; border-collapse:collapse; background:#fff; }
        th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
        th { background:#f8fafc; color:#0f172a; }
    </style>
</head>
<body>

<%@ include file="/sidebar.jsp" %>

<%
    List<VolDetails> volDetailsList = (List<VolDetails>) request.getAttribute("volDetailsList");
    Map<Long, Float> caBillet = (Map<Long, Float>) request.getAttribute("caBilletParVolAvion");
    Map<Long, Float> caPub = (Map<Long, Float>) request.getAttribute("caPubParVolAvion");
    Map<Long, Float> caTotal = (Map<Long, Float>) request.getAttribute("caTotalParVolAvion");
    List<VolAvion> volAvions = (List<VolAvion>) request.getAttribute("volAvions");
    Map<Long, Float> totalPayerParVolAvion = (Map<Long, Float>) request.getAttribute("totalPayerParVolAvion");
    caAttenduMap = (Map<Long, Float>) request.getAttribute("caAttenduParVolAvion");
    java.time.LocalDateTime date = (java.time.LocalDateTime) request.getAttribute("date");

    float sumBillet = 0f;
    float sumPub = 0f;
    float sumTotal = 0f;

    DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
%>

<div class="main-content">
    <div class="page-header">
        <h1>Chiffres d'affaires par occurrence</h1>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID VolAvion</th>
                <th>Numéro Vol</th>
                <th>Aéroport Départ</th>
                <th>Aéroport Arrivée</th>
                <th>Avion</th>
                <th>Date départ</th>
                <th>Heure départ</th>
                <th>CA Billet</th>
                <th>CA Pub</th>
                <th>Total</th>
                <th>Total payé</th>
                <th>Reste a payé</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (volDetailsList != null && !volDetailsList.isEmpty()) {
                    for (VolDetails vd : volDetailsList) {
                        Integer idVAint = vd.getIdVolAvion();
                        Long idVA = idVAint != null ? idVAint.longValue() : null;
                        Float cb = (idVA != null && caBillet != null && caBillet.get(idVA) != null) ? caBillet.get(idVA) : 0f;
                        Float cp = (idVA != null && caPub != null && caPub.get(idVA) != null) ? caPub.get(idVA) : 0f;
                        Float tot = (idVA != null && caTotal != null && caTotal.get(idVA) != null) ? caTotal.get(idVA) : (cb + cp);
                        Float pourcentage = (totPaye / caAttenduMap.get(idVA)) * 100;
                        Float totPaye = cp * pourcentage / 100;
                        

                        sumBillet += cb;
                        sumPub += cp;
                        sumTotal += tot;

                        Aeroport depart = vd.getForeignKey("id_aeroport_depart");
                        Aeroport arrivee = vd.getForeignKey("id_aeroport_arrivee");
                        Avion avion = vd.getForeignKey("id_avion");
            %>
            <tr>
                <td><%= idVA != null ? idVA : "-" %></td>
                <td><%= vd.getNumeroVol() != null ? vd.getNumeroVol() : "-" %></td>
                <td><%= depart != null ? depart.getNom() : "-" %></td>
                <td><%= arrivee != null ? arrivee.getNom() : "-" %></td>
                <td><%= avion != null ? (avion.getModele() != null ? avion.getModele() : avion.getId()) : "-" %></td>
                <td><%= vd.getDateDepart() != null ? dateFmt.format(vd.getDateDepart()) : "-" %></td>
                <td><%= vd.getDateDepart() != null ? timeFmt.format(vd.getDateDepart()) : "-" %></td>
                <td><%= String.format("%.2f", cb) %></td>
                <td><%= String.format("%.2f", cp) %></td>
                <td><%= String.format("%.2f", tot) %></td>
                <td><%= String.format("%.2f" , totPaye) %></td>
                <td><%= String.format("%.2f" , resteAPayer) %></td>
            </tr>
            <%
                    }
                } else if (volAvions != null) {
                    // fallback: show volAvions when volDetails missing
                    for (VolAvion va : volAvions) {
                        Long idVA = va.getId();
                        Float cb = (caBillet != null && caBillet.get(idVA) != null) ? caBillet.get(idVA) : 0f;
                        Float cp = (caPub != null && caPub.get(idVA) != null) ? caPub.get(idVA) : 0f;
                        Float tot = (caTotal != null && caTotal.get(idVA) != null) ? caTotal.get(idVA) : (cb + cp);
                        sumBillet += cb; sumPub += cp; sumTotal += tot;
            %>
            <tr>
                <td><%= va.getId() %></td>
                <td><%= va.getForeignKey("id_vol") != null ? ((gestion_compagnie_aerienne.entities.Vol)va.getForeignKey("id_vol")).getNumeroVol() : "-" %></td>
                <td><%= "-" %></td>
                <td><%= "-" %></td>
                <td><%= va.getForeignKey("id_avion") != null ? ((Avion)va.getForeignKey("id_avion")).getModele() : "-" %></td>
                <td><%= va.getDateDepart() != null ? dateFmt.format(va.getDateDepart()) : "-" %></td>
                <td><%= va.getDateDepart() != null ? timeFmt.format(va.getDateDepart()) : "-" %></td>
                <td><%= String.format("%.2f", cb) %></td>
                <td><%= String.format("%.2f", cp) %></td>
                <td><%= String.format("%.2f", tot) %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
            <tfoot>
            <tr>
                <th colspan="7">Totaux</th>
                <th><%= String.format("%.2f", sumBillet) %></th>
                <th><%= String.format("%.2f", sumPub) %></th>
                <th><%= String.format("%.2f", sumTotal) %></th>
            </tr>
            </tfoot>
        </table>
    </div>
</div>

</body>
</html>
