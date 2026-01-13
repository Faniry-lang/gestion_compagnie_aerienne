<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des passagers de reservation</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        .page-header { display:flex; justify-content:space-between; align-items:center; }
        .filter-btn { padding:8px 14px; cursor:pointer; }
        .filter-overlay { position:fixed; top:0; left:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); z-index:999; display:none; }
        .filter-overlay.open { display:block; }
        .filter-panel { position:fixed; top:0; right:-380px; width:350px; height:100vh; background:#fff; z-index:1000; transition:right 0.3s; padding:20px; box-shadow:-2px 0 10px rgba(0,0,0,0.2); }
        .filter-panel.open { right:0; }
        .filter-panel form { display:flex; flex-direction:column; gap:10px; margin-top:16px; }
        .filter-header { display:flex; justify-content:space-between; align-items:center; }
        .close-btn { font-size:24px; background:none; border:none; cursor:pointer; }
        .table-container { margin-top:10px; }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:10px 12px; border-bottom:1px solid #eef2ff; text-align:left; }
        th { background:#f8fafc; color:#0f172a; }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <h1>Passagers par reservation</h1>
            <button class="filter-btn" onclick="openFilters()">Filtres</button>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>ID Reservation</th>
                        <th>Passager</th>
                        <th>Vol</th>
                        <th>VolAvion</th>
                        <th>Siège</th>
                        <th>Prix</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<ReservationPassager> rps = (List<ReservationPassager>) request.getAttribute("reservationPassagers");
                        if(rps != null && !rps.isEmpty()) {
                            for(ReservationPassager rp : rps) {
                                try { rp.mount(); } catch(Exception ignored) {}
                                Reservation res = (Reservation) rp.getForeignKeysCollection().get("id_reservation");
                                Passager pass = (Passager) rp.getForeignKeysCollection().get("id_passager");
                                Vol vol = (Vol) rp.getForeignKeysCollection().get("id_vol");
                                VolAvion va = (VolAvion) rp.getForeignKeysCollection().get("id_vol_avion");
                                Siege s = (Siege) rp.getForeignKeysCollection().get("id_siege");
                    %>
                                <tr>
                                    <td><%= rp.getId() %></td>
                                    <td><%= res != null ? res.getReference() : rp.getIdReservation() %></td>
                                    <td><%= pass != null ? pass.getNom() + " " + pass.getPrenom() : rp.getIdPassager() %></td>
                                    <td><%= vol != null ? vol.getNumeroVol() : rp.getIdVol() %></td>
                                    <td><%= va != null ? va.getId() : rp.getIdVolAvion() %></td>
                                    <td><%= s != null ? s.getNumeroSiege() : rp.getIdSiege() %></td>
                                    <td><%= rp.getPrix() %></td>
                                </tr>
                    <%      }
                        } else { %>
                            <tr><td colspan="7">Aucun passager trouvé</td></tr>
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
            <form action="reservation-passager" method="get">
                <input type="hidden" name="action" value="list" />

                <label>Reservation</label>
                <select name="idReservation">
                    <option value="">(Tous)</option>
                    <% List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations"); if(reservations != null) { for(Reservation r : reservations) { %>
                        <option value="<%= r.getId() %>"><%= r.getReference() != null ? r.getReference() : r.getId() %></option>
                    <% } } %>
                </select>

                <label>Passager</label>
                <select name="idPassager">
                    <option value="">(Tous)</option>
                    <% List<Passager> passagers = (List<Passager>) request.getAttribute("passagers"); if(passagers != null) { for(Passager p : passagers) { %>
                        <option value="<%= p.getId() %>"><%= p.getNom() + " " + p.getPrenom() %></option>
                    <% } } %>
                </select>

                <div class="form-actions">
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
