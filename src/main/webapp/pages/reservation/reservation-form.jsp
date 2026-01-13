<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.*" %>
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
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        /* Scoped styles for reservation form - modern & minimal */
        .reservation-card {
            max-width: 980px;
            margin: 24px auto;
            background: #ffffff;
            border-radius: 12px;
            padding: 22px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.06);
            border: 1px solid #e6edf3;
            display: grid;
            grid-template-columns: 1fr 420px;
            gap: 20px;
        }

        .reservation-card .flight-details {
            background: linear-gradient(180deg, #f8fafc, #ffffff);
            padding: 18px;
            border-radius: 10px;
            border: 1px solid #eef2ff;
        }

        .flight-details h3 { margin-bottom: 10px; color: #0f172a; }
        .flight-details p { color: #475569; margin: 6px 0; font-size: 0.95em; }

        .reservation-form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        #passagers-container { display:flex; flex-direction:column; gap:10px; }
        .passager-row {
            display:flex;
            gap:8px;
            align-items:center;
            background:#fbfdff;
            padding:8px;
            border-radius:8px;
            border:1px solid #eef2ff;
        }

        .passager-row select { flex:1; padding:8px 10px; border-radius:6px; border:1px solid #d1d5db; }
        .remove-btn {
            background:none; border:1px solid #f87171; color:#b91c1c; padding:6px 8px; border-radius:6px; cursor:pointer; font-weight:700;
        }

        .add-passager {
            align-self:flex-start;
        }

        .form-actions { display:flex; gap:12px; justify-content:flex-end; margin-top:12px; }

        /* mobile */
        @media (max-width:900px) {
            .reservation-card { grid-template-columns: 1fr; padding:16px; }
            .reservation-card .flight-details { order:2; }
        }
    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">

        <div class="reservation-card">

            <div>
                <div class="flight-details">
                    <h3>Détails du vol</h3>
                    <p><strong>Numéro du vol:</strong> <%= (vol != null ? vol.getNumeroVol() : "N/A") %></p>
                    <p><strong>Modèle de l'avion:</strong> <%= (avion != null ? avion.getModele() : "N/A") %></p>
                    <p><strong>Date de départ:</strong> <%= (volAvion != null && volAvion.getDateDepart() != null ? volAvion.getDateDepart().toString() : "N/A") %></p>
                    <p><strong>Date d'arrivée:</strong> <%= (volAvion != null && volAvion.getDateArrivee() != null ? volAvion.getDateArrivee().toString() : "N/A") %></p>
                    <hr class="divider" />
                    <p class="label-small">Sélectionnez un ou plusieurs passagers et confirmez la réservation.</p>
                </div>
            </div>

            <div>
                <form class="reservation-form" action="reservation" method="post">

                    <div id="passagers-container">
                        <label class="label-small" style="font-weight:700; color:#0f172a;">Passagers</label>
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

                    <button type="button" id="add-passager-btn" class="btn btn-secondary add-passager">Ajouter un passager</button>

                    <div class="form-actions">
                        <input type="hidden" name="prix" value="900000"/>
                        <input type="hidden" name="idVolAvion" value="<%= idVolAvion %>"/>
                        <button type="submit" class="btn btn-primary">Réserver</button>
                        <a href="accueil" class="btn btn-secondary">Annuler</a>
                    </div>

                </form>
            </div>

        </div>

    </div>

    <script>
        // Template for a passager select row (re-used innerHTML generation)
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
                const sel = row.querySelector('select');
                if (sel) sel.selectedIndex = 0;
            }
        }
    </script>
</body>
</html>
