package com.OceanViewResort.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Dao.RoomTypeDAO;
import com.OceanViewResort.Model.ReservationBean;
import com.OceanViewResort.Model.RoomTypeBean;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Room Types for availability dropdown ──────────────
        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        List<RoomTypeBean> roomTypes = roomTypeDAO.getAllRoomTypes();
        request.setAttribute("roomTypes", roomTypes);

        // ── Stat Cards ────────────────────────────────────────
        ReservationDAO resDAO = new ReservationDAO();

        request.setAttribute("totalReservations", resDAO.countByStatus(null));
        request.setAttribute("activeBookings",     resDAO.countByStatus("Confirmed"));
        request.setAttribute("todayCheckIns",      resDAO.countTodayCheckIns());
        request.setAttribute("totalRevenue",       resDAO.getTotalRevenue());

        // ── Recent 5 Reservations ─────────────────────────────
        List<ReservationBean> recent = resDAO.getRecentReservations(5);
        request.setAttribute("recentReservations", recent);

        RequestDispatcher rd = request.getRequestDispatcher("/Views/Dashboard.jsp");
        rd.forward(request, response);
    }
}