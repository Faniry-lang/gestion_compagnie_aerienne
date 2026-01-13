<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.Avion" %>
<%@ page import="gestion_compagnie_aerienne.entities.TypeAvion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des avions</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        .page-header { display:flex; justify-content:space-between; align-items:center; }
        .search-row { display:flex; gap:10px; align-items:flex-end; margin:12px 0; flex-wrap:wrap; }
        .search-row .field { display:flex; flex-direction:column; }
        .filter-btn { padding:8px 14px; }
        .filter-overlay { position: fixed; top:0; left:0; width:100vw; height:100vh; background: rgba(0,0,0,0.5); display:none; }
        .filter-overlay.open { display:block; }
        .filter-panel { position: fixed; top:0; right:-380px; width:350px; height:100vh; background:#fff; transition:right .25s; padding:20px; box-shadow:-2px 0 12px rgba(0,0,0,.12); }
        .filter-panel.open { right:0; }
        .filter-panel form { margin-top:12px; display:flex; flex-direction:column; gap:10px; }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <h1>Liste des avions</h1>
            <button class="filter-btn" onclick="openFilters()">Filtres</button>
        </div>

        <form action="avion" method="get" class="search-row">
            <div class="field">
                <label>Modèle</label>
                <input type="text" name="modele" value="<%= request.getParameter("modele") != null ? request.getParameter("modele") : "" %>" />
            </div>
            <div class="field">
                <label>Constructeur</label>
                <input type="text" name="constructeur" value="<%= request.getParameter("constructeur") != null ? request.getParameter("constructeur") : "" %>" />
            </div>
            <div style="display:flex; gap:8px; align-items:flex-end;">
                <button class="btn" type="submit">Rechercher</button>
                <a href="avion" class="btn btn-secondary" style="text-decoration:none; padding:6px 10px;">Réinitialiser</a>
            </div>
        </form>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Modèle</th>
                        <th>Type</th>
                        <th>Nombre sièges</th>
                        <th>Constructeur</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Avion> avions = (List<Avion>) request.getAttribute("avions");
                        if(avions != null && !avions.isEmpty()) {
                            for(Avion a : avions) {
                                a.mount();
                    %>
                                <tr>
                                    <td><%= a.getId() %></td>
                                    <td><%= a.getModele() != null ? a.getModele() : "" %></td>
                                    <td><%= ((TypeAvion) a.getForeignKeysCollection().get("id_type_avion")).getLibelle() %></td>
                                    <td><%= a.getNbrSiege() != null ? a.getNbrSiege() : "" %></td>
                                    <td><%= a.getConstructeur() != null ? a.getConstructeur() : "" %></td>
                                </tr>
                    <%      }
                        } else { %>
                            <tr><td colspan="5">Aucun avion trouvé</td></tr>
                    <%  } %>
                </tbody>
            </table>
        </div>

        <!-- overlay + side filter panel -->
        <div id="filterOverlay" class="filter-overlay" onclick="closeFilters()"></div>
        <div id="filterPanel" class="filter-panel">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h3>Filtres</h3>
                <button class="close-btn" onclick="closeFilters()">×</button>
            </div>
            <form action="avion" method="get">
                <label>Type d'avion</label>
                <select name="idTypeAvion">
                    <option value="">(Tous)</option>
                    <% List<TypeAvion> types = (List<TypeAvion>) request.getAttribute("types"); if(types != null) { for(TypeAvion t : types) { %>
                        <option value="<%= t.getId() %>"><%= t.getLibelle() != null ? t.getLibelle() : t.getId() %></option>
                    <% } } %>
                </select>

                <div style="margin-top:12px; display:flex; gap:8px; justify-content:flex-end;">
                    <button class="btn" type="submit">Appliquer</button>
                </div>
            </form>
        </div>

    </div>

    <script>
        function openFilters(){ document.getElementById('filterPanel').classList.add('open'); document.getElementById('filterOverlay').classList.add('open'); }
        function closeFilters(){ document.getElementById('filterPanel').classList.remove('open'); document.getElementById('filterOverlay').classList.remove('open'); }
    </script>
</body>
</html>
