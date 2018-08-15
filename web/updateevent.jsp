<%@page import="dao.EventDao"%>
<%@page import="model.Event"%>
<!doctype html>
<html>

    <head>
        <title>Register Event</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
        <style>
            input[type=time],input[type=number],select{
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
        <%@include file="header.jsp" %>
        <%            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("pragma", "no-cache");
            response.setHeader("Expires", "0");
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>


        <%
            String eventId = null, hostId = null, user = null;
            EventDao ed = new EventDao();
            Event ev = new Event();
            eventId = request.getParameter("eid");
            hostId = request.getParameter("hostid");

            if (eventId == null) {
                eventId = "-1";
            }
            if (hostId == null) {
                hostId = "  ";
            }
            if (session.getAttribute("username") != null) {
                user = session.getAttribute("username").toString();
            }
            if (user != null && hostId.equals(user)) {
                ev = ed.searchEventByEventid(Integer.parseInt(eventId));
                if (ev == null) {
                    out.println("<h3>No Event Found</h3>");
                } else {
        %>
        <div class="container-register" style="color: #fff;">
            <h1 style="text-align:center; font-family:Georgia, serif;">Update Event</h1>
            <form method="post" action="updateEvent">
                <input type="hidden" name="id" value="<%=ev.getEvent_id()%>">
                <div class="row">
                    <div class="col-25">
                        <label for="name" >Name</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="name" name="txtEventName" placeholder="Event name" value="<%=ev.getE_name()%>">
                    </div>
                </div>

                <div class="row">
                    <div class="col-25">
                        <label for="type">Type</label>
                    </div>
                    <div class="col-75">
                        <select id="type" name="txtEventType" >
                            <option value="music" <% if (ev.getE_type().equals("music")) { %>selected <% } %>>Music</option>
                            <option value="food & drink"<% if (ev.getE_type().equals("food & drink")) { %>selected <% } %>>Food & Drink</option>
                            <option value="class"<% if (ev.getE_type().equals("class")) { %>selected <% } %>>Class</option>
                            <option value="art"<% if (ev.getE_type().equals("art")) { %>selected <% } %>>Art</option>
                            <option value="party"<% if (ev.getE_type().equals("party")) { %>selected <% } %>>Party</option>
                            <option value="sport & wellness"<% if (ev.getE_type().equals("sport & wellness")) { %>selected <% } %>>Sports & Wellness</option>
                            <option value="seminar"<% if (ev.getE_type().equals("seminar")) { %>selected <% } %>>Seminar</option>
                            <option value="workshop"<% if (ev.getE_type().equals("workshop")) { %>selected <% } %>>Workshop</option>
                            <option value="other"<% if (ev.getE_type().equals("other")) { %>selected <% }%>>Other</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="sdate">Date</label>
                    </div>
                    <div class="col-75">
                        <input type="date" id="sdate" name="txtStartDate" value="<%= ev.getE_startdate()%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="edate">Time</label>
                    </div>
                    <div class="col-75">
                        <input type="time" id="edate" name="txtEndDate" value="<%= ev.getE_enddate()%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="vanue">Vanue</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="venue" name="txtEventVenue" placeholder="Event venue" value="<%= ev.getE_venue()%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="city">City</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="city" name="txtEventCity" placeholder="Event City" value="<%= ev.getE_city()%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="desc">Description</label>
                    </div>
                    <div class="col-75">
                        <textarea id="desc" name="txtDesc" placeholder="Event Description" style="height:150px"><%= ev.getE_desc()%></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="row">
                        <div class="col-25">
                            <label for="matt">Max Attendees</label>
                        </div>
                        <div class="col-75">
                            <input type="number" id="matt" name="txtMaxAtteendes" placeholder="Max Attendees" value="<%= ev.getE_seat()%>">
                        </div>
                    </div>
                    <input type="submit" value="Update">
                </div>
            </form>
        </div>
        <%
                }
            }
        %>
        <%@include file="footer.jsp" %>
    </body>

</html>