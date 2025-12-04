/* ==========================================
   DATABASE INITIALIZATION
========================================== */
CREATE DATABASE IF NOT EXISTS vulnbank;
USE vulnbank;


/* ==========================================
   USERS TABLE (CUSTOMERS)
========================================== */
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* Customer accounts */
INSERT INTO users (username, password, email) VALUES
('alice', 'alice123', 'alice@example.com'),
('bob', 'bob123', 'bob@example.com'),
('john', 'john123', 'john@example.com');


/* ==========================================
   ADMINS TABLE (ADMIN PANEL ONLY)
========================================== */
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* Seed admin login */
INSERT INTO admins (username, password, email) VALUES
('admin', 'admin123', 'admin@gmail.com');


/* ==========================================
   ACCOUNTS TABLE
========================================== */
CREATE TABLE IF NOT EXISTS accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    balance DECIMAL(10,2) NOT NULL DEFAULT 1000.00,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO accounts (user_id, balance) VALUES
(1, 5000.00),
(2, 3000.00),
(3, 4500.00);


/* ==========================================
   TRANSACTIONS TABLE
========================================== */
CREATE TABLE IF NOT EXISTS transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    from_id INT NOT NULL,
    to_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    description VARCHAR(255) DEFAULT 'Transfer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_id) REFERENCES accounts(id),
    FOREIGN KEY (to_id) REFERENCES accounts(id)
);

INSERT INTO transactions (from_id, to_id, amount, description) VALUES
(1, 2, 150.00, 'Dinner split'),
(2, 1, 50.00, 'Refund'),
(1, 3, 20.00, 'Coffee payment');


/* ==========================================
   BLOGS TABLE
========================================== */
CREATE TABLE IF NOT EXISTS blogs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO blogs (title, content) VALUES
('Service updates', 'Monthly maintenance schedule and details.'),
('Security notices', 'Important announcements for customers.'),
('Welcome to Horizon Bank', 'We are glad to have you.');


/* ==========================================
   CONTACT MESSAGES TABLE
========================================== */
CREATE TABLE IF NOT EXISTS contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/* ==========================================
   LOGIN LOGS
========================================== */
CREATE TABLE IF NOT EXISTS login_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    ip_address VARCHAR(255),
    user_agent TEXT,
    success TINYINT(1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/* ==========================================
   PASSWORD RESET TOKENS
========================================== */
CREATE TABLE IF NOT EXISTS reset_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    expires_at DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
