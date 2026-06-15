<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Orders | Delicious Foods</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<section>
    <h2>My Orders</h2>

    <%
        List<Map<String,Object>> orders =
                (List<Map<String,Object>>) request.getAttribute("orders");
    %>

    <div class="order-history-box">

        <%
        if (orders != null && !orders.isEmpty()) {
            for (Map<String,Object> o : orders) {
        %>

        <div class="my-order-card">
            <h3>Order #<%= o.get("id") %></h3>

            <div style="border:1px solid #ddd; padding:15px; margin-bottom:15px; border-radius:10px; background:#f9fff9;">

    <h3 style="color:#006b2f;">Order #<%= o.get("id") %></h3>

    <p><b>Status:</b> <span style="color:#d35400;"><%= o.get("status") %></span></p>

    <p><b>Total:</b> Rs. <%= o.get("total") %></p>

    <p><b>Payment:</b> <%= o.get("payment") %></p>

    <p><b>Phone:</b> <%= o.get("phone") %></p>

    <p><b>Address:</b> <%= o.get("address") %></p>

    <p><b>Date:</b>
        <%= o.get("createdAt").toString().substring(0, 19) %>
    </p>

</div>
        </div>

        <%
            }
        } else {
        %>

        <p style="text-align:center;">No orders found.</p>

        <%
        }
        %>

    </div>

    <div style="text-align:center;margin-top:25px;">
        <a href="index.jsp" class="main-btn">Back to Home</a>
    </div>
</section>
        <script>
setInterval(() => {
    location.reload();
}, 5000);
</script>

</body>
</html>