<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "pkg.*" %>
<%
String userName = request.getParameter("username");
String password = request.getParameter("password");

session.setAttribute("name",userName);
//database
final String SQL = "SELECT email,password FROM customer";
Connection con ;
Statement st;
ResultSet rs;

try{
    con = DatabaseConnection.getDatabaseConnection();
    if(con!=null){
        String mail = "";
        String pass = "";
        st = con.createStatement();
        rs = st.executeQuery(SQL);
        while(rs.next()){
           mail = rs.getString(1);
           pass = rs.getString(2); 
           
           if(userName.equals(mail) && password.equals(pass)){
                response.sendRedirect("Main.html");
            }else{
                out.println("Invalid Details");
            }
        }
        
        
        rs.close();
        st.close();
        con.close();
    }else{
        out.println("Failed to connect with database, Try after some time...");
    }
}catch (Exception e){
    out.println(e);
}
    
%>