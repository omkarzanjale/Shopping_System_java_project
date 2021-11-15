<html>
<head><title>Category</title>
    <link rel="stylesheet" href="css/MainCss.css">
	<link href="https://fonts.googleapis.com/css2?family=Bentham&family=Piazzolla:ital,wght@0,600;1,300;1,600&display=swap" rel="stylesheet">
    <style type="text/css">
        body{
            background: url("Images/Categorybg.jpg");
            background-size: 100% 50%;

        }
        .all-categories {
            font-weight: bold;
            font-size: 20px;
            margin-bottom: 10px;
        }
        
        form{
            text-align: center;
        }
        .center1 {
            text-align: center;
        }
        h1{
            text-align: center;
        }
    </style>
</head>
<body>
    <%@ page language = "java" %>
    <%@ page import = "java.sql.*" %>
    <%@  page import = "java.io.*" %>
    <%@ page import = "pkg.DatabaseConnection" %>
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
    <!-----------------------------All category Section----------------->

    <div class="all-categories">
        <% 
        Connection con = null;
        ResultSet rs;
        Statement st;

        final String sql = "SELECT * FROM category";
        try{
            con = DatabaseConnection.getDatabaseConnection();
            if(con!=null){
                st = con.createStatement();
                rs = st.executeQuery(sql);%>
                <h1> All Categories </h1><br><br>
                <%while(rs.next()){
                    %>
                        <form action="AllProduct.jsp" method="post">
                        <input type="hidden" class="name" name="category" value="<%=rs.getString(2)%>"> <%= rs.getString(2)%>
                        <input type="image" name="category" value="<%= rs.getString(2) %>" src="Images/arrow.png" height="15px" width="30px">
                        </form><br>
                    <%
                    }%><br>
                    <%st.close();
                    rs.close();
            }else{
            %>
                <h1>Unsuccessful</h1>
            <% }
            
        }catch (Exception e){
            out.println(e);}%>
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