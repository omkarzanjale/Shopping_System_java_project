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
            .paymentform{
                padding: 75px;
                padding-top: 0px;
                padding-left: 500px;
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
        int aid = Integer.parseInt(request.getParameter("aid"));
        int cid = Integer.parseInt(request.getParameter("cid"));
        String pid = request.getParameter("pid");
        try{%>
            <div class="all">
                <div class="paymentform">
                    <table>
                    <form action="Order.jsp" method="post"><br>
                        <label for="heading"><h1>Card Details</h1></label><br>
                        <tr><td><label for="cardno">Card NO :</label></td>
                        <td><input type="number" name="cardno" required/></td></tr>
                        
                        <tr><td><label for="cardtype">Card Type :</label></td>
                        <td><select class="select-control" name = "cardtype" required>
                            <option value="creditcard">Credit Card </option>
                            <option value="debitcard">Debit Card</option>
                        </select></td></tr>
                        
                        <tr>
                        <td><label for="cvv">CVV :</label></td>
                        <td><input type="number" name="cvv" required/></td></tr>
                        
                        <tr>
                        <td><label for="pin">Pin :</label></td>
                        <td><input type="password" name="pin" required/></td></tr>

                        <tr>
                            <td><label for="quantity">Quantity :</label></td>
                            <td><input type="number" name="quantity" required/></td>
                        </tr>

                        <tr>
                            <td><label for="fastDelivery">Delivery :</label></td>
                            <td><input type="checkbox" name="delivery" value="Normal"/>Normal
                            <input type="checkbox" name="delivery" value="Speed"/>speed</td>
                        </tr>
                       

                        <input type="hidden" name = "cid" value="<%= cid %>"> 
                        <input type="hidden" name="buy" value="<%= pid %>">
                        <input type="hidden" name="aid" value="<%= aid %>">
                        
                        
                        <tr><td><br>
                        <button type="submit" class="paybtn">Pay</button>
                        </td></tr>
                    </form>
                    </table>
                </div>
            </div>
               
        <%}catch (Exception e){
            out.println(e);
        }%>

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