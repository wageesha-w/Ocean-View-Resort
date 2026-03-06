package com.OceanViewResort.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.OceanViewResort.Dao.AdminDAO;
import com.OceanViewResort.Model.AdminBean;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET request → show login page
    	response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminBean admin = new AdminBean();
        admin.setUsername(username);
        admin.setPassword(password);

        AdminDAO dao = new AdminDAO();
        boolean isValid = dao.validateAdmin(admin);

        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin.getUsername());
            session.setAttribute("adminId", admin.getAdminId());

            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/Views/Login.jsp?error=invalid");
        }
    }
}