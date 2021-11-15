<%@ page contentType = "text/html" pageEncoding = "UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import = "pkg.DatabaseConnection" %>
<!DOCTYPE HTML>
<html>
<head>
    <!--------<meta charset="UTF-8">
        <meta name="viewport" content="width-device-width ,initial-scale=1.0">--->
        <title> Online Shopping System </title>
        <link rel="stylesheet" href="css/MainCss.css">
        <link href="https://fonts.googleapis.com/css2?family=Bentham&family=Piazzolla:ital,wght@0,600;1,300;1,600&display=swap" rel="       ">
        <style type="text/css">
            .name{
                border-radius:20px;
                background-color:lightcoral;
                padding: 50px;
                margin: 0px;	        
            }
           /* .name input[type="image"]:hover{
               background:#121212;
            }*/
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
				<a href="Cart.jsp"><img src="Images/cart.png" width="20px" height="19px"></a>
			</nav>
		</div>
	</div>
    <%
    String email = (String)session.getAttribute("name");
    String prid = request.getParameter("prid");
    
    if(email!=null){
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        int cid = 0;
        try{
            con = DatabaseConnection.getDatabaseConnection();
            String sql = "SELECT id FROM customer WHERE email = ?";
            pst = con.prepareStatement(sql);
            pst.setString(1,email);
            rs = pst.executeQuery();
            while(rs.next()){
                cid = rs.getInt(1);
            }
            rs.close();
            pst.close();

            String SQL = "INSERT INTO Advancebooking"+"(id,prid) VALUES(?,?)";
            pst = con.prepareStatement(SQL);
            pst.setInt(1,cid);
            pst.setString(2,prid);
            int booked = pst.executeUpdate();
            if(booked>0){%>
                <div class="name">
                    <h1>Advancebooking is successfull</h1>
                    <h2>Thank You</h2>
                </div><br>
            <%}else{%>
                <div class="name">
                    <h1>Advancebooking is Unsuccessfull</h1>
                </div><br>
            <%}
        }catch (Exception e){
            out.println(e);
        }
    }else{%>
        <script type="text/javascript">
            alert("Login Please and try again..");
        </script>
        <%response.sendRedirect("Login.html");
    }
    %>
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