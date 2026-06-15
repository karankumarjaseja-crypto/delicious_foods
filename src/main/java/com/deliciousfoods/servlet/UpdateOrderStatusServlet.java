package com.deliciousfoods.servlet;

import com.deliciousfoods.model.User;
import com.deliciousfoods.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/update-order-status")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;

        try (PrintWriter out = response.getWriter()) {

            if (user == null || !"ADMIN".equals(user.getRole())) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\":false,\"message\":\"Admin login required\"}");
                return;
            }

            String orderIdParam = request.getParameter("orderId");
            String status = request.getParameter("status");

            if (orderIdParam == null || orderIdParam.trim().isEmpty()
                    || status == null || status.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Missing orderId or status\"}");
                return;
            }

            int orderId = Integer.parseInt(orderIdParam);

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                         "UPDATE orders SET status=? WHERE id=?")) {

                ps.setString(1, status);
                ps.setInt(2, orderId);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    out.print("{\"success\":true,\"status\":\"" + escapeJson(status) + "\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"success\":false,\"message\":\"Order not found\"}");
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}