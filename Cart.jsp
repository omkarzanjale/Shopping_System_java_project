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
            .all{
                background-color: cornflowerblue;
                border-radius: 20px;
                margin-bottom: 10px;
            }
            .userinfo{
                background-color: darkgoldenrod;
                border-radius: 50px;
            }
            .name{
                background-color: darkgoldenrod;
                border-radius: 200px;
            }
            
        </style>
</head>
<body style="align-items: center;">
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
    if(email!=null){
        Connection con;
        PreparedStatement pst;
        ResultSet rs;%>
        <div class="all">
            <center>
            <%try{
                int cid = 0;
                String pid = "";
                con = DatabaseConnection.getDatabaseConnection();
                String sql = "SELECT id,fname,lname,contact,address FROM customer WHERE email=?";
                pst = con.prepareStatement(sql);
                pst.setString(1,email);
                rs = pst.executeQuery();
                while(rs.next()){
                    cid = rs.getInt(1);
                    %><br>
                    <div class="userinfo">
                        <br><br><h2>Welcome To Cart</h2>
                        <h3><%= rs.getString(2)%> <%=rs.getString(3) %></h3>
                        <h3><%= rs.getString(5)%></h3> <p><%=rs.getString(4) %></p><br>
                    </div>
                <%}
                rs.close();
                pst.close();

                String SQL = "SELECT * FROM cart WHERE id=?";
                pst = con.prepareStatement(SQL);
                pst.setInt(1,cid);
                rs = pst.executeQuery();
                while(rs.next()){
                    pid = rs.getString(1);
                }
                rs.close();
                pst.close();

                String qry = "SELECT * FROM Product WHERE prid=?";
                pst = con.prepareStatement(qry);
                pst.setString(1,pid);
                rs = pst.executeQuery();
                while(rs.next()){
                    if(rs.getInt(7)>0){%><br>
                        <div class = "name"><br>
                            <form action="Confirm.jsp" method="post">
                                <h3>Product Name : <%= rs.getString(2)%></h3><br>
                                <h4>Brand : <%= rs.getString(3)%></h4><br>
                                <h5><%= rs.getString(4)%></h5><BR>
                                <p>Rs.<%= rs.getString(5)%></p><br>
                                <p>Click on buy to reorder</p><br>
                                <input type="hidden" name="buy" value="<%= rs.getString(1)%>">
                                <input type="image" name="buy" value="<%= rs.getString(1)%>" src="Images/buynow.png" width="10%" height="10%">
                                <br>
                            </form><br>
                        </div><br>
                    <%}else{%>
                        <div class = "name"><br>
                            <form action="Advancebook.jsp" method="post">
                                <h2>Out of stock <br> Book in advance</h2><br>
                                <h3>Product Name : <%= rs.getString(2)%></h3><br>
                                <h4>Brand : <%= rs.getString(3)%></h4><br>
                                <h5><%= rs.getString(4)%></h5><BR>
                                <h4><%= rs.getString(5)%></h4>
                                <input type="hidden" name="prid" value="<%= rs.getString(1)%>">
                                <input type="image" name="prid" value="<%= rs.getString(1)%>" src="Images/buynow.png" width="10%" height="10%"><br>
                            </form>
                        </div><br>
                    <%}
                }
            }catch(Exception e){
                out.println(e);
            }%>
        </center>
        </div>

    <%}else{
        response.sendRedirect("Login.html");
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