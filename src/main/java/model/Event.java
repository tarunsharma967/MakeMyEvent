
package model;

import java.util.Date;

public class Event {

    
    String e_name,e_desc,e_venue,e_type,username,e_city;
    int e_seat,event_id;
    String e_startdate,e_enddate;

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    public String getE_name() {
        return e_name;
    }

    public void setE_name(String e_name) {
        this.e_name = e_name;
    }

    public String getE_desc() {
        return e_desc;
    }

    public void setE_desc(String e_desc) {
        this.e_desc = e_desc;
    }

    public String getE_venue() {
        return e_venue;
    }

    public void setE_venue(String e_venue) {
        this.e_venue = e_venue;
    }

    public String getE_type() {
        return e_type;
    }

    public void setE_type(String e_type) {
        this.e_type = e_type;
    }

    public String getE_startdate() {
        return e_startdate;
    }

    public void setE_startdate(String e_startdate) {
        this.e_startdate = e_startdate;
    }

    public String getE_enddate() {
        return e_enddate;
    }

    public void setE_enddate(String e_enddate) {
        this.e_enddate = e_enddate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    
    
    public int getE_seat() {
        return e_seat;
    }

    public void setE_seat(int e_seat) {
        this.e_seat = e_seat;
    }

    public String getE_city() {
        return e_city;
    }

    public void setE_city(String e_city) {
        this.e_city = e_city;
    }
    
}
