<%@ page contentType = "text/html" pageEncoding = "UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import = "pkg.DatabaseConnection" %>
<!DOCTYPE HTML>
<html>
<head>
    <title> Online Shopping System </title>
    <link rel="stylesheet" href="css/MainCss.css">
    <link href="https://fonts.googleapis.com/css2?family=Bentham&family=Piazzolla:ital,wght@0,600;1,300;1,600&display=swap" rel="stylesheet">
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
        ResultSet rs;
        PreparedStatement pst;
        try{
            con = DatabaseConnection.getDatabaseConnection();
            if(con!=null){
                String sql = "SELECT * FROM product WHERE aid =(SELECT aid FROM admin WHERE email=?)";
                pst = con.prepareStatement(sql);
                pst.setString(1,email);
                rs = pst.executeQuery();
                while(rs.next()){%>
                    <table border="1">
                        <tr>
                            <td><%= rs.getString(1) %></td>
                            <td><%= rs.getString(2) %></td>
                            <td><a>Remove</a></td>
                        </tr>
                    </table>
                <%}
            }
            else{
                out.println("Failed to connect With Database");
            }

        }catch (Exception e){
            out.println(e);
        }
    %>

</body>
</html>