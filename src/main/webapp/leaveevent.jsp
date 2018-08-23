<%-- 
    Document   : leaveevent.jsp
    Created on : Apr 14, 2018, 4:59:47 PM
    Author     : hello
--%>

<%@page import="dao.EventDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
            if (ed.leaveEvent(user, Integer.parseInt(event))) {
                response.sendRedirect(url);
            } 
            else {
                out.print("<script language=\"text/javascript\"> alert('Joining falied'); </script>");
                response.sendRedirect(url);
            }
        %>
    </body>
</html>
