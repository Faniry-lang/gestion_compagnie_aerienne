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
%>
<html>
<head>
    <title>Détails des croisières du vol <%= vol.getNumeroVol() %> </title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Détails des croisières du vol <%= vol.getNumeroVol() %></h1>
        </div>

        <div class="table-container">
    <table>
        <thead>
            <tr>
                <th>ID Croisière</th>
                <th>Avion</th>
                <th>Date Départ</th>
                <th>Date Arrivée</th>
                <th>Capacité Totale</th>
                <th>Places réservées</th>
                <th>Places restantes</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<VolDetails> croisieres = (List<VolDetails>) request.getAttribute("volDetails");
                for(VolDetails croisiere: croisieres)
                {
                    Avion avion = (Avion) croisiere.getForeignKeysCollection().get("id_avion");
            %>
                <tr>
                    <td>
                        <%= croisiere.getIdVolAvion() %>
                    </td>
                    <td>
                        <%= avion.getModele() %>
                    </td>
                    <td>
                        <%= croisiere.getDateDepart() %>
                    </td>
                    <td>
                        <%= croisiere.getDateArrivee() %>
                    </td>
                    <td>
                        <%= croisiere.getCapaciteTotale() %>
                    </td>
                    <td>
                        <%= croisiere.getPlacesReservees() %>
                    </td>
                    <td>
                        <%= croisiere.getPlacesRestantes() %>
                    </td>
                    <td>
                        <a href="reservation?action=form&idVolAvion=<%= croisiere.getIdVolAvion() %>">Réserver</a>
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
