<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.RemiseAgeTarif" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des remises par âge</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        .page-header { display:flex; justify-content:space-between; align-items:center; }
        .table-container { margin-top:10px; }
        table { width:100%; border-collapse:collapse; background:#fff; }
        th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
        th { background:#f8fafc; color:#0f172a; }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <h1>Remises par âge</h1>
            <div><a class="btn" href="remise-age?action=form"><i class="fi fi-rr-plus"></i> Enregistrer</a></div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Vol (id)</th>
                        <th>Classe (id)</th>
                        <th>Tranche âge (id)</th>
                        <th>Tranche réf (id)</th>
                        <th>Pourcentage</th>
                        <th>Montant</th>
                        <th>Est en %</th>
                        <th>Créé le</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<RemiseAgeTarif> list = (List<RemiseAgeTarif>) request.getAttribute("remiseAges");
                        if (list != null && !list.isEmpty()) {
                            for (RemiseAgeTarif r : list) {
                    %>
                        <tr>
                            <td><%= r.getId() %></td>
                            <td><%= r.getIdVol() %></td>
                            <td><%= r.getIdClasseSiege() != null ? r.getIdClasseSiege() : "Toutes" %></td>
                            <td><%= r.getIdTrancheAge() %></td>
                            <td><%= r.getIdTrancheAgeRef() != null ? r.getIdTrancheAgeRef() : "-" %></td>
                            <td><%= r.getMontantPourcentage() != null ? r.getMontantPourcentage() : "" %></td>
                            <td><%= r.getMontantComplet() != null ? r.getMontantComplet() : "" %></td>
                            <td><%= r.getEstEnPourcentage() ? "Oui" : "Non" %></td>
                            <td><%= r.getCreatedOn() != null ? r.getCreatedOn() : "" %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="9">Aucune remise trouvée</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

