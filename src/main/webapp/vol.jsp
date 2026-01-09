<%@ page contentType="text/html;charset=UTF-8" language="java"
         import="java.util.List,gestion_compagnie_aerienne.entities.Vol" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aeroport - Gestion Compagnie Aerienne</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/solid/all.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>

<div class="main-content">
    <div class="page-header">
        <h1>Gestion des Vols</h1>
    </div>



    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Numero Vol</th>
                <th>Date départ</th>
                <th>Date arrivée</th>
                <th>Places restantes</th>

                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                @SuppressWarnings("unchecked")
                Map<Vol, Integer> vols = (Map<Vol, Integer>) request.getAttribute("vols");
                    for(Map.Entry<Vol, Integer> entry: vols.entrySet()) {
                        Vol vol = entry.getKey();
                        Integer placesRestantes = entry.getValue();
            %>
            <tr>
                <td><%= vol.getNumeroVol() %></td>
                <td><%= vol.getDateDepart() %></td>
                <td><%= vol.getDateArrivee() %></td>
                <td><%= placesRestantes %></td>
                <td class="actions">
                    <button class="action-btn"><i class="fi fi-ss-eye"></i> Reserver</button>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
