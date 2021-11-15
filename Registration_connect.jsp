<%@ page language = "java" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "pkg.DatabaseConnection" %>
<%
    //getting values and store it
    String fName=request.getParameter("fname");
    String lName=request.getParameter("lname");
    String password=request.getParameter("password");
    String contact=request.getParameter("contact");
    String gender=request.getParameter("gender");
    String email=request.getParameter("email");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String pinCode = request.getParameter("pincode");

    
    //database
    Connection con = null;
    PreparedStatement pst;
    try{
        con = DatabaseConnection.getDatabaseConnection();
        if(con!=null){
            //online_shopping_project=#  CREATE TABLE customer(id SERIAL PRIMARY KEY,fname varchar(10),lname varchar(10),password varchar(25),contact varchar(10),gender varchar(10),email varchar(50),address varchar(50),city varchar(10),pincode varchar(8));
            final String sql = "INSERT INTO customer"+"(fname,lname,password,contact,gender,email,address,city,pincode) VALUES(?,?,?,?,?,?,?,?,?)";//seq.nextval
            pst = con.prepareStatement(sql);
            pst.setString(1,fName);
            pst.setString(2,lName);
            pst.setString(3,password);
            pst.setString(4,contact);
            pst.setString(5,gender);
            pst.setString(6,email);
            pst.setString(7,address);
            pst.setString(8,city);
            pst.setString(9,pinCode);
            pst.executeUpdate();
            pst.close();
            con.close();
            response.sendRedirect("Login.html");
        }else{
            out.println("Database Connection failed, try again..");
        }
    }catch(Exception e){
        out.println(e);
    }
%>