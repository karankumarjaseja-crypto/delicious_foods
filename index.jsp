<%@ page contentType="text/html;charset=UTF-8" isELIgnored="true" %>
<%@ page import="com.deliciousfoods.model.User" %>

<%
User user = null;

if (session != null && session.getAttribute("user") != null) {
    user = (User) session.getAttribute("user");
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
    
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Delicious Foods | Pure Vegetarian Food</title>
  <link rel="stylesheet" href="style.css" />

  <style>
    .promo-box,
    .order-status-box {
      margin: 18px;
      background: white;
      padding: 18px;
      border-radius: 14px;
      box-shadow: 0 6px 16px rgba(0,0,0,0.08);
    }

    .promo-box h3,
    .order-status-box h3 {
      color: #006b2f;
      margin-bottom: 12px;
    }

    .promo-row {
      display: flex;
      gap: 8px;
    }

    .promo-row input {
      flex: 1;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 10px;
    }

    .promo-row button {
      background: #00a651;
      color: white;
      border: none;
      border-radius: 10px;
      padding: 0 14px;
      font-weight: bold;
      cursor: pointer;
    }

    #promoMessage {
      margin-top: 8px;
      color: #006b2f;
      font-weight: bold;
      font-size: 13px;
    }

    .whatsapp-btn {
      display: block;
      margin: 10px 18px;
      padding: 14px;
      background: #25D366;
      color: white;
      text-align: center;
      border-radius: 12px;
      text-decoration: none;
      font-weight: bold;
    }

    .thankyou-modal {
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,.65);
      z-index: 9999;
      display: none;
      align-items: center;
      justify-content: center;
    }

    .thankyou-modal.active {
      display: flex;
    }

    .thankyou-box {
      background: white;
      padding: 40px;
      border-radius: 25px;
      text-align: center;
      animation: popThank .45s ease;
      max-width: 420px;
      width: 90%;
    }

    .checkmark {
      width: 75px;
      height: 75px;
      background: #00a651;
      color: white;
      border-radius: 50%;
      display: grid;
      place-items: center;
      font-size: 42px;
      margin: 0 auto 18px;
    }

    .thankyou-box h2 {
      color: #006b2f;
      margin-bottom: 10px;
    }

    .thankyou-box p {
      color: #667085;
      margin-bottom: 10px;
    }

    .thankyou-box button {
      margin-top: 20px;
      background: #00a651;
      color: white;
      border: none;
      padding: 13px 24px;
      border-radius: 25px;
      font-weight: bold;
      cursor: pointer;
    }

    .checkout-btn {
      border: none;
      cursor: pointer;
      width: calc(100% - 36px);
    }

    .side-user {
      display: block;
      margin: 18px;
      font-weight: bold;
      color: #006b2f;
    }

    .side-menu a {
      display: block;
      margin: 0 18px 10px;
      color: #0a0a0a;
      text-decoration: none;
    }

    .info-modal {
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,0.55);
      display: none;
      align-items: center;
      justify-content: center;
      z-index: 10000;
    }

    .info-modal.active {
      display: flex;
    }

    .info-box {
      background: white;
      padding: 28px;
      border-radius: 18px;
      max-width: 420px;
      width: 90%;
      position: relative;
    }

    .auth-close {
      position: absolute;
      top: 12px;
      right: 12px;
      background: transparent;
      border: none;
      font-size: 22px;
      cursor: pointer;
    }

    .notification {
      position: fixed;
      bottom: 18px;
      left: 50%;
      transform: translateX(-50%);
      background: #006b2f;
      color: white;
      padding: 12px 18px;
      border-radius: 12px;
      display: none;
      z-index: 10010;
      font-weight: bold;
    }

    .notification.show {
      display: block;
    }

    @keyframes popThank {
      from {
        transform: scale(.7);
        opacity: 0;
      }
      to {
        transform: scale(1);
        opacity: 1;
      }
    }
  </style>
</head>
<body>
<div class="page-loader" id="pageLoader">
  <div class="loader-circle"></div>
  <p>Loading Delicious Foods...</p>
</div>

<header>
  <nav class="navbar" id="navbar">
    <div class="logo">Delicious <span>Foods</span></div>

    <ul class="nav-links" id="navLinks">
      <li><a href="#home" class="nav-link active">Home</a></li>
      <li><a href="#deals" class="nav-link">Deals</a></li>
      <li><a href="#menu" class="nav-link">Menu</a></li>
    </ul>

    <div class="nav-right">
      <button class="cart-btn" onclick="toggleCart()">Cart <span id="cartCount">0</span></button>
      <button class="menu-btn" onclick="toggleSideMenu()">☰</button>
    </div>
  </nav>
</header>

<div class="side-menu" id="sideMenu">
  <div class="side-menu-header">
    <h2>Delicious Foods</h2>
    <button onclick="toggleSideMenu()">×</button>
  </div>

  <span class="side-user">Welcome <%= (user != null ? user.getFullName() : "Guest") %></span>
  <a href="logout">Logout</a>
  <a href="#about" onclick="sideNavigate(event, '#about')">About Us</a>
  <a href="#contact" onclick="sideNavigate(event, '#contact')">Contact</a>
  <a href="my-orders" onclick="toggleSideMenu()">My Orders</a>
  <a href="#" onclick="showInfoPage(event, 'Privacy Policy', 'We respect customer privacy and only use customer details for order processing.')">Privacy Policy</a>
  <a href="#" onclick="showInfoPage(event, 'Refund Policy', 'Refunds are processed only for cancelled or incorrect orders after restaurant verification.')">Refund Policy</a>
  <a href="#" onclick="showInfoPage(event, 'Terms & Conditions', 'Orders are subject to availability, delivery area, restaurant timing and confirmation.')">Terms & Conditions</a>
  <a href="#" onclick="showInfoPage(event, 'FAQ / Help', 'For help, contact us on WhatsApp: 03328888082 / 03078337665.')">FAQ / Help</a>
</div>

<section class="hero reveal" id="home">
  <div class="hero-content">
    <h1>Delicious Foods</h1>
    <h2>Pure Vegetarian Food</h2>
    <p>Fresh vegetarian meals, cakes, pizza, rolls, biryani, handi and more.</p>
    <a href="#menu" class="main-btn">Order Now</a>
  </div>
</section>

<section class="categories reveal">
  <h2>Our Categories</h2>
  <div class="category-buttons">
    <button class="active-filter" onclick="filterMenu('all', this)">All</button>
    <button onclick="filterMenu('pizza', this)">Pizza</button>
    <button onclick="filterMenu('burger', this)">Burgers</button>
    <button onclick="filterMenu('fries', this)">Fries</button>
    <button onclick="filterMenu('roll', this)">Rolls</button>
    <button onclick="filterMenu('pasta', this)">Pasta</button>
    <button onclick="filterMenu('sandwich', this)">Sandwich</button>
    <button onclick="filterMenu('biryani', this)">Biryani</button>
    <button onclick="filterMenu('chinese', this)">Chinese</button>
    <button onclick="filterMenu('daal', this)">Daal</button>
    <button onclick="filterMenu('cake', this)">Cakes</button>
  </div>
</section>

<section class="deals reveal" id="deals">
  <h2>Special Deals</h2>
  <div class="deal-cards" id="dealCards"></div>
</section>

<section class="menu reveal" id="menu">
  <h2>Our Menu</h2>
  <input type="text" id="searchInput" placeholder="Search food..." onkeyup="searchFood()" />
  <div class="cards" id="menuCards"></div>
</section>

<div class="food-modal" id="foodModal">
  <div class="food-modal-box">
    <button class="close-modal" onclick="closeFoodModal()">×</button>
    <img id="modalImage" alt="Food Image" />

    <div class="modal-content">
      <h2 id="modalTitle"></h2>
      <p id="modalDesc"></p>
      <h3>Rs. <span id="modalPrice"></span></h3>

      <label>Select Flavour / Option</label>
      <select id="flavourSelect"></select>

      <div id="wrapOptionBox" class="hidden">
        <label>Wrap It Your Way</label>
        <select id="wrapSelect">
          <option value="Wrap in Paratha" data-price="0">Wrap in Paratha</option>
          <option value="Wrap in Chapati" data-price="0">Wrap in Chapati</option>
          <option value="Wrap in Double Paratha" data-price="90">Wrap in Double Paratha + Rs.90</option>
        </select>
      </div>

      <label>Cold Drink</label>
      <select id="drinkSelect">
        <option value="0">No Cold Drink</option>
        <option value="100">Add Cold Drink + Rs.100</option>
      </select>

      <label>Extra Ketchup</label>
      <input type="number" id="ketchupQty" value="0" min="0" />
      <small>0 to 5 ketchup are free. After 5 ketchup Rs.5 per extra ketchup.</small>

      <div class="qty-row">
        <button onclick="changeFoodQty(-1)">−</button>
        <span id="foodQty">1</span>
        <button onclick="changeFoodQty(1)">+</button>
      </div>

      <button class="main-btn modal-cart-btn" onclick="addModalToCart()">Add To Cart</button>
    </div>
  </div>
</div>

<aside class="cart-sidebar" id="cartSidebar">
  <div class="cart-header">
    <h2>🛒 Your Cart</h2>
    <button onclick="toggleCart()">×</button>
  </div>

  <div id="cartItems"></div>

  <button class="add-more-btn" onclick="goToMenu()">+ Add more items</button>

  <div class="payment-box">
    <h3>Payment Method</h3>
    <label><input type="radio" name="payment" value="Cash on Delivery" checked> Cash on Delivery</label>
    <label><input type="radio" name="payment" value="EasyPaisa"> EasyPaisa</label>
    <label><input type="radio" name="payment" value="JazzCash"> JazzCash</label>
    <label><input type="radio" name="payment" value="Bank Transfer"> Bank Transfer</label>
    <div id="paymentDetails"></div>
  </div>

  <div class="customer-box">
    <h3>Customer Details</h3>
    <input type="text" id="customerName" placeholder="Your Full Name *">
    <input type="text" id="customerPhone" placeholder="Phone Number *">
    <input type="text" id="customerAltPhone" placeholder="Alternative Phone Number">
    <textarea id="customerAddress" placeholder="Complete Delivery Address *"></textarea>
    <input type="text" id="customerArea" placeholder="Area / Landmark *">
    <textarea id="customerNote" placeholder="Special Instructions"></textarea>
  </div>

  <div class="promo-box">
    <h3>Promo Code</h3>
    <div class="promo-row">
      <input type="text" id="promoCode" placeholder="Enter promo code">
      <button type="button" onclick="applyPromoCode()">Apply</button>
    </div>
    <p id="promoMessage"></p>
  </div>

  <div class="order-status-box">
    <h3>Your Order Status</h3>
    <p id="orderStatus">No order placed yet.</p>
  </div>

  <div class="bill-box">
    <p><span>Total</span> <strong>Rs. <span id="totalPrice">0</span></strong></p>
    <p><span>Tax 15%</span> <strong>Rs. <span id="taxPrice">0</span></strong></p>
    <p><span>Delivery Fee</span> <strong>Rs. <span id="deliveryFee">0</span></strong></p>
    <hr>
    <p class="grand-total"><span>Grand Total</span> <strong>Rs. <span id="grandTotal">0</span></strong></p>
  </div>

  <button class="checkout-btn" onclick="placeOrder()">Place Order →</button>
  <a class="whatsapp-btn" id="whatsappOrder" target="_blank">Order on WhatsApp</a>

  <p class="delivery-time">Your order will be delivered approximately in 60 minutes.</p>
</aside>

<div class="info-modal" id="infoModal">
  <div class="info-box">
    <button class="auth-close" onclick="closeInfo()">×</button>
    <h2 id="infoTitle"></h2>
    <p id="infoText"></p>
  </div>
</div>

<section class="about reveal" id="about">
  <h2>About Us</h2>
  <p>Delicious Foods is a pure vegetarian restaurant serving fresh, hygienic and tasty food with love.</p>
</section>

<section class="contact reveal" id="contact">
  <div class="contact-container">
    <h2>Contact Us</h2>

    <div class="contact-grid">
      <div class="contact-card">
        <div class="contact-icon">📍</div>
        <h3>Address</h3>
        <p>Garden East Bano Plaza, Karachi</p>
      </div>

      <div class="contact-card">
        <div class="contact-icon">⏰</div>
        <h3>Timings</h3>
        <p>3 PM to 1 AM</p>
      </div>

      <div class="contact-card">
        <div class="contact-icon">📞</div>
        <h3>Phone / WhatsApp</h3>
        <p>03328888082<br>03078337665</p>
      </div>

      <div class="contact-card">
        <div class="contact-icon">🌐</div>
        <h3>Social Media</h3>
        <p>
          <a href="https://facebook.com/deliciouscakefood" target="_blank">Facebook</a><br>
          <a href="https://instagram.com/delicious_bakecook" target="_blank">Instagram</a>
        </p>
      </div>
    </div>

    <a href="https://share.google/bqlfR6vKM3wR9n3Gh" target="_blank" class="location-btn">View Location</a>
  </div>
</section>

<footer>
  <p>© 2026 Delicious Foods. Pure Vegetarian Food.</p>
</footer>

<div class="thankyou-modal" id="thankyouModal">
  <div class="thankyou-box">
    <div class="checkmark">✓</div>
    <h2>Thank You!</h2>
    <p>Your order has been placed successfully.</p>
    <p>Status: Pending</p>
    <button onclick="closeThankyou()">Continue Shopping</button>
  </div>
</div>

<div id="notification" class="notification"></div>
<script>
let cart = [];
let freeDelivery = false;

function goToMenu() {
  const cartSidebar = document.getElementById("cartSidebar");
  const menu = document.getElementById("menu");

  if (cartSidebar) cartSidebar.classList.remove("active");
  if (menu) menu.scrollIntoView({ behavior: "smooth" });
}

function toggleCart() {
  const cartSidebar = document.getElementById("cartSidebar");
  if (!cartSidebar) return;
  cartSidebar.classList.toggle("active");
}

function toggleSideMenu() {
  const sideMenu = document.getElementById("sideMenu");
  if (!sideMenu) return;
  sideMenu.classList.toggle("active");
}

function sideNavigate(event, selector) {
  event.preventDefault();
  toggleSideMenu();
  const target = document.querySelector(selector);
  if (target) target.scrollIntoView({ behavior: "smooth" });
}

function filterMenu(category, button) {
  const buttons = document.querySelectorAll(".category-buttons button");
  buttons.forEach((btn) => btn.classList.remove("active-filter"));
  if (button) button.classList.add("active-filter");
}

function searchFood() {
  const searchTerm = document.getElementById("searchInput")?.value?.trim().toLowerCase();
  const cards = document.querySelectorAll(".cards .card");
  if (!cards) return;
  cards.forEach((card) => {
    const text = card.textContent.toLowerCase();
    card.style.display = text.includes(searchTerm) ? "block" : "none";
  });
}

function closeFoodModal() {
  document.getElementById("foodModal")?.classList.remove("active");
}

function changeFoodQty(delta) {
  const qtyEl = document.getElementById("foodQty");
  if (!qtyEl) return;
  let qty = Number(qtyEl.innerText || qtyEl.textContent || 1);
  qty = Math.max(1, qty + delta);
  qtyEl.innerText = qty;
}

function addModalToCart() {
  const foodName = document.getElementById("modalTitle")?.innerText;
  const foodPrice = Number(document.getElementById("modalPrice")?.innerText || 0);
  const flavour = document.getElementById("flavourSelect")?.value || "Default";
  const qty = Number(document.getElementById("foodQty")?.innerText || 1);

  if (!foodName || foodPrice <= 0) {
    alert("Please select a food item before adding to cart.");
    return;
  }

  cart.push({
    name: foodName,
    price: foodPrice,
    flavour: flavour,
    quantity: qty
  });

  updateCart();
  closeFoodModal();
  showNotification("Item added to cart");
}

function showInfoPage(event, title, text) {
  event.preventDefault();
  document.getElementById("infoTitle").innerText = title;
  document.getElementById("infoText").innerText = text;
  document.getElementById("infoModal")?.classList.add("active");
}

function closeInfo() {
  document.getElementById("infoModal")?.classList.remove("active");
}

function showNotification(message) {
  const notification = document.getElementById("notification");
  if (!notification) return;
  notification.innerText = message;
  notification.classList.add("show");
  setTimeout(() => {
    notification.classList.remove("show");
  }, 2500);
}

function applyPromoCode() {
  const codeEl = document.getElementById("promoCode");
  const promoMessage = document.getElementById("promoMessage");

  if (!codeEl || !promoMessage) return;

  const code = codeEl.value.trim().toUpperCase();

  if (code === "NEWUSER") {
    freeDelivery = true;
    promoMessage.innerText = "Promo applied! Free delivery unlocked.";
    promoMessage.style.color = "#006b2f";
  } else {
    freeDelivery = false;
    promoMessage.innerText = "Invalid promo code.";
    promoMessage.style.color = "red";
  }

  updateCart();
}

function validateOrderDetails() {
  const name = document.getElementById("customerName")?.value?.trim();
  const phone = document.getElementById("customerPhone")?.value?.trim();
  const address = document.getElementById("customerAddress")?.value?.trim();
  const area = document.getElementById("customerArea")?.value?.trim();

  if (typeof cart === "undefined") {
    alert("Cart error: reload page");
    return false;
  }

  if (cart.length === 0) {
    alert("Please add at least one item to cart.");
    return false;
  }

  if (!name || !phone || !address || !area) {
    alert("Please fill all required fields.");
    return false;
  }

  if (phone.length < 10) {
    alert("Please enter valid phone number.");
    return false;
  }

  return true;
}

function placeOrder() {
  if (!validateOrderDetails()) return;

  const modal = document.getElementById("thankyouModal");
  const status = document.getElementById("orderStatus");

  if (modal) modal.classList.add("active");
  if (status) status.innerText = "Order placed successfully. Status: Pending";

  if (typeof showNotification === "function") {
    showNotification("Order placed successfully!");
  }

  cart = [];
  updateCart();
}

function closeThankyou() {
  document.getElementById("thankyouModal")?.classList.remove("active");
  document.getElementById("cartSidebar")?.classList.remove("active");
  document.getElementById("menu")?.scrollIntoView({ behavior: "smooth" });
}

function updateCart() {
  const cartItems = document.getElementById("cartItems");
  const cartCount = document.getElementById("cartCount");
  const totalPrice = document.getElementById("totalPrice");
  const taxPrice = document.getElementById("taxPrice");
  const deliveryFee = document.getElementById("deliveryFee");
  const grandTotal = document.getElementById("grandTotal");
  const whatsappOrder = document.getElementById("whatsappOrder");

  if (!cartItems) return;

  cartItems.innerHTML = "";

  let total = 0;
  let itemCount = 0;
  let message = "Hello Delicious Foods, I want to order:%0A%0A";

  cart.forEach((item) => {
    const itemTotal = item.price * item.quantity;
    total += itemTotal;
    itemCount += item.quantity;

    cartItems.innerHTML += `
      <div class="cart-item">
        <div class="cart-item-top">
          <div>
            <h4>${item.name}</h4>
            <p>Flavour: ${item.flavour}</p>
            <strong>Rs. ${item.price} x ${item.quantity}</strong>
          </div>
        </div>
      </div>
    `;

    message += `${item.name} (${item.flavour}) x ${item.quantity} - Rs. ${itemTotal}%0A`;
  });

  const tax = Math.round(total * 0.15);
  const delivery = cart.length > 0 ? (freeDelivery ? 0 : 100) : 0;
  const finalTotal = total + tax + delivery;

  if (totalPrice) totalPrice.innerText = total;
  if (taxPrice) taxPrice.innerText = tax;
  if (deliveryFee) deliveryFee.innerText = delivery;
  if (grandTotal) grandTotal.innerText = finalTotal;
  if (cartCount) cartCount.innerText = itemCount;

  const paymentEl = document.querySelector('input[name="payment"]:checked');
  const paymentMethod = paymentEl ? paymentEl.value : "Cash on Delivery";

  if (whatsappOrder) {
    whatsappOrder.href =
      `https://wa.me/923328888082?text=${encodeURIComponent(message + "%0A%0ATotal: Rs. " + finalTotal)}`;
  }

  showPaymentDetails(paymentMethod);
}

function showPaymentDetails(paymentMethod) {
  const paymentDetails = document.getElementById("paymentDetails");
  if (!paymentDetails) return;

  if (paymentMethod === "EasyPaisa") {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>EasyPaisa Details</h4>
        <p><b>Number:</b> 03328888082</p>
      </div>
    `;
  } else if (paymentMethod === "JazzCash") {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>JazzCash Details</h4>
        <p><b>Number:</b> 03328888082</p>
      </div>
    `;
  } else if (paymentMethod === "Bank Transfer") {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>Bank Transfer</h4>
        <p>Contact WhatsApp for details</p>
      </div>
    `;
  } else {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>Cash on Delivery</h4>
      </div>
    `;
  }
}
</script>

</body>
</html>