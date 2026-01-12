<%@ page import="gestion_compagnie_aerienne.entities.Vol" %>
<%@ page import="gestion_compagnie_aerienne.entities.Aeroport" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: ME-PC
  Date: 12/01/2026
  Time: 19:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des vols</title>
</head>
<body>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Numéro Vol</th>
                <th>Aeroport Départ</th>
                <th>Aeroport Arrivée</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                for(Vol vol: vols)
                {
                    Aeroport depart = (Aeroport) vol.getForeignKeysCollection().get("id_aeroport_depart");
                    Aeroport arrivee = (Aeroport) vol.getForeignKeysCollection().get("id_aeroport_arrivee");
            %>
                <tr>
                    <td>
                        <%= vol.getId() %>
                    </td>
                    <td>
                        <%= vol.getNumeroVol() %>
                    </td>
                    <td>
                        <%= depart != null ? depart.getNom() : "N/A" %>
                    </td>
                    <td>
                        <%= arrivee != null ? arrivee.getNom() : "N/A" %>
                    </td>
                    <td>
                        <a href="vol-details?idVol=<%= vol.getId() %>">Voir Détails</a>
                    </td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
