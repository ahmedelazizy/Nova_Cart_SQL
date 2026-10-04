

/* =========================================================
   1. RESET IDENTITY VALUES
   ========================================================= */

DBCC CHECKIDENT ('Customer', RESEED, 0);
DBCC CHECKIDENT ('Category', RESEED, 0);
DBCC CHECKIDENT ('Product', RESEED, 0);
DBCC CHECKIDENT ('Order', RESEED, 0);
DBCC CHECKIDENT ('Payment', RESEED, 0);
DBCC CHECKIDENT ('Review', RESEED, 0);
GO


/* =========================================================
   2. CUSTOMER - 10 Records
   ========================================================= */

INSERT INTO Customer
    (FullName, Email, Phone, Address, JoinDate)
VALUES
    ('Ahmed Hassan', 'ahmed.hassan@gmail.com', '01010000001', 'Zagazig', '2025-01-15'),
    ('Omar Ali', 'omar.ali@gmail.com', '01010000002', 'Cairo', '2025-02-10'),
    ('Youssef Mohamed', 'youssef.m@gmail.com', '01010000003', 'Alexandria', '2025-02-20'),
    ('Mariam Ahmed', 'mariam.ahmed@gmail.com', '01010000004', 'Mansoura', '2025-03-05'),
    ('Sara Khaled', 'sara.khaled@gmail.com', '01010000005', 'Tanta', '2025-03-18'),
    ('Karim Mostafa', 'karim.mostafa@gmail.com', '01010000006', 'Giza', '2025-04-02'),
    ('Nour Ibrahim', 'nour.ibrahim@gmail.com', '01010000007', 'Ismailia', '2025-04-15'),
    ('Adam Samir', 'adam.samir@gmail.com', '01010000008', 'Port Said', '2025-05-01'),
    ('Laila Mahmoud', 'laila.mahmoud@gmail.com', '01010000009', 'Cairo', '2025-05-20'),
    ('Hassan Tarek', 'hassan.tarek@gmail.com', '01010000010', 'Zagazig', '2025-06-10');
GO


/* =========================================================
   3. CATEGORY - 10 Records
   ========================================================= */

INSERT INTO Category
    (CategoryName)
VALUES
    ('Smartphones'),
    ('Laptops'),
    ('Fashion'),
    ('Home Appliances'),
    ('Books'),
    ('Accessories'),
    ('Gaming'),
    ('Audio'),
    ('Cameras'),
    ('Office Supplies');
GO


/* =========================================================
   4. PRODUCT - 10 Records
   ========================================================= */

INSERT INTO Product
    (ProductName, CategoryID, Price, StockQuantity)
VALUES
    ('Samsung Galaxy S25', 1, 34999.00, 25),
    ('iPhone 16', 1, 42999.00, 18),
    ('Lenovo IdeaPad 5', 2, 28999.00, 12),
    ('Nike Running Shoes', 3, 3499.00, 40),
    ('Philips Air Fryer', 4, 5999.00, 20),
    ('Clean Code Book', 5, 850.00, 30),
    ('Logitech Wireless Mouse', 6, 1299.00, 50),
    ('PlayStation 5 Controller', 7, 3999.00, 15),
    ('Sony WH-1000XM5', 8, 9999.00, 10),
    ('Canon EOS Camera', 9, 25999.00, 8);
GO


/* =========================================================
   5. ORDER - 10 Records
   ========================================================= */

INSERT INTO [Order]
    (CustomerID, OrderDate, Status)
VALUES
    (1, '2025-06-15', 'Delivered'),
    (1, '2025-07-03', 'Delivered'),
    (2, '2025-06-20', 'Shipped'),
    (2, '2025-07-10', 'Delivered'),
    (3, '2025-07-15', 'Pending'),
    (4, '2025-08-01', 'Delivered'),
    (5, '2025-08-12', 'Cancelled'),
    (6, '2025-08-20', 'Delivered'),
    (7, '2025-09-05', 'Shipped'),
    (8, '2025-09-18', 'Delivered');
GO


/* =========================================================
   6. ORDER ITEM - 16 Records
   ========================================================= */

INSERT INTO OrderItem
    (OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 34999.00),
    (1, 7, 2, 1299.00),

    (2, 4, 1, 3499.00),
    (2, 6, 2, 850.00),

    (3, 2, 1, 42999.00),
    (3, 7, 1, 1299.00),

    (4, 3, 1, 28999.00),
    (4, 9, 1, 9999.00),

    (5, 5, 1, 5999.00),

    (6, 1, 1, 34999.00),
    (6, 6, 1, 850.00),

    (7, 8, 1, 3999.00),

    (8, 4, 2, 3499.00),

    (9, 7, 1, 1299.00),
    (9, 9, 1, 9999.00),

    (10, 6, 3, 850.00);
GO


/* =========================================================
   7. PAYMENT - 10 Records
   ========================================================= */

INSERT INTO Payment
    (OrderID, PaymentDate, PaymentAmount, PaymentMethod)
VALUES
    (1, '2025-06-15', 37597.00, 'Credit Card'),
    (2, '2025-07-03', 5199.00, 'PayPal'),
    (3, '2025-06-20', 44298.00, 'Cash on Delivery'),
    (4, '2025-07-10', 38998.00, 'Credit Card'),
    (5, '2025-07-15', 5999.00, 'PayPal'),
    (6, '2025-08-01', 35849.00, 'Credit Card'),
    (7, '2025-08-12', 3999.00, 'Cash on Delivery'),
    (8, '2025-08-20', 6998.00, 'PayPal'),
    (9, '2025-09-05', 11298.00, 'Credit Card'),
    (10, '2025-09-18', 2550.00, 'Cash on Delivery');
GO


/* =========================================================
   8. REVIEW - 10 Records
   ========================================================= */

INSERT INTO Review
    (CustomerID, ProductID, Rating, Comment, ReviewDate)
VALUES
    (1, 1, 5, 'Excellent phone and very fast performance.', '2025-06-25'),
    (1, 7, 4, 'Good mouse and comfortable to use.', '2025-06-26'),

    (2, 2, 5, 'Great phone with excellent camera.', '2025-06-30'),
    (2, 7, 3, 'Good product but the buttons could be better.', '2025-07-05'),

    (3, 2, 4, 'Very good overall experience.', '2025-07-25'),

    (4, 3, 5, 'Excellent laptop for everyday work.', '2025-08-10'),

    (5, 5, 2, 'The product works but the experience was average.', '2025-08-20'),

    (6, 1, 4, 'Good performance and battery life.', '2025-08-15'),

    (7, 4, 3, 'Comfortable shoes but the size runs small.', '2025-09-10'),

    (8, 6, 1, 'The book was not what I expected.', '2025-09-25');
GO


/* =========================================================
   9. FINAL CHECK
   ========================================================= */

SELECT COUNT(*) AS Customers FROM Customer;
SELECT COUNT(*) AS Categories FROM Category;
SELECT COUNT(*) AS Products FROM Product;
SELECT COUNT(*) AS Orders FROM [Order];
SELECT COUNT(*) AS OrderItems FROM OrderItem;
SELECT COUNT(*) AS Payments FROM Payment;
SELECT COUNT(*) AS Reviews FROM Review;
GO