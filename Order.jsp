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
            .details{
                border-radius:20px;
                background-color:lightcoral;
                padding: 50px;
                padding-top: 50px;
                padding-bottom: 50px;
                margin: 0px;
            }
            .name{
            border-radius:20px;
            background-color:lightcoral;
            padding: 50px;
            margin: 0px;	        
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
				<a href="Cart.jsp"><img src="Images/cart.png" width="20px" height="19px"></a>
			</nav>
		</div>
	</div>
   <!----- online_shopping_project=# CREATE TABLE orders(orid SERIAL PRIMARY KEY,cardno varchar(50),cardtype varchar(20),cvv varchar(10),pin varchar(10),id int REFERENCES customer(id) 
    ON DELETE CASCADE ON UPDATE SET NULL,aid int REFERENCES admin(aid) ON DELETE CASCADE ON UPDATE SET NULL,prid varchar(10) REFERENCES product(prid) ON DELETE CASCADE ON UPDATE SET NULL);------->
    <%
        String name = (String)session.getAttribute("name");
        if(name!=null){
            String cardno = request.getParameter("cardno");
            String cardtype = request.getParameter("cardtype");
            String cvv = request.getParameter("cvv");
            String pin = request.getParameter("pin");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String pid = request.getParameter("buy");
            int cid = Integer.parseInt(request.getParameter("cid"));
            int aid = Integer.parseInt(request.getParameter("aid"));
            String delivery = request.getParameter("delivery");

            Connection con;
            PreparedStatement pst;
            ResultSet rs;
            int stck = 0;
            int price = 0;
            String total = "";
            if(delivery.equals("Speed")){
                String ccity="";
                String pname="";
                try{
                    String newprice="";
                    int newaid = 0;
                    String newpid ="";
                    String newpname = "";
                    String newpbrand = "";
                    String newpdescription = "";
                    con = DatabaseConnection.getDatabaseConnection();

                    String sql = "select * from product WHERE prid =?";
                    pst = con.prepareStatement(sql);
                    pst.setString(1,pid);
                    rs = pst.executeQuery();
                    while(rs.next()){
                        pname = rs.getString(2);
                    }
                    rs.close();
                    pst.close();

                    String SQL ="SELECT * FROM customer WHERE id =?";
                    pst = con.prepareStatement(SQL);
                    pst.setInt(1,cid);
                    rs = pst.executeQuery();
                    while(rs.next()){
                        ccity = rs.getString(9);
                    }
                    rs.close();
                    pst.close();

                    String qry = "SELECT p.prid,p.prname,p.aid,p.price,p.brand,p.description FROM product p,admin a,customer c WHERE a.aid=p.aid AND a.city = ? AND p.prname = ?";
                    pst = con.prepareStatement(qry);
                    pst.setString(1,ccity);
                    pst.setString(2,pname);
                    rs = pst.executeQuery();
                    while(rs.next()){
                        newpid = rs.getString(1);
                        newaid = rs.getInt(3);
                        newprice = rs.getString(4);
                        newpname = rs.getString(2);
                        newpbrand = rs.getString(5);
                        newpdescription = rs.getString(6);
                    }
                    if(newpid.equals("")){%>
                        <div class = "name">
                            <h2>Speed Delivery is not available</h2>
                            <a href="Main.html"><input type="button" class="button" value="Cancel"></a>
                        </div>
                    <%}else{%>
                        <div class = "name">
                            <form action="SpeedOrder.jsp" method="post">
                                <h2>Speed Delivery available</h2><br>
                                <h3>Product Name : <%= newpname %></h3><br>
                                <h4>Brand : <%= newpbrand %></h4><br>
                                <h5><%= newpdescription %></h5><BR>
                                <p>Rs.<%= newprice %></p><BR>
                                <input type="hidden" name="aid" value="<%= newaid %>">
                                <input type="hidden" name="pid" value="<%= newpid %>">
                                <input type="hidden" name="cid" value="<%= cid %>">
                                <input type="hidden" name="cardno" value="<%= cardno %>">
                                <input type="hidden" name="cardtype" value="<%= cardtype %>">
                                <input type="hidden" name="cvv" value="<%= cvv %>">
                                <input type="hidden" name="pin" value="<%= pin %>">
                                <input type="hidden" name="quantity" value="<%= quantity %>">
                                <label for="msg">Click on Confirm to order above Product</label><br>
                                <input type="submit" class="button" value="Confirm"/><br>
                                
                            </form>
                            <a href="Main.html"><input type="button" class="button" value="Cancel"></a>
                        </div><br>
                    <%}
                    rs.close();
                    pst.close();
                    con.close();
                }catch(Exception e){
                    out.println(e);
                }
            }
            if(delivery.equals("Normal")){
                try{
                    con = DatabaseConnection.getDatabaseConnection();
                    String  QUERY = "SELECT * FROM product WHERE prid = ?";
                    pst = con.prepareStatement(QUERY);
                    pst.setString(1,pid);
                    rs = pst.executeQuery();
                    while(rs.next()){
                        price = Integer.parseInt(rs.getString(5));
                        stck = rs.getInt(7);
                    }
                    total = Integer.toString(price * quantity); 
                    rs.close();
                    pst.close();

                    String sql = "INSERT INTO orders"+"(cardno,cardtype,cvv,pin,id,aid,prid,quantity,total) VALUES(?,?,?,?,?,?,?,?,?)";
                    pst = con.prepareStatement(sql);
                    pst.setString(1,cardno);
                    pst.setString(2,cardtype);
                    pst.setString(3,cvv);
                    pst.setString(4,pin);
                    pst.setInt(5,cid);
                    pst.setInt(6,aid);
                    pst.setString(7,pid);
                    pst.setInt(8,quantity);
                    pst.setString(9,total);
                    int success=pst.executeUpdate();
                    pst.close();
                    
                    if(success>0){
                        stck -= quantity;
                    }
                    
                    String query = "UPDATE product SET stock = ? WHERE prid=?";
                    pst = con.prepareStatement(query);
                    pst.setInt(1,stck);
                    pst.setString(2,pid);
                    pst.executeUpdate();
                    pst.close();

                    if(success==0){
                        out.println("Order is Unsuccessful");
                    }else{
                        int oid = 0;
                        String get_qry="SELECT orid FROM orders WHERE prid=? AND id=? AND aid=?";
                        pst = con.prepareStatement(get_qry);
                        pst.setString(1,pid);
                        pst.setInt(2,cid);
                        pst.setInt(3,aid);
                        rs = pst.executeQuery();
                        while(rs.next()){
                            oid = rs.getInt(1);
                        }
                        rs.close();
                        pst.close();

                        String SQL="SELECT fname,address,prname FROM customer c,product p, orders o WHERE c.id=o.id AND p.prid=o.prid AND o.orid=?";
                        pst=con.prepareStatement(SQL);
                        pst.setInt(1,oid);
                        rs=pst.executeQuery();%>
                        <div class="details">
                            <%while(rs.next()){%>
                                <h2>Thank You <%= rs.getString(1)%></h2><br>
                                <h3>Your Order for <%=rs.getString(3)%> is successfull (Quantity <%= quantity %>)</h3><br>
                                <h3>Total Amount : <%= total %></h3><br>
                                <h2>Delivary Address : <%= rs.getString(2)%></h2> 
                            <%}%>
                        </div> <br>
                        <%rs.close();
                        pst.close();
                    } 
                    con.close();
                }catch(Exception e){
                    out.println(e);
                }
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
                    <p>Online Shopping System </p>
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