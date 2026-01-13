<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="gestion_compagnie_aerienne.entities.Vol" %>
<%@ page import="gestion_compagnie_aerienne.entities.Aeroport" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Liste des vols</title>

    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .filter-btn {
            padding: 8px 14px;
            cursor: pointer;
        }

        .filter-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0,0,0,0.5);
            z-index: 999;
            display: none;
        }

        .filter-overlay.open {
            display: block;
        }

        .filter-panel {
            position: fixed;
            top: 0;
            right: -380px;
            width: 350px;
            height: 100vh;
            background: #fff;
            z-index: 1000;
            box-shadow: -2px 0 10px rgba(0,0,0,0.2);
            transition: right 0.3s ease;
            padding: 20px;
        }

        .filter-panel.open {
            right: 0;
        }

        .filter-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .close-btn {
            font-size: 24px;
            background: none;
            border: none;
            cursor: pointer;
        }

        .filter-panel form {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .filter-panel input,
        .filter-panel button {
            padding: 8px;
        }
    </style>
</head>

<body>

<%@ include file="/sidebar.jsp" %>

<%
    List<Aeroport> aeroports = (List<Aeroport>) request.getAttribute("aeroports");
%>

<div class="main-content">

    <div class="page-header">
        <h1>Liste des vols</h1>
        <button class="filter-btn" onclick="openFilters()">
            <i class="fi fi-rr-filter"></i> Filtres
        </button>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Numéro Vol</th>
                <th>Aéroport Départ</th>
                <th>Aéroport Arrivée</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>

            <%
                List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                if (vols != null) {
                    for (Vol vol : vols) {
                        Aeroport depart = (Aeroport) vol.getForeignKeysCollection().get("id_aeroport_depart");
                        Aeroport arrivee = (Aeroport) vol.getForeignKeysCollection().get("id_aeroport_arrivee");
            %>
            <tr>
                <td><%= vol.getId() %></td>
                <td><%= vol.getNumeroVol() %></td>
                <td><%= depart != null ? depart.getNom() : "N/A" %></td>
                <td><%= arrivee != null ? arrivee.getNom() : "N/A" %></td>
                <td>
                    <a href="vol-details?idVol=<%= vol.getId() %>">Voir détails</a>
                </td>
            </tr>
            <%
                    }
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

    <form action="vol" method="get">
        <label>Aéroport de départ</label>
        <select name="idAeroportDepart">
            <option value="">-- Sélectionner un aeroport --</option>
            <% for (Aeroport aeroport : aeroports) { %>
                <option value="<%= aeroport.getId() %>"><%= aeroport.getNom() %></option>
            <% } %>
        </select>

        <label>Aéroport d'arrivee</label>
        <select name="idAeroportArrivee">
            <option value="">-- Sélectionner un aeroport --</option>
            <% for (Aeroport aeroport : aeroports) { %>
            <option value="<%= aeroport.getId() %>"><%= aeroport.getNom() %></option>
            <% } %>
        </select>
        <button type="submit">Appliquer</button>
    </form>
</div>

<script>
    function openFilters() {
        document.getElementById("filterPanel").classList.add("open");
        document.getElementById("filterOverlay").classList.add("open");
    }

    function closeFilters() {
        document.getElementById("filterPanel").classList.remove("open");
        document.getElementById("filterOverlay").classList.remove("open");
    }
</script>

</body>
</html>
