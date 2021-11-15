<%@ page language = "java" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "pkg.*" %>
<%
String userName = request.getParameter("username");
String password = request.getParameter("password");

session.setAttribute("email",userName);
//database
final String SQL = "SELECT * FROM Admin WHERE email=? AND password=? ";
Connection con ;
PreparedStatement st;
ResultSet rs;
out.println(password);

try{
    con = DatabaseConnection.getDatabaseConnection();
    if(con!=null){
        String mail = "";
        String pass = "";
        st = con.prepareStatement(SQL);
        st.setString(1,userName);
        st.setString(2,password);
        rs = st.executeQuery();
        if(rs.next()){
            response.sendRedirect("Admin.jsp");
        }else{
             out.println("Invalid Details");
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