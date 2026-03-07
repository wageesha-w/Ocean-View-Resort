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
import com.OceanViewResort.Model.RoomBean;


@WebServlet("/CheckAvailabilityServlet")
public class CheckAvailabilityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

int roomTypeId =
Integer.parseInt(request.getParameter("roomType"));
String checkIn = request.getParameter("checkIn");
String checkOut = request.getParameter("checkOut");

RoomDAO dao = new RoomDAO();
List<RoomBean> rooms =
dao.getAvailableRooms(roomTypeId, checkIn, checkOut);

request.setAttribute("availableRooms", rooms);

RequestDispatcher rd =
request.getRequestDispatcher("/Views/Dashboard.jsp");
rd.forward(request, response);
}
}




