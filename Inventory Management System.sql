create database InventoryManagerDB;

-- Selecting the database
USE InventoryManagerDB;

-- Creating Brands table
CREATE TABLE Brands (
     bid INT AUTO_INCREMENT PRIMARY KEY,
     bname VARCHAR(20)
);


-- Creating inv_user table
CREATE TABLE inv_user (
    user_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(20),
    password VARCHAR(20),
    last_login TIMESTAMP,
    user_type VARCHAR(10)
);

-- Creating categories table
CREATE TABLE categories (
    cid INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(20)
);

CREATE TABLE Stores (
    sid INT AUTO_INCREMENT PRIMARY KEY,
    sname VARCHAR(50),
    address VARCHAR(100),
    mobno VARCHAR(15)
);

-- Creating product table
CREATE TABLE product (
    pid INT AUTO_INCREMENT PRIMARY KEY,
    cid INT,
    bid INT,
    sid INT,
    pname VARCHAR(20),
    p_stock INT,
    price DECIMAL(10, 2),
    added_date DATE,
    FOREIGN KEY (cid) REFERENCES Categories(cid),
    FOREIGN KEY (bid) REFERENCES Brands(bid),
    FOREIGN KEY (sid) REFERENCES Stores(sid)
);

-- Creating provides table
CREATE TABLE provides (
    bid INT,
    sid INT,
    discount INT,
    FOREIGN KEY (bid) REFERENCES Brands(bid),
    FOREIGN KEY (sid) REFERENCES stores(sid)
);

-- Creating customer_cart table
CREATE TABLE customer_cart (
    cust_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    mobno BIGINT
);

-- Creating select_product table
CREATE TABLE select_product (
    cust_id INT,
    pid INT,
    quantity INT,
    FOREIGN KEY (cust_id) REFERENCES customer_cart(cust_id),
    FOREIGN KEY (pid) REFERENCES product(pid)
);

-- Creating transaction table
CREATE TABLE transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    paid DECIMAL(10, 2),
    due DECIMAL(10, 2),
    gst DECIMAL(5, 2),
    discount DECIMAL(10, 2),
    payment_method VARCHAR(10),
    cart_id INT,
    FOREIGN KEY (cart_id) REFERENCES customer_cart(cust_id)
);

-- Creating invoice table
CREATE TABLE invoice (
    item_no INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(20),
    quantity INT,
    net_price DECIMAL(10, 2),
    transaction_id INT,
    FOREIGN KEY (transaction_id) REFERENCES transaction(id)
);

-- INSERT INTO BRANDS
INSERT INTO Brands VALUES (1, 'Apple');
INSERT INTO Brands VALUES (2, 'Samsung');
INSERT INTO Brands VALUES (3, 'Nike');
INSERT INTO Brands VALUES (4, 'Fortune');

-- Inserting into Categories Table
INSERT INTO Categories (category_name) VALUES ('Electronics');
INSERT INTO Categories (category_name) VALUES ('Clothing');
INSERT INTO Categories (category_name) VALUES ('Grocery');

-- Inserting into Stores Table:
INSERT INTO Stores (sname, address, mobno) VALUES ('Ram kumar', 'Katpadi vellore', 9999999999);
INSERT INTO Stores (sname, address, mobno) VALUES ('Rakesh kumar', 'Chennai', 8888555541);
INSERT INTO Stores (sname, address, mobno) VALUES ('Suraj', 'Haryana', 7777555541);

-- Inserting into Product Table:
INSERT INTO Product (cid, bid, sid, pname, p_stock, price, added_date) VALUES (1, 1, 1, 'IPHONE', 4, 45000.00, '2022-01-31');
INSERT INTO Product (cid, bid, sid, pname, p_stock, price, added_date) VALUES (1, 1, 1, 'Airpods', 3, 19000.00, '2022-01-27');
INSERT INTO Product (cid, bid, sid, pname, p_stock, price, added_date) VALUES (1, 1, 1, 'Smart Watch', 3, 19000.00, '2022-01-27');
INSERT INTO Product (cid, bid, sid, pname, p_stock, price, added_date) VALUES (2, 3, 2, 'Air Max', 6, 7000.00, '2022-01-27');
INSERT INTO Product (cid, bid, sid, pname, p_stock, price, added_date) VALUES (3, 4, 3, 'REFINED OIL', 6, 750.00, '2022-01-25');

-- Inserting into Provides Table:
INSERT INTO Provides (bid, sid, discount) VALUES (1, 1, 12);
INSERT INTO Provides (bid, sid, discount) VALUES (2, 2, 7);
INSERT INTO Provides (bid, sid, discount) VALUES (3, 3, 15);
INSERT INTO Provides (bid, sid, discount) VALUES (1, 2, 7);
INSERT INTO Provides (bid, sid, discount) VALUES (4, 2, 19);
INSERT INTO Provides (bid, sid, discount) VALUES (4, 3, 20);

-- Inserting into Customer_cart Table:
INSERT INTO Customer_cart (name, mobno) VALUES ('Ram', 9876543210);
INSERT INTO Customer_cart (name, mobno) VALUES ('Shyam', 7777777777);
INSERT INTO Customer_cart (name, mobno) VALUES ('Mohan', 7777777775);

-- Inserting into Select_product Table:
INSERT INTO Select_product (cust_id, pid, quantity) VALUES (1, 2, 2);
INSERT INTO Select_product (cust_id, pid, quantity) VALUES (1, 3, 1);
INSERT INTO Select_product (cust_id, pid, quantity) VALUES (2, 3, 3);
INSERT INTO Select_product (cust_id, pid, quantity) VALUES (3, 2, 1);

-- Inserting into Transaction Table:
INSERT INTO Transaction (total_amount, paid, due, gst, discount, payment_method, cart_id) VALUES (57000, 20000, 5000, 350, 350, 'card', 1);
INSERT INTO Transaction (total_amount, paid, due, gst, discount, payment_method, cart_id) VALUES (19000, 17000, 2000, 190, 190, 'cash', 2);
INSERT INTO Transaction (total_amount, paid, due, gst, discount, payment_method, cart_id) VALUES (19000, 17000, 2000, 190, 190, 'cash', 3);

-- PL/SQL Function:
DELIMITER //

CREATE FUNCTION get_cart(c_id INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN c_id;
END //

DELIMITER ;

-- PL/SQL Procedure:
DELIMITER //

CREATE PROCEDURE check_stock(IN x INT)
BEGIN
    IF x < 2 THEN
        SELECT 'Stock is Less';
    ELSE
        SELECT 'Stock is Sufficient';
    END IF;
END //

DELIMITER ;

