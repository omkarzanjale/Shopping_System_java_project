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
					
					<li><a href="Account.jsp"> Account </a></li>
					
					
				</ul>
				
			</nav>
			
		</div>
	</div>
    <%
        String email = (String)session.getAttribute("email");
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        int aid = 0;
        try{
            con = DatabaseConnection.getDatabaseConnection();
            String sql = "SELECT * FROM admin WHERE email=?";
            pst = con.prepareStatement(sql);
            pst.setString(1,email);
            rs = pst.executeQuery();
            while(rs.next()){%>
                <div class = "name">
                    <% aid = rs.getInt(1);
                    session.setAttribute("aid",aid);%>
                    <h1>WELCOME <%=rs.getString(2)%></h1>
                    Email : <%= rs.getString(3)%><br>
                    City : <%= rs.getString(5)%><br>
                    Pin Code : <%= rs.getString(6)%><br>
                    Contact : <%= rs.getString(7)%>
                </div><br>
            <%}rs.close();
            pst.close();

            String SQL = "SELECT c.fname,c.lname,c.city,p.prname,o.total,o.quantity FROM customer c,product p,admin a,orders o WHERE c.id=o.id AND p.prid=o.prid AND a.aid=o.aid AND o.aid=?";
            pst=con.prepareStatement(SQL);
            pst.setInt(1,aid);
            rs = pst.executeQuery();%>
            <div class = "name">
                <h1>Order Summary</h1>
                <%while(rs.next()){%>
                    -------------------------------------------------------------<br>
                    Customer Name : <%= rs.getString(1)%> <%= rs.getString(2)%><br>
                    Order From : <%= rs.getString(3)%><br>
                    Product : <%= rs.getString(4)%><br>
                    Quantity : <%= rs.getInt(6)%><br>
                    Price : <%= rs.getString(5)%> <br>
                <%}%>
            </div><br>
            <%rs.close();
            pst.close();

            String qry = "SELECT c.fname,c.lname,c.city,p.prname,p.price,p.prid FROM product p,customer c,Advancebooking ab WHERE p.prid = ab.prid AND c.id = ab.id AND p.aid=?";
            pst = con.prepareStatement(qry);
            pst.setInt(1,aid);
            rs = pst.executeQuery();%>
            <div class = "name">
                <h1>Booked Order Summary</h1>
                <%while(rs.next()){%>
                    -------------------------------------------------------------<br>
                    Customer Name : <%= rs.getString(1)%> <%= rs.getString(2)%><br>
                    Order From : <%= rs.getString(3)%><br>
                    Product : <%= rs.getString(4)%><br>
                    Price : <%= rs.getString(5)%> <br><br>
                    
                <%}%>
            </div><br>

            <div class="button"><h3><a href="addProduct.html">Add new Product &#10141;</a></h3></div>
            <div class="button"><h3><a href="DeleteProduct.jsp">Delete Product &#10141;</a></h3></div>
            <div class="button"><h3><a href="UpdateProduct.jsp">Update Product &#10141;</a></h3></div>
            <%rs.close();
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
                    <p> Online Shopping System</p>
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
                <p class="copyright">Copyright OMKAR & VISHAKHA</p>
        </div>
    </div>
</body>
</html>