<%@ page import="java.time.LocalDateTime" %>
<%@ page import="gestion_compagnie_aerienne.entities.VolAvion" %>
<%@ page import="gestion_compagnie_aerienne.entities.ClasseSiege" %>
<%@ page import="gestion_compagnie_aerienne.entities.Vol" %>
<%@ page import="gestion_compagnie_aerienne.entities.Avion" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Revenu maximum du vol</title>

    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        .page-header {
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:20px;
        }

        .filter-card {
            background:#fff;
            border:1px solid #e6eef8;
            border-radius:12px;
            padding:16px;
            box-shadow:0 6px 20px rgba(2,6,23,0.06);
            margin-bottom:20px;
        }

        .filter-form {
            display:flex;
            gap:12px;
            align-items:flex-end;
            flex-wrap:wrap;
        }

        .filter-form label {
            font-size:13px;
            color:#475569;
        }

        .filter-form input,
        .filter-form select {
            padding:8px;
            min-width:200px;
        }

        .info-grid {
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(240px, 1fr));
            gap:16px;
            margin-top:20px;
        }

        .info-card {
            background:#fff;
            border-radius:12px;
            border:1px solid #e6eef8;
            padding:16px;
            box-shadow:0 4px 16px rgba(2,6,23,0.05);
        }

        .info-card h3 {
            margin:0;
            font-size:14px;
            color:#64748b;
            font-weight:500;
        }

        .info-card p {
            margin:6px 0 0;
            font-size:18px;
            font-weight:600;
            color:#0f172a;
        }

        .revenue-card {
            margin-top:24px;
            padding:24px;
            text-align:center;
            background:linear-gradient(135deg, #0ea5e9, #0284c7);
            color:#fff;
            border-radius:16px;
            box-shadow:0 10px 30px rgba(2,6,23,0.2);
        }

        .revenue-card h2 {
            margin:0;
            font-size:18px;
            font-weight:500;
            opacity:.9;
        }

        .revenue-card .amount {
            margin-top:8px;
            font-size:36px;
            font-weight:700;
        }
    </style>
</head>

<body>
<%@ include file="/sidebar.jsp" %>

<div class="main-content">

    <%
        LocalDateTime date = (LocalDateTime) request.getAttribute("date");
        VolAvion volAvion = (VolAvion) request.getAttribute("volAvion");
        ClasseSiege classeSiege = (ClasseSiege) request.getAttribute("classeSiege");
        List<ClasseSiege> classeSieges = (List<ClasseSiege>) request.getAttribute("classeSieges");
        Float revenuMaxFloat = (Float) request.getAttribute("revenuMax");
        String revenuMax = String.format("%.2f", revenuMaxFloat);
        Vol vol = (Vol) volAvion.getForeignKeysCollection().get("id_vol");
        Avion avion = (Avion) volAvion.getForeignKeysCollection().get("id_avion");
    %>

    <div class="page-header">
        <h1>Analyse du revenu maximum</h1>
    </div>

    <!-- Filtres -->
    <div class="filter-card">
        <form action="vol-details" method="get" class="filter-form">
            <input type="hidden" name="action" value="revenu-max"/>
            <input type="hidden" name="idVolAvion" value="<%= volAvion.getId() %>"/>

            <div>
                <label>Date / heure</label>
                <input type="datetime-local" name="date" value="<%= date != null ? date : "" %>" />
            </div>

            <div>
                <label>Classe</label>
                <select name="idClasseSiege">
                    <option value="">-- Toutes --</option>
                    <% if(classeSieges != null) {
                        for(ClasseSiege cs : classeSieges) { %>
                    <option value="<%= cs.getId() %>"><%= cs.getLibelle() %></option>
                    <%  } } %>
                </select>
            </div>

            <button type="submit" class="btn">
                <i class="fi fi-rr-filter"></i> Filtrer
            </button>
        </form>
    </div>

    <!-- Informations vol -->
    <div class="info-grid">
        <div class="info-card">
            <h3>Numéro du vol</h3>
            <p><%= vol != null ? vol.getNumeroVol() : "" %></p>
        </div>

        <div class="info-card">
            <h3>Avion</h3>
            <p><%= avion != null ? avion.getModele() : "" %></p>
        </div>

        <div class="info-card">
            <h3>Classe sélectionnée</h3>
            <p><%= classeSiege != null ? classeSiege.getLibelle() : "Toutes les classes" %></p>
        </div>
    </div>

    <!-- Revenu -->
    <div class="revenue-card">
        <h2>Revenu maximum estimé</h2>
        <div class="amount">
            <%= revenuMax != null ? revenuMax : 0 %> Ar
        </div>
    </div>

</div>
</body>
</html>
