<%--
  Created by IntelliJ IDEA.
  User: ME-PC
  Date: 10/01/2026
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erreur - Gestion Compagnie Aerienne</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">
    <style>
        .error-page{ display:flex; align-items:center; justify-content:center; min-height:80vh; }
        .error-card{ background:var(--surface,#fff); border-radius:14px; padding:28px; box-shadow:0 12px 30px rgba(2,6,23,0.06); display:grid; grid-template-columns:1fr 420px; gap:20px; align-items:center; border:1px solid var(--border,#e6eef8); max-width:1000px; width:100%; }
        .error-illustration{ max-width:100%; border-radius:10px; }
        .error-title{ font-size:1.5rem; margin:0 0 8px 0; }
        .error-message{ color:var(--muted,#64748b); margin-bottom:16px; white-space:pre-wrap; }
        .error-ctas{ display:flex; gap:12px; }
        @media (max-width:900px){ .error-card{ grid-template-columns:1fr; padding:18px; } }
    </style>
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <div class="error-page">
        <div class="error-card">
            <div>
                <h2 class="error-title">Oups — une erreur est survenue</h2>
                <p class="error-message"><%= request.getAttribute("error-message") != null ? request.getAttribute("error-message") : "Une erreur inattendue est survenue." %></p>
                <div class="error-ctas">
                    <a href="accueil" class="btn">Retour à l'accueil</a>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">Page précédente</button>
                </div>
            </div>
            <div>
                <img src="assets/images/error-illustration.jpg" alt="Error illustration" class="error-illustration" />
            </div>
        </div>
    </div>
</div>
</body>
</html>
