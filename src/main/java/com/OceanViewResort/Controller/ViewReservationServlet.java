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
import com.OceanViewResort.Model.ReservationBean;

@WebServlet("/ViewReservationServlet")
public class ViewReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── GET: load all reservations (or filtered) ─────────────────
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReservationDAO dao = new ReservationDAO();

        String keyword    = request.getParameter("search");
        String statusFilter = request.getParameter("statusFilter");

        List<ReservationBean> reservations;

        if (keyword != null && !keyword.trim().isEmpty()) {
            reservations = dao.searchReservations(keyword.trim());
            request.setAttribute("keyword", keyword);

        } else if (statusFilter != null && !statusFilter.isEmpty()
                   && !"All".equals(statusFilter)) {
            reservations = dao.getReservationsByStatus(statusFilter);
            request.setAttribute("statusFilter", statusFilter);

        } else {
            reservations = dao.getAllReservations();
        }

        request.setAttribute("reservations", reservations);

        RequestDispatcher rd = request.getRequestDispatcher("/Views/ViewReservation.jsp");
        rd.forward(request, response);
    }

    // ── POST: handle action buttons ──────────────────────────────
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action        = request.getParameter("action");
        int    reservationId = Integer.parseInt(request.getParameter("reservationId"));

        ReservationDAO dao = new ReservationDAO();
        boolean success    = false;
        String  message    = "";

        switch (action) {
            case "complete":
                success = dao.completeStay(reservationId);
                message = success ? "Stay completed and bill calculated."
                                  : "Error completing stay.";
                break;

            case "cancel":
                success = dao.updateStatus(reservationId, "Cancelled");
                message = success ? "Reservation cancelled."
                                  : "Error cancelling reservation.";
                break;

            default:
                message = "Unknown action.";
        }

        request.setAttribute("message", message);
        doGet(request, response);
    }
}