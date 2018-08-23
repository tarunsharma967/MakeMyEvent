<%-- 
    Document   : logout
    Created on : Apr 13, 2018, 10:21:38 PM
    Author     : hello
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>logout</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("pragma", "no-cache");
            response.setHeader("Expires", "0");
            session.setAttribute("username", null);
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
