<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="gestion_compagnie_aerienne.entities.CAGlobal" %>
        <%@ page import="java.util.List" %>
            <%@ page import="java.time.format.DateTimeFormatter" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Chiffre d'affaire Global</title>
                    <link rel="stylesheet" href="assets/css/style.css">
                    <link rel="stylesheet" href="assets/icons/css/all/all.css">
                    <style>
                        table {
                            width: 100%;
                            border-collapse: collapse;
                            background: #fff;
                        }

                        th,
                        td {
                            padding: 10px 12px;
                            border-bottom: 1px solid #eef2ff;
                            text-align: left;
                        }

                        th {
                            background: #f8fafc;
                            color: #0f172a;
                        }

                        .filter-form {
                            margin-bottom: 20px;
                            display: flex;
                            gap: 10px;
                            align-items: flex-end;
                        }

                        .form-group {
                            display: flex;
                            flex-direction: column;
                        }
                    </style>
                </head>

                <body>

                    <%@ include file="/sidebar.jsp" %>

                        <% List<CAGlobal> caGlobalList = (List<CAGlobal>) request.getAttribute("caGlobalList");
                                String dateStr = (String) request.getAttribute("dateStr");
                                if(dateStr == null) dateStr = "";

                                float sumBillet = 0f;
                                float sumPub = 0f;
                                float sumExtra = 0f;
                                float sumTotal = 0f;
                                %>

                                <div class="main-content">
                                    <div class="page-header">
                                        <h1>Chiffre d'affaire Global (Janvier 2026)</h1>
                                    </div>

                                    <form action="ca-global" method="get" class="filter-form">
                                        <input type="hidden" name="action" value="list">

                                        <div class="form-group">
                                            <label>Date (Mois/Année)</label>
                                            <input type="month" name="date" value="<%= dateStr %>">
                                        </div>

                                        <button type="submit" class="btn">Filtrer</button>
                                    </form>

                                    <div class="table-container">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>CA Billet</th>
                                                    <th>CA Pub</th>
                                                    <th>CA Extra</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% if (caGlobalList !=null && !caGlobalList.isEmpty()) { for (CAGlobal
                                                    ca : caGlobalList) { sumBillet +=(ca.getCaBillet() !=null ?
                                                    ca.getCaBillet() : 0); sumPub +=(ca.getCaPub() !=null ?
                                                    ca.getCaPub() : 0); sumExtra +=(ca.getCaProduitExtra() !=null ?
                                                    ca.getCaProduitExtra() : 0); sumTotal +=(ca.getTotal() !=null ?
                                                    ca.getTotal() : 0); DateTimeFormatter
                                                    fmt=DateTimeFormatter.ofPattern("MMMM yyyy"); %>
                                                    <tr>
                                                        <td>
                                                            <%= ca.getDate().format(fmt) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getCaBillet() !=null ?
                                                                ca.getCaBillet() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getCaPub() !=null ?
                                                                ca.getCaPub() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getCaProduitExtra() !=null ?
                                                                ca.getCaProduitExtra() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getTotal() !=null ?
                                                                ca.getTotal() : 0)) %>
                                                        </td>
                                                    </tr>
                                                    <% } } else { %>
                                                        <tr>
                                                            <td colspan="5" style="text-align:center;">Aucune donnée
                                                                trouvée</td>
                                                        </tr>
                                                        <% } %>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th>Totaux</th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumBillet) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumPub) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumExtra) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumTotal) %>
                                                    </th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                        </table>
                                    </div>

                                    <div class="page-header" style="margin-top: 40px;">
                                        <h1>Chiffre d'affaire Théorique (Janvier 2026)</h1>
                                    </div>

                                    <div class="table-container">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>CA Billet Théorique</th>
                                                    <th>CA Pub Théorique</th>
                                                    <th>CA Extra Théorique</th>
                                                    <th>Total Théorique</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% float sumBilletT=0f; float sumPubT=0f; float sumExtraT=0f; float
                                                    sumTotalT=0f; if (caGlobalList !=null && !caGlobalList.isEmpty()) {
                                                    for (CAGlobal ca : caGlobalList) { sumBilletT
                                                    +=(ca.getCaBilletTheorique() !=null ? ca.getCaBilletTheorique() :
                                                    0); sumPubT +=(ca.getCaPubTheorique() !=null ?
                                                    ca.getCaPubTheorique() : 0); sumExtraT +=(ca.getCaExtraTheorique()
                                                    !=null ? ca.getCaExtraTheorique() : 0); sumTotalT
                                                    +=(ca.getTotalTheorique() !=null ? ca.getTotalTheorique() : 0);
                                                    DateTimeFormatter fmt=DateTimeFormatter.ofPattern("MMMM yyyy"); %>
                                                    <tr>
                                                        <td>
                                                            <%= ca.getDate().format(fmt) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getCaBilletTheorique() !=null
                                                                ? ca.getCaBilletTheorique() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getCaPubTheorique() !=null ?
                                                                ca.getCaPubTheorique() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getCaExtraTheorique() !=null
                                                                ? ca.getCaExtraTheorique() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (ca.getTotalTheorique() !=null ?
                                                                ca.getTotalTheorique() : 0)) %>
                                                        </td>
                                                    </tr>
                                                    <% } } else { %>
                                                        <tr>
                                                            <td colspan="5" style="text-align:center;">Aucune donnée
                                                                trouvée</td>
                                                        </tr>
                                                        <% } %>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th>Totaux</th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumBilletT) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumPubT) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumExtraT) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumTotalT) %>
                                                    </th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>

                </body>

                </html>