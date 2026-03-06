package com.OceanViewResort.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Dao.RoomTypeDAO;
import com.OceanViewResort.Model.RoomTypeBean;


@WebServlet("/RoomManagementServlet")
public class RoomManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
    RoomDAO roomDAO = new RoomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<RoomTypeBean> roomTypes = roomTypeDAO.getAllRoomTypes();
        request.setAttribute("roomTypes", roomTypes);
        RequestDispatcher rd = request.getRequestDispatcher("/Views/RoomsManagement.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("addRoom".equals(action)) {
            String roomNumber = request.getParameter("roomNumber");
            int roomTypeId = Integer.parseInt(request.getParameter("roomType"));
            boolean success = roomDAO.addRoom(roomNumber, roomTypeId);
            request.setAttribute("message", success ? "Room Added Successfully" : "Error Adding Room");

        } else if ("updatePrice".equals(action)) {
            int roomTypeId = Integer.parseInt(request.getParameter("roomType"));
            double newPrice = Double.parseDouble(request.getParameter("newPrice"));
            boolean success = roomTypeDAO.updatePrice(roomTypeId, newPrice);
            request.setAttribute("message", success ? "Price Updated" : "Error Updating Price");
        }

        doGet(request, response);
    }
}