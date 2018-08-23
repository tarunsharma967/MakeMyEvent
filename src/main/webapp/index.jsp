<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>MakeMyEvent</title>
        <link href="https://fonts.googleapis.com/css?family=Changa+One|Open+Sans" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/normalize.css">

        <link rel="stylesheet" href="css/responsive.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%@include file = "header.jsp" %><br><br>
        <div id="wrapper">
            <section>
                <ul id="gallery">
                    <li>
                        <a href="events.jsp?type=music">
                            <img src="img/music.jpg" alt="">
                            <p>Music</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=food%20%26%20drink">
                            <img src="img/foodNdrink.jpg" alt="">
                            <p>Food and Drink</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=class">
                            <img src="img/class.jpg" alt="">
                            <p>Class</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=art">
                            <img src="img/art.jpg" alt="">
                            <p>Art</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=party">
                            <img src="img/party.jpg" alt="">
                            <p>Party</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=sport%20%26%20wellness">
                            <img src="img/sport.jpg" alt="">
                            <p>Sports</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=workshop">
                            <img src="img/workshop.jpg" alt="">
                            <p>Workshop</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=seminar">
                            <img src="img/seminar.jpg" alt="">
                            <p>Seminar</p>
                        </a>
                    </li>
                    <li>
                        <a href="events.jsp?type=social">
                            <img src="img/social.jpg" alt="">
                            <p>Social</p>
                        </a>
                    </li>
                </ul>
            </section>
        </div>
        <%@include file="footer.jsp" %>
    </body>

</html>