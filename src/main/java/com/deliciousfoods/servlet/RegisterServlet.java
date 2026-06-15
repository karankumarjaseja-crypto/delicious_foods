package com.deliciousfoods.servlet;

import com.deliciousfoods.dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!password.equals(confirmPassword)) {
                response.sendRedirect("register.jsp?error=Passwords do not match");
                return;
            }

            boolean ok = new UserDAO().register(fullName, email, phone, password);
            if (ok) response.sendRedirect("login.jsp?success=Registration successful");
            else response.sendRedirect("register.jsp?error=Registration failed");
        } catch (Exception e) {
            response.sendRedirect("register.jsp?error=Email already exists or database error");
        }
    }
}
