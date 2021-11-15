package pkg;
import java.sql.*;
public class DatabaseConnection{
    private String URL = "jdbc:postgresql://localhost:5432/online_shooping_project";
    private String USERNAME = "postgres";
    private String PASSWORD = "omkar";
    public Connection getDatabaseConnection(){
        Connection con = null;
        try{
            Class.forName("org.jdbc.Driver");
            con = DriverManager.getConnection(URL,USERNAME,PASSWORD);
        }catch (Exception e){
            System.err.println(e);
        }
        return con;
    }
}