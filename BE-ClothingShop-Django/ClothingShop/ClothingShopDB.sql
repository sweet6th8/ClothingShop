CREATE DATABASE ClothingShop;
USE ClothingShop;

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL UNIQUE,
	slug VARCHAR(200) NOT NULL UNIQUE,
    description TEXT
);


CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL UNIQUE,
    slug VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    price INT NOT NULL,
    images VARCHAR(255), 
    stock INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);

CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR
);

CREATE TABLE Order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT AUTO_INCREMENT,
    order_date TIMESTAMP,
    price INT NOT NULL,
    order_status ENUM, 
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

INSERT INTO Category (title, slug, description) VALUES
('Men\'s Clothing', 'mens-clothing', 'A variety of men\'s clothing including shirts, pants, and accessories.'),
('Women\'s Clothing', 'womens-clothing', 'A selection of women\'s clothing including dresses, tops, and skirts.'),
('Kids\' Clothing', 'kids-clothing', 'Clothing options for children of all ages.'),
('Footwear', 'footwear', 'Shoes, boots, sandals, and other footwear for all genders and ages.'),
('Accessories', 'accessories', 'A range of accessories including bags, hats, and jewelry.');

INSERT INTO Product (product_name, slug, description, price, images, stock, is_available, category_id) VALUES
('Men\'s T-Shirt', 'mens-t-shirt', 'A comfortable cotton t-shirt for men.', 19, 'images/mens_tshirt.jpg', 100, TRUE, 1),
('Women\'s Dress', 'womens-dress', 'A stylish summer dress for women.', 35, 'images/womens_dress.jpg', 50, TRUE, 2),
('Kids\' Hoodie', 'kids-hoodie', 'A warm hoodie for kids.', 25, 'images/kids_hoodie.jpg', 30, TRUE, 3),
('Running Shoes', 'running-shoes', 'Lightweight running shoes for all athletes.', 60, 'images/running_shoes.jpg', 70, TRUE, 4),
('Leather Handbag', 'leather-handbag', 'A high-quality leather handbag.', 80, 'images/leather_handbag.jpg', 20, TRUE, 5);

SELECT * FROM Category;
SELECT * FROM Product;


SHOW TABLES;
