<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Delicious Foods</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial, sans-serif;
        }

        body{
            background:#f4fff6;
            color:#102b16;
        }

        .admin-wrapper{
            display:flex;
            min-height:100vh;
        }

        .sidebar{
            width:270px;
            background:linear-gradient(180deg,#006b2f,#00a651);
            color:white;
            padding:30px 22px;
            position:fixed;
            top:0;
            left:0;
            height:100vh;
            box-shadow:8px 0 28px rgba(0,0,0,0.18);
        }

        .sidebar h2{
            font-size:28px;
            margin-bottom:8px;
        }

        .sidebar p{
            color:#caff9c;
            margin-bottom:35px;
        }

        .side-link{
            display:block;
            color:white;
            text-decoration:none;
            padding:14px 16px;
            border-radius:15px;
            margin-bottom:10px;
            font-weight:bold;
            transition:.3s;
        }

        .side-link:hover,
        .side-link.active{
            background:rgba(255,255,255,0.18);
            transform:translateX(7px);
        }

        .main{
            margin-left:270px;
            width:calc(100% - 270px);
            padding:35px;
        }

        .topbar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:30px;
        }

        .topbar h1{
            color:#006b2f;
            font-size:34px;
        }

        .logout-btn{
            background:#00a651;
            color:white;
            padding:12px 25px;
            border-radius:30px;
            text-decoration:none;
            font-weight:bold;
            box-shadow:0 10px 25px rgba(0,166,81,.25);
            transition:.3s;
        }

        .logout-btn:hover{
            background:#006b2f;
            transform:translateY(-3px);
        }

        .stats{
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
            gap:22px;
            margin-bottom:35px;
        }

        .stat-card{
            background:white;
            padding:25px;
            border-radius:24px;
            box-shadow:0 14px 32px rgba(0,0,0,0.10);
            transition:.35s;
            border:1px solid #e5f8ea;
            position:relative;
            overflow:hidden;
        }

        .stat-card::after{
            content:"";
            position:absolute;
            width:110px;
            height:110px;
            background:#e6ffed;
            border-radius:50%;
            right:-35px;
            top:-35px;
        }

        .stat-card:hover{
            transform:translateY(-10px) scale(1.03);
            box-shadow:0 22px 45px rgba(0,107,47,.20);
        }

        .stat-icon{
            font-size:36px;
            margin-bottom:15px;
            position:relative;
            z-index:2;
        }

        .stat-card h3{
            color:#667085;
            font-size:16px;
            margin-bottom:8px;
            position:relative;
            z-index:2;
        }

        .stat-card h2{
            color:#006b2f;
            font-size:30px;
            position:relative;
            z-index:2;
        }

        .table-card{
            background:white;
            border-radius:26px;
            padding:25px;
            box-shadow:0 14px 35px rgba(0,0,0,.10);
            overflow-x:auto;
        }

        .table-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:20px;
        }

        .table-header h2{
            color:#006b2f;
            font-size:26px;
        }

        .badge{
            background:#e8fff0;
            color:#006b2f;
            padding:9px 15px;
            border-radius:20px;
            font-weight:bold;
        }

        table{
            width:100%;
            border-collapse:collapse;
            min-width:850px;
        }

        th{
            background:#006b2f;
            color:white;
            padding:16px;
            text-align:left;
            font-size:15px;
        }

        th:first-child{
            border-radius:14px 0 0 14px;
        }

        th:last-child{
            border-radius:0 14px 14px 0;
        }

        td{
            padding:15px;
            border-bottom:1px solid #edf2ef;
            color:#102b16;
        }

        tr:hover{
            background:#f4fff6;
        }

        .status{
            display:inline-block;
            padding:8px 13px;
            border-radius:20px;
            background:#e8fff0;
            color:#006b2f;
            font-weight:bold;
            font-size:13px;
        }

        select{
            padding:9px 10px;
            border-radius:10px;
            border:1px solid #bdebc8;
            outline:none;
            background:white;
        }

        button{
            background:#00a651;
            color:white;
            border:none;
            padding:9px 15px;
            border-radius:10px;
            cursor:pointer;
            font-weight:bold;
            margin-left:6px;
            transition:.3s;
        }

        button:hover{
            background:#006b2f;
        }

        .empty{
            text-align:center;
            padding:35px;
            color:#667085;
            font-size:18px;
        }

        @media(max-width:768px){
            .admin-wrapper{
                flex-direction:column;
            }

            .sidebar{
                position:relative;
                width:100%;
                height:auto;
            }

            .main{
                margin-left:0;
                width:100%;
                padding:20px;
            }

            .topbar{
                flex-direction:column;
                align-items:flex-start;
                gap:15px;
            }
        }
    </style>
</head>

<body>

<%
    List<Map<String,Object>> orders =
            (List<Map<String,Object>>) request.getAttribute("orders");

    Object todaySaleObj = request.getAttribute("todaySale");
    Object monthSaleObj = request.getAttribute("monthSale");
    Object totalSaleObj = request.getAttribute("totalSale");
    Object totalOrdersObj = request.getAttribute("totalOrders");

    double todaySale = todaySaleObj == null ? 0 : (Double) todaySaleObj;
    double monthSale = monthSaleObj == null ? 0 : (Double) monthSaleObj;
    double totalSale = totalSaleObj == null ? 0 : (Double) totalSaleObj;
    int totalOrders = totalOrdersObj == null ? 0 : (Integer) totalOrdersObj;
%>

<div class="admin-wrapper">

    <aside class="sidebar">
        <h2>🍽 Delicious</h2>
        <p>Admin Control Panel</p>

        <a class="side-link active" href="admin-dashboard">Dashboard</a>
        <a class="side-link" href="#">Orders</a>
        <a class="side-link" href="#">Users</a>
        <a class="side-link" href="#">Menu Items</a>
        <a class="side-link" href="#">Deals</a>
        <a class="side-link" href="#">Reports</a>
        <a class="side-link" href="index.jsp">View Website</a>
        <a class="side-link" href="logout">Logout</a>
    </aside>

    <main class="main">

        <div class="topbar">
            <div>
                <h1>Admin Dashboard</h1>
                <p>Welcome to Delicious Foods management system</p>
            </div>

            <a class="logout-btn" href="logout">Logout</a>
        </div>

        <div class="stats">

            <div class="stat-card">
                <div class="stat-icon">🧾</div>
                <h3>Total Orders</h3>
                <h2><%= totalOrders %></h2>
            </div>

            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <h3>Today Sale</h3>
                <h2>Rs. <%= String.format("%.2f", todaySale) %></h2>
            </div>

            <div class="stat-card">
                <div class="stat-icon">📆</div>
                <h3>This Month Sale</h3>
                <h2>Rs. <%= String.format("%.2f", monthSale) %></h2>
            </div>

            <div class="stat-card">
                <div class="stat-icon">💰</div>
                <h3>Total Sale</h3>
                <h2>Rs. <%= String.format("%.2f", totalSale) %></h2>
            </div>

        </div>

        <div class="table-card">

            <div class="table-header">
                <h2>Recent Orders</h2>
                <span class="badge"><%= totalOrders %> Orders</span>
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Phone</th>
                    <th>Payment</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Update</th>
                </tr>

                <%
                if (orders != null && !orders.isEmpty()) {
                    for (Map<String,Object> o : orders) {
                %>

                <tr>
                    <td>#<%= o.get("id") %></td>
                    <td><%= o.get("customerName") %></td>
                    <td><%= o.get("phone") %></td>
                    <td><%= o.get("payment") %></td>
                    <td><b>Rs. <%= o.get("total") %></b></td>
                    <td>
    <span class="status" id="status-text-<%= o.get("id") %>">
        <%= o.get("status") %>
    </span>
</td>
                    <td>
                        <form class="status-form">
                            <input type="hidden" name="orderId" value="<%= o.get("id") %>">
                            <select name="status">
                                <option value="PENDING">PENDING</option>
                                <option value="CONFIRMED">CONFIRMED</option>
                                <option value="PREPARING">PREPARING</option>
                                <option value="OUT_FOR_DELIVERY">OUT_FOR_DELIVERY</option>
                                <option value="DELIVERED">DELIVERED</option>
                                <option value="CANCELLED">CANCELLED</option>
                            </select>
                            <button type="submit">Update</button>
                        </form>
                    </td>
                </tr>

                <%
                    }
                } else {
                %>

                <tr>
                    <td colspan="7" class="empty">No orders found yet.</td>
                </tr>

                <%
                }
                %>

            </table>
        </div>

    </main>
</div>
                <script>
document.querySelectorAll(".status-form").forEach(function(form) {

    form.addEventListener("submit", function(e) {

        e.preventDefault();

        const button = form.querySelector("button");
        const orderId = form.querySelector("input[name='orderId']").value;
        const status = form.querySelector("select[name='status']").value;

        const statusText =
            document.getElementById("status-text-" + orderId);

        button.disabled = true;
        button.innerText = "Updating...";

        fetch("update-order-status", {
            method: "POST",
            headers: {
                "Content-Type":
                "application/x-www-form-urlencoded"
            },
            body:
                "orderId=" + encodeURIComponent(orderId) +
                "&status=" + encodeURIComponent(status)
        })
        .then(response => response.json())
        .then(data => {

            if (data.success) {

                statusText.innerText = data.status;

                button.innerText = "Updated ✓";

                setTimeout(() => {
                    button.innerText = "Update";
                    button.disabled = false;
                }, 1200);

            } else {

                button.innerText = "Failed";

                setTimeout(() => {
                    button.innerText = "Update";
                    button.disabled = false;
                }, 1200);
            }
        })
        .catch(err => {

            console.error(err);

            button.innerText = "Failed";

            setTimeout(() => {
                button.innerText = "Update";
                button.disabled = false;
            }, 1200);
        });

    });

});
</script>

</body>
</html>