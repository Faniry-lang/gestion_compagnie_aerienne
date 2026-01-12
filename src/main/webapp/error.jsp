<%--
  Created by IntelliJ IDEA.
  User: ME-PC
  Date: 10/01/2026
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error page</title>
</head>
<body>
    <h1>Oups une erreur s'est produite: </h1>
    <%= request.getAttribute("error-message") %>
</body>
</html>
