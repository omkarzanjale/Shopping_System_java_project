package pkg;
import java.sql.*;
public class DatabaseConnection{
    private static final String URL = 	"jdbc:postgresql://localhost:5432/online_shopping_project";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "omkar";
    public static Connection getDatabaseConnection(){
        Connection con = null;
        try{
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(URL,USERNAME,PASSWORD);
        }catch (Exception e){
            System.err.println(e);
        }
        return con;
    }
}