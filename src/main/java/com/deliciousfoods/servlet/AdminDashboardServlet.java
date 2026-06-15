package com.deliciousfoods.servlet;

import com.deliciousfoods.model.User;
import com.deliciousfoods.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Admin login required");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            List<Map<String, Object>> orders = new ArrayList<>();

            String orderSql =
        "SELECT id, customer_name, customer_phone, payment_method, " +
        "grand_total, status, created_at " +
        "FROM orders " +
        "WHERE DATE(created_at) = CURDATE() " +
        "ORDER BY created_at DESC";

            try (PreparedStatement ps = con.prepareStatement(orderSql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();

                    row.put("id", rs.getInt("id"));
                    row.put("customerName", rs.getString("customer_name"));
                    row.put("phone", rs.getString("customer_phone"));
                    row.put("payment", rs.getString("payment_method"));
                    row.put("total", rs.getDouble("grand_total"));
                    row.put("status", rs.getString("status"));
                    row.put("createdAt", rs.getTimestamp("created_at"));

                    orders.add(row);
                }
            }

            double todaySale = 0;
            double monthSale = 0;
            double totalSale = 0;
            int totalOrders = 0;

            String todaySaleSql =
                    "SELECT IFNULL(SUM(grand_total),0) AS today_sale " +
                    "FROM orders WHERE DATE(created_at) = CURDATE()";

            try (PreparedStatement ps = con.prepareStatement(todaySaleSql);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    todaySale = rs.getDouble("today_sale");
                }
            }

            String monthSaleSql =
                    "SELECT IFNULL(SUM(grand_total),0) AS month_sale " +
                    "FROM orders " +
                    "WHERE MONTH(created_at) = MONTH(CURDATE()) " +
                    "AND YEAR(created_at) = YEAR(CURDATE())";

            try (PreparedStatement ps = con.prepareStatement(monthSaleSql);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    monthSale = rs.getDouble("month_sale");
                }
            }

            String totalSaleSql =
                    "SELECT IFNULL(SUM(grand_total),0) AS total_sale FROM orders";

            try (PreparedStatement ps = con.prepareStatement(totalSaleSql);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalSale = rs.getDouble("total_sale");
                }
            }

            String totalOrdersSql =
                    "SELECT COUNT(*) AS total_orders FROM orders";

            try (PreparedStatement ps = con.prepareStatement(totalOrdersSql);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalOrders = rs.getInt("total_orders");
                }
            }

            request.setAttribute("orders", orders);
            request.setAttribute("todaySale", todaySale);
            request.setAttribute("monthSale", monthSale);
            request.setAttribute("totalSale", totalSale);
            request.setAttribute("totalOrders", totalOrders);

            request.getRequestDispatcher("admin.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}