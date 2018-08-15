<%@page import="dao.UserDao"%>
<%@page import="model.User"%>
<!doctype html>
<html>

    <head>
        <title>Register User</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/normalize.css">
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/responsive.css">
        
        
        <script>
            function email()
            {
                alert('Email already registerd!.');
                document.getElementById("email").focus();
            }
            
            function username()
            {
                alert('Username unavilable!.');
                document.getElementById("uname").focus();
            }
        </script>
            
    </head>

    <body>
        <%@include file="header.jsp" %>
        <div class="container" style="color: #fff;">
            <h1 style="text-align:center; font-family:Georgia, serif;">Register Yourself</h1>
            <form method="post" action="register.jsp">
                <div class="row">
                    <div class="col-25">
                        <label for="name">Name</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="name" name="txtName" placeholder="Your name" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="uname">User Name</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="uname" name="txtUserName" placeholder="Choose a user Name" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="psss">Password</label>
                    </div>
                    <div class="col-75">
                        <input type="password" id="pass" name="txtPassword" placeholder="Enter Password" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-25">
                        <label for="email">Email</label>
                    </div>
                    <div class="col-75">
                        <input type="email" id="email" name="txtEmail" placeholder="Enter Email" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="mno">Contact No</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="mno" name="txtPhoneNo" placeholder="Enter Phone No" maxlength="10" minlength="10" required>
                    </div>
                </div>
                <div class="row">
                    <input type="submit" value="Register">
                </div>
            </form>

        </div>

        <%            String pno, name, username, password, email;

            name = request.getParameter("txtName");
            if (name != null) {
                username = request.getParameter("txtUserName");
                password = request.getParameter("txtPassword");
                email = request.getParameter("txtEmail");
                pno = request.getParameter("txtPhoneNo");
                
                User u = new User();
                u.setName(name);
                u.setUsername(username);
                u.setPassword(password);
                u.setEmail(email);
                u.setPno(pno);
                try {
                   
                    UserDao ud = new UserDao();
                    if(ud.searchUser(username) != null){%>
                    <script> username(); </script>
                    <%
                     }
                    else if(ud.searchUserbyEmail(email) != null){%>
                    <script> email(); </script>
                    <%
                      }  
                     else if (ud.insertUser(u)) {
        %> 
        <%
            session.setAttribute("username", username);
            response.sendRedirect("index.jsp");
                        } else{%>
        <script>
            alert("sorry!");
        </script>
        <%
          }      } 
                catch (Exception e) {
                    out.println(e);
                }
            }

        %>
        <%@include file="footer.jsp" %>
    </body>

</html>