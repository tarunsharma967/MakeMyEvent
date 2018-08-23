<!DOCTYPE html>
<html>
    <head>
        <style>
            header{
                z-index: 1000;
            }
        </style>
    </head>
    <body> 
        <header>
            <a href="index.jsp" id="logo">
                <h1>MakeMyEvent</h1>
            </a>
            <nav>
                <ul>
                    <li><a href="index.jsp" class="selected">Home</a></li>
                    <li><a href="registerEvent.jsp">Create Event</a></li>
                    <li><a href="events.jsp">Explore Events</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                        <%
                            if (session.getAttribute("username") == null) {
                        %>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp">Sign up</a></li>
                        <%        } else {
                        %>
                    <li><a href="profile.jsp">Profile</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                        <%
                            }
                        %>
                </ul>
            </nav>
        </header>
        <br><br><br>
    </body>