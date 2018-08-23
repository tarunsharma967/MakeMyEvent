package dao;

import java.sql.*;
import java.util.*;
import connection.MyCon;
import model.User;

public class UserDao {

    String sql;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean insertUser(User ur) throws Exception {

        sql = "insert into user values (?,?,?,?,?)";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, ur.getUsername());
        ps.setString(2, ur.getName());
        ps.setString(3, ur.getEmail());
        ps.setString(4, ur.getPassword());
        ps.setString(5, ur.getPno());
        int n = 0;
        n = ps.executeUpdate();
        if (n > 0) {
            return true;
        }
        return false;
    }

    public boolean deleteUser(String username) throws Exception {

        sql = "delete from user where username=?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, username);
        int n = 0;
        if (n > 0) {
            return true;
        }
        return false;
    }

    public User searchUser(String username) throws Exception {
        sql = "select * from user where username=?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, username);
        rs = ps.executeQuery();
        User ur = new User();
        if (rs.next()) {
            ur.setUsername(rs.getString(1));
            ur.setName(rs.getString(2));
            ur.setEmail(rs.getString(3));
            ur.setPassword(rs.getString(4));
            ur.setPno(rs.getString(5));

        } else {
            ur = null;
        }
        return ur;

    }
    
    public User searchUserbyEmail(String email) throws Exception {
        sql = "select * from user where email=?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, email);
        rs = ps.executeQuery();
        User ur = new User();
        if (rs.next()) {
            ur.setUsername(rs.getString(1));
            ur.setName(rs.getString(2));
            ur.setEmail(rs.getString(3));
            ur.setPassword(rs.getString(4));
            ur.setPno(rs.getString(5));

        } else {
            ur = null;
        }
        return ur;

    }

    public List<User> searchallUser() throws Exception {

        sql = "select * from user";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        List<User> mylist = new ArrayList<User>();
        while (rs.next()) {
            User ur = new User();
            ur.setUsername(rs.getString(1));
            ur.setName(rs.getString(2));
            ur.setEmail(rs.getString(3));
            ur.setPassword(rs.getString(4));
            ur.setPno(rs.getString(5));
            mylist.add(ur);
            ur = null;
        }
        return mylist;
    }

    public boolean updateUser(User ur) throws Exception {
        sql = "update user set username=?,name=?,email=?,psassword=?,pno=? where username=?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ur.setUsername(rs.getString(1));
        ur.setName(rs.getString(2));
        ur.setEmail(rs.getString(3));
        ur.setPassword(rs.getString(4));
        ur.setPno(rs.getString(5));
        ur.setUsername(rs.getString(6));

        return ps.executeUpdate() > 0;
    }
}
