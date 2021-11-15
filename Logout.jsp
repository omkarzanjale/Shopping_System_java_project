<%@ page contentType = "text/html" pageEncoding = "UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <!--------<meta charset="UTF-8">
        <meta name="viewport" content="width-device-width ,initial-scale=1.0">--->
        <title> Online Shopping System </title>
        <link rel="stylesheet" href="css/MainCss.css">
        <link href="https://fonts.googleapis.com/css2?family=Bentham&family=Piazzolla:ital,wght@0,600;1,300;1,600&display=swap" rel="stylesheet">
        <style type="text/css">
            .logout{
                background-color: cornflowerblue;
                margin-bottom: 10px;
                padding: 40px;
            }
        </style>
</head>
<body style="text-align: center;">
    <div class="navigation">
		<div class="inner-row">
			<nav> 
				<ul>
					<li><a href="Main.html"> Home </a></li>
					<li><a href="Account.jsp"> Account </a></li>
					<li><a href="Category.jsp"> Product </a></li>
					<li><a href="ContactUs.html"> Contact </a></li>
					<li><a href="AboutUs.html"> About Us </a></li>
				</ul>
				<img src="Images/cart.png" width="20px" height="19px" >
			</nav>
			
		</div>
	</div>
    <div class="logout">
        <%
        if(session.getAttribute("name")!=null){
            session.invalidate();
            out.println("Successfully logged out...");
        }
        else if(session.getAttribute("email")!=null){
            session.invalidate();
            out.println("Successfully logged out..."); 
        }
        %><br><br>
        <script type="text/javascript">
            function redirect(){
                window.location = "Main.html";
            }
            document.write("You will redirected to home page in few seconds...");
            
            setTimeout('redirect()',4000);
        </script><br>
    </div>
    <!---------footer section---------->
    <div class="footer">
        <div class="container">				
            <div class="title">
                <div class="footer-col1">
                    <p>Online Shopping System</p>
                    <div class="app-logo">
                        <img src="Images/logo.jpg">
                    </div>
                </div>
                <div class="footer-col">
                    <p> Your Account </p><br>
                    <p> Customer Services </p> 
                </div>
            </div>
            <hr>
                <p class="copyright">Copyright</p>
        </div>
    </div>
</body>
</html>