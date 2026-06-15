package com.deliciousfoods.servlet;

import com.deliciousfoods.model.User;
import com.deliciousfoods.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Please login first\"}");
            return;
        }

        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        String customerAddress = request.getParameter("customerAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        String subtotalStr = request.getParameter("total");
        String taxStr = request.getParameter("tax");
        String deliveryFeeStr = request.getParameter("deliveryFee");
        String grandTotalStr = request.getParameter("grandTotal");

        if (customerName == null || customerName.trim().isEmpty()
                || customerPhone == null || customerPhone.trim().isEmpty()
                || customerAddress == null || customerAddress.trim().isEmpty()
                || paymentMethod == null || paymentMethod.trim().isEmpty()) {

            response.getWriter().write("{\"status\":\"error\",\"message\":\"Customer details are required\"}");
            return;
        }

        try {
            double subtotal = Double.parseDouble(subtotalStr);
            double tax = Double.parseDouble(taxStr);
            double deliveryFee = Double.parseDouble(deliveryFeeStr);
            double grandTotal = Double.parseDouble(grandTotalStr);

            try (Connection con = DBConnection.getConnection()) {

                String sql =
                        "INSERT INTO orders " +
                        "(user_id, customer_name, customer_phone, customer_address, payment_method, subtotal, tax, delivery_fee, grand_total, status, created_at) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

                try (PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1, user.getId());
                    ps.setString(2, customerName);
                    ps.setString(3, customerPhone);
                    ps.setString(4, customerAddress);
                    ps.setString(5, paymentMethod);
                    ps.setDouble(6, subtotal);
                    ps.setDouble(7, tax);
                    ps.setDouble(8, deliveryFee);
                    ps.setDouble(9, grandTotal);
                    ps.setString(10, "PENDING");

                    ps.executeUpdate();
                }

                response.getWriter().write("{\"status\":\"success\",\"message\":\"Order placed successfully\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();

            String safeMessage = e.getMessage()
                    .replace("\\", "\\\\")
                    .replace("\"", "'")
                    .replace("\n", " ")
                    .replace("\r", " ");

            response.getWriter().write("{\"status\":\"error\",\"message\":\"" + safeMessage + "\"}");
        }
    }
}