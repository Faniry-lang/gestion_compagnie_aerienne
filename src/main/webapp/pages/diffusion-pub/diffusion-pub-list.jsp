<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="gestion_compagnie_aerienne.entities.Societe" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CA des Publicités</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        .page-header { display: flex; justify-content: space-between; align-items: center; }
        .filter-btn { padding: 8px 14px; cursor: pointer; }
        .filter-overlay { position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.5); z-index: 999; display: none; }
        .filter-overlay.open { display: block; }
        .filter-panel { position: fixed; top: 0; right: -380px; width: 350px; height: 100vh; background: #fff; z-index: 1000; box-shadow: -2px 0 10px rgba(0,0,0,0.2); transition: right 0.3s ease; padding: 20px; }
        .filter-panel.open { right: 0; }
        .filter-header { display: flex; justify-content: space-between; align-items: center; }
        .close-btn { font-size: 24px; background: none; border: none; cursor: pointer; }
        .filter-panel form { margin-top: 20px; display: flex; flex-direction: column; gap: 10px; }
        .filter-panel input, .filter-panel button { padding: 8px; }
        .ca-display { margin-top: 20px; padding: 20px; background: #f8fafc; border-radius: 8px; text-align: center; }
        .ca-display h2 { margin: 0; color: #0f172a; }
        .page-header .filter-btn i { font-size:18px; height:18px; line-height:18px; display:inline-block; vertical-align:middle; margin-right:8px; }
    </style>
</head>
<body>

<%@ include file="/sidebar.jsp" %>

<% List<Societe> societes = (List<Societe>) request.getAttribute("societes"); %>
<% Double ca = (Double) request.getAttribute("ca"); %>
<% Integer mois = (Integer) request.getAttribute("mois"); %>
<% Integer annee = (Integer) request.getAttribute("annee"); %>
<% Integer idSociete = (Integer) request.getAttribute("idSociete"); %>

<div class="main-content">

    <div class="page-header">
        <h1>CA des Publicités</h1>
        <div style="display:flex; gap:10px; align-items:center;">
            <button class="filter-btn" onclick="openFilters()">
                <i class="fi fi-rr-filter"></i> Filtres
            </button>
        </div>
    </div>

    <div class="ca-display">
        <h2>Chiffre d'Affaires: <%= ca != null ? String.format("%.2f", ca) : "0.00" %> Ar</h2>
    </div>

</div>

<div id="filterOverlay" class="filter-overlay" onclick="closeFilters()"></div>

<div id="filterPanel" class="filter-panel">
    <div class="filter-header">
        <h2>Filtres</h2>
        <button class="close-btn" onclick="closeFilters()">×</button>
    </div>

    <form action="diffusion-pub" method="get">
        <label>Société</label>
        <select name="idSociete">
            <option value="">-- Toutes les sociétés --</option>
            <% if (societes != null) { for (Societe societe : societes) { %>
                <option value="<%= societe.getId() %>" <%= idSociete != null && idSociete.equals(societe.getId()) ? "selected" : "" %>><%= societe.getNom() %></option>
            <% } } %>
        </select>

        <label>Mois</label>
        <input type="number" name="mois" min="1" max="12" value="<%= mois != null ? mois : "" %>" />

        <label>Année</label>
        <input type="number" name="annee" value="<%= annee != null ? annee : "" %>" />

        <button type="submit">Appliquer</button>
    </form>
</div>

<script>
    function openFilters() { document.getElementById("filterPanel").classList.add("open"); document.getElementById("filterOverlay").classList.add("open"); }
    function closeFilters() { document.getElementById("filterPanel").classList.remove("open"); document.getElementById("filterOverlay").classList.remove("open"); }
</script>

</body>
</html>