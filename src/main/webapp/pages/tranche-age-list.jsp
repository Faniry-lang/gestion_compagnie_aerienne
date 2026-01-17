<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.TrancheAge" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des tranches d'âges</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        .page-header { display:flex; justify-content:space-between; align-items:center; }
        .modal-overlay { position: fixed; inset:0; background: rgba(2,6,23,0.45); display:none; align-items:center; justify-content:center; z-index:1100; }
        .modal-overlay.open { display:flex; }
        .modal-card { background:var(--surface,#fff); border-radius:12px; padding:20px; width:520px; max-width:94%; box-shadow:0 12px 30px rgba(2,6,23,0.08); border:1px solid var(--border,#e6eef8); }
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
            <h1>Tranches d'âges</h1>
            <div style="display:flex; gap:10px; align-items:center;">
                <button class="btn" id="openCreateBtn"><i class="fi fi-rr-plus"></i> Enregistrer</button>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Libellé</th>
                        <th>Âge min</th>
                        <th>Âge max</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<TrancheAge> list = (List<TrancheAge>) request.getAttribute("trancheAges");
                        if (list != null && !list.isEmpty()) {
                            for (TrancheAge t : list) {
                    %>
                        <tr>
                            <td><%= t.getId() %></td>
                            <td><%= t.getLibelle() != null ? t.getLibelle() : "" %></td>
                            <td><%= t.getAgeMin() != null ? t.getAgeMin() : "" %></td>
                            <td><%= t.getAgeMax() != null ? t.getAgeMax() : "" %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="4">Aucune tranche d'âge trouvée</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div id="createOverlay" class="modal-overlay" onclick="closeCreate(event)">
        <div class="modal-card" onclick="event.stopPropagation()">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                <h3>Créer une tranche d'âge</h3>
                <button class="close-btn" onclick="closeCreate(event)">×</button>
            </div>
            <form action="tranche-age" method="post">
                <input type="hidden" name="action" value="create" />
                <label>Libellé</label>
                <input type="text" name="libelle" required />
                <label>Âge minimum</label>
                <input type="number" name="ageMin" min="0" />
                <label>Âge maximum</label>
                <input type="number" name="ageMax" min="0" />
                <div style="margin-top:12px;">
                    <button class="btn" type="submit">Enregistrer</button>
                    <button type="button" class="btn btn-secondary" onclick="closeCreate(event)">Annuler</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.getElementById('openCreateBtn').addEventListener('click', function(){ document.getElementById('createOverlay').classList.add('open'); });
        function closeCreate(e){ e && e.stopPropagation(); document.getElementById('createOverlay').classList.remove('open'); }
    </script>
</body>
</html>

