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
        /* Modal styles (centered overlay) */
        .modal-overlay { position: fixed; inset:0; background: rgba(2,6,23,0.45); display:none; align-items:center; justify-content:center; z-index:1100; }
        .modal-overlay.open { display:flex; }
        .modal-card { background:var(--surface,#fff); border-radius:12px; padding:20px; width:520px; max-width:94%; box-shadow:0 12px 30px rgba(2,6,23,0.08); border:1px solid var(--border,#e6eef8); }
        .search-row { display:flex; gap:10px; align-items:flex-end; margin:12px 0; flex-wrap:wrap; }
        .search-row .field { display:flex; flex-direction:column; }
        .filter-btn { padding:8px 14px; }
        .filter-overlay { position: fixed; top:0; left:0; width:100vw; height:100vh; background: rgba(0,0,0,0.5); display:none; }
        .filter-overlay.open { display:block; }
        .filter-panel { position: fixed; top:0; right:-380px; width:350px; height:100vh; background:#fff; transition:right .25s; padding:20px; box-shadow:-2px 0 12px rgba(0,0,0,.12); }
        .filter-panel.open { right:0; }
        .filter-panel form { margin-top:12px; display:flex; flex-direction:column; gap:10px; }
        table { width:100%; border-collapse:collapse; background:#fff; }
        th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
        th { background:#f8fafc; color:#0f172a; }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <h1>Liste des avions</h1>
            <div style="display:flex; gap:10px; align-items:center;">
                <button class="btn" id="openCreateAvionBtn"><i class="fi fi-rr-plus"></i>Enregistrer</button>
                <button class="filter-btn" onclick="openFilters()">Filtres</button>
            </div>
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
                <a href="avion" class="btn btn-secondary" style="text-decoration:none; padding:6px 10px;"><i class="fi fi-rr-rotate-left"></i> Réinitialiser</a>
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
                                try { a.mount(); } catch(Exception ignored) {}
                    %>
                                <tr>
                                    <td><%= a.getId() %></td>
                                    <td><%= a.getModele() != null ? a.getModele() : "" %></td>
                                    <td><%= a.getForeignKeysCollection().get("id_type_avion") != null ? ((TypeAvion) a.getForeignKeysCollection().get("id_type_avion")).getLibelle() : "" %></td>
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


        <div id="createAvionOverlay" class="modal-overlay" onclick="closeCreateAvion(event)">
            <div class="modal-card" style="max-width:560px;" onclick="event.stopPropagation()">
                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                    <h3>Créer un avion</h3>
                    <button class="close-btn" onclick="closeCreateAvion(event)">×</button>
                </div>
                <form action="avion" method="post">
                    <input type="hidden" name="action" value="create" />
                    <label>Type</label>
                    <select name="idTypeAvion" required>
                        <option value="">(Sélectionner)</option>
                        <% if(types != null) { for(TypeAvion t : types) { %>
                            <option value="<%= t.getId() %>"><%= t.getLibelle() %></option>
                        <% } } %>
                    </select>
                    <label>Modele</label>
                    <input type="text" name="modele" required />
                    <label>Constructeur</label>
                    <input type="text" name="constructeur" />
                    <label>Nombre de sièges</label>
                    <input type="number" name="nbrSiege" />

                    <div class="form-actions" style="margin-top:12px;">
                        <button class="btn" type="submit">Enregistrer</button>
                        <button type="button" class="btn btn-secondary" onclick="closeCreateAvion(event)">Annuler</button>
                    </div>
                </form>
            </div>
        </div>

    </div>

    <script>
        function openFilters(){ document.getElementById('filterPanel').classList.add('open'); document.getElementById('filterOverlay').classList.add('open'); }
        function closeFilters(){ document.getElementById('filterPanel').classList.remove('open'); document.getElementById('filterOverlay').classList.remove('open'); }
        document.getElementById('openCreateAvionBtn').addEventListener('click', function(){ document.getElementById('createAvionOverlay').classList.add('open'); });
        function closeCreateAvion(e){ e && e.stopPropagation(); document.getElementById('createAvionOverlay').classList.remove('open'); }
    </script>
</body>
</html>
