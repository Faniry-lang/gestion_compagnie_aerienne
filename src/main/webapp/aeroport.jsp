<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List,gestion_compagnie_aerienne.entities.Aeroport" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aeroport - Gestion Compagnie Aerienne</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/solid/all.css">
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <div class="main-content">
        <div class="page-header">
            <h1>Gestion des Aeroports</h1>
            <button class="btn btn-primary">
                <i class="fi fi-ss-plus"></i> Nouvelle Aeroport
            </button>
        </div>

        <div class="filters-section">
            <div class="filters-row">
                <div class="filter-group">
                    <label for="filter-todo-1">TODO filtre 1</label>
                    <input type="text" id="filter-todo-1" placeholder="Remplir filtre 1...">
                </div>
                
                <div class="filter-group">
                    <label for="filter-todo-2">TODO filtre 2</label>
                    <input type="text" id="filter-todo-2" placeholder="Remplir filtre 2...">
                </div>
                
                <div class="filter-group">
                    <label>&nbsp;</label>
                    <button class="btn btn-secondary"><i class="fi fi-ss-search"></i> Rechercher</button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>code_iata</th>
                        <th>nom</th>
                        <th>ville</th>
                        <th>pays</th>

                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        @SuppressWarnings("unchecked")
                        List<Aeroport> items = (List<Aeroport>) request.getAttribute("aeroports");
                        if (items == null || items.isEmpty()) {
                        <tr>
                            <td><%= entity.getId() %></td>
                        <td><%= entity.getCodeIata() %></td>
                        <td><%= entity.getNom() %></td>
                        <td><%= entity.getVille() %></td>
                        <td><%= entity.getPays() %></td>

                            <td class="actions">
                                <button class="action-btn"><i class="fi fi-ss-eye"></i> Voir</button>
                                <button class="action-btn"><i class="fi fi-ss-pen"></i> Modifier</button>
                                <button class="action-btn"><i class="fi fi-ss-trash"></i> Supprimer</button>
                            </td>
                        </tr>
                        <tr>
                            <td><%= entity.getId() %></td>
                            <td><!-- TODO: replace with getter for COL_1 --></td>
                            <td><!-- TODO: replace with getter for COL_2 --></td>
                            <td class="actions">
                                <button class="action-btn"><i class="fi fi-ss-eye"></i> Voir</button>
                                <button class="action-btn"><i class="fi fi-ss-pen"></i> Modifier</button>
                                <button class="action-btn"><i class="fi fi-ss-trash"></i> Supprimer</button>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
