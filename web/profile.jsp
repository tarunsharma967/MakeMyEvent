<%-- 
    Document   : profile
    Created on : Mar 29, 2018, 9:32:49 PM
    Author     : hello
--%>
<!DOCTYPE html>
<%@page import="model.User"%>
<%@page import="model.Event"%>
<%@page import="java.util.List"%>
<%@page import="dao.EventDao,dao.UserDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Profile</title>
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/table.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
      </style>


    </head>
    <body>
        <%@include file="header.jsp"%><br><br>

        <%            String name = null;
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>


        <h1 style="text-align:center; font-family : Georgia,serif;">User Profile</h1>


        <%     if (session.getAttribute("username") != null) {
                User user;
                UserDao ud = new UserDao();
                user = ud.searchUser(session.getAttribute("username").toString());
                name = user.getName();
            }
        %>
        <div class="username">
            <h2 style="font-size: 25px;">Welcome <%=name%>!</h2>
        </div>       
        <h3 style="font-family:Georgia, serif;">Going</h3>
        <hr>
        <%
            List<Event> eventList;
            EventDao event = new EventDao();
            if (name != null) {
                eventList = event.searchAllByGoing(session.getAttribute("username").toString());
                if (eventList.isEmpty()) {
                    out.println("<h3>Please join a event.</h3>");
                } else {
        %>
        <table id="table" class="table table-hover table-mc-light-blue">
            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Name</th>
                    <th>From</th>
                    <th>To</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String e_startdate[] = new String[4];
                    
                    for (Event ev : eventList) {
                        String url = "view.jsp?id=" + ev.getEvent_id();
                        out.print("<tr>");
                        out.println("<td>" + ev.getEvent_id() + "</td>");
                        out.println("<td><a href =" + url + ">" + ev.getE_name() + "</a></td>");
                        e_startdate = ev.getE_startdate().split("-");
                        out.println("<td>" + e_startdate[2] + "-" + e_startdate[1] + "-" + e_startdate[0] + "</td>");
                        out.println("<td>" + ev.getE_enddate()+"</td>");
                        out.print("</tr>");
                    }
                %>
            </tbody>
        </table>
        <%
                }
            }

        %>
        <h3 style="font-family:Georgia, serif;">Event Created</h3>
        <hr>
        <%                    if (name != null) {
                eventList = event.searchAllByUser(session.getAttribute("username").toString());
                if (eventList.isEmpty()) {
                    out.println("<h3>No Event is Created.</h3>");
                } else {
        %>
        <table id="table" class="table table-hover table-mc-light-blue">
            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Name</th>
                    <th>Event type</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Event ev : eventList) {
                        String url = "view.jsp?id=" + ev.getEvent_id();
                        out.println("</tr>");
                        out.println("<td>" + ev.getEvent_id() + "</td>");
                        out.println("<td><a href =" + url + ">" + ev.getE_name() + "</a></td>");
                        out.println("<td>" + ev.getE_type() + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
        <%
                }
            }
        %>
        <%@include file="footer.jsp" %>
    </body>
</html>
