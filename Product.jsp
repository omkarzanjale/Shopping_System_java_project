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
        <link href="https://fonts.googleapis.com/css2?family=Bentham&family=Piazzolla:ital,wght@0,600;1,300;1,600&display=swap" rel="stylesheet">
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
        String pid = request.getParameter("product");
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        try{
            con = DatabaseConnection.getDatabaseConnection();

            String sql = "SELECT * FROM Product WHERE prid=?";
            pst = con.prepareStatement(sql);
            pst.setString(1,pid);
            rs = pst.executeQuery();
            while(rs.next()){
                if(rs.getInt(7)>0){%>
                    <div class = "name">
                        <form action="Confirm.jsp" method="post">
                            <h3>Product Name : <%= rs.getString(2)%></h3><br>
                            <h4>Brand : <%= rs.getString(3)%></h4><br>
                            <h5><%= rs.getString(4)%></h5><BR>
                            <p>Rs.<%= rs.getString(5)%></p><BR>
                            <input type="hidden" name="buy" value="<%= rs.getString(1)%>">
                            <input type="image" name="buy" value="<%= rs.getString(1)%>" src="Images/buynow.png" width="10%" height="10%">
                        </form>
                    </div><br>
                <%}else{%>
                    <div class = "name">
                        <form action="Advancebook.jsp" method="post">
                            <h2>Out of stock <br> Book in advance</h2><br>
                            <h3>Product Name : <%= rs.getString(2)%></h3><br>
                            <h4>Brand : <%= rs.getString(3)%></h4><br>
                            <h5><%= rs.getString(4)%></h5><BR>
                            <h4>Rs.<%= rs.getString(5)%></h4><br>
                            <input type="hidden" name="prid" value="<%= rs.getString(1)%>">
                            <input type="image" name="prid" value="<%= rs.getString(1)%>" src="Images/buynow.png" width="10%" height="10%">
                        </form>
                    </div><br>
                <%}
            }
            rs.close();
            pst.close();
            con.close();
        }catch(Exception e){
            out.println(e);
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