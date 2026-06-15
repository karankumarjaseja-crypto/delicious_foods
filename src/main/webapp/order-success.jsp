<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Order Success</title><link rel="stylesheet" href="style.css"></head>
<body>
<section class="about">
  <h2>Order Placed Successfully</h2>
  <p>Your order number is: <strong><%= request.getParameter("orderId") %></strong></p>
  <a class="main-btn" href="index.jsp">Back Home</a>
</section>
</body></html>
