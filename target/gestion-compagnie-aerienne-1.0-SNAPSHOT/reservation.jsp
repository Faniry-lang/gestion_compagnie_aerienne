<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reservations - Gestion Compagnie Aerienne</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/solid/all.css">
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <div class="main-content">
        <div class="page-header">
            <h1>Gestion des Reservations</h1>
            <button class="btn btn-primary">
                <i class="fi fi-ss-plus"></i> Nouvelle Reservation
            </button>
        </div>

        <div class="filters-section">
            <div class="filters-row">
                <div class="filter-group">
                    <label for="filter-reference">Reference</label>
                    <input type="text" id="filter-reference" placeholder="Rechercher par reference...">
                </div>
                
                <div class="filter-group">
                    <label for="filter-date-debut">Date debut</label>
                    <input type="date" id="filter-date-debut">
                </div>
                
                <div class="filter-group">
                    <label for="filter-date-fin">Date fin</label>
                    <input type="date" id="filter-date-fin">
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
                        <th>Reference</th>
                        <th>Date de creation</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty reservations}">
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 20px; color: #9ca3af;">
                                Aucune réservation trouvée
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="res" items="${reservations}">
                        <c:set var="reservation" value="${res}" scope="page" />
                        <tr>
                            <td>${reservation.id}</td>
                            <td>${reservation.reference}</td>
                            <td>
                                <fmt:formatDate value="${reservation.createdon}" 
                                    pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                            <td class="actions">
                                <button class="action-btn"><i class="fi fi-ss-eye"></i> Voir</button>
                                <button class="action-btn"><i class="fi fi-ss-pen"></i> Modifier</button>
                                <button class="action-btn"><i class="fi fi-ss-trash"></i> Supprimer</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>