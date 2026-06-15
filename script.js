let cart = [];
let currentFood = null;
let modalQty = 1;
let freeDelivery = false;

const WHATSAPP_PRIMARY = "923328888082";
const WHATSAPP_SECONDARY = "03078337665";
console.log("SCRIPT LOADED SUCCESSFULLY");

const menuItems = [
  {
    name: "Pizza",
    category: "pizza",
    price: 799,
    image: "images/pizza.png",
    desc: "Loaded cheesy vegetarian pizza.",
    flavours: [
      "Afghani Pizza",
      "Fajita Pizza",
      "Tikka Pizza",
      "Cheese Lover Pizza",
      "Paneer Pizza",
      "Supreme Veg Pizza"
    ]
  },
  {
    name: "Burger",
    category: "burger",
    price: 399,
    image: "images/burger.png",
    desc: "Fresh burger with crispy patty, cheese and sauces.",
    flavours: [
      "Zinger Burger",
      "Crispy Burger",
      "Cheese Burger",
      "Jalapeno Burger",
      "BBQ Burger",
      "Double Patty Burger",
      "Veggie Burger"
    ]
  },
  {
    name: "Fries",
    category: "fries",
    price: 199,
    image: "images/fries.png",
    desc: "Golden crispy fries served hot.",
    flavours: [
      "Masala Fries",
      "Peri Peri Fries",
      "Loaded Fries",
      "Cheese Fries",
      "Mayo Garlic Fries",
      "BBQ Fries"
    ]
  },
  {
    name: "Roll",
    category: "roll",
    price: 345,
    image: "images/roll.png",
    desc: "Soft roll with delicious filling and sauces.",
    flavours: [
      "Chicken Malai Roll",
      "Chatni Roll",
      "Mayo Garlic Roll",
      "Afghani Roll",
      "Tikka Roll",
      "Spicy Roll"
    ],
    hasWrap: true
  },
  {
    name: "Pasta",
    category: "pasta",
    price: 449,
    image: "images/pasta.png",
    desc: "Creamy pasta with rich sauce.",
    flavours: [
      "Alfredo Pasta",
      "White Sauce Pasta",
      "Red Sauce Pasta",
      "Cheesy Pasta",
      "Creamy Mushroom Pasta"
    ]
  },
  {
    name: "Sandwich",
    category: "sandwich",
    price: 299,
    image: "images/sandwich.png",
    desc: "Grilled sandwich with fresh filling.",
    flavours: [
      "Club Sandwich",
      "Grilled Sandwich",
      "Cheese Sandwich",
      "Veggie Sandwich",
      "Mayo Sandwich"
    ]
  },
  {
    name: "Biryani",
    category: "biryani",
    price: 349,
    image: "images/biryani.png",
    desc: "Fresh aromatic veg biryani.",
    flavours: ["Veg Biryani", "Paneer Biryani", "Spicy Biryani", "Masala Biryani"]
  },
  {
    name: "Manchurian",
    category: "chinese",
    price: 379,
    image: "images/manchurian.png",
    desc: "Saucy and spicy veg Manchurian.",
    flavours: [
      "Veg Manchurian",
      "Garlic Manchurian",
      "Spicy Manchurian",
      "Schezwan Manchurian"
    ]
  },
  {
    name: "Veg Chowmin",
    category: "chinese",
    price: 179,
    image: "images/veg-chowmin.png",
    desc: "Fresh veg chowmin loaded with vegetables.",
    flavours: [
      "Veg Chowmin",
      "Schezwan Chowmin",
      "Garlic Chowmin",
      "Hot & Spicy Chowmin"
    ]
  },
  {
    name: "Daal",
    category: "daal",
    price: 229,
    image: "images/daal.png",
    desc: "Hot comforting daal with homely taste.",
    flavours: ["Daal Tadka", "Daal Fry", "Daal Makhani", "Simple Daal"]
  },
  {
    name: "Chocolate Fudge Cake",
    category: "cake",
    price: 299,
    image: "images/chocolate-fudge-cake.png",
    desc: "Rich and moist chocolate fudge cake.",
    flavours: ["Chocolate Fudge", "Double Chocolate", "Nutella Fudge", "Classic Chocolate"]
  }
];

const deals = [
  {
    name: "Pizza Deal",
    category: "deals",
    price: 1599,
    image: "images/pizza-deal.png",
    desc: "2 Large Pizzas + 1 Regular Fries + 1.5 Ltr Drink",
    flavours: [
      "Afghani Pizza",
      "Fajita Pizza",
      "Tikka Pizza",
      "Cheese Lover Pizza",
      "Paneer Pizza"
    ]
  },
  {
    name: "Burger Deal",
    category: "deals",
    price: 699,
    image: "images/burger-deal.png",
    desc: "2 Burgers + 1 Regular Fries + 2 Drinks",
    flavours: ["Zinger Burger", "Crispy Burger", "Cheese Burger", "Jalapeno Burger", "BBQ Burger"]
  },
  {
    name: "Family Deal",
    category: "deals",
    price: 1999,
    image: "images/family-deal.png",
    desc: "2 Medium Pizzas + 2 Burgers + 1 Large Fries + 1.5 Ltr Drink",
    flavours: [
      "Afghani Pizza + Zinger Burger",
      "Fajita Pizza + Cheese Burger",
      "Tikka Pizza + BBQ Burger",
      "Supreme Veg Pizza + Crispy Burger"
    ]
  },
  {
    name: "Friends Deal",
    category: "deals",
    price: 1199,
    image: "images/friends-deal.png",
    desc: "2 Burgers + 2 Fries + 2 Drinks",
    flavours: ["Zinger Burger", "Crispy Burger", "Cheese Burger", "BBQ Burger"]
  }
];

function renderMenu() {
  const menuCards = document.getElementById("menuCards");
  if (!menuCards) return;

  menuCards.innerHTML = menuItems
    .map(
      (item, index) => `
      <div class="card ${item.category}" data-name="${item.name.toLowerCase()}">
        <img src="${item.image}" class="food-image" alt="${item.name}">
        <h3>${item.name}</h3>
        <p>${item.desc}</p>
        <h4>Rs. ${item.price}</h4>
        <button class="plus-btn" onclick="openFoodModal(menuItems[${index}])">+</button>
      </div>
    `
    )
    .join("");
}

function renderDeals() {
  const dealCards = document.getElementById("dealCards");
  if (!dealCards) return;

  dealCards.innerHTML = deals
    .map(
      (deal, index) => `
      <div class="deal-card reveal">
        <img src="${deal.image}" alt="${deal.name}">
        <div class="deal-info">
          <h3>${deal.name}</h3>
          <p>${deal.desc}</p>
          <h4>Rs. ${deal.price}</h4>
          <button class="plus-btn" onclick="openFoodModal(deals[${index}])">+</button>
        </div>
      </div>
    `
    )
    .join("");
}

function toggleSideMenu() {
  document.getElementById("sideMenu")?.classList.toggle("active");
}

function toggleCart() {
  document.getElementById("cartSidebar")?.classList.toggle("active");
}

function goToMenu() {
  document.getElementById("cartSidebar")?.classList.remove("active");
  document.getElementById("menu")?.scrollIntoView({ behavior: "smooth" });
}

function showPageLoader() {
  document.getElementById("pageLoader")?.classList.add("show");
}

function hidePageLoader() {
  document.getElementById("pageLoader")?.classList.remove("show");
}

function sideNavigate(event, target) {
  event.preventDefault();
  showPageLoader();
  document.getElementById("sideMenu")?.classList.remove("active");

  setTimeout(() => {
    hidePageLoader();
    document.querySelector(target)?.scrollIntoView({ behavior: "smooth" });
  }, 650);
}

function showInfoPage(event, title, text) {
  if (event) event.preventDefault();

  showPageLoader();
  document.getElementById("sideMenu")?.classList.remove("active");

  setTimeout(() => {
    hidePageLoader();

    const infoTitle = document.getElementById("infoTitle");
    const infoText = document.getElementById("infoText");
    const infoModal = document.getElementById("infoModal");

    if (infoTitle) infoTitle.innerText = title;
    if (infoText) infoText.innerText = text;
    if (infoModal) infoModal.classList.add("active");
  }, 650);
}

function closeInfo() {
  document.getElementById("infoModal")?.classList.remove("active");
}

function openFoodModal(food) {
  if (!food) return;

  currentFood = food;
  modalQty = 1;

  const modal = document.getElementById("foodModal");
  const modalTitle = document.getElementById("modalTitle");
  const modalDesc = document.getElementById("modalDesc");
  const modalPrice = document.getElementById("modalPrice");
  const modalImage = document.getElementById("modalImage");
  const foodQty = document.getElementById("foodQty");
  const flavourSelect = document.getElementById("flavourSelect");
  const drinkSelect = document.getElementById("drinkSelect");
  const ketchupQty = document.getElementById("ketchupQty");
  const wrapOptionBox = document.getElementById("wrapOptionBox");

  modal?.classList.add("active");
  if (modalTitle) modalTitle.innerText = food.name;
  if (modalDesc) modalDesc.innerText = food.desc;
  if (modalPrice) modalPrice.innerText = food.price;
  if (modalImage) modalImage.src = food.image;
  if (foodQty) foodQty.innerText = modalQty;
  if (drinkSelect) drinkSelect.value = "0";
  if (ketchupQty) ketchupQty.value = "0";

  if (flavourSelect) {
    flavourSelect.innerHTML = `<option value="">Select flavour</option>`;
    food.flavours.forEach((flavour) => {
      flavourSelect.innerHTML += `<option value="${flavour}">${flavour}</option>`;
    });
  }

  if (food.hasWrap) {
    wrapOptionBox?.classList.remove("hidden");
  } else {
    wrapOptionBox?.classList.add("hidden");
  }
}

function closeFoodModal() {
  document.getElementById("foodModal")?.classList.remove("active");
}

function changeFoodQty(value) {
  modalQty += value;
  if (modalQty < 1) modalQty = 1;
  document.getElementById("foodQty").innerText = modalQty;
}

function addModalToCart() {
  if (!currentFood) {
    alert("No food selected.");
    return;
  }

  const flavour = document.getElementById("flavourSelect")?.value;
  if (!flavour) {
    alert("Please select flavour first.");
    return;
  }

  const drinkPrice = Number(document.getElementById("drinkSelect")?.value || 0);
  const ketchupQty = Number(document.getElementById("ketchupQty")?.value || 0);
  const ketchupCharge = ketchupQty > 5 ? (ketchupQty - 5) * 5 : 0;

  let wrapName = "";
  let wrapPrice = 0;
  if (currentFood.hasWrap) {
    const wrapSelect = document.getElementById("wrapSelect");
    if (wrapSelect) {
      wrapName = wrapSelect.value || "";
      wrapPrice = Number(wrapSelect.options[wrapSelect.selectedIndex]?.dataset.price || 0);
    }
  }

  const finalUnitPrice = currentFood.price + drinkPrice + ketchupCharge + wrapPrice;

  cart.push({
    name: currentFood.name,
    price: finalUnitPrice,
    quantity: modalQty,
    flavour,
    drinkPrice,
    ketchupQty,
    ketchupCharge,
    wrapName,
    wrapPrice
  });

  closeFoodModal();
  updateCart();
  document.getElementById("cartSidebar")?.classList.add("active");
  showNotification(`${currentFood.name} added to cart`);
}

function getOrderTotals() {
  let total = 0;
  let itemCount = 0;

  cart.forEach((item) => {
    total += item.price * item.quantity;
    itemCount += item.quantity;
  });

  const tax = Math.round(total * 0.15);
  const delivery = cart.length > 0 ? (freeDelivery ? 0 : 100) : 0;
  const finalTotal = total + tax + delivery;

  return { total, itemCount, tax, delivery, finalTotal };
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
  let message = "Hello Delicious Foods, I want to order:%0A%0A";

  cart.forEach((item, index) => {
    const itemTotal = item.price * item.quantity;
    cartItems.innerHTML += `
      <div class="cart-item">
        <div class="cart-item-top">
          <div>
            <h4>${item.name}</h4>
            <p>Flavour: ${item.flavour}</p>
            ${item.wrapName ? `<p>Wrap: ${item.wrapName} ${item.wrapPrice ? "+ Rs." + item.wrapPrice : ""}</p>` : ""}
            <p>Cold Drink: ${item.drinkPrice ? "Yes + Rs.100" : "No"}</p>
            <p>Extra Ketchup: ${item.ketchupQty} ${item.ketchupCharge ? "| Charge Rs." + item.ketchupCharge : "| Free"}</p>
            <strong>Rs. ${item.price} x ${item.quantity}</strong>
          </div>

          <div class="qty-box">
            <button onclick="decreaseQty(${index})">−</button>
            <span>${item.quantity}</span>
            <button onclick="increaseQty(${index})">+</button>
          </div>
        </div>

        <button class="remove-btn" onclick="removeItem(${index})">Remove</button>
      </div>
    `;

    message += `${index + 1}. ${item.name}%0A`;
    message += `Flavour: ${item.flavour}%0A`;
    if (item.wrapName) message += `Wrap: ${item.wrapName}%0A`;
    message += `Cold Drink: ${item.drinkPrice ? "Yes + Rs.100" : "No"}%0A`;
    message += `Extra Ketchup: ${item.ketchupQty} ${item.ketchupCharge ? "Charge Rs." + item.ketchupCharge : "Free"}%0A`;
    message += `Qty: ${item.quantity}%0A`;
    message += `Item Total: Rs. ${itemTotal}%0A%0A`;
  });

  const { total, itemCount, tax, delivery, finalTotal } = getOrderTotals();

  if (totalPrice) totalPrice.innerText = total;
  if (taxPrice) taxPrice.innerText = tax;
  if (deliveryFee) deliveryFee.innerText = delivery;
  if (grandTotal) grandTotal.innerText = finalTotal;
  if (cartCount) cartCount.innerText = itemCount;

  const paymentMethod = document.querySelector('input[name="payment"]:checked')?.value || "Cash on Delivery";
  const customerName = document.getElementById("customerName")?.value || "Not provided";
  const customerPhone = document.getElementById("customerPhone")?.value || "Not provided";
  const customerAltPhone = document.getElementById("customerAltPhone")?.value || "Not provided";
  const customerAddress = document.getElementById("customerAddress")?.value || "Not provided";
  const customerArea = document.getElementById("customerArea")?.value || "Not provided";
  const customerNote = document.getElementById("customerNote")?.value || "No instructions";

  message += `Customer Name: ${customerName}%0A`;
  message += `Customer Phone: ${customerPhone}%0A`;
  message += `Alternative Phone: ${customerAltPhone}%0A`;
  message += `Address: ${customerAddress}%0A`;
  message += `Area / Landmark: ${customerArea}%0A`;
  message += `Special Instructions: ${customerNote}%0A`;
  message += `Payment Method: ${paymentMethod}%0A`;
  message += `Promo Code: ${freeDelivery ? "NEWUSER - Free Delivery" : "None"}%0A%0A`;
  message += `Total: Rs. ${total}%0A`;
  message += `Tax 15%: Rs. ${tax}%0A`;
  message += `Delivery Fee: Rs. ${delivery}%0A`;
  message += `Grand Total: Rs. ${finalTotal}%0A%0A`;
  message += `Restaurant Numbers: 03328888082 / 03078337665`;

  if (whatsappOrder) {
    whatsappOrder.href = `https://wa.me/${WHATSAPP_PRIMARY}?text=${message}`;
  }

  showPaymentDetails();
}

function increaseQty(index) {
  if (!cart[index]) return;
  cart[index].quantity += 1;
  updateCart();
}

function decreaseQty(index) {
  if (!cart[index]) return;
  if (cart[index].quantity > 1) {
    cart[index].quantity -= 1;
  } else {
    cart.splice(index, 1);
  }
  updateCart();
}

function removeItem(index) {
  if (!cart[index]) return;
  cart.splice(index, 1);
  updateCart();
}

function applyPromoCode() {
  const promoInput = document.getElementById("promoCode");
  const promoMessage = document.getElementById("promoMessage");

  if (!promoInput || !promoMessage) return;

  const code = promoInput.value.trim().toUpperCase();
  if (code === "NEWUSER") {
    freeDelivery = true;
    promoMessage.innerText = "Promo applied! Free delivery unlocked.";
    promoMessage.style.color = "#006b2f";
    showNotification("Promo NEWUSER applied");
  } else {
    freeDelivery = false;
    promoMessage.innerText = "Invalid promo code.";
    promoMessage.style.color = "red";
  }

  updateCart();
}

function validateOrderDetails() {
  const name = document.getElementById("customerName")?.value.trim() || "";
  const phone = document.getElementById("customerPhone")?.value.trim() || "";
  const address = document.getElementById("customerAddress")?.value.trim() || "";
  const area = document.getElementById("customerArea")?.value.trim() || "";

  if (cart.length === 0) {
    alert("Please add at least one item to cart.");
    return false;
  }

  if (!name || !phone || !address || !area) {
    alert("Please fill all mandatory details: Name, Phone Number, Complete Address and Area / Landmark.");
    return false;
  }

  if (phone.length < 10) {
    alert("Please enter a valid phone number.");
    return false;
  }

  return true;
}

function placeOrder() {
  const loggedIn = window.isLoggedIn === true;
  if (!loggedIn) {
    alert("Please login first to place order");
    window.location.href = "login.jsp";
    return;
  }

  if (!validateOrderDetails()) return;

  const orderData = {
    customerName: document.getElementById("customerName")?.value || "",
    customerPhone: document.getElementById("customerPhone")?.value || "",
    customerAltPhone: document.getElementById("customerAltPhone")?.value || "",
    customerAddress: document.getElementById("customerAddress")?.value || "",
    customerArea: document.getElementById("customerArea")?.value || "",
    customerNote: document.getElementById("customerNote")?.value || "",
    paymentMethod: document.querySelector('input[name="payment"]:checked')?.value || "Cash on Delivery",
    promoCode: document.getElementById("promoCode")?.value || "",
    total: parseFloat(document.getElementById("totalPrice")?.textContent || "0"),
    tax: parseFloat(document.getElementById("taxPrice")?.textContent || "0"),
    deliveryFee: parseFloat(document.getElementById("deliveryFee")?.textContent || "0"),
    grandTotal: parseFloat(document.getElementById("grandTotal")?.textContent || "0"),
    itemsJson: JSON.stringify(cart)
  };

  fetch("place-order", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: new URLSearchParams(orderData)
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.status === "success") {
        document.getElementById("thankyouModal")?.classList.add("active");
        document.getElementById("orderStatus").innerText = "Order placed successfully. Status: Pending";
        cart = [];
        updateCart();
      } else {
        alert("Order failed: " + (data.message || "Unknown error"));
      }
    })
    .catch((error) => {
      alert("Error placing order: " + error);
    });
}

function closeThankyou() {
  document.getElementById("thankyouModal")?.classList.remove("active");
  document.getElementById("cartSidebar")?.classList.remove("active");
  document.getElementById("menu")?.scrollIntoView({ behavior: "smooth" });
}

function filterMenu(category, button) {
  const allCards = document.querySelectorAll("#menuCards .card");
  const categoryButtons = document.querySelectorAll(".category-buttons button");

  categoryButtons.forEach((btn) => btn.classList.remove("active-filter"));
  if (button) button.classList.add("active-filter");

  allCards.forEach((card) => {
    if (category === "all") {
      card.style.display = "block";
    } else {
      card.style.display = card.classList.contains(category) ? "block" : "none";
    }
  });
}

function searchFood() {
  const input = document.getElementById("searchInput")?.value.toLowerCase() || "";
  const cards = document.querySelectorAll("#menuCards .card");

  cards.forEach((card) => {
    const title = card.dataset.name || "";
    card.style.display = title.includes(input) ? "block" : "none";
  });
}

function showPaymentDetails() {
  const paymentMethod = document.querySelector('input[name="payment"]:checked')?.value || "Cash on Delivery";
  const paymentDetails = document.getElementById("paymentDetails");
  if (!paymentDetails) return;

  if (paymentMethod === "EasyPaisa") {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>EasyPaisa Details</h4>
        <p><b>Account Title:</b> Delicious Foods</p>
        <p><b>Number:</b> 03328888082</p>
        <p>Please send payment and share screenshot on WhatsApp.</p>
      </div>
    `;
  } else if (paymentMethod === "JazzCash") {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>JazzCash Details</h4>
        <p><b>Account Title:</b> Delicious Foods</p>
        <p><b>Number:</b> 03328888082</p>
        <p>Please send payment and share screenshot on WhatsApp.</p>
      </div>
    `;
  } else if (paymentMethod === "Bank Transfer") {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>Bank Transfer</h4>
        <p>Please contact restaurant for bank account details.</p>
        <p><b>WhatsApp:</b> 03328888082 / 03078337665</p>
      </div>
    `;
  } else {
    paymentDetails.innerHTML = `
      <div class="payment-details">
        <h4>Cash on Delivery</h4>
        <p>You will pay when your order is delivered.</p>
      </div>
    `;
  }
}

function showNotification(message) {
  const notification = document.getElementById("notification");
  if (!notification) return;

  notification.innerText = message;
  notification.classList.add("show");
  setTimeout(() => {
    notification.classList.remove("show");
  }, 2200);
}

function updateActiveLink() {
  const sections = document.querySelectorAll("section[id]");
  const navLinks = document.querySelectorAll(".nav-link");
  let current = "home";

  sections.forEach((section) => {
    const sectionTop = section.offsetTop - 130;
    if (window.scrollY >= sectionTop) {
      current = section.getAttribute("id");
    }
  });

  navLinks.forEach((link) => {
    link.classList.remove("active");
    if (link.getAttribute("href") === "#" + current) {
      link.classList.add("active");
    }
  });
}

window.addEventListener("scroll", () => {
  const navbar = document.getElementById("navbar");
  if (navbar) {
    if (window.scrollY > 50) navbar.classList.add("scrolled");
    else navbar.classList.remove("scrolled");
  }
  updateActiveLink();
});

document.addEventListener("change", (event) => {
  const idsToWatch = [
    "customerName",
    "customerPhone",
    "customerAltPhone",
    "customerAddress",
    "customerArea",
    "customerNote",
    "promoCode"
  ];

  if (event.target.name === "payment" || idsToWatch.includes(event.target.id)) {
    updateCart();
  }
});

document.addEventListener("keyup", (event) => {
  const idsToWatch = [
    "customerName",
    "customerPhone",
    "customerAltPhone",
    "customerAddress",
    "customerArea",
    "customerNote",
    "promoCode"
  ];

  if (idsToWatch.includes(event.target.id)) {
    updateCart();
  }
});

document.addEventListener("DOMContentLoaded", () => {
  renderMenu();
  renderDeals();
  updateCart();

  const revealElements = document.querySelectorAll(".reveal");
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("show");
        }
      });
    },
    { threshold: 0.15 }
  );

  revealElements.forEach((element) => observer.observe(element));
});