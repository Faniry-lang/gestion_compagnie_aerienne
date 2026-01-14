<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<TarifVol> tarifs = (List<TarifVol>) request.getAttribute("tarifs");
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<ClasseSiege> classes = (List<ClasseSiege>) request.getAttribute("classes");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tarifs Vol</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        .page-header { display:flex; justify-content:space-between; align-items:center; }
        .filter-btn { padding:8px 14px; cursor:pointer; }
        .filter-overlay { position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.5); z-index: 999; display: none; }
        .filter-overlay.open { display:block; }
        .filter-panel { position: fixed; top: 0; right: -380px; width: 350px; height: 100vh; background: #fff; z-index: 1000; box-shadow: -2px 0 10px rgba(0,0,0,0.2); transition: right 0.3s ease; padding: 20px; }
        .filter-panel.open { right: 0; }
        .filter-header { display:flex; justify-content:space-between; align-items:center; }
        .close-btn { font-size:24px; background:none; border:none; cursor:pointer; }

        table { width:100%; border-collapse:collapse; background:#fff; }
        th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
        th { background:#f8fafc; color:#0f172a; }

        /* Modal pour insertion (centré) */
        .modal-overlay { position: fixed; inset:0; background: rgba(2,6,23,0.45); display:none; align-items:center; justify-content:center; z-index:1100; }
        .modal-overlay.open { display:flex; }
        .modal-card { background:var(--surface,#fff); border-radius:12px; padding:20px; width:520px; max-width:94%; box-shadow:0 12px 30px rgba(2,6,23,0.08); border:1px solid var(--border,#e6eef8); }
        .modal-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:12px; }
        .modal-row{ display:flex; gap:10px; }
        .modal-row .col{ flex:1; display:flex; flex-direction:column; }
        @media (max-width:560px){ .modal-row{ flex-direction:column; } }

        .modal-card input, .modal-card select, .modal-card textarea { width:100%; box-sizing:border-box; }

        .page-header .filter-btn i,
        .page-header #openCreateTarifBtn i { font-size:18px; height:18px; line-height:18px; display:inline-block; vertical-align:middle; margin-right:8px; }

    </style>
</head>
<body>
<%@ include file="/sidebar.jsp" %>

<div class="main-content" style="padding:20px;">
    <div class="page-header">
        <h1>Tarifs Vol</h1>
        <div style="display:flex; gap:10px; align-items:center;">
            <button class="btn" id="openCreateTarifBtn"><i class="fi fi-rr-plus"></i> Ajouter</button>
            <button class="filter-btn btn-secondary" onclick="openFilters()"><i class="fi fi-rr-filter"></i> Filtres</button>
        </div>
    </div>

    <div style="margin-top:12px;">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Vol</th>
                    <th>Classe</th>
                    <th>Montant</th>
                    <th>Créé le</th>
                </tr>
            </thead>
            <tbody>
                <% if (tarifs != null && !tarifs.isEmpty()) {
                    for (TarifVol t : tarifs) {
                        Vol v = t.getForeignKey("id_vol");
                        ClasseSiege c = t.getForeignKey("id_classe_siege");
                %>
                    <tr>
                        <td><%= t.getId() %></td>
                        <td><%= v != null ? v.getNumeroVol() : "N/A" %></td>
                        <td><%= c != null ? c.getLibelle() : "N/A" %></td>
                        <td><%= t.getMontant() %></td>
                        <td><%= t.getCreatedOn() != null ? t.getCreatedOn().toString().replace('T',' ') : "N/A" %></td>
                    </tr>
                <%  }
                } else { %>
                    <tr><td colspan="5">Aucun tarif trouvé</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <div id="overlay" class="filter-overlay" onclick="closeFilters()"></div>

    <!-- Filter panel -->
    <div id="filterPanel" class="filter-panel">
        <div class="filter-header">
            <h2>Filtres</h2>
            <button class="close-btn" onclick="closeFilters()">×</button>
        </div>
        <form action="tarif-vol" method="get">
            <input type="hidden" name="action" value="list" />
            <label>Vol</label><br>
            <select name="idVol">
                <option value="">(Tous)</option>
                <% if (vols != null) { for (Vol v : vols) { %>
                    <option value="<%= v.getId() %>"><%= v.getNumeroVol() %></option>
                <% } } %>
            </select><br>
            <label>Classe</label><br>
            <select name="idClasseSiege">
                <option value="">(Tous)</option>
                <% if (classes != null) { for (ClasseSiege c : classes) { %>
                    <option value="<%= c.getId() %>"><%= c.getLibelle() %></option>
                <% } } %>
            </select><br>
            <label>Date minimum</label><br>
            <input type="date" name="dateMin"><br>
            <label>Date maximum</label><br>
            <input type="date" name="dateMax"><br><br>
            <button type="submit" class="btn">Appliquer</button>
        </form>
    </div>

    <!-- Insert modal (centré) -->
    <div id="createTarifOverlay" class="modal-overlay" onclick="closeCreateTarif(event)">
        <div class="modal-card" onclick="event.stopPropagation()">
            <div class="modal-header">
                <h3>Ajouter un tarif</h3>
                <button class="close-btn" onclick="closeCreateTarif(event)">×</button>
            </div>
            <form action="tarif-vol" method="post">
                <div class="modal-row">
                    <div class="col">
                        <label>Vol</label>
                        <select name="idVol" required>
                            <option value="">Sélectionner</option>
                            <% if (vols != null) { for (Vol v : vols) { %>
                                <option value="<%= v.getId() %>"><%= v.getNumeroVol() %></option>
                            <% } } %>
                        </select>
                    </div>
                </div>

                <div class="modal-row" style="margin-top:10px;">
                    <div class="col">
                        <label>Classe</label>
                        <select name="idClasseSiege" required>
                            <option value="">Sélectionner</option>
                            <% if (classes != null) { for (ClasseSiege c : classes) { %>
                                <option value="<%= c.getId() %>"><%= c.getLibelle() %></option>
                            <% } } %>
                        </select>
                    </div>
                    <div class="col">
                        <label>Montant</label>
                        <input type="number" step="0.01" name="montant" required />
                    </div>
                </div>

                <div class="form-actions" style="margin-top:14px; display:flex; gap:8px;">
                    <button type="submit" class="btn">Enregistrer</button>
                    <button type="button" class="btn btn-secondary" onclick="closeCreateTarif(event)">Annuler</button>
                </div>
            </form>
        </div>
    </div>

</div>

<script>
    function openFilters() { document.getElementById("filterPanel").classList.add("open"); document.getElementById("overlay").classList.add("open"); }
    function closeFilters() { document.getElementById("filterPanel").classList.remove("open"); document.getElementById("overlay").classList.remove("open"); }

    document.getElementById('openCreateTarifBtn').addEventListener('click', function(){
        document.getElementById('createTarifOverlay').classList.add('open');
    });
    function closeCreateTarif(e){ e && e.stopPropagation(); document.getElementById('createTarifOverlay').classList.remove('open'); }
</script>
</body>
</html>
