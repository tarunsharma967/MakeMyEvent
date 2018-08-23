/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.EventDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Event;

/**
 *
 * @author Tarun
 */
@WebServlet(name = "updateEvent", urlPatterns = {"/updateEvent"})
public class updateEvent extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            String  e_name, e_desc, e_type, e_startdate, e_enddate, e_venue, e_city, seat;
            int e_seat,eid;
                
            PrintWriter out = response.getWriter();
            Event ce = new Event();
            EventDao ed = new EventDao();
            
            e_name = request.getParameter("txtEventName");
            e_desc = request.getParameter("txtDesc");
            e_venue = request.getParameter("txtEventVenue");
            e_type = request.getParameter("txtEventType");
            e_startdate = request.getParameter("txtStartDate");
            e_enddate = request.getParameter("txtEndDate");
            seat = request.getParameter("txtMaxAtteendes");
            e_city = request.getParameter("txtEventCity");
            eid = Integer.parseInt(request.getParameter("id"));
            e_seat = Integer.parseInt(seat);
                
                ce.setE_name(e_name);
                ce.setE_desc(e_desc);
                ce.setE_venue(e_venue);
                ce.setE_type(e_type);
                ce.setE_startdate(e_startdate);
                ce.setE_enddate(e_enddate);
                ce.setE_seat(e_seat);
                ce.setE_city(e_city);
                ce.setEvent_id(eid);
                try 
                {
                    if (ed.updateEvent(ce)) {
                        response.sendRedirect("profile.jsp");
                    }
                } 
                catch(Exception e) 
                {
                    out.println(e);
                }
            }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
