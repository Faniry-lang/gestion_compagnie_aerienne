<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.*" %>
<%--
  Created by IntelliJ IDEA.
  User: ME-PC
  Date: 12/01/2026
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Billet> billets = (List<Billet>) request.getAttribute("billets");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des billets</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
</head>
<body>
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Billets</h1>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Passager</th>
                        <th>Vol</th>
                        <th>VolAvion</th>
                        <th>Siège</th>
                        <th>Classe</th>
                        <th>Prix</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (billets != null) {
                        for (Billet b : billets) {
                            Passager passager = ((Passager) b.getForeignKeysCollection().get("id_passager"));
                            Vol vol = ((Vol) b.getForeignKeysCollection().get("id_vol"));
                            VolAvion volAvion = ((VolAvion) b.getForeignKeysCollection().get("id_vol_avion"));
                            volAvion.mount();
                            Avion avion = (Avion) volAvion.getForeignKeysCollection().get("id_avion");
                            Siege siege = (Siege) b.getForeignKeysCollection().get("id_siege");
                            ClasseSiege classeSiege = (ClasseSiege) b.getForeignKeysCollection().get("id_classe_siege");
                    %>
                            <tr>
                                <td><%= b.getId() %></td>
                                <td><%= passager.getNom() %></td>
                                <td><%= vol.getNumeroVol() %></td>
                                <td><%= avion.getModele() %></td>
                                <td><%= siege.getNumeroSiege() %></td>
                                <td><%= classeSiege.getLibelle() %></td>
                                <td><%= b.getPrix() %></td>
                            </tr>
                    <%   }
                    } else { %>
                        <tr><td colspan="7">Aucun billet trouvé</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
