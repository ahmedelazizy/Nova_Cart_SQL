CREATE DATABASE NovaCart
GO

USE NovaCart
GO


--(1)--Customer

CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    JoinDate DATE NOT NULL
)

--(2)-- Category
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
)


--(3)--Product
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL,

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID),

    CONSTRAINT CHK_Product_Price
        CHECK (Price >= 0),

    CONSTRAINT CHK_Product_Stock
        CHECK (StockQuantity >= 0)
)


--(4)--- Order

CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,

    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID),

    CONSTRAINT CHK_Order_Status
        CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
)



---(5) OrderItem

CREATE TABLE OrderItem (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_OrderItem
        PRIMARY KEY (OrderID, ProductID),

    CONSTRAINT FK_OrderItem_Order
        FOREIGN KEY (OrderID)
        REFERENCES [Order](OrderID),

    CONSTRAINT FK_OrderItem_Product
        FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID),

    CONSTRAINT CHK_OrderItem_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CHK_OrderItem_UnitPrice
        CHECK (UnitPrice >= 0)
)


--(6)--  Payment

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,

    CONSTRAINT FK_Payment_Order
        FOREIGN KEY (OrderID)
        REFERENCES [Order](OrderID),

    CONSTRAINT CHK_Payment_Amount
        CHECK (PaymentAmount >= 0),

    CONSTRAINT CHK_Payment_Method
        CHECK (
            PaymentMethod IN (
                'Credit Card',
                'PayPal',
                'Cash on Delivery'
            )
        )
)


--(7)-- Review

CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT NOT NULL,
    Comment VARCHAR(1000),
    ReviewDate DATE NOT NULL,

    CONSTRAINT FK_Review_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID),

    CONSTRAINT FK_Review_Product
        FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID),

    CONSTRAINT CHK_Review_Rating
        CHECK (Rating BETWEEN 1 AND 5),

    CONSTRAINT UQ_Review_Customer_Product
        UNIQUE (CustomerID, ProductID)
)