package connection;

import java.sql.*;

public class MyCon {

    static Connection con = null;

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver Load.........");
        } 
        catch (Exception e) {
            System.out.println(e);
        }
    }

    public static Connection myConnection() {
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/myevent", "root", "root");
            System.out.println("Database Connected");
        } 
        
        catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }
}
