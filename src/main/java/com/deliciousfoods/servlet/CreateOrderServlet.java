package com.deliciousfoods.servlet;

import com.deliciousfoods.model.User;
import com.deliciousfoods.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/create-order")
public class CreateOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
User user = (session != null) ? (User) session.getAttribute("user") : null;

if (user == null) {
    response.sendRedirect("login.jsp?error=Please login first");
    return;
}

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerAddress = request.getParameter("customerAddress");
            String paymentMethod = request.getParameter("paymentMethod");

            double subtotal = Double.parseDouble(request.getParameter("subtotal"));
            double tax = Math.round(subtotal * 0.15);
            double deliveryFee = subtotal > 0 ? 100 : 0;
            double grandTotal = subtotal + tax + deliveryFee;

            String orderSql =
                    "INSERT INTO orders " +
                    "(user_id, customer_name, customer_phone, customer_address, payment_method, " +
                    "subtotal, tax, delivery_fee, grand_total, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, user.getId());
                ps.setString(2, customerName);
                ps.setString(3, customerPhone);
                ps.setString(4, customerAddress);
                ps.setString(5, paymentMethod);
                ps.setDouble(6, subtotal);
                ps.setDouble(7, tax);
                ps.setDouble(8, deliveryFee);
                ps.setDouble(9, grandTotal);
                ps.setString(10, "Pending");

                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {

                    if (!keys.next()) {
                        con.rollback();
                        throw new ServletException("Order ID was not generated.");
                    }

                    int orderId = keys.getInt(1);

                    String[] productNames = request.getParameterValues("productName");
                    String[] flavours = request.getParameterValues("flavour");
                    String[] wrapOptions = request.getParameterValues("wrapOption");
                    String[] coldDrinks = request.getParameterValues("coldDrink");
                    String[] ketchupQtys = request.getParameterValues("ketchupQty");
                    String[] unitPrices = request.getParameterValues("unitPrice");
                    String[] quantities = request.getParameterValues("quantity");

                    if (productNames == null || productNames.length == 0) {
                        con.rollback();
                        response.sendRedirect("index.jsp?error=Cart is empty");
                        return;
                    }

                    String itemSql =
                            "INSERT INTO order_items " +
                            "(order_id, product_name, flavour, wrap_option, cold_drink, ketchup_qty, " +
                            "unit_price, quantity, item_total) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

                    try (PreparedStatement ips = con.prepareStatement(itemSql)) {

                        for (int i = 0; i < productNames.length; i++) {

                            double unit = Double.parseDouble(unitPrices[i]);
                            int qty = Integer.parseInt(quantities[i]);

                            ips.setInt(1, orderId);
                            ips.setString(2, productNames[i]);
                            ips.setString(3, flavours != null && i < flavours.length ? flavours[i] : "");
                            ips.setString(4, wrapOptions != null && i < wrapOptions.length ? wrapOptions[i] : "");
                            ips.setBoolean(5, coldDrinks != null && i < coldDrinks.length && "true".equalsIgnoreCase(coldDrinks[i]));
                            ips.setInt(6, ketchupQtys != null && i < ketchupQtys.length ? Integer.parseInt(ketchupQtys[i]) : 0);
                            ips.setDouble(7, unit);
                            ips.setInt(8, qty);
                            ips.setDouble(9, unit * qty);

                            ips.addBatch();
                        }

                        ips.executeBatch();
                    }

                    con.commit();

                    session.setAttribute("latestOrderId", orderId);
                    response.sendRedirect("order-success.jsp?orderId=" + orderId);
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}