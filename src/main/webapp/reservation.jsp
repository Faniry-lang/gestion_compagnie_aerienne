<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Réservations - Gestion Compagnie Aérienne</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <div class="main-content">
        <div class="page-header">
            <h1>Gestion des Réservations</h1>
            <button class="btn btn-primary">
                ➕ Nouvelle Réservation
            </button>
        </div>

        <div class="filters-section">
            <div class="filters-row">
                <div class="filter-group">
                    <label for="filter-reference">Référence</label>
                    <input type="text" id="filter-reference" placeholder="Rechercher par référence...">
                </div>
                
                <div class="filter-group">
                    <label for="filter-date-debut">Date début</label>
                    <input type="date" id="filter-date-debut">
                </div>
                
                <div class="filter-group">
                    <label for="filter-date-fin">Date fin</label>
                    <input type="date" id="filter-date-fin">
                </div>
                
                <div class="filter-group">
                    <label>&nbsp;</label>
                    <button class="btn btn-secondary">🔍 Rechercher</button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Référence</th>
                        <th>Date de création</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>RES-2024-001</td>
                        <td>2024-01-15 10:30:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>RES-2024-002</td>
                        <td>2024-01-16 14:20:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>RES-2024-003</td>
                        <td>2024-01-17 09:15:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>RES-2024-004</td>
                        <td>2024-01-18 11:45:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>RES-2024-005</td>
                        <td>2024-01-19 16:00:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>RES-2024-006</td>
                        <td>2024-01-20 08:30:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>RES-2024-007</td>
                        <td>2024-01-21 13:10:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>RES-2024-008</td>
                        <td>2024-01-22 10:25:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>9</td>
                        <td>RES-2024-009</td>
                        <td>2024-01-23 15:40:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                    <tr>
                        <td>10</td>
                        <td>RES-2024-010</td>
                        <td>2024-01-24 12:05:00</td>
                        <td class="actions">
                            <button class="action-btn">👁️ Voir</button>
                            <button class="action-btn">✏️ Modifier</button>
                            <button class="action-btn">🗑️ Supprimer</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>