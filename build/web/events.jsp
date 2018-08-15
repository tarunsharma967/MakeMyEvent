<%-- 
    Document   : events
    Created on : Apr 13, 2018, 9:17:48 PM
    Author     : hello
--%>

<%@page import="model.Event"%>
<%@page import="dao.EventDao"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events</title>
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/table.css">
  <meta name="viewport" content="width=device-width, initial-scale=0.8  ">
  
  <style>
       select{
                width: 50%;
                position: relative;
                left: 50%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                resize: vertical;

            }
  </style>
    </head>
    <body>
        <%@include file = "header.jsp" %>
        <form method="get" action="events.jsp">   
            <table id="table" class="table table-hover table-mc-light-blue">
                <thead>
                    <tr>
                        <td style="width: 382px;"><label for="type" style="left: 0px;padding-top: 30px;">Event Type:</label>
                            <select id="type" name="type" style="left: 10px;">
                                <option value="">--Type--</option>
                                <option value="music">Music</option>
                                <option value="food & drink">Food & Drink</option>
                                <option value="class">Class</option>
                                <option value="art">Art</option>
                                <option value="party">Party</option>
                                <option value="sport & wellness">Sports & Wellness</option>
                                <option value="seminar">Seminar</option>
                                <option value="workshop">Workshop</option>
                                <option value="other">Other</option>
                            </select>
                        </td>
                        <td style="width: 382px"><label for="city" style="left: 10px;padding-top: 30px;">City:</label>
                            <input type="text" name="city" placeholder="City" id="city" style="left: 25px;"></td>
                        <td><input type="submit" value="Search" style="margin-left: 1px;bottom: 10px;top: 20px;padding-left: 20px;" ></td>
                    </tr>
                </thead>
            </table>
        </form>
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
            String type = "";
            type = request.getParameter("type");
            if (type == null) {
                type = "";
            }
            String city = "";
            city = request.getParameter("city");
            if (city == null) {
                city = "";
            }
        %>  
        <%
            List<Event> eventList;
            EventDao event = new EventDao();

            if (type.length() != 0 && city.length() == 0) {
                eventList = event.searchEventByEventType(type);
                if (eventList.isEmpty()) {
                    out.println("<h3>No Event found for " + type + ".</h3>");
                } else {
        %>
        <table id="table" class="table table-hover table-mc-light-blue">

            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Name</th>
                    <th>Event Date</th>
                    <th>Event type</th>
                    <th>Event city</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String d[] = new String[4];
                    for (Event ev : eventList) {
                        d = ev.getE_startdate().split("-");
                        String url = "view.jsp?id=" + ev.getEvent_id();
                        out.println("</tr>");
                        out.println("<td>" + ev.getEvent_id() + "</td>");
                        out.println("<td><a href =" + url + ">" + ev.getE_name() + "</a></td>");
                        out.println("<td>" + d[2] + "-" + d[1] + "-" + d[0] +" "+ev.getE_enddate()+ "</td>");
                        out.println("<td>" + ev.getE_type() + "</td>");
                        out.println("<td>" + ev.getE_city() + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
        <%
                }
            }
        %>

        <%
            if (city.length() != 0 && type.length() == 0) {
                eventList = event.searchEventByEventCity(city.toLowerCase());
                if (eventList.isEmpty()) {
                    out.println("<h3>No Event found at " + city + ".</h3>");
                } else {
        %>
        <table id="table" class="table table-hover table-mc-light-blue">

            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Name</th>
                    <th>Event Date</th>
                    <th>Event type</th>
                    <th>Event city</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String d[] = new String[4];
                    for (Event ev : eventList) {
                        d = ev.getE_startdate().split("-");

                        String url = "view.jsp?id=" + ev.getEvent_id();
                        out.println("</tr>");
                        out.println("<td>" + ev.getEvent_id() + "</td>");
                        out.println("<td><a href =" + url + ">" + ev.getE_name() + "</a></td>");
                        out.println("<td>" + d[2] + "-" + d[1] + "-" + d[0] +" "+ev.getE_enddate()+ "</td>");
                        out.println("<td>" + ev.getE_type() + "</td>");
                        out.println("<td>" + ev.getE_city() + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>

        <%
                }
            }
        %>

        <%
            if (city.length() != 0 && type.length() != 0) {
                eventList = event.searchEventByEventTypeAndCity(type, city.toLowerCase());
                if (eventList.isEmpty()) {
                    out.println("<h3>No Event found on " + type + " at " + city + ".</h3>");
                } else {
        %>
        <table id="table" class="table table-hover table-mc-light-blue">
            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Name</th>
                    <th>Event Date</th>
                    <th>Event type</th>
                    <th>Event city</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String d[] = new String[4];
                    for (Event ev : eventList) {
                        d = ev.getE_startdate().split("-");
                        String url = "view.jsp?id=" + ev.getEvent_id();
                        out.println("</tr>");
                        out.println("<td>" + ev.getEvent_id() + "</td>");
                        out.println("<td><a href =" + url + ">" + ev.getE_name() + "</a></td>");
                        out.println("<td>" + d[2] + "-" + d[1] + "-" + d[0]+" "+ev.getE_enddate()+"</td>");
                        out.println("<td>" + ev.getE_type() + "</td>");
                        out.println("<td>" + ev.getE_city() + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
        <%
                }
            }
        %>


        <%
            if (city.length() == 0 && type.length() == 0) {
                eventList = event.searchAllEvent();
                if (eventList.isEmpty()) {
                    out.println("<h3>No Event found.</h3>");
                } else {
        %>
        <table id="table" class="table table-hover table-mc-light-blue">
            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Name</th>
                    <th>Event Date</th>
                    <th>Event type</th>
                    <th>Event city</th>
                    <th>Hosted by</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String d[] = new String[4];
                    for (Event ev : eventList) {
                        d = ev.getE_startdate().split("-");
                        String url = "view.jsp?id=" + ev.getEvent_id();
                        out.println("</tr>");
                        out.println("<td>" + ev.getEvent_id() + "</td>");
                        out.println("<td><a href =" + url + ">" + ev.getE_name() + "</a></td>");
                        out.println("<td>" + d[2] + "-" + d[1] + "-" + d[0]+" "+ev.getE_enddate()+ "</td>");
                        out.println("<td>" + ev.getE_type() + "</td>");
                        out.println("<td>" + ev.getE_city() + "</td>");
                        out.println("<td>" + ev.getUsername() + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
        <%
                }
            }
        %>
    </table>

</body>
</html>
