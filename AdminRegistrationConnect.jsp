<%@ page language = "java" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "pkg.DatabaseConnection" %>
<%
    //getting values and store it
    String fName=request.getParameter("fname");
    String password=request.getParameter("password");
    String contact=request.getParameter("contact");
    String email=request.getParameter("email");
    String city = request.getParameter("city");
    String pinCode = request.getParameter("pincode");

    
    //database
    Connection con = null;
    PreparedStatement pst;
    try{
        con = DatabaseConnection.getDatabaseConnection();
        if(con!=null){
            final String sql = "INSERT INTO admin"+"(aname,email,password,city,pincode,phone) VALUES(?,?,?,?,?,?)";//seq.nextval
            pst = con.prepareStatement(sql);
            pst.setString(1,fName);
            pst.setString(2,email);
            pst.setString(3,password);
            pst.setString(4,city);
            pst.setString(5,pinCode);
            pst.setString(6,contact);
            pst.executeUpdate();
            pst.close();
            con.close();
            response.sendRedirect("AdminlLgin.html");
        }else{
            out.println("Database Connection failed, try again..");
        }
    }catch(Exception e){
        out.println(e);
    }
%>