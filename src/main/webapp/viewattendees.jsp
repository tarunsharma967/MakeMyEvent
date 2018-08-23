<%-- 
    Document   : viewattendees
    Created on : 16 Apr, 2018, 10:28:06 AM
    Author     : Tarun
--%>

<%@page import="model.User"%>
<%@page import="dao.EventDao"%>
<%@page import="model.Event"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>MakeMyEvent | view Attendees</title>
        <meta name="format-detection" content="telephone=no">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/table.css">
        <link rel="stylesheet" href="css/style.css">
            </head>
    <body>
        <%@include file="header.jsp" %><br><br>
        <div id="demo">
            <h1 >Attendee List</h1>
        </div>
        <%    
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("pragma", "no-cache");
            response.setHeader("Expires", "0");
            String name = null;
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            } 
            else {
        %>
        <table id="table" class="table table-hover table-mc-light-blue">
            <%
                String eventId = null, hostId = null, user = null;
                List<User> attendeeList;
                EventDao ed = new EventDao();
                eventId = request.getParameter("eid");
                hostId = request.getParameter("hostid");

                if (eventId == null) {
                    eventId = "-1";
                }
                if (hostId == null) {
                    hostId = "  ";
                }

                user = session.getAttribute("username").toString();
                if (user != null && hostId.equals(user)) {
                    attendeeList = ed.searchAttendeesByEventId(Integer.parseInt(eventId));
                    if (attendeeList.isEmpty()) {
                        out.println("<h3>No Attendee found.</h3>");
                    } else {
            %>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                <%
                                String d[] = new String[4];
                                for (User u : attendeeList) {
                                    out.println("</tr>");
                                    out.println("<td>" + u.getUsername() + "</td>");
                                    out.println("<td>" + u.getName() + "</td>");
                                    out.println("<td>" + u.getEmail() + "</td>");
                                    out.println("<td>" + u.getPno() + "</td>");
                                    out.println("</tr>");
                                }
                            }
                        }
                    }
                %>
            </tbody>
        </table>
        <%@include file="footer.jsp" %>

    </body>
</html>
