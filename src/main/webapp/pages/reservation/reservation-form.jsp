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
    Integer idVolAvion = (Integer) request.getAttribute("idVolAvion");
    List<Passager> passagers = (List<Passager>) request.getAttribute("passagers");
    VolAvion volAvion = (VolAvion) request.getAttribute("volAvion");
    Vol vol = (Vol) request.getAttribute("vol");
    Avion avion = (Avion) request.getAttribute("avion");
%>
<html>
<head>
    <title>Création d'une réservation</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .passager-row { margin-bottom: 8px; }
        .remove-btn { margin-left: 8px; }
        .flight-details { margin-bottom: 16px; padding: 8px; border: 1px solid #ccc; background: linear-gradient(135deg, #1e293b 0%, #1a1f2e 100%); border-radius:8px; }
        .flight-details p { margin: 4px 0; }
        .reservation-form-box { background: linear-gradient(135deg, #1e293b 0%, #1a1f2e 100%); padding:20px; border-radius:12px; border:1px solid rgba(96,165,250,0.08); }
        .form-actions { margin-top: 12px; }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">

    <div class="reservation-form-box">
    <div class="flight-details">
        <h3>Détails du vol</h3>
        <p>Numéro du vol: <%= (vol != null ? vol.getNumeroVol() : "N/A") %></p>
        <p>Modèle de l'avion: <%= (avion != null ? avion.getModele() : "N/A") %></p>
        <p>Date de départ: <%= (volAvion != null && volAvion.getDateDepart() != null ? volAvion.getDateDepart().toString() : "N/A") %></p>
        <p>Date d'arrivée: <%= (volAvion != null && volAvion.getDateArrivee() != null ? volAvion.getDateArrivee().toString() : "N/A") %></p>
    </div>

    <form action="reservation" method="post">
        <div id="passagers-container">
            <label>Passagers:</label>
            <div class="passager-row">
                <select name="idPassager">
                    <% if (passagers != null) {
                        for(Passager passager: passagers) { %>
                            <option value="<%= passager.getId() %>"><%= passager.getNom() + " " + passager.getPrenom() %></option>
                    <%  }
                    } else { %>
                        <option value="">(Aucun passager disponible)</option>
                    <% } %>
                </select>
                <button type="button" class="remove-btn" onclick="removeRow(this)">Supprimer</button>
            </div>
        </div>

        <div>
            <button type="button" id="add-passager-btn" class="btn btn-secondary">Ajouter un passager</button>
        </div>

        <div class="form-actions">
            <input type="hidden" name="prix" value="900000"/>
            <input type="hidden" name="idVolAvion" value="<%= idVolAvion %>"/>
            <button type="submit" class="btn btn-primary">Réserver</button>
        </div>
    </form>
    </div>

    </div>

    <script>
        // Template for a passager select row
        const passagersOptions = `
            <% if (passagers != null) {
                for(Passager passager: passagers) { %>
                    <option value="<%= passager.getId() %>"><%= passager.getNom() + " " + passager.getPrenom() %></option>
            <%  }
            } else { %>
                <option value="">(Aucun passager disponible)</option>
            <% } %>
        `;

        document.getElementById('add-passager-btn').addEventListener('click', function() {
            const container = document.getElementById('passagers-container');
            const div = document.createElement('div');
            div.className = 'passager-row';
            const select = document.createElement('select');
            select.name = 'idPassager';
            select.innerHTML = passagersOptions;
            const removeBtn = document.createElement('button');
            removeBtn.type = 'button';
            removeBtn.className = 'remove-btn';
            removeBtn.textContent = 'Supprimer';
            removeBtn.onclick = function() { removeRow(removeBtn); };
            div.appendChild(select);
            div.appendChild(removeBtn);
            container.appendChild(div);
        });

        function removeRow(btn) {
            const row = btn.parentNode;
            const container = document.getElementById('passagers-container');
            if (container.children.length > 1) {
                container.removeChild(row);
            } else {
                // clear selection if it's the last row
                const sel = row.querySelector('select');
                if (sel) sel.selectedIndex = 0;
            }
        }
    </script>
</body>
</html>
