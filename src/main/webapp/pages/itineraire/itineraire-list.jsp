<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.Itineraire" %>
<%@ page import="gestion_compagnie_aerienne.entities.Aeroport" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des itinéraires</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        .page-header { display:flex; justify-content:space-between; align-items:center; }
        .filter-btn { padding:8px 14px; cursor:pointer; }

        .modal-overlay { position: fixed; inset:0; background: rgba(2,6,23,0.45); display:none; align-items:center; justify-content:center; z-index:1100; }
        .modal-overlay.open { display:flex; }
        .modal-card { background:var(--surface,#fff); border-radius:12px; padding:20px; width:520px; max-width:94%; box-shadow:0 12px 30px rgba(2,6,23,0.08); border:1px solid var(--border,#e6eef8); }
        .filter-overlay { position: fixed; top:0; left:0; width:100vw; height:100vh; background: rgba(0,0,0,0.5); z-index:999; display:none; }
        .filter-overlay.open { display:block; }
        .filter-panel { position: fixed; top:0; right:-380px; width:350px; height:100vh; background:#fff; z-index:1000; box-shadow:-2px 0 10px rgba(0,0,0,0.2); transition:right .3s ease; padding:20px; }
        .filter-panel.open { right:0; }
        .filter-header { display:flex; justify-content:space-between; align-items:center; }
        .close-btn { font-size:24px; background:none; border:none; cursor:pointer; }
        .filter-panel form { margin-top:20px; display:flex; flex-direction:column; gap:10px; }
        .filter-panel input, .filter-panel select, .filter-panel button { padding:8px; }
        .search-row { display:flex; gap:10px; align-items:flex-end; margin:12px 0; }
        table { width:100%; border-collapse:collapse; background:#fff; }
        th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
        th { background:#f8fafc; color:#0f172a; }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <h1>Liste des itinéraires</h1>
            <div style="display:flex; gap:10px; align-items:center;">
                <button class="btn" id="openCreateItinBtn"><i class="fi fi-rr-plus"></i>Enregistrer</button>
                <button class="filter-btn" onclick="openFilters()">Filtres</button>
            </div>
        </div>

        <form action="itineraire" method="get" class="search-row">
            <div>
                <label>Distance min (km)</label>
                <input type="number" step="0.1" name="distanceMin" value="<%= request.getParameter("distanceMin") != null ? request.getParameter("distanceMin") : "" %>" />
            </div>
            <div>
                <label>Distance max (km)</label>
                <input type="number" step="0.1" name="distanceMax" value="<%= request.getParameter("distanceMax") != null ? request.getParameter("distanceMax") : "" %>" />
            </div>
            <div style="display:flex; gap:8px; align-items:flex-end;">
                <button class="btn" type="submit">Rechercher</button>
                <a href="itineraire" class="btn btn-secondary" style="text-decoration:none; padding:6px 10px;"><i class="fi fi-rr-rotate-left"></i> Réinitialiser</a>
            </div>
        </form>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Aéroport départ</th>
                        <th>Aéroport arrivée</th>
                        <th>Distance (km)</th>
                        <th>Durée estimée (min)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Itineraire> its = (List<Itineraire>) request.getAttribute("itineraires");
                        if(its != null && !its.isEmpty()) {
                            for(Itineraire it : its) {
                                Aeroport dep =  it.getForeignKey("id_aeroport_depart");
                                Aeroport arr =  it.getForeignKey("id_aeroport_arrivee");
                    %>
                                <tr>
                                    <td><%= it.getId() %></td>
                                    <td><%= dep != null ? dep.getNom() : it.getIdAeroportDepart() %></td>
                                    <td><%= arr != null ? arr.getNom() : it.getIdAeroportArrivee() %></td>
                                    <td><%= it.getDistanceKm() != null ? it.getDistanceKm() : "" %></td>
                                    <td><%= it.getDureeMoyenneEstimee() != null ? it.getDureeMoyenneEstimee() : "" %></td>
                                </tr>
                    <%      }
                        } else { %>
                            <tr><td colspan="5">Aucun itinéraire trouvé</td></tr>
                    <%  } %>
                </tbody>
            </table>
        </div>

        <div id="filterOverlay" class="filter-overlay" onclick="closeFilters()"></div>
        <div id="filterPanel" class="filter-panel">
            <div class="filter-header">
                <h2>Filtres</h2>
                <button class="close-btn" onclick="closeFilters()">×</button>
            </div>
            <form action="itineraire" method="get">
                <label>Aéroport départ</label>
                <select name="idAeroportDepart">
                    <option value="">(Tous)</option>
                    <% List<Aeroport> aeroports = (List<Aeroport>) request.getAttribute("aeroports"); if(aeroports != null) { for(Aeroport a : aeroports) { %>
                        <option value="<%= a.getId() %>"><%= a.getNom() != null ? a.getNom() : a.getId() %></option>
                    <% } } %>
                </select>

                <label>Aéroport arrivée</label>
                <select name="idAeroportArrivee">
                    <option value="">(Tous)</option>
                    <% if(aeroports != null) { for(Aeroport a : aeroports) { %>
                        <option value="<%= a.getId() %>"><%= a.getNom() != null ? a.getNom() : a.getId() %></option>
                    <% } } %>
                </select>

                <div class="form-actions">
                    <button class="btn" type="submit">Appliquer</button>
                </div>
            </form>
        </div>

    </div>


    <div id="createItinOverlay" class="modal-overlay" onclick="closeCreateItin(event)">
        <div class="modal-card" style="max-width:600px;" onclick="event.stopPropagation()">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                <h3>Créer un itinéraire</h3>
                <button class="close-btn" onclick="closeCreateItin(event)">×</button>
            </div>
            <form action="itineraire" method="post">
                <input type="hidden" name="action" value="create" />
                <label>Aéroport départ</label>
                <select id="idAeroportDepart_modal" name="idAeroportDepart" required>
                    <option value="">(Sélectionner)</option>
                    <% if(aeroports != null) { for(Aeroport a : aeroports) { %>
                        <option value="<%= a.getId() %>"><%= a.getNom() != null ? a.getNom() : a.getId() %></option>
                    <% } } %>
                </select>

                <label>Aéroport arrivée</label>
                <select id="idAeroportArrivee_modal" name="idAeroportArrivee" required>
                    <option value="">(Sélectionner)</option>
                    <% if(aeroports != null) { for(Aeroport a : aeroports) { %>
                        <option value="<%= a.getId() %>"><%= a.getNom() != null ? a.getNom() : a.getId() %></option>
                    <% } } %>
                </select>

                <label>Distance (km)</label>
                <input id="distanceKm_modal" type="number" step="0.1" name="distanceKm" required />

                <label>Durée estimée (min)</label>
                <input id="duree_modal" type="number" name="dureeMoyenneEstimee" />

                <div class="form-actions" style="margin-top:12px;">
                    <button class="btn" type="submit">Enregistrer</button>
                    <button type="button" class="btn btn-secondary" onclick="closeCreateItin(event)">Annuler</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openFilters(){ document.getElementById('filterPanel').classList.add('open'); document.getElementById('filterOverlay').classList.add('open'); }
        function closeFilters(){ document.getElementById('filterPanel').classList.remove('open'); document.getElementById('filterOverlay').classList.remove('open'); }
        document.getElementById('openCreateItinBtn').addEventListener('click', function(){ document.getElementById('createItinOverlay').classList.add('open'); });
        function closeCreateItin(e){ e && e.stopPropagation(); document.getElementById('createItinOverlay').classList.remove('open'); }
    </script>
</body>
</html>
