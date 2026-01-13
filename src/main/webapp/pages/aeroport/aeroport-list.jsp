<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.Aeroport" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des aéroports</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        .page-header { display:flex; justify-content:space-between; align-items:center; }
        .filter-row { display:flex; gap:12px; align-items:flex-end; margin:14px 0; }

        .modal-overlay { position: fixed; inset:0; background: rgba(2,6,23,0.45); display:none; align-items:center; justify-content:center; z-index:1100; }
        .modal-overlay.open { display:flex; }
        .modal-card { background:var(--surface,#fff); border-radius:12px; padding:20px; width:520px; max-width:94%; box-shadow:0 12px 30px rgba(2,6,23,0.08); border:1px solid var(--border,#e6eef8); }
        .filter-row .field { display:flex; flex-direction:column; }
        .actions { display:flex; gap:8px; }
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
            <h1>Liste des aéroports</h1>
            <div style="display:flex; gap:10px; align-items:center;">
                <button class="btn" id="openCreateAeroBtn"><i class="fi fi-rr-plus"></i>Enregistrer</button>
            </div>
        </div>

        <form action="aeroport" method="get" class="filter-row">
            <div class="field">
                <label>Code IATA</label>
                <input type="text" name="codeIata" value="<%= request.getParameter("codeIata") != null ? request.getParameter("codeIata") : "" %>" placeholder="Ex: CDG" />
            </div>
            <div class="field">
                <label>Nom</label>
                <input type="text" name="nom" value="<%= request.getParameter("nom") != null ? request.getParameter("nom") : "" %>" placeholder="Ex: Charles de Gaulle" />
            </div>
            <div class="field">
                <label>Ville</label>
                <input type="text" name="ville" value="<%= request.getParameter("ville") != null ? request.getParameter("ville") : "" %>" placeholder="Ex: Paris" />
            </div>
            <div class="field">
                <label>Pays</label>
                <input type="text" name="pays" value="<%= request.getParameter("pays") != null ? request.getParameter("pays") : "" %>" placeholder="Ex: France" />
            </div>

            <div class="actions">
                <button type="submit" class="btn">Rechercher</button>
                <a href="aeroport" class="btn btn-secondary" style="text-decoration:none; padding:8px 12px;"><i class="fi fi-rr-rotate-left"></i> Réinitialiser</a>
            </div>
        </form>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Code IATA</th>
                        <th>Nom</th>
                        <th>Ville</th>
                        <th>Pays</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Aeroport> aeroports = (List<Aeroport>) request.getAttribute("aeroports");
                        if(aeroports != null && !aeroports.isEmpty()) {
                            for(Aeroport a : aeroports) {
                    %>
                                <tr>
                                    <td><%= a.getId() %></td>
                                    <td><%= a.getCodeIata() != null ? a.getCodeIata() : "" %></td>
                                    <td><%= a.getNom() != null ? a.getNom() : "" %></td>
                                    <td><%= a.getVille() != null ? a.getVille() : "" %></td>
                                    <td><%= a.getPays() != null ? a.getPays() : "" %></td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                            <tr><td colspan="5">Aucun aéroport trouvé</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>


    <div id="createAeroOverlay" class="modal-overlay" onclick="closeCreateAero(event)">
        <div class="modal-card" style="max-width:560px;" onclick="event.stopPropagation()">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                <h3>Créer un aeroport</h3>
                <button class="close-btn" onclick="closeCreateAero(event)">×</button>
            </div>
            <form action="aeroport" method="post">
                <input type="hidden" name="action" value="create" />
                <label>Code IATA</label>
                <input type="text" name="codeIata" required />
                <label>Nom</label>
                <input type="text" name="nom" required />
                <label>Ville</label>
                <input type="text" name="ville" />
                <label>Pays</label>
                <input type="text" name="pays" />

                <div class="form-actions" style="margin-top:12px;">
                    <button class="btn" type="submit">Enregistrer</button>
                    <button type="button" class="btn btn-secondary" onclick="closeCreateAero(event)">Annuler</button>
                </div>
            </form>
        </div>
    </div>


    <script>
        function openFilters(){ document.getElementById('filterPanel').classList.add('open'); document.getElementById('filterOverlay').classList.add('open'); }
        function closeFilters(){ document.getElementById('filterPanel').classList.remove('open'); document.getElementById('filterOverlay').classList.remove('open'); }
        document.getElementById('openCreateAeroBtn').addEventListener('click', function(){ document.getElementById('createAeroOverlay').classList.add('open'); });
        function closeCreateAero(e){ e && e.stopPropagation(); document.getElementById('createAeroOverlay').classList.remove('open'); }
    </script>
</body>
</html>
