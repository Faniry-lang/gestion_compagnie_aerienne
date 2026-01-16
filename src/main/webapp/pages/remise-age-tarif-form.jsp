<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.TrancheAge" %>
<%@ page import="gestion_compagnie_aerienne.entities.ClasseSiege" %>
<%@ page import="gestion_compagnie_aerienne.entities.Vol" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire Remise par âge</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">
        <h1>Créer une remise</h1>
        <form action="remise-age" method="post">
            <input type="hidden" name="action" value="create" />
            <label>Vol</label>
            <select name="idVol" required>
                <option value="">-- sélectionnez --</option>
                <%
                    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                    if (vols != null) {
                        for (Vol v : vols) {
                %>
                    <option value="<%= v.getId() %>"><%= v.getNumeroVol() != null ? v.getNumeroVol() : ("Vol " + v.getId()) %></option>
                <%
                        }
                    }
                %>
            </select>

            <label>Classe (optionnel - laisser vide pour toutes les classes)</label>
            <select name="idClasseSiege">
                <option value="">-- toutes les classes --</option>
                <%
                    List<ClasseSiege> classes = (List<ClasseSiege>) request.getAttribute("classeSieges");
                    if (classes != null) {
                        for (ClasseSiege c : classes) {
                %>
                    <option value="<%= c.getId() %>"><%= c.getLibelle() != null ? c.getLibelle() : ("Classe " + c.getId()) %></option>
                <%
                        }
                    }
                %>
            </select>

            <label>Tranche d'âge</label>
            <select name="idTrancheAge" required>
                <option value="">-- sélectionnez --</option>
                <%
                    List<TrancheAge> tranches = (List<TrancheAge>) request.getAttribute("trancheAges");
                    if (tranches != null) {
                        for (TrancheAge t : tranches) {
                %>
                    <option value="<%= t.getId() %>"><%= t.getLibelle() != null ? t.getLibelle() : ("Tranche " + t.getId()) %></option>
                <%
                        }
                    }
                %>
            </select>

            <label>Tranche d'âge de référence (optionnel - pour calculer basé sur une autre tranche)</label>
            <select name="idTrancheAgeRef">
                <option value="">-- aucune --</option>
                <%
                    if (tranches != null) {
                        for (TrancheAge t : tranches) {
                %>
                    <option value="<%= t.getId() %>"><%= t.getLibelle() != null ? t.getLibelle() : ("Tranche " + t.getId()) %></option>
                <%
                        }
                    }
                %>
            </select>

            <label>Montant en pourcentage</label>
            <input type="number" step="0.01" name="montantPourcentage" />

            <label>Montant complet</label>
            <input type="number" step="0.01" name="montantComplet" />

            <label>Date (création)</label>
            <input type="datetime-local" name="date" />

            <div style="margin-top:12px;">
                <button class="btn" type="submit">Enregistrer</button>
                <a class="btn btn-secondary" href="remise-age" style="text-decoration:none;">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>

