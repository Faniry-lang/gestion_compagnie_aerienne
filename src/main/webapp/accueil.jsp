<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Accueil - Gestion Compagnie Aerienne</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        .welcome-card {
            max-width: 1100px;
            margin: 36px auto;
            background: var(--surface, #ffffff);
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(2,6,23,0.06);
            display: grid;
            grid-template-columns: 1fr 460px;
            gap: 24px;
            align-items: center;
            padding: 28px;
            border: 1px solid var(--border, #e6eef8);
        }
        .welcome-card .welcome-text h1{ margin:0 0 8px 0; font-size:1.6rem; }
        .welcome-card .welcome-text p{ color:var(--muted, #64748b); margin:0 0 18px 0; line-height:1.5; }
        .welcome-illustration{ width:100%; height:auto; display:block; border-radius:12px; }
        .welcome-ctas{ display:flex; gap:12px; }
        @media (max-width:960px){ .welcome-card{ grid-template-columns:1fr; padding:18px; } .welcome-illustration{ order:-1; max-height:320px; object-fit:contain; } }
    </style>
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <div class="main-content">
        <div class="welcome-card">
            <div class="welcome-text">
                <h1>Bienvenue dans l'espace d'administration</h1>
                <p>Gerez facilement vols, reservations et billets depuis cette console. Utilisez les filtres pour trouver rapidement des informations et creer ou modifier des enregistrements en quelques clics.</p>
                <div class="welcome-ctas">
                    <a href="vol" class="btn">Voir les vols</a>
                    <a href="reservation" class="btn btn-secondary">Voir les reservations</a>
                </div>
            </div>

            <div class="welcome-image">
                <img src="assets/images/flight-booking-illustration.jpg" alt="Flight booking illustration" class="welcome-illustration" />
            </div>
        </div>

        <!-- stats would go here -->
    </div>
</body>
</html>
