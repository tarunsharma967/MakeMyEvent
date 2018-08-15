package dao;

import connection.MyCon;
import java.sql.*;
import java.util.*;

public class LoginDao {

    String sql;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public static boolean checkLogin(String username, String password) throws Exception {
        String sql;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        sql = "select * from user where username=? and password=?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        rs = ps.executeQuery();
        if (rs.next()) {
            return true;
        }
        return false;

    }

}
