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
            body{
                background: url("Images/bg5.jpg");
                background-size: 100% 80%;              
            }
            .acnt{
                padding-bottom: 50px;
                padding-top: 50px;
                margin-bottom: 10px;
            }
        </style>
</head>
<body style="text-align: center;">
    
    
    <%
        String name = (String)session.getAttribute("name");
        String email = (String)session.getAttribute("email");
        
        if(name!=null){%>
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

            <div class="acnt">
                <%try{
                    Connection con;
                    ResultSet rs;
                    PreparedStatement pst;
                    con = DatabaseConnection.getDatabaseConnection();
                    String sql = "SELECT fname,lname,contact,address FROM customer WHERE email=?";
                    pst = con.prepareStatement(sql);
                    pst.setString(1,name);
                    rs = pst.executeQuery();
                    while(rs.next()){%>
                        <br><br><h2>Welcome</h2>
                        <h3><%= rs.getString(1)%> <%=rs.getString(2) %></h3>
                        <h3><%= rs.getString(4)%></h3> <p><%=rs.getString(3) %></p><br>
                    <%}
                    rs.close();
                    pst.close();
                    con.close(); 
                }catch(Exception e){
                    out.println(e);
                }%>
                <div class="button"><h3><a href="Logout.jsp">Logout &#10141;</a></h3></div>
            </div>
        <%}
        else if(email!=null){%>
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
            <div class="acnt">
                <div class="button"><h3><a href="Logout.jsp">Logout &#10141;</a></h3></div><br>
            </div>
        <%}
        else{%>
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
            <div class="acnt">
                <div class="button"><h3><a href="AdminlLgin.html">ADMIN &#10141;</a></h3></div><br>
                <div class="button"><h3><a href="Login.html">USER &#10141;</a></h3></div><br>
            </div>
        <%}
        
    %>
    </div>
    
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