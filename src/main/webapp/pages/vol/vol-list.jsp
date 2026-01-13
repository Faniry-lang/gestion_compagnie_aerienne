<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.Vol" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des vols</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<%@ include file="/sidebar.jsp" %>
<div class="main-content">
    <h1>Liste des vols</h1>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Numero Vol</th>
                    <th>Aeroport Depart</th>
                    <th>Aeroport Arrivee</th>
                </tr>
            </thead>
            <tbody>
                <% List<Vol> vols = (List<Vol>) request.getAttribute("vols"); if(vols != null) { for(Vol vol : vols) { %>
                    <tr>
                        <td><%= vol.getNumeroVol() %></td>
                        <td><%= vol.getAeroportDepart() %></td>
                        <td><%= vol.getAeroportArrivee() %></td>
                        <td><a href="vol-details?idVol=<%= vol.getId() %>">Voir details</a></td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>

    <form action="vol" method="get">
        <label>Aeroport de depart</label>
        <select name="idAeroportDepart">
            <option value="">-- Selectionner un aeroport --</option>
        </select>

        <label>Aeroport d'arrivee</label>
        <select name="idAeroportArrivee">
            <option value="">-- Selectionner un aeroport --</option>
        </select>
    </form>
</div>
</body>
</html>
