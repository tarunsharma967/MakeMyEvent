<%-- 
    Document   : deleteevent
    Created on : 16 Apr, 2018, 10:24:05 AM
    Author     : Tarun
--%>

<%@page import="dao.EventDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>MakeMyEvent | Delete event</title>
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%@include file = "header.jsp" %><br><br>

        <%              response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("pragma", "no-cache");
            response.setHeader("Expires", "0");
            String name = null;
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>


        <%
            String cur_user, user, event;
            user = request.getParameter("hostid");
            cur_user = session.getAttribute("username").toString();
            if (user == null) {
                user = "  ";
            }
            if (cur_user == null) {
                cur_user = "";
            }
            event = request.getParameter("eid");
            if (user.equals(cur_user)) {
                EventDao ed = new EventDao();
                if (ed.deleteEvent(Integer.parseInt(event))) {
                    out.print("<h3>Event Deleted<h3>");
                } else {
                    out.print("<script language=\"text/javascript\"> alert('Delete falied'); </script>");
                }
            } else {
                out.print("<h3>you are not athorized<h3>");
            }
        %>

        <%@include file="footer.jsp" %>

    </body>
</html>
