package com.deliciousfoods.servlet;

import com.deliciousfoods.model.User;
import com.deliciousfoods.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
User user = (session != null) ? (User) session.getAttribute("user") : null;

if (user == null) {
    response.sendRedirect("login.jsp?error=Please login first");
    return;
}

        List<Map<String, Object>> orders = new ArrayList<>();

        String sql =
                "SELECT id, customer_name, customer_phone, customer_address, " +
                "payment_method, grand_total, status, created_at " +
                "FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, user.getId());

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();

                    row.put("id", rs.getInt("id"));
                    row.put("customerName", rs.getString("customer_name"));
                    row.put("phone", rs.getString("customer_phone"));
                    row.put("address", rs.getString("customer_address"));
                    row.put("payment", rs.getString("payment_method"));
                    row.put("total", rs.getDouble("grand_total"));
                    row.put("status", rs.getString("status"));
                    row.put("createdAt", rs.getTimestamp("created_at"));

                    orders.add(row);
                }
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("my-orders.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}