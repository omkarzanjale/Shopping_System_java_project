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
            h1{
                text-align: center;
                font-size : 50px;
            }
            .productform{
                padding-bottom: 10px;
                padding-right: 75px;
                padding-top: 50px;
                padding-left: 430px;
                font-size: 30px;
            }
            .productform table{
                color: brown;
            }
            .productform td{
                padding: 15px;
            }
            .productform th{
                color: darkblue;
            }
            button{
                display:inline-block;
                background:#ff523b;
                color:#fff;
                padding:8px 30px;
                margin:30px 0px;
                border-radius:30px;
                transition:background 0.3s;
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
            String pid = request.getParameter("buy");
            Connection con;
            PreparedStatement pst;
            ResultSet rs;
            int cid = 0;
            int aid = 0;
            try{
                con = DatabaseConnection.getDatabaseConnection();
                String sql = "SELECT * FROM product WHERE prid=?";
                pst = con.prepareStatement(sql);
                pst.setString(1,pid);
                rs = pst.executeQuery();
                while(rs.next()){
                    aid =rs.getInt(8);%>
                    <div class="all"><br><br>
                        <h1>Added to Cart</h1>
                        <div class="productform">
                            <table >
                                <tr>
                                    <td><h2>Product Details</h2></td>
                                </tr>
                                <tr>
                                    <td><b>Name :</b><%= rs.getString(2)%></td>
                                </tr>
                                <tr>
                                    <td><b>Brand :</b><%= rs.getString(3)%></td>
                                </tr>
                                <tr>
                                    <td><b>Specification :</b><%= rs.getString(4)%></td>
                                </tr>
                                <tr>
                                    <td><b>Price :</b><%= rs.getString(5)%></td>
                                </tr>
                                <tr>
                                    <td><b>Discount :</b><%= rs.getString(6)%>%</td>
                                </tr>
                            </table>
                        </div>
                        
                    <%}
                    rs.close();
                    pst.close();

                    String SQL = "SELECT id from customer where email=?";
                    pst = con.prepareStatement(SQL);
                    pst.setString(1,email);
                    rs = pst.executeQuery();
                    while(rs.next()){
                        cid = rs.getInt(1);
                    }
                    rs.close();
                    pst.close();
                    
                    String qry = "INSERT INTO cart"+"(prid,id) VALUES(?,?)";
                    pst = con.prepareStatement(qry);
                    pst.setString(1,pid);
                    pst.setInt(2,cid);
                    pst.executeUpdate();
                    %>
                    <center>
                    <div class="confirmbtn">
                        <form action="Payment.jsp" method="POST">
                            <input type = "hidden" name="aid" value="<%= aid %>">
                            <input type = "hidden" name="pid" value="<%= pid %>">
                            <input type="hidden" name="cid" value="<%= cid %>">
                            <button type="submit" class="btn">Confirm</button>
                        </form>
                    </div>
                    </center><br><br>
                </div>
                <%rs.close();
                pst.close();
                        
            }catch (Exception e){
                out.println(e);
            }
        }else{
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