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
    List<Passager> passagers = (List<Passager>) request.getAttribute("passagers");
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
    List<Siege> sieges = (List<Siege>) request.getAttribute("sieges");
    List<ClasseSiege> classes = (List<ClasseSiege>) request.getAttribute("classes");
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des billets</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .filter-btn {
            padding: 8px 14px;
            cursor: pointer;
        }

        .filter-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0,0,0,0.5);
            z-index: 999;
            display: none;
        }

        .filter-overlay.open {
            display: block;
        }

        .filter-panel {
            position: fixed;
            top: 0;
            right: -380px;
            width: 350px;
            height: 100vh;
            background: #fff;
            z-index: 1000;
            box-shadow: -2px 0 10px rgba(0,0,0,0.2);
            transition: right 0.3s ease;
            padding: 20px;
        }

        .filter-panel.open {
            right: 0;
        }

        .filter-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .close-btn {
            font-size: 24px;
            background: none;
            border: none;
            cursor: pointer;
        }

        .filter-panel form {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .filter-panel input,
        .filter-panel button {
            padding: 8px;
        }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Billets</h1>
            <button class="filter-btn" onclick="openFilters()">
                <i class="fi fi-rr-filter"></i> Filtres
            </button>
        </div>

        <!-- Filter form -->
        <div class="filter-panel" style="margin: 10px 0; padding: 10px; background: #fff; border-radius:4px;">
            <form action="billet" method="get" style="display:flex; gap:10px; flex-wrap:wrap; align-items:center;">
                <input type="hidden" name="action" value="list" />

                <div>
                    <label>Passager</label><br>
                    <select name="idPassager">
                        <option value="">(Tous)</option>
                        <% if(passagers != null) { for(Passager p : passagers) { %>
                            <option value="<%= p.getId() %>"><%= p.getNom() + " " + p.getPrenom() %></option>
                        <% } } %>
                    </select>
                </div>

                <div>
                    <label>Vol</label><br>
                    <select name="idVol">
                        <option value="">(Tous)</option>
                        <% if(vols != null) { for(Vol v : vols) { %>
                            <option value="<%= v.getId() %>"><%= v.getNumeroVol() %></option>
                        <% } } %>
                    </select>
                </div>

                <div>
                    <label>Avion</label><br>
                    <select name="idAvion">
                        <option value="">(Tous)</option>
                        <% if(avions != null) { for(Avion a : avions) { %>
                            <option value="<%= a.getId() %>"><%= a.getModele() %></option>
                        <% } } %>
                    </select>
                </div>

                <div>
                    <label>Siège</label><br>
                    <select name="idSiege">
                        <option value="">(Tous)</option>
                        <% if(sieges != null) { for(Siege s : sieges) { %>
                            <option value="<%= s.getId() %>"><%= s.getNumeroSiege() %></option>
                        <% } } %>
                    </select>
                </div>

                <div>
                    <label>Classe</label><br>
                    <select name="idClasseSiege">
                        <option value="">(Tous)</option>
                        <% if(classes != null) { for(ClasseSiege c : classes) { %>
                            <option value="<%= c.getId() %>"><%= c.getLibelle() %></option>
                        <% } } %>
                    </select>
                </div>

                <div>
                    <label>Réservation</label><br>
                    <select name="idReservation">
                        <option value="">(Tous)</option>
                        <% if(reservations != null) { for(Reservation r : reservations) { %>
                            <option value="<%= r.getId() %>"><%= (r.getReference() != null ? r.getReference() : String.valueOf(r.getId())) %></option>
                        <% } } %>
                    </select>
                </div>

                <div style="display:flex; gap:6px; align-items:flex-end;">
                    <button type="submit" class="btn">Appliquer</button>
                    <a href="billet?action=list" class="btn btn-secondary" style="text-decoration:none; padding:6px 10px;">Réinitialiser</a>
                </div>
            </form>
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
                            if(volAvion != null) volAvion.mount();
                            Avion avion = (volAvion != null) ? (Avion) volAvion.getForeignKeysCollection().get("id_avion") : null;
                            Siege siege = (Siege) b.getForeignKeysCollection().get("id_siege");
                            ClasseSiege classeSiege = (ClasseSiege) b.getForeignKeysCollection().get("id_classe_siege");
                    %>
                            <tr>
                                <td><%= b.getId() %></td>
                                <td><%= passager != null ? passager.getNom() : "N/A" %></td>
                                <td><%= vol != null ? vol.getNumeroVol() : "N/A" %></td>
                                <td><%= avion != null ? avion.getModele() : "N/A" %></td>
                                <td><%= siege != null ? siege.getNumeroSiege() : "N/A" %></td>
                                <td><%= classeSiege != null ? classeSiege.getLibelle() : "N/A" %></td>
                                <td><%= b.getPrix() %></td>
                            </tr>
                    <%   }
                    } else { %>
                        <tr><td colspan="7">Aucun billet trouvé</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Overlay -->
        <div id="filterOverlay" class="filter-overlay" onclick="closeFilters()"></div>

        <!-- Filter panel -->
        <div id="filterPanel" class="filter-panel">
            <div class="filter-header">
                <h2>Filtres</h2>
                <button class="close-btn" onclick="closeFilters()">×</button>
            </div>

            <form action="billet" method="get">
                <input type="hidden" name="action" value="list" />

                <label>Passager</label>
                <select name="idPassager">
                    <option value="">(Tous)</option>
                    <% if(passagers != null) { for(Passager p : passagers) { %>
                        <option value="<%= p.getId() %>"><%= p.getNom() + " " + p.getPrenom() %></option>
                    <% } } %>
                </select>

                <label>Vol</label>
                <select name="idVol">
                    <option value="">(Tous)</option>
                    <% if(vols != null) { for(Vol v : vols) { %>
                        <option value="<%= v.getId() %>"><%= v.getNumeroVol() %></option>
                    <% } } %>
                </select>

                <label>Avion</label>
                <select name="idAvion">
                    <option value="">(Tous)</option>
                    <% if(avions != null) { for(Avion a : avions) { %>
                        <option value="<%= a.getId() %>"><%= a.getModele() %></option>
                    <% } } %>
                </select>

                <label>Siège</label>
                <select name="idSiege">
                    <option value="">(Tous)</option>
                    <% if(sieges != null) { for(Siege s : sieges) { %>
                        <option value="<%= s.getId() %>"><%= s.getNumeroSiege() %></option>
                    <% } } %>
                </select>

                <label>Classe</label>
                <select name="idClasseSiege">
                    <option value="">(Tous)</option>
                    <% if(classes != null) { for(ClasseSiege c : classes) { %>
                        <option value="<%= c.getId() %>"><%= c.getLibelle() %></option>
                    <% } } %>
                </select>

                <label>Réservation</label>
                <select name="idReservation">
                    <option value="">(Tous)</option>
                    <% if(reservations != null) { for(Reservation r : reservations) { %>
                        <option value="<%= r.getId() %>"><%= (r.getReference() != null ? r.getReference() : String.valueOf(r.getId())) %></option>
                    <% } } %>
                </select>

                <button type="submit">Appliquer</button>
            </form>
        </div>
    </div>

    <script>
        function openFilters() {
            document.getElementById("filterPanel").classList.add("open");
            document.getElementById("filterOverlay").classList.add("open");
        }

        function closeFilters() {
            document.getElementById("filterPanel").classList.remove("open");
            document.getElementById("filterOverlay").classList.remove("open");
        }
    </script>
</body>
</html>
