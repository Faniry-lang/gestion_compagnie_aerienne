<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire Tranche d'âge</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">
        <h1>Créer / Modifier une tranche d'âge</h1>
        <form action="tranche-age" method="post">
            <label>Libellé</label>
            <input type="text" name="libelle" required />
            <label>Âge minimum</label>
            <input type="number" name="ageMin" min="0" />
            <label>Âge maximum</label>
            <input type="number" name="ageMax" min="0" />
            <div style="margin-top:12px;">
                <button class="btn" type="submit">Enregistrer</button>
                <a href="tranche-age" class="btn btn-secondary" style="text-decoration:none;">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>

