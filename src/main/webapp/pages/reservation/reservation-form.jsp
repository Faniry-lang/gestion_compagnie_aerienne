<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer idVolAvion = (Integer) request.getAttribute("idVolAvion");
    List<Passager> passagers = (List<Passager>) request.getAttribute("passagers");
    Map<Siege, Boolean> siegesDisponibles = (Map<Siege, Boolean>) request.getAttribute("sieges");
    VolAvion volAvion = (VolAvion) request.getAttribute("volAvion");
    Vol vol = (Vol) request.getAttribute("vol");
    Avion avion = (Avion) request.getAttribute("avion");

    Map<Integer, List<Siege>> siegesParClasse = new HashMap<>();
    Map<Integer, ClasseSiege> classesMap = new HashMap<>();

    if(siegesDisponibles != null) {
        for(Map.Entry<Siege, Boolean> entry : siegesDisponibles.entrySet()) {
            Siege siege = entry.getKey();
            Boolean available = entry.getValue();
            if(available != null && available) {
                ClasseSiege classeSiege = siege.getForeignKey("id_classe_siege");
                if(classeSiege != null) {
                    Integer classeId = classeSiege.getId();
                    if(!siegesParClasse.containsKey(classeId)) {
                        siegesParClasse.put(classeId, new ArrayList<Siege>());
                        classesMap.put(classeId, classeSiege);
                    }
                    siegesParClasse.get(classeId).add(siege);
                }
            }
        }
    }
%>
<html>
<head>
    <title>Création d'une réservation</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        .reservation-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 24px;
        }

        .flight-info-card {
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            border-radius: 16px;
            padding: 28px;
            margin-bottom: 32px;
            box-shadow: 0 4px 20px rgba(15, 23, 42, 0.08);
            border: 1px solid #e2e8f0;
        }

        .flight-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 24px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e2e8f0;
        }

        .flight-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
        }

        .flight-title {
            flex: 1;
        }

        .flight-title h2 {
            margin: 0 0 4px 0;
            color: #0f172a;
            font-size: 26px;
            font-weight: 700;
        }

        .flight-title p {
            margin: 0;
            color: #64748b;
            font-size: 14px;
        }

        .flight-route {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            gap: 24px;
            align-items: center;
            margin-bottom: 24px;
        }

        .airport-block {
            background: white;
            padding: 20px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .airport-label {
            font-size: 12px;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .airport-name {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.3;
        }

        .route-arrow {
            font-size: 32px;
            color: #3b82f6;
        }

        .flight-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
        }

        .meta-item {
            background: white;
            padding: 16px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .meta-icon {
            width: 40px;
            height: 40px;
            background: #f1f5f9;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #475569;
            font-size: 18px;
        }

        .meta-content {
            flex: 1;
        }

        .meta-label {
            font-size: 12px;
            color: #64748b;
            margin-bottom: 2px;
        }

        .meta-value {
            font-size: 15px;
            font-weight: 600;
            color: #0f172a;
        }

        .seats-section {
            background: white;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 4px 20px rgba(15, 23, 42, 0.08);
            border: 1px solid #e2e8f0;
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #e2e8f0;
        }

        .section-icon {
            width: 44px;
            height: 44px;
            background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 22px;
        }

        .section-header h3 {
            margin: 0;
            color: #0f172a;
            font-size: 22px;
            font-weight: 700;
        }

        .classe-group {
            margin-bottom: 32px;
        }

        .classe-group:last-child {
            margin-bottom: 0;
        }

        .classe-header {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 18px;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-radius: 10px;
            margin-bottom: 16px;
            border: 1px solid #e2e8f0;
        }

        .classe-badge {
            padding: 6px 14px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        .classe-name {
            font-size: 17px;
            font-weight: 700;
            color: #0f172a;
            flex: 1;
        }

        .classe-count {
            font-size: 14px;
            color: #64748b;
            font-weight: 600;
        }

        .seats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 12px;
        }

        .seat-card {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            background: #fafbfc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            transition: all 0.2s ease;
        }

        .seat-card:hover {
            background: #f1f5f9;
            border-color: #cbd5e1;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.06);
        }

        .seat-icon {
            width: 36px;
            height: 36px;
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #475569;
            font-size: 16px;
        }

        .seat-number {
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
            min-width: 60px;
        }

        .seat-card select {
            flex: 1;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            background: white;
            color: #0f172a;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .seat-card select:hover {
            border-color: #3b82f6;
        }

        .seat-card select:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            margin-top: 28px;
            padding-top: 24px;
            border-top: 2px solid #e2e8f0;
        }

        .hint-text {
            color: #64748b;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .hint-icon {
            color: #3b82f6;
            font-size: 18px;
        }

        .actions-buttons {
            display: flex;
            gap: 12px;
        }

        .empty-state {
            text-align: center;
            padding: 48px 24px;
            color: #64748b;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.4;
        }

        @media (max-width: 768px) {
            .flight-route {
                grid-template-columns: 1fr;
            }

            .route-arrow {
                transform: rotate(90deg);
            }

            .flight-meta {
                grid-template-columns: 1fr;
            }

            .seats-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .actions-buttons {
                width: 100%;
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<%@ include file="/sidebar.jsp" %>
<div class="main-content">

    <div class="page-header">
        <h1>Réservation de sièges</h1>
        <div style="display:flex; gap:10px; align-items:center;">
            <a href="vol?action=list" class="btn btn-secondary" style="text-decoration:none;">
                <i class="fi fi-rr-arrow-left"></i> Retour
            </a>
            <button form="seatForm" type="submit" class="btn btn-primary">
                <i class="fi fi-rr-check"></i> Confirmer la réservation
            </button>
        </div>
    </div>

    <div class="reservation-container">
        <div class="flight-info-card">
            <div class="flight-header">
                <div class="flight-icon">
                    <i class="fi fi-rr-plane-departure"></i>
                </div>
                <div class="flight-title">
                    <h2>Vol <%= (vol != null ? vol.getNumeroVol() : "N/A") %></h2>
                    <p>Sélectionnez vos sièges pour ce vol</p>
                </div>
            </div>

            <div class="flight-route">
                <div class="airport-block">
                    <div class="airport-label">Départ</div>
                    <div class="airport-name">
                        <%= (vol != null ? (vol.getForeignKey("id_aeroport_depart") != null ? ((gestion_compagnie_aerienne.entities.Aeroport)vol.getForeignKey("id_aeroport_depart")).getNom() : "Non spécifié") : "N/A") %>
                    </div>
                </div>
                <div class="route-arrow">
                    <i class="fi fi-rr-arrow-right"></i>
                </div>
                <div class="airport-block">
                    <div class="airport-label">Arrivée</div>
                    <div class="airport-name">
                        <%= (vol != null ? (vol.getForeignKey("id_aeroport_arrivee") != null ? ((gestion_compagnie_aerienne.entities.Aeroport)vol.getForeignKey("id_aeroport_arrivee")).getNom() : "Non spécifié") : "N/A") %>
                    </div>
                </div>
            </div>

            <div class="flight-meta">
                <div class="meta-item">
                    <div class="meta-icon">
                        <i class="fi fi-rr-calendar"></i>
                    </div>
                    <div class="meta-content">
                        <div class="meta-label">Date de départ</div>
                        <div class="meta-value">
                            <%= (volAvion != null && volAvion.getDateDepart() != null ? volAvion.getDateDepart().toString() : "Non définie") %>
                        </div>
                    </div>
                </div>

                <div class="meta-item">
                    <div class="meta-icon">
                        <i class="fi fi-rr-calendar-clock"></i>
                    </div>
                    <div class="meta-content">
                        <div class="meta-label">Date d'arrivée</div>
                        <div class="meta-value">
                            <%= (volAvion != null && volAvion.getDateArrivee() != null ? volAvion.getDateArrivee().toString() : "Non définie") %>
                        </div>
                    </div>
                </div>

                <div class="meta-item">
                    <div class="meta-icon">
                        <i class="fi fi-rr-plane"></i>
                    </div>
                    <div class="meta-content">
                        <div class="meta-label">Avion</div>
                        <div class="meta-value">
                            <%= (avion != null ? avion.getModele() : "Non spécifié") %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <form id="seatForm" action="reservation" method="post">
            <input type="hidden" name="idVolAvion" value="<%= idVolAvion %>" />

            <div class="seats-section">
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fi fi-rr-seat-airline"></i>
                    </div>
                    <h3>Sélection des sièges</h3>
                </div>

                <% if(siegesParClasse.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fi fi-rr-chair"></i>
                    <p>Aucun siège disponible pour ce vol.</p>
                </div>
                <% } else {
                    for(Map.Entry<Integer, List<Siege>> entry : siegesParClasse.entrySet()) {
                        Integer classeId = entry.getKey();
                        List<Siege> sieges = entry.getValue();
                        ClasseSiege classe = classesMap.get(classeId);
                %>
                <div class="classe-group" data-classe-id="<%= classeId %>">
                    <div class="classe-header">
                        <div class="classe-badge">
                            <i class="fi fi-rr-star"></i>
                        </div>
                        <div class="classe-name">
                            <%= (classe != null ? classe.getLibelle() : "Classe " + classeId) %>
                        </div>
                        <div class="classe-count">
                            <%= sieges.size() %> siège<%= sieges.size() > 1 ? "s" : "" %> disponible<%= sieges.size() > 1 ? "s" : "" %>
                        </div>
                        <div class="classe-price" style="margin-left:12px; font-weight:700; color:#0f172a;">
                            <% Float priceForClasse = 0f; Map<Integer, Float> tarifsMap = (Map<Integer, Float>) request.getAttribute("tarifsMap"); if(tarifsMap != null && tarifsMap.containsKey(classeId)) { priceForClasse = tarifsMap.get(classeId); } %>
                            <span>Prix: </span><span class="price-value" data-price="<%= priceForClasse %>"><%= priceForClasse %> €</span>
                        </div>
                    </div>

                    <div class="seats-grid">
                        <% for(Siege siege : sieges) { %>
                        <div class="seat-card" data-siege-id="<%= siege.getId() %>" data-classe-id="<%= classeId %>">
                            <div class="seat-icon">
                                <i class="fi fi-rr-chair"></i>
                            </div>
                            <div class="seat-number"><%= siege.getNumeroSiege() %></div>
                            <input type="hidden" class="hid-siege" value="<%= siege.getId() %>" />
                            <select class="sel-passager" aria-label="Sélection passager pour siège <%= siege.getNumeroSiege() %>">
                                <option value="">-- Sélectionner --</option>
                                <% if(passagers != null) {
                                    for(Passager p : passagers) { %>
                                <option value="<%= p.getId() %>"><%= p.getNom() %> <%= p.getPrenom() %></option>
                                <% }
                                } %>
                            </select>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% }
                } %>

                <div style="display:flex; justify-content:space-between; align-items:center; margin-top:18px;">
                    <div class="hint-text">
                        <i class="fi fi-rr-info hint-icon"></i>
                        <span>Sélectionnez un passager pour chaque siège que vous souhaitez réserver</span>
                    </div>
                    <div style="display:flex; align-items:center; gap:20px;">
                        <div>
                            <div style="font-size:13px; color:#64748b;">Montant total</div>
                            <div id="totalPrice" style="font-size:20px; font-weight:800; color:#0f172a;">0 €</div>
                        </div>
                        <div class="actions-buttons">
                            <a href="accueil" class="btn btn-secondary">
                                <i class="fi fi-rr-cross"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fi fi-rr-check"></i> Confirmer la réservation
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>

<script>
    (function(){
        const form = document.getElementById('seatForm');

        function parsePriceText(text){
            if(!text) return 0;
            text = text.replace(/\u00A0/g,'').replace('€','').trim();
            text = text.replace(',', '.');
            const v = parseFloat(text);
            return isNaN(v) ? 0 : v;
        }

        function getClassePrice(classeId){
            if(!classeId) return 0;
            const el = document.querySelector('.classe-group[data-classe-id="' + classeId + '"] .price-value');
            return el ? parsePriceText(el.textContent) : 0;
        }

        function formatPrice(v){ return (v||0).toFixed(2) + ' €'; }

        function recalcTotal(){
            let total = 0;
            document.querySelectorAll('.seat-card').forEach(row => {
                const select = row.querySelector('.sel-passager');
                const passengerId = select ? select.value.trim() : '';
                if(passengerId) {
                    const classeId = row.getAttribute('data-classe-id');
                    const montant = getClassePrice(classeId);
                    total += montant;
                }
            });
            document.getElementById('totalPrice').innerText = formatPrice(total);


            let prixField = form.querySelector('input[name="prix"]');
            if(!prixField) {
                prixField = document.createElement('input');
                prixField.type = 'hidden';
                prixField.name = 'prix';
                form.appendChild(prixField);
            }
            prixField.value = total;
        }

        form.addEventListener('change', function(e){
            if(e && e.target && e.target.classList.contains('sel-passager')) {
                recalcTotal();
            }
        });

        form.addEventListener('submit', function(e){
            if(e) e.preventDefault();
            const oldTemp = form.querySelectorAll('input._temp_pair');
            oldTemp.forEach(i => i.remove());

            const rows = form.querySelectorAll('.seat-card');
            const pairs = [];
            rows.forEach(row => {
                const select = row.querySelector('.sel-passager');
                const passengerId = select ? select.value.trim() : '';
                if(passengerId) {
                    const siegeId = row.querySelector('.hid-siege').value;
                    pairs.push({passengerId, siegeId});
                }
            });

            if(pairs.length === 0) {
                alert('Veuillez sélectionner au moins un passager pour réserver.');
                return;
            }

            pairs.forEach(p => {
                const ip = document.createElement('input');
                ip.type='hidden';
                ip.name='idPassager';
                ip.value = p.passengerId;
                ip.className = '_temp_pair';

                const is = document.createElement('input');
                is.type='hidden';
                is.name='idSiege';
                is.value = p.siegeId;
                is.className = '_temp_pair';

                form.appendChild(ip);
                form.appendChild(is);
            });

            recalcTotal();

            form.submit();
        });

        recalcTotal();
    })();
</script>

</body>
</html>