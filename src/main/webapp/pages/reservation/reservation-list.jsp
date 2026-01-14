<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="gestion_compagnie_aerienne.entities.ReservationDetails" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Liste des réservations</title>

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
        table { width:100%; border-collapse:collapse; background:#fff; }
        th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
        th { background:#f8fafc; color:#0f172a; }
    </style>
</head>

<body>

<%@ include file="/sidebar.jsp" %>

<%
    List<ReservationDetails> reservations = (List<ReservationDetails>) request.getAttribute("reservations");
%>

<div class="main-content">

    <div class="page-header">
        <h1>Liste des réservations</h1>
        <button class="filter-btn" onclick="openFilters()">
            <i class="fi fi-rr-filter"></i> Filtres
        </button>
    </div>

    <form action="reservation" method="get" class="filter-row">
        <div class="field">
            <label>Référence</label>
            <input type="text" name="reference" placeholder="Référence" value="<%= request.getParameter("reference") != null ? request.getParameter("reference") : "" %>" />
        </div>
        <div class="actions">
            <button type="submit" class="btn">Rechercher</button>
            <a href="reservation" class="btn btn-secondary" style="text-decoration:none; padding:6px 10px;"><i class="fi fi-rr-rotate-left"></i> Réinitialiser</a>
        </div>
    </form>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Référence</th>
                <th>Date création</th>
                <th>Nombre passagers</th>
                <th>Montant total</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>

            <%
                if (reservations != null) {
                    for (ReservationDetails r : reservations) {
            %>
            <tr>
                <td><%= r.getId() %></td>
                <td><%= r.getReference() %></td>
                <td><%= (r.getCreatedOn() != null ? r.getCreatedOn().toString() : "N/A") %></td>
                <td><%= (r.getNbrPassagers() != null ? r.getNbrPassagers() : "N/A") %></td>
                <td><%= (r.getMontantTotal() != null ? r.getMontantTotal() : "N/A") %></td>
                <td>
                    <a class="btn btn-secondary" href="reservation-passager?action=list&idReservation=<%= r.getId() %>"><i class="fi fi-rr-eye"></i> Voir détails</a>
                    <form action="reservation" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="pay">
                        <input type="hidden" name="idReservation" value="<%= r.getId() %>">

                        <button type="submit" class="btn btn-success">
                            <i class="fi fi-rr-credit-card"></i> Payer
                        </button>
                    </form>
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

    <form action="reservation" method="get">
        <!-- reference moved above the table -->
        <label>Montant total (min)</label>
        <input type="number" step="0.01" name="montantMin" value="" />

        <label>Montant total (max)</label>
        <input type="number" step="0.01" name="montantMax" value="" />

        <label>Nombre de passagers (min)</label>
        <input type="number" name="nbrMin" value="" />

        <label>Nombre de passagers (max)</label>
        <input type="number" name="nbrMax" value="" />

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

