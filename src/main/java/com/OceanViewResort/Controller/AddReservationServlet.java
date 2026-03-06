package com.OceanViewResort.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailUtil;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Dao.RoomTypeDAO;
import com.OceanViewResort.Model.ReservationBean;
import com.OceanViewResort.Model.RoomBean;
import com.OceanViewResort.Model.RoomTypeBean;

@WebServlet("/AddReservationServlet")
public class AddReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── GET: load room types + forward to Add Reservation page ──
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        List<RoomTypeBean> roomTypes = roomTypeDAO.getAllRoomTypes();
        request.setAttribute("roomTypes", roomTypes);

        RequestDispatcher rd = request.getRequestDispatcher("/Views/AddReservation.jsp");
        rd.forward(request, response);
    }

    // ── POST: save reservation ───────────────────────────────────
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ── Load available rooms for a selected type + dates ──
        if ("loadRooms".equals(action)) {

            int roomTypeId  = Integer.parseInt(request.getParameter("roomType"));
            String checkIn  = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");

            RoomDAO roomDAO = new RoomDAO();
            List<RoomBean> availableRooms = roomDAO.getAvailableRooms(roomTypeId, checkIn, checkOut);

            RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
            List<RoomTypeBean> roomTypes = roomTypeDAO.getAllRoomTypes();

            request.setAttribute("availableRooms", availableRooms);
            request.setAttribute("roomTypes", roomTypes);
            request.setAttribute("selectedRoomType", roomTypeId);
            request.setAttribute("selectedCheckIn", checkIn);
            request.setAttribute("selectedCheckOut", checkOut);

            RequestDispatcher rd = request.getRequestDispatcher("/Views/AddReservation.jsp");
            rd.forward(request, response);
            return;
        }

        // ── Save reservation ──────────────────────────────────────
        try {
            String guestName       = request.getParameter("guestName");
            String address         = request.getParameter("address");
            String contactNo       = request.getParameter("contactNo");
            String email           = request.getParameter("email");
            int    roomId          = Integer.parseInt(request.getParameter("roomId"));
            int    roomTypeId      = Integer.parseInt(request.getParameter("roomType"));
            Date   checkIn         = Date.valueOf(request.getParameter("checkIn"));
            Date   checkOut        = Date.valueOf(request.getParameter("checkOut"));
            String reservationType = request.getParameter("reservationType");

            ReservationBean res = new ReservationBean();
            res.setGuestName(guestName);
            res.setAddress(address);
            res.setContactNo(contactNo);
            res.setEmail(email);
            res.setRoomId(roomId);
            res.setRoomTypeId(roomTypeId);
            res.setCheckIn(checkIn);
            res.setCheckOut(checkOut);
            res.setReservationType(reservationType);

            // Calculate bill upfront
            ReservationDAO dao = new ReservationDAO();
            double bill = dao.calculateBill(checkIn, checkOut, roomTypeId);
            res.setTotalBill(bill);

            boolean success = dao.addReservation(res);

            if(success){

                String subject = "Booking Confirmation - Ocean View Resort";

                String body = "Dear " + guestName + ",\n\n"
                            + "Greetings from Ocean View Resort!\n\n"
                            + "Thank you for choosing to stay with us. We are pleased to confirm that your reservation has been successfully completed.\n\n"

                            + "🗓️ Reservation Details\n"
                            + "--------------------------------------------------\n"
                            + "Guest Name : " + guestName + "\n"
                            + "Room ID    : " + roomId + "\n"
                            + "Check-In   : " + checkIn + "\n"
                            + "Check-Out  : " + checkOut + "\n"
                            + "Total Bill : LKR " + bill + "\n"
                            + "--------------------------------------------------\n\n"

                            + "If you need to make any changes to your reservation or require additional assistance, please feel free to contact us.\n\n"
                            + "We look forward to welcoming you and hope you have a relaxing and enjoyable stay at Ocean View Resort.\n\n"

                            + "Warm Regards,\n"
                            + "Ocean View Resort\n\n"

                            + "📧 Contact Information\n"
                            + "--------------------------------------------------\n"
                            + "Address : Hilltop Building, 52 Park Rd, Galle, Sri Lanka\n"
                            + "Mobile  : +94 77 123 4567\n"
                            + "Landline: +94 91 765 4321\n"
                            + "Website : www.oceanviewresort.lk\n";

                EmailUtil.sendEmail(email, subject, body);

                request.setAttribute("message","Reservation saved successfully! Confirmation email sent.");

            }else{
                request.setAttribute("message","Error: Could not save reservation.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
        }

        doGet(request, response);
    }
}