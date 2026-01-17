<%@ page import="gestion_compagnie_aerienne.entities.VolAvion" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    VolAvion volAvion = (VolAvion) request.getAttribute("volAvion");
    Float chiffreAffaire = (Float) request.getAttribute("chiffreAffaire");
    LocalDateTime date = (LocalDateTime) request.getAttribute("date");
%>
<html>
<head>
    <title>Chiffre d'affaires du vol</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
</head>
<style>
    .info-card {
        background: #fff;
        border-radius: 12px;
        padding: 20px;
        margin: 20px 0;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    .info-row {
        display: flex;
        justify-content: space-between;
        padding: 12px 0;
        border-bottom: 1px solid #eef2ff;
    }
    .info-row:last-child {
        border-bottom: none;
    }
    .info-label {
        font-weight: 600;
        color: #64748b;
    }
    .info-value {
        color: #0f172a;
    }
    .ca-amount {
        font-size: 2.5em;
        font-weight: 700;
        color: #10b981;
        text-align: center;
        margin: 30px 0;
    }
    .date-form {
        background: #f8fafc;
        padding: 20px;
        border-radius: 8px;
        margin: 20px 0;
    }
</style>
<body>
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1><i class="fi fi-rr-chart-line"></i> Chiffre d'affaires</h1>
            <a class="btn btn-secondary" href="javascript:history.back()"><i class="fi fi-rr-arrow-left"></i> Retour</a>
        </div>

        <div class="info-card">
            <h2>Informations du vol</h2>
            <div class="info-row">
                <span class="info-label">ID Vol-Avion :</span>
                <span class="info-value"><%= volAvion.getId() %></span>
            </div>
            <div class="info-row">
                <span class="info-label">ID Vol :</span>
                <span class="info-value"><%= volAvion.getIdVol() %></span>
            </div>
            <div class="info-row">
                <span class="info-label">ID Avion :</span>
                <span class="info-value"><%= volAvion.getIdAvion() %></span>
            </div>
            <div class="info-row">
                <span class="info-label">Date de départ :</span>
                <span class="info-value"><%= volAvion.getDateDepart() %></span>
            </div>
            <div class="info-row">
                <span class="info-label">Date d'arrivée :</span>
                <span class="info-value"><%= volAvion.getDateArrivee() %></span>
            </div>
        </div>

        <div class="date-form">
            <h3>Calculer le CA à une date spécifique</h3>
            <form action="vol-details" method="get" style="display: flex; gap: 15px; align-items: flex-end;">
                <input type="hidden" name="action" value="ca" />
                <input type="hidden" name="idVolAvion" value="<%= volAvion.getId() %>" />
                <div style="flex: 1;">
                    <label>Date de référence</label>
                    <input type="datetime-local" name="date" value="<%= date != null ? date.toString().substring(0, 16) : "" %>" />
                </div>
                <button class="btn" type="submit"><i class="fi fi-rr-search"></i> Calculer</button>
            </form>
        </div>

        <div class="info-card">
            <h2>Chiffre d'affaires</h2>
            <div class="info-row">
                <span class="info-label">Calculé au :</span>
                <span class="info-value"><%= date != null ? date : "N/A" %></span>
            </div>
            <div class="ca-amount">
                <%= chiffreAffaire != null ? String.format("%.2f", chiffreAffaire) : "0.00" %> Ar
            </div>
            <p style="text-align: center; color: #64748b; font-size: 0.9em;">
                <i class="fi fi-rr-info"></i> Ce montant représente la somme des billets vendus jusqu'à la date spécifiée
            </p>
        </div>
    </div>
</body>
</html>

