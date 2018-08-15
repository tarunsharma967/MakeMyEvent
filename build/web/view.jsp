<!DOCTYPE html>
<%@page import="dao.EventDao"%>
<%@page import="model.Event"%>
<html>
    <head>
        <meta charset="utf-8">
        <title>MakeMyEvent</title>
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/style.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>

    <body>
        <%@include file="header.jsp" %><br><br>
        <div id="wrapper">
            <section>
                <%                 
                    String eventId = null, e_name = null, e_desc = null, e_venue = null, e_type = null, e_city = null, hosted_by = null;
                    int e_seat = 0, booked_seat = 0;
                    String e_startdate[] = new String[4];
                    String e_enddate=null;
                    String user = null;
                    EventDao ed = new EventDao();

                    eventId = request.getParameter("id");
                    if (eventId == null || session.getAttribute("username") == null) {
                        response.sendRedirect("login.jsp");
                    } else {
                        Event e = ed.searchEventByEventid(Integer.parseInt(eventId));
                        booked_seat = ed.bookedEventSeat(Integer.parseInt(eventId));
                        System.out.print(booked_seat);
                        e_name = e.getE_name();
                        e_desc = e.getE_desc();
                        e_venue = e.getE_venue();
                        e_type = e.getE_type();
                        e_startdate = e.getE_startdate().split("-");
                        e_enddate = e.getE_enddate();
                        e_city = e.getE_city();
                        e_seat = e.getE_seat();
                        hosted_by = e.getUsername();
                        user = session.getAttribute("username").toString();

                    }


                %>
                <h1><b><%=e_name%></b></h1>
                <h3><%=e_type%></h3>
                <h2><b>Hosted by </b><%=hosted_by%></h2>
                <h3><b>Spot Left :</b> <%=(e_seat - booked_seat)%></h3>
                <h3><b>Date:  </b>  <%=e_startdate[2] + "-" + e_startdate[1] + "-" + e_startdate[0]%></h3>
                <h3><b>Time: </b>  <%= e_enddate %></h3>
                <h3><b>Venue :</b> <%=e_venue + ", " + e_city%></h3>

                <h3><b>Description :</b></h3>
                <p>
                    <%=e_desc%> 
                </p>
                <%
                    if (hosted_by.equals(user)) {
                %>
                <form method="post" action="deleteevent.jsp">
                    <input type="hidden" name="eid" value=<%=eventId%> >
                    <input type="hidden" name="hostid" value=<%= hosted_by%> >
                    <input type="submit" value="Delete Event" style="margin-left: 5px;">
                </form>
                <form method="post" action="updateevent.jsp">
                    <input type="hidden" name="eid" value=<%=eventId%> >
                    <input type="hidden" name="hostid" value=<%= hosted_by%> >
                    <input type="submit" value="Update Event" style="margin-left: 25px;">
                </form>
                <form method="post" action="viewattendees.jsp">
                    <input type="hidden" name="eid" value=<%=eventId%> >
                    <input type="hidden" name="hostid" value=<%= hosted_by%> >
                    <input type="submit" value="View Attendees" style="margin-left: 28px;">
                </form>
                <%
                     } else {

                         if (ed.isJoinedEvent(user, eventId)) {%>
                <form method="post" action="joinevent.jsp">
                    <input type="hidden" name="eid" value=<%=eventId%> >
                    <input type="hidden" name="uid" value=<%= user%> >
                    <%
                        if (e_seat - booked_seat != 0) {
                    %>
                    <input type="submit" value="Join" style="margin-left: 5px;">
                    <%
                    } else {
                    %>
                    <input type="submit" value="No Seat Availible" style="margin-left: 5px;" disabled>
                    <%
                        }
                    } else {%>
                </form>
                <form method="post" action="leaveevent.jsp">
                    <input type="hidden" name="eid" value=<%=eventId%> >
                    <input type="hidden" name="uid" value=<%= user%> >
                    <input type="submit" value="Leave" style="margin-left: 5px;">

                </form>
                <%
                        }
                    }
                %>
            </section>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
