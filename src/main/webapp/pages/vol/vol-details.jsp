<%@ page import="gestion_compagnie_aerienne.entities.Vol" %>
<%@ page import="gestion_compagnie_aerienne.entities.VolDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.Avion" %><%--
  Created by IntelliJ IDEA.
  User: ME-PC
  Date: 12/01/2026
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Vol vol = (Vol) request.getAttribute("vol");
    Integer idVolAttr = (Integer) request.getAttribute("idVol");
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
%>
<html>
<head>
    <title>Details des croiseres du vol <%= vol.getNumeroVol() %> </title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
</head>
<style>
    table { width:100%; border-collapse:collapse; background:#fff; }
    th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
    th { background:#f8fafc; color:#0f172a; }
</style>
<body>
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Details des croiseres du vol <%= vol.getNumeroVol() %></h1>
            <button class="filter-btn" onclick="openFilters()"><i class="fi fi-rr-filter"></i> Filtres</button>
        </div>

        <div class="table-container">
    <table>
        <thead>
            <tr>
                <th>ID Croisiere</th>
                <th>Avion</th>
                <th>Date Depart</th>
                <th>Date Arrivee</th>
                <th>Capacite Totale</th>
                <th>Places reservees</th>
                <th>Places restantes</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<VolDetails> croisieres = (List<VolDetails>) request.getAttribute("volDetails");
                if (croisieres != null) {
                    for(VolDetails croisiere: croisieres) {
                        Avion avion = croisiere.getForeignKey("id_avion");
            %>
                <tr>
                    <td><%= croisiere.getIdVolAvion() %></td>
                    <td><%= avion != null ? avion.getModele() : (croisiere.getIdAvion() != null ? croisiere.getIdAvion() : "N/A") %></td>
                    <td><%= croisiere.getDateDepart() %></td>
                    <td><%= croisiere.getDateArrivee() %></td>
                    <td><%= croisiere.getCapaciteTotale() %></td>
                    <td><%= croisiere.getPlacesReservees() %></td>
                    <td><%= croisiere.getPlacesRestantes() %></td>
                    <td>
                        <a class="btn btn-secondary" href="reservation?action=form&idVolAvion=<%= croisiere.getIdVolAvion() %>"><i class="fi fi-rr-ticket"></i> Reserver</a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="8">Aucune croisiere trouvee</td></tr>
            <%
                }
            %>
        </tbody>
    </table>
        </div>
    </div>

<!-- Overlay -->
<div id="filterOverlay" class="filter-overlay" onclick="closeFilters()"></div>

<!-- Filter panel -->
<div id="filterPanel" class="filter-panel">
    <div class="filter-header">
        <h2>Filtres</h2>
        <button class="close-btn" onclick="closeFilters()">×</button>
    </div>

    <form action="vol-details" method="get">
        <input type="hidden" name="idVol" value="<%= idVolAttr != null ? idVolAttr : (request.getParameter("idVol") != null ? request.getParameter("idVol") : "") %>" />

        <label>Avion</label>
        <select name="idAvion">
            <option value="">(Tous)</option>
            <% if (avions != null) { String selIdAvion = request.getParameter("idAvion"); for (Avion a : avions) { %>
                <option value="<%= a.getId() %>" <%= (selIdAvion != null && selIdAvion.equals(String.valueOf(a.getId()))) ? "selected" : "" %>><%= a.getModele() != null ? a.getModele() : a.getId() %></option>
            <% } } %>
        </select>

        <label>Date depart (min)</label>
        <input type="datetime-local" name="dateDepartMin" value="<%= request.getParameter("dateDepartMin") != null ? request.getParameter("dateDepartMin") : "" %>" />

        <label>Date depart (max)</label>
        <input type="datetime-local" name="dateDepartMax" value="<%= request.getParameter("dateDepartMax") != null ? request.getParameter("dateDepartMax") : "" %>" />

        <label>Date arrivee (min)</label>
        <input type="datetime-local" name="dateArriveeMin" value="<%= request.getParameter("dateArriveeMin") != null ? request.getParameter("dateArriveeMin") : "" %>" />

        <label>Date arrivee (max)</label>
        <input type="datetime-local" name="dateArriveeMax" value="<%= request.getParameter("dateArriveeMax") != null ? request.getParameter("dateArriveeMax") : "" %>" />

        <label>Places restantes (min)</label>
        <input type="number" name="placesRestantesMin" min="0" value="<%= request.getParameter("placesRestantesMin") != null ? request.getParameter("placesRestantesMin") : "" %>" />

        <label>Places restantes (max)</label>
        <input type="number" name="placesRestantesMax" min="0" value="<%= request.getParameter("placesRestantesMax") != null ? request.getParameter("placesRestantesMax") : "" %>" />

        <div class="form-actions">
            <button class="btn" type="submit">Appliquer</button>
        </div>
    </form>
</div>

<script>
    function openFilters() { document.getElementById("filterPanel").classList.add("open"); document.getElementById("filterOverlay").classList.add("open"); }
    function closeFilters(){ document.getElementById("filterPanel").classList.remove("open"); document.getElementById("filterOverlay").classList.remove("open"); }
</script>

</body>
</html>
