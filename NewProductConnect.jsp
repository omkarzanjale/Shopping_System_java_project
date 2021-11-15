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
       .cont-blk{
           background-color: cornflowerblue;
           height: 530px;
       }
        </style>
</head>
<body style="text-align: center;">
    <div class="navigation">
		<div class="inner-row">
			<nav> 
				<ul>
					<li><a href="Account.jsp"> Account </a></li>
				</ul>
				<img src="Images/cart.png" width="20px" height="19px" >
			</nav>
			
		</div>
	</div>

    <%
        int aid = (Integer)session.getAttribute("aid");
        String prid = request.getParameter("prid");
        String prname = request.getParameter("prname");
        String brand = request.getParameter("brand");
        String desc = request.getParameter("description");
        String price = request.getParameter("price");
        int discount = Integer.parseInt(request.getParameter("discount"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String category = request.getParameter("category");
        
        Connection con;
        PreparedStatement pst,lst;

        try{
            con = DatabaseConnection.getDatabaseConnection();
            String sql = "INSERT INTO product"+"(prid,prname,brand,description,price,discount,stock,aid) VALUES(?,?,?,?,?,?,?,?)";
            pst = con.prepareStatement(sql);
            pst.setString(1,prid);
            pst.setString(2,prname);
            pst.setString(3,brand);
            pst.setString(4,desc);
            pst.setString(5,price);
            pst.setInt(6,discount);
            pst.setInt(7,stock);
            pst.setInt(8,aid);
            int success = pst.executeUpdate();
            pst.close();
            String SQL = "INSERT INTO product_category"+"(prid,cgid) VALUES(?,?)";
            lst = con.prepareStatement(SQL);
            lst.setString(1,prid);
            lst.setString(2,category);
            lst.executeUpdate();
            if(success!=0){%>
                <div class="cont-blk">
                    <h2>Product is published</h2>  
                    <script type="text/javascript">
                        function redirect(){
                            window.location = "Admin.jsp";
                        }
                        document.write("You will redirected to Admin page in few seconds...");
                        setTimeout('redirect()',4000);
                    </script>
                </div><br>
            <%}
            lst.close();
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
                    <p> Online Shopping System </p>
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