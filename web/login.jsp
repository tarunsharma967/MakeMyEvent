

<%@page import="dao.LoginDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <title>Login</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
    </head>

    <body>
        <%@include file="header.jsp" %>
        <script type="text/javascript">
            function validateForm()
            {

                if (document.getElementById("txtUserName") == "")
                {
                    alert("User Name should not be blank..");
                    document.getElementById("txtUserName").focus();
                    return false;
                } else if (document.getElementById("txtPassword") == "")
                {
                    alert("Password should not be blank");
                    document.getElementById("txtPassword").focus();
                    return false;
                }
                return true;
                alert("Password should not be blank");

            }
            function wrong()
            {
                alert("Invalid Username or Password");
            }

        </script>

        <div class="container" style="color: #fff;">

            <h1 style="text-align:center; font-family:Georgia, serif;">User Login</h1>
            <form method="post" action="login.jsp" id="myform">  
                <div class="row">
                    <div class="col-25">
                        <label for="uname">User Name</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="uname" name="txtUserName" placeholder="User Name">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="upass">Password</label>
                    </div>
                    <div class="col-75">
                        <input type="password" id="upass" name="txtPassword" placeholder="Password">
                    </div>
                    <div class="row">
                        <input type="submit" value="Login" onclick="javascript:validateForm();">
                    </div>
                    <h3 style="margin-left: 459px;margin-right:459px;margin-top: 25px;color:whitesmoke;background-color:#69655d">Don't have an account? <a href="register.jsp" style="color: #4caf50;">Sign Up</a></h3>
                    
                </div>
            </form>
        </div>

        <%            if (session.getAttribute("username") != null) {
                response.sendRedirect("index.jsp");
            }
            String username = null, password = null;
            username = request.getParameter("txtUserName");
            password = request.getParameter("txtPassword");
            if (username != null) {
                if (LoginDao.checkLogin(username, password)) {
                    session.setAttribute("username", username);
                    response.sendRedirect("index.jsp");
                } else {
        %>
        <script>
            wrong();
        </script>
        <%
                }
            }
        %>
        <%@include file="header.jsp" %>
    </body>

</html>