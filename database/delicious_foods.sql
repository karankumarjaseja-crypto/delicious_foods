CREATE DATABASE IF NOT EXISTS delicious_foods;
USE delicious_foods;

-- =========================
-- USERS TABLE (UPDATED)
-- =========================
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(30) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('USER','ADMIN') DEFAULT 'USER',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- PRODUCTS TABLE (UPDATED)
-- =========================
CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  base_price DECIMAL(10,2) NOT NULL,
  image_name VARCHAR(120),
  description TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  stock INT DEFAULT 100
);

-- =========================
-- PRODUCT FLAVOURS
-- =========================
CREATE TABLE IF NOT EXISTS product_flavours (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  flavour_name VARCHAR(100) NOT NULL,
  extra_price DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- =========================
-- ORDERS TABLE (UPGRADED)
-- =========================
CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NULL,
  customer_name VARCHAR(100) NOT NULL,
  customer_phone VARCHAR(30) NOT NULL,
  customer_address TEXT NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  tax DECIMAL(10,2) NOT NULL,
  delivery_fee DECIMAL(10,2) NOT NULL,
  grand_total DECIMAL(10,2) NOT NULL,

  status ENUM('PENDING','CONFIRMED','PREPARING','OUT_FOR_DELIVERY','DELIVERED','CANCELLED') DEFAULT 'PENDING',
  payment_status ENUM('UNPAID','PAID','FAILED') DEFAULT 'UNPAID',

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- =========================
-- ORDER ITEMS
-- =========================
CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  flavour VARCHAR(100),
  wrap_option VARCHAR(100),
  cold_drink BOOLEAN DEFAULT FALSE,
  ketchup_qty INT DEFAULT 0,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL,
  item_total DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- =========================
-- LOG TABLES
-- =========================
CREATE TABLE IF NOT EXISTS order_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  old_status VARCHAR(50),
  new_status VARCHAR(50),
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  action VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- INDEXING (PERFORMANCE)
-- =========================
CREATE INDEX idx_order_user ON orders(user_id);
CREATE INDEX idx_order_status ON orders(status);

-- =========================
-- TRIGGERS
-- =========================

DELIMITER $$

-- ORDER INSERT AUTO STATUS
CREATE TRIGGER trg_order_status
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    SET NEW.status = 'PENDING';
END $$

-- ORDER UPDATE LOG
CREATE TRIGGER trg_order_update_log
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_logs(order_id, old_status, new_status)
    VALUES (OLD.id, OLD.status, NEW.status);
END $$

-- USER REGISTER LOG
CREATE TRIGGER trg_user_register
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO user_logs(user_id, action)
    VALUES (NEW.id, 'USER REGISTERED');
END $$

DELIMITER ;

-- =========================
-- SAMPLE DATA
-- =========================

INSERT INTO users(full_name,email,phone,password_hash,role)
VALUES('Admin','admin@deliciousfoods.com','03002386639',
'240be518fabd2724b246a1dee660ff15421156297950b4e020428d1e5df0f0d0','ADMIN')
ON DUPLICATE KEY UPDATE email=email;

INSERT INTO products(name,category,base_price,image_name,description) VALUES
('Pizza','pizza',799,'pizza.png','Loaded cheesy vegetarian pizza'),
('Burger','burger',399,'burger.png','Fresh burger with crispy patty'),
('Fries','fries',199,'fries.png','Golden crispy fries'),
('Roll','roll',345,'roll.png','Delicious roll'),
('Pasta','pasta',449,'pasta.png','Creamy pasta'),
('Sandwich','sandwich',299,'sandwich.png','Grilled sandwich'),
('Biryani','biryani',349,'biryani.png','Aromatic veg biryani'),
('Manchurian','chinese',379,'manchurian.png','Spicy manchurian'),
('Veg Chowmin','chinese',179,'veg-chowmin.png','Veg chowmin'),
('Daal','daal',229,'daal.png','Homemade daal'),
('Chocolate Cake','cake',299,'cake.png','Chocolate cake')
ON DUPLICATE KEY UPDATE name=name;





/* order log table query which was added in php admin direct
CREATE TABLE order_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); */

/*Trriggers query
DELIMITER $$

CREATE TRIGGER after_order_status_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO order_logs(order_id, old_status, new_status)
        VALUES (OLD.id, OLD.status, NEW.status);
    END IF;
END $$

DELIMITER ; */