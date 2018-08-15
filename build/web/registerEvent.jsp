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

        <script>
            function validate()
            {
                var enddate = document.forms["RegForm"]["txtEndDate"];
                var startdate = document.forms["RegForm"]["txtStartDate"];
                var type = document.forms["RegForm"]["txtEventType"];
                var attendees = document.forms["RegForm"]["txtMaxAtteendes"];
                
               
                if(startdate.value == "")
                {
                     $('#sdate').after('<p>Enter a date!.</p>');
                     startdate.focus();
                    return false;
                }
                else
                {
                    var sDate = new Date(startdate.value);
                    var today = new Date();
                    if ( sDate < today) { 
                        $('#sdate').after('<p>Enter a valid date!.</p>');
                        enddate.focus();
                        return false;
                    }
                }
               
                if(enddate.value == "")
                {
                     $('#edate').after('<p>Enter a date!.</p>');
                     enddate.focus();
                    return false;
                }
                else
                {
                    var eDate = new Date(enddate.value);
                    var sDate = new Date(startdate.value);
                    if ( eDate < sDate) { 
                        $('#edate').after('<p>Enter a valid date!.</p>');
                        enddate.focus();        
                        return false;
                  }
                }
                
                if (type.value == "")
                {
                    $('#type').after('<p>Select a Event Type!.</p>');
                    type.focus();
                    return false;
                }
                
                if (attendees.value == "" || !attendees.match(/^\d+/)))
                {
                    $('#matt').after('<p>Enter Valid No!.</p>');
                    attendees.focus();
                    return false;
                }
                return true;
            }
        </script>
    </head>

    <body>
        <%@include file="header.jsp" %>
        <%            
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("pragma", "no-cache");
            response.setHeader("Expires", "0");
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="container-register" style="color: #fff;">
            <h1 style="text-align:center; font-family:Georgia, serif;">Create a Event</h1>
            <form name="RegForm" method="post" action="registerEvent.jsp" onsubmit="return validate();">
                <div class="row">
                    <div class="col-25">
                        <label for="name">Name</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="name" name="txtEventName" placeholder="Event name" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-25">
                        <label for="type">Type</label>
                    </div>
                    <div class="col-75">
                        <select id="type" name="txtEventType">
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
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="sdate">Date</label>
                    </div>
                    <div class="col-75">
                        <input type="date" id="sdate" name="txtStartDate" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="edate">Time</label>
                    </div>
                    <div class="col-75">
                        <input type="time" id="edate" name="txtEndDate" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="vanue">Venue</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="venue" name="txtEventVenue" placeholder="Event venue" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="city">City</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="city" name="txtEventCity" placeholder="Event City" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="desc">Description</label>
                    </div>
                    <div class="col-75">
                        <textarea id="desc" name="txtDesc" placeholder="Event Description" style="height:150px" required></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="row">
                        <div class="col-25">
                            <label for="matt">Max Attendees</label>
                        </div>
                        <div class="col-75">
                            <input type="number" id="matt" name="txtMaxAtteendes" placeholder="Max Attendees" required>
                        </div>
                    </div>
                    <input type="submit" value="Create">
                </div>
            </form>
        </div>
        <%
            String e_name, e_desc, e_type, e_startdate, e_enddate, e_venue, e_city, seat;
            int e_seat;

            e_name = request.getParameter("txtEventName");
            e_desc = request.getParameter("txtDesc");
            e_venue = request.getParameter("txtEventVenue");
            e_type = request.getParameter("txtEventType");
            e_startdate = request.getParameter("txtStartDate");
            e_enddate = request.getParameter("txtEndDate");
            seat = request.getParameter("txtMaxAtteendes");
            e_city = request.getParameter("txtEventCity");
            if (e_name != null) {
                e_seat = Integer.parseInt(seat);
                Event ce = new Event();
                ce.setE_name(e_name);
                ce.setE_desc(e_desc);
                ce.setE_venue(e_venue);
                ce.setE_type(e_type);
                ce.setE_startdate(e_startdate);
                ce.setE_enddate(e_enddate);
                ce.setE_seat(e_seat);
                ce.setE_city(e_city);
                ce.setUsername(session.getAttribute("username").toString());
                try {
                    EventDao e = new EventDao();
                    if (e.insertEvent(ce)) {
                        response.sendRedirect("profile.jsp");
                    }
                } catch (Exception e) {
                    out.println(e);
                }
            }


        %>
        <%@include file="footer.jsp" %>
    </body>

</html>