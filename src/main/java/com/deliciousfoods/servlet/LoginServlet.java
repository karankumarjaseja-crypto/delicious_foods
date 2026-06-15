package com.deliciousfoods.servlet;

import com.deliciousfoods.dao.UserDAO;
import com.deliciousfoods.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            User user = new UserDAO().login(request.getParameter("email"), request.getParameter("password"));
            if (user == null) {
                response.sendRedirect("login.jsp?error=Invalid email or password");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("admin-dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect("login.jsp?error=Database error");
        }
    }
}
