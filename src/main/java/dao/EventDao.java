package dao;

import java.sql.*;
import java.util.*;
import connection.MyCon;
import model.Event;
import model.User;

public class EventDao {

    String sql;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String date = java.time.LocalDate.now().toString();
    int n = 0;

    public boolean insertEvent(Event e) {

        try {
            sql = "insert into create_event(e_name,e_desc,e_venue,e_type,e_startdate,e_enddate,e_seat,username,e_city) values (?,?,?,?,?,?,?,?,?)";
            con = MyCon.myConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, e.getE_name());
            ps.setString(2, e.getE_desc());
            ps.setString(3, e.getE_venue());
            ps.setString(4, e.getE_type());
            ps.setString(5, e.getE_startdate());
            ps.setString(6, e.getE_enddate());
            ps.setInt(7, e.getE_seat());
            ps.setString(8, e.getUsername());
            ps.setString(9, e.getE_city().toLowerCase());
            n = ps.executeUpdate();
            con.close();
        } catch (SQLException s) {
            System.out.println(s);
        }
        return n > 0;
    }

    public boolean joinEvent(String username, int eventId) {

        sql = "insert into event_join values(?,?)";
        con = MyCon.myConnection();
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setInt(2, eventId);
            n = ps.executeUpdate();
            con.close();
            return n > 0;
        } catch (SQLException e) {
            return false;
        }

    }

    public int bookedEventSeat(int eventId) {

        sql = "select count(*) from event_join where event_id=?";
        con = MyCon.myConnection();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int ceat=rs.getInt(1);
                con.close();
                return ceat;
            } else {
                return 0;
            }
        } catch (SQLException e) {
            return 0;
        }

    }

    public boolean leaveEvent(String username, int eventId) {

        sql = "delete from event_join where username = ? and event_id = ?";
        con = MyCon.myConnection();
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setInt(2, eventId);
            int n = ps.executeUpdate();
            con.close();
            return n > 0;
        } catch (Exception e) {
            return false;
        }

    }

    public boolean isJoinedEvent(String username, String eventId) {

        sql = "select * from event_join where username = ? and event_id = ?";
        con = MyCon.myConnection();
        boolean res = false;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, eventId);
            ResultSet rs = ps.executeQuery();
            res = rs.next();
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return !res;

    }

    public List<User> searchAttendeesByEventId(int eventId) {

        sql = "select user.username,name,email,pno from event_join,user where event_join.username = user.username and event_join.event_id = ?";
        con = MyCon.myConnection();
        List<User> mylist = new ArrayList<User>();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUsername(rs.getString(1));
                u.setName(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPno(rs.getString(4));
                mylist.add(u);

            }
            con.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return mylist;

    }

    public boolean deleteEvent(int event_id) throws Exception {

        sql = "delete from create_event where event_id=?";
        String sql2 = "delete from event_join where event_id=?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        PreparedStatement ps2 = con.prepareStatement(sql2);
        ps.setInt(1, event_id);
        ps2.setInt(1, event_id);
        n = ps.executeUpdate();
        int n2 = ps2.executeUpdate();
        con.close();
        return n > 0 && n2 > 0;
    }

    public Event searchEventByEventid(int event_id) throws Exception {
        sql = "select * from create_event where event_id =? and e_startdate >= ?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, event_id);
        ps.setString(2, date);
        rs = ps.executeQuery();
        Event ce = new Event();
        if (rs.next()) {
            ce.setEvent_id(rs.getInt(1));
            ce.setE_name(rs.getString(2));
            ce.setE_desc(rs.getString(3));
            ce.setE_venue(rs.getString(4));
            ce.setE_type(rs.getString(5));
            ce.setE_startdate(rs.getString(6));
            ce.setE_enddate(rs.getString(7));
            ce.setE_seat(rs.getInt(8));
            ce.setUsername(rs.getString(9));
            ce.setE_city(rs.getString(10));
        } else {
            ce = null;
        }
        con.close();
        return ce;
    }

    public List<Event> searchEventByEventCity(String e_city) throws Exception {
        sql = "select * from create_event where e_city =? and e_startdate >= ?";
        con = MyCon.myConnection();
        String city = e_city.toLowerCase();
        ps = con.prepareStatement(sql);
        ps.setString(1, city);
        ps.setString(2, date);
        rs = ps.executeQuery();
        List<Event> mylist = new ArrayList<Event>();
        while (rs.next()) {
            Event ce = new Event();
            ce.setEvent_id(rs.getInt(1));
            ce.setE_name(rs.getString(2));
            ce.setE_desc(rs.getString(3));
            ce.setE_venue(rs.getString(4));
            ce.setE_type(rs.getString(5));
            ce.setE_startdate(rs.getString(6));
            ce.setE_enddate(rs.getString(7));
            ce.setE_seat(rs.getInt(8));
            ce.setUsername(rs.getString(9));
            ce.setE_city(rs.getString(10));
            mylist.add(ce);
            ce = null;
        }
        con.close();
        return mylist;
    }

    public List<Event> searchEventByEventType(String e_type) throws Exception {
        List<Event> mylist = new ArrayList<Event>();
        sql = "select * from create_event where e_type =? and e_startdate >= ?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, e_type);
        ps.setString(2, date);
        rs = ps.executeQuery();
        while (rs.next()) {
            Event ce = new Event();
            ce.setEvent_id(rs.getInt(1));
            ce.setE_name(rs.getString(2));
            ce.setE_desc(rs.getString(3));
            ce.setE_venue(rs.getString(4));
            ce.setE_type(rs.getString(5));
            ce.setE_startdate(rs.getString(6));
            ce.setE_enddate(rs.getString(7));
            ce.setE_seat(rs.getInt(8));
            ce.setUsername(rs.getString(9));
            ce.setE_city(rs.getString(10));
            mylist.add(ce);
        }
        con.close();
        return mylist;
    }

    public List<Event> searchEventByEventTypeAndCity(String e_type, String e_city) throws Exception {
        List<Event> mylist = new ArrayList<Event>();
        sql = "select * from create_event where e_type =?  and e_city=? and e_startdate >= ?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, e_type);
        ps.setString(2, e_city);
        ps.setString(3, date);
        rs = ps.executeQuery();
        while (rs.next()) {
            Event ce = new Event();
            ce.setEvent_id(rs.getInt(1));
            ce.setE_name(rs.getString(2));
            ce.setE_desc(rs.getString(3));
            ce.setE_venue(rs.getString(4));
            ce.setE_type(rs.getString(5));
            ce.setE_startdate(rs.getString(6));
            ce.setE_enddate(rs.getString(7));
            ce.setE_seat(rs.getInt(8));
            ce.setUsername(rs.getString(9));
            ce.setE_city(rs.getString(10));
            mylist.add(ce);
        }
        con.close();
        return mylist;
    }

    public List<Event> searchAllEvent() throws Exception {
        sql = "select * from create_event where e_startdate >= ?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, date);
        rs = ps.executeQuery();
        List<Event> mylist = new ArrayList<Event>();
        while (rs.next()) {
            Event ce = new Event();
            ce.setEvent_id(rs.getInt(1));
            ce.setE_name(rs.getString(2));
            ce.setE_desc(rs.getString(3));
            ce.setE_venue(rs.getString(4));
            ce.setE_type(rs.getString(5));
            ce.setE_startdate(rs.getString(6));
            ce.setE_enddate(rs.getString(7));
            ce.setE_seat(rs.getInt(8));
            ce.setUsername(rs.getString(9));
            ce.setE_city(rs.getString(10));
            mylist.add(ce);
            ce = null;
        }
        con.close();
        return mylist;
    }

    public boolean updateEvent(Event ce) throws Exception {
        sql = "update create_event set e_name=?,e_desc=?,e_venue=?,e_type=?,e_startdate=?,e_enddate=?,e_seat=?,e_city=? where event_id=?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, ce.getE_name());
        ps.setString(2, ce.getE_desc());
        ps.setString(3, ce.getE_venue());
        ps.setString(4, ce.getE_type());
        ps.setString(5, ce.getE_startdate());
        ps.setString(6, ce.getE_enddate());
        ps.setInt(7, ce.getE_seat());
        ps.setString(8, ce.getE_city());
        ps.setInt(9, ce.getEvent_id());
        int n = 0;
        
        n = ps.executeUpdate();
        con.close();
        return n > 0;
    }

    public List<Event> searchAllByUser(String username) throws Exception {
        sql = "select * from create_event where username=? and e_startdate >= ?";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, date);
        rs = ps.executeQuery();
        List<Event> mylist = new ArrayList<Event>();
        while (rs.next()) {
            Event ce = new Event();
            ce.setEvent_id(rs.getInt(1));
            ce.setE_name(rs.getString(2));
            ce.setE_desc(rs.getString(3));
            ce.setE_venue(rs.getString(4));
            ce.setE_type(rs.getString(5));
            ce.setE_startdate(rs.getString(6));
            ce.setE_enddate(rs.getString(7));
            ce.setE_seat(rs.getInt(8));
            ce.setUsername(rs.getString(9));
            ce.setE_city(rs.getString(10));
            mylist.add(ce);
            ce = null;
        }
        con.close();
        return mylist;
    }

    public List<Event> searchAllByGoing(String username) throws Exception {
        sql = "select * from create_event where event_id in(select event_id from event_join where username=?)  and e_startdate >= ?;";
        con = MyCon.myConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, date);
        rs = ps.executeQuery();
        List<Event> mylist = new ArrayList<Event>();
        while (rs.next()) {
            Event ce = new Event();
            ce.setEvent_id(rs.getInt(1));
            ce.setE_name(rs.getString(2));
            ce.setE_desc(rs.getString(3));
            ce.setE_venue(rs.getString(4));
            ce.setE_type(rs.getString(5));
            ce.setE_startdate(rs.getString(6));
            ce.setE_enddate(rs.getString(7));
            ce.setE_seat(rs.getInt(8));
            ce.setUsername(rs.getString(9));
            ce.setE_city(rs.getString(10));
            mylist.add(ce);
            ce = null;
        }
        con.close();
        return mylist;
    }

}
