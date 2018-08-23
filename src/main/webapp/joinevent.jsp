<%-- 
    Document   : joinevent.jsp
    Created on : Apr 14, 2018, 3:42:37 PM
    Author     : hello
--%>

<%@page import="dao.EventDao"%>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>

        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("pragma", "no-cache");
            response.setHeader("Expires", "0");
            String name = null;
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>


        <%
            String user, event, url;
            user = request.getParameter("uid");
            event = request.getParameter("eid");
            url = "view.jsp?id=" + event;
            EventDao ed = new EventDao();
            if (ed.joinEvent(user, Integer.parseInt(event))) {
                out.print("<script language=\"text/javascript\"> alert('Joined Suscessfully  '); </script>");
                response.sendRedirect(url);
            } 
            else {
                out.print("<script language=\"text/javascript\"> alert('Joining falied'); </script>");
                response.sendRedirect(url);
            }
        %>
    </body>
</html>
