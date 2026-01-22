<%@ page import="gestion_compagnie_aerienne.entities.VolAvion" %>
<%@ page import="java.util.List" %>
<%@ page import="gestion_compagnie_aerienne.entities.Passager" %>
<%@ page import="gestion_compagnie_aerienne.entities.TrancheAge" %>
<%@ page import="gestion_compagnie_aerienne.entities.ClasseSiege" %><%--
  Created by IntelliJ IDEA.
  User: ME-PC
  Date: 22/01/2026
  Time: 08:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    VolAvion volAvion = (VolAvion) request.getAttribute("volAvion");
    List<Passager> passagers = (List<Passager>) request.getAttribute("passagers");
    List<TrancheAge> trancheAges = (List<TrancheAge>) request.getAttribute("tranchesAges");
    List<ClasseSiege> classeSieges = (List<ClasseSiege>) request.getAttribute("classesSiege");
%>
<div>
    <form action="reservation?action=reservation-rapide" method="post">
        <input type="hidden" name="idVolAvion" value="<%= volAvion.getId() %>" />
        <input type="text" name="reference" placeholder="Reference reservation" />
        <select name="idPassager">
            <option value="">
                -- Séléctionnez un passager
            </option>
            <%
                for(Passager passager : passagers)
                {
            %>
                <option value="<%= passager.getId() %>"><%= passager.getNom() %></option>
            <%
                }
            %>
        </select>

        <input type="number" name="nbrSiege" />
        <select name="idClasseSiege" >
            <option value="">
                -- Séléctionnez une classe --
            </option>
            <%
                for(ClasseSiege cs : classeSieges)
                {
            %>
            <option value="<%= cs.getId() %>"><%= cs.getLibelle() %></option>
            <%
                }
            %>
        </select>
        <select name="idTrancheAge" >
            <option value="">
                -- Séléctionnez un tranche d'age --
            </option>
            <%
                for(TrancheAge ta : trancheAges)
                {
            %>
            <option value="<%= ta.getId() %>"><%= ta.getLibelle() %></option>
            <%
                }
            %>
        </select>
        <input type="submit" value="Valider"/>
    </form>
</div>
</body>
</html>
