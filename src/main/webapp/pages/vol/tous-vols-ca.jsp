<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="gestion_compagnie_aerienne.entities.CAGlobalParVolAvion" %>
        <%@ page import="java.util.List" %>
            <%@ page import="java.time.format.DateTimeFormatter" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Chiffres d'affaires - Tous les vols</title>
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
                    </style>
                </head>

                <body>

                    <%@ include file="/sidebar.jsp" %>

                        <% List<CAGlobalParVolAvion> caGlobalList = (List<CAGlobalParVolAvion>)
                                request.getAttribute("caGlobalList");
                                java.time.LocalDateTime date = (java.time.LocalDateTime) request.getAttribute("date");

                                float sumBillet = 0f;
                                float sumPub = 0f;
                                float sumTotal = 0f;
                                float sumPaye = 0f;
                                float sumReste = 0f;

                                DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
                                %>

                                <div class="main-content">
                                    <div class="page-header">
                                        <h1>Chiffres d'affaires par occurrence</h1>
                                    </div>

                                    <div class="table-container">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID VolAvion</th>
                                                    <th>Numéro Vol</th>
                                                    <th>Aéroport Départ</th>
                                                    <th>Aéroport Arrivée</th>
                                                    <th>Avion</th>
                                                    <th>Date départ</th>
                                                    <th>Heure départ</th>
                                                    <th>CA Billet</th>
                                                    <th>CA Pub</th>
                                                    <th>CA Extra</th>
                                                    <th>Total</th>
                                                    <th>Total payé</th>
                                                    <th>Reste a payé</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% if (caGlobalList !=null && !caGlobalList.isEmpty()) { for
                                                    (CAGlobalParVolAvion dto : caGlobalList) { sumBillet
                                                    +=(dto.getCaBillet() !=null ? dto.getCaBillet() : 0); sumPub
                                                    +=(dto.getCaPub() !=null ? dto.getCaPub() : 0); sumTotal
                                                    +=(dto.getTotal() !=null ? dto.getTotal() : 0); sumPaye
                                                    +=(dto.getTotalPaye() !=null ? dto.getTotalPaye() : 0); sumReste
                                                    +=(dto.getResteAPayer() !=null ? dto.getResteAPayer() : 0); %>
                                                    <tr>
                                                        <td>
                                                            <%= dto.getIdVolAvion() %>
                                                        </td>
                                                        <td>
                                                            <%= dto.getNumeroVol() %>
                                                        </td>
                                                        <td>
                                                            <%= dto.getAeroportDepart() %>
                                                        </td>
                                                        <td>
                                                            <%= dto.getAeroportArrivee() %>
                                                        </td>
                                                        <td>
                                                            <%= dto.getModeleAvion() %>
                                                        </td>
                                                        <td>
                                                            <%= dto.getDateDepart() !=null ?
                                                                dateFmt.format(dto.getDateDepart()) : "-" %>
                                                        </td>
                                                        <td>
                                                            <%= dto.getDateDepart() !=null ?
                                                                timeFmt.format(dto.getDateDepart()) : "-" %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (dto.getCaBillet() !=null ?
                                                                dto.getCaBillet() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (dto.getCaPub() !=null ?
                                                                dto.getCaPub() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (dto.getCaProduitExtra() !=null ?
                                                                dto.getCaProduitExtra() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f", (dto.getTotal() !=null ?
                                                                dto.getTotal() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f" , (dto.getTotalPaye() !=null ?
                                                                dto.getTotalPaye() : 0)) %>
                                                        </td>
                                                        <td>
                                                            <%= String.format("%,.2f" , (dto.getResteAPayer() !=null ?
                                                                dto.getResteAPayer() : 0)) %>
                                                        </td>
                                                    </tr>
                                                    <% } } else { %>
                                                        <tr>
                                                            <td colspan="13" style="text-align:center;">Aucun vol trouvé
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="7">Totaux</th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumBillet) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumPub) %>
                                                    </th>
                                                    <th>-</th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumTotal) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumPaye) %>
                                                    </th>
                                                    <th>
                                                        <%= String.format("%,.2f", sumReste) %>
                                                    </th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>

                </body>

                </html>