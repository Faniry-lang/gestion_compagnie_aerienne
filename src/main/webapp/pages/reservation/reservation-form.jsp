<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.*" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer idVolAvion = (Integer) request.getAttribute("idVolAvion");
    List<Passager> passagers = (List<Passager>) request.getAttribute("passagers");
    Map<Siege, Boolean> siegesDisponibles = (Map<Siege, Boolean>) request.getAttribute("sieges");
    VolAvion volAvion = (VolAvion) request.getAttribute("volAvion");
    Vol vol = (Vol) request.getAttribute("vol");
    Avion avion = (Avion) request.getAttribute("avion");
%>
<html>
<head>
    <title>Création d'une réservation</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/icons/css/all/all.css">

    <style>
        /* Scoped styles for reservation form - modern & minimal */
        .reservation-card {
            max-width: 980px;
            margin: 24px auto;
            background: #ffffff;
            border-radius: 12px;
            padding: 22px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.06);
            border: 1px solid #e6edf3;
            display: grid;
            grid-template-columns: 1fr 420px;
            gap: 20px;
        }

        .reservation-card .flight-details {
            background: linear-gradient(180deg, #f8fafc, #ffffff);
            padding: 18px;
            border-radius: 10px;
            border: 1px solid #eef2ff;
        }

        .flight-details h3 { margin-bottom: 10px; color: #0f172a; }
        .flight-details p { color: #475569; margin: 6px 0; font-size: 0.95em; }

        .reservation-form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        #passagers-container { display:flex; flex-direction:column; gap:10px; }
        .passager-row {
            display:flex;
            gap:8px;
            align-items:center;
            background:#fbfdff;
            padding:8px;
            border-radius:8px;
            border:1px solid #eef2ff;
        }

        .passager-row select.siege-select { width: 120px; }

        .passager-row select { flex:1; padding:8px 10px; border-radius:6px; border:1px solid #d1d5db; }
        .remove-btn {
            background:none; border:1px solid #f87171; color:#b91c1c; padding:6px 8px; border-radius:6px; cursor:pointer; font-weight:700;
        }

        .add-passager {
            align-self:flex-start;
        }

        .form-actions { display:flex; gap:12px; justify-content:flex-end; margin-top:12px; }

        /* small adjustment for siege select width inside a passager-row */
        .passager-row select.siege-select { width: 120px; }

        /* mobile */
        @media (max-width:900px) {
            .reservation-card { grid-template-columns: 1fr; padding:16px; }
            .reservation-card .flight-details { order:2; }
        }

        .seat-box-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        .seat-box {
            border-radius: ;
        }

    </style>
</head>
<body>
    <%@ include file="/sidebar.jsp" %>
    <div class="main-content">

        <div class="seat-box-container">
            <%
                for(Map.Entry<Siege, Boolean> entry : siegesDisponibles.entrySet())
                {
            %>
            <div class="seat-box">
            </div>
            <%
            }
            %>
        </div>

    </div>
</body>
</html>
