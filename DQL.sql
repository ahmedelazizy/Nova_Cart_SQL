/*
Mission 1 — Customer & Product Overview
1. Display all customers.
2. Display the product name, category, and current price for every product.
3. Display products whose current price is greater than 5000.
4. Display all customers ordered by join date, newest first.
5. Display the total number of customers

*/
--1
select * 
from Customer
--2
select ProductName , CategoryName , Price
from Product 
join category
ON Product.CategoryID = Category.CategoryID 
--3
SELECT ProductName , Price
from Product
where Price >5000
--4
select *
from Customer
order by joinDate desc
--5
select count(*) as 'total number of customers'
from Customer



/*
Mission 2 — Aggregation & Business Totals
1. Calculate the average current product price.
2. Display the highest and lowest current product prices.
3. Calculate the total available stock quantity.
4. Calculate the total amount recorded in Payments.
5. Display the number of orders for each order status.
6. Display the total payment amount for each payment method.
*/
--1
select avg(Price) as 'product prices'
from product
--2
select MAX(Price) as 'highest ' , MIN(Price) 'lowest'
from product
--3
select sum(StockQuantity) as 'available stock quantity'
from product
--4
select sum(PaymentAmount) ' total amount '
from Payment
--5
select count(*) , status
from [Order]
group by status
--6
select sum(PaymentAmount) ' total amount ' , PaymentMethod
from Payment
group by PaymentMethod

/*
Mission 3 — Order & Sales Analysis
1. Calculate the total sales amount for each order using quantity multiplied by the historical unit price.
2. Display only orders whose total sales exceed 5000.
3. Display each order together with the customer's name, order date, and status.
4. Display each order with its products, purchased quantities, and historical unit prices.
5. Display the total amount spent by each customer.
*/
--1
SELECT OrderID,SUM(Quantity * UnitPrice) AS TotalSalesAmount
FROM OrderItem
GROUP BY OrderID;
--2
SELECT OrderID , SUM(Quantity * UnitPrice) AS TotalSalesAmount
FROM OrderItem
GROUP BY OrderID
having SUM(Quantity * UnitPrice) = 5000
--3
SELECT 
    [Order].OrderID,
    Customer.FullName,
    [Order].OrderDate,
    [Order].Status
FROM [Order]
JOIN Customer
    ON [Order].CustomerID = Customer.CustomerID
--4
SELECT 
    [Order].OrderID,
    Product.ProductName,
    OrderItem.Quantity,
    OrderItem.UnitPrice
FROM [Order]
JOIN OrderItem
    ON [Order].OrderID = OrderItem.OrderID
JOIN Product
    ON OrderItem.ProductID = Product.ProductID
--5
SELECT 
    Customer.CustomerID,
    Customer.FullName,
    SUM(Payment.PaymentAmount) AS TotalSpent
FROM Customer
JOIN [Order]
    ON Customer.CustomerID = [Order].CustomerID
JOIN Payment
    ON [Order].OrderID = Payment.OrderID
GROUP BY 
    Customer.CustomerID,
    Customer.FullName
/*
Mission 4 — Reviews & Relationships
1. Display the number of reviews received by each product, including products with no reviews.
2. Display all reviews together with the customer name and product name.
3. Display customers who have placed at least one order.
4. Display products that have never been ordered.
5. Display products that have never received a review.
6. Display all customers and their number of orders, including customers who have never placed an
order.
*/

--1
select ProductName , count(ReviewID) as 'number of reviews'
from Product
left join Review
on Product.ProductID = Review.ProductID
group by ProductName

--2
select FullName , ProductName , Rating , Comment , ReviewDate
from Review
join Customer
on Review.CustomerID = Customer.CustomerID
join Product
on Review.ProductID = Product.ProductID

--3
select distinct FullName
from Customer
join [Order]
on Customer.CustomerID = [Order].CustomerID

--4
select ProductName
from Product
left join OrderItem
on Product.ProductID = OrderItem.ProductID
where OrderItem.ProductID is null

--5
select ProductName
from Product
left join Review
on Product.ProductID = Review.ProductID
where Review.ProductID is null

--6
select FullName , count(OrderID) as 'number of orders'
from Customer
left join [Order]
on Customer.CustomerID = [Order].CustomerID
group by FullName

/*
Mission 5 — Subqueries
1. Display customers who placed more orders than the average number of orders among customers
who placed at least one order.
2. Display products whose current price is above the average current product price.
3. Display customers whose total spending exceeds the average among customers who made at least one payment.
*/
--1
select FullName , count(OrderID) as 'number of orders'
from Customer
join [Order]
on Customer.CustomerID = [Order].CustomerID
group by FullName
having count(OrderID) > 
(
    select avg(number_of_orders)
    from
    (
        select count(OrderID) as number_of_orders
        from [Order]
        group by CustomerID
    ) as orders
)

--2
select ProductName , Price
from Product
where Price >
(
    select avg(Price)
    from Product
)

--3
select FullName , sum(PaymentAmount) as 'total spending'
from Customer
join [Order]
on Customer.CustomerID = [Order].CustomerID
join Payment
on [Order].OrderID = Payment.OrderID
group by FullName
having sum(PaymentAmount) >
(
    select avg(total_spending)
    from
    (
        select sum(PaymentAmount) as total_spending
        from Payment
        join [Order]
        on Payment.OrderID = [Order].OrderID
        group by CustomerID
    ) as spending
)
/*
Mission 6 — Common Table Expressions
1. Using a CTE, calculate total revenue by month.
2. Using a CTE, calculate total spending by customer and return only customers whose spending
exceeds 10000.
*/
--1
with monthly_revenue as
(
    select month([Order].OrderDate) as month_number,
           sum(OrderItem.Quantity * OrderItem.UnitPrice) as total_revenue
    from [Order]
    join OrderItem
    on [Order].OrderID = OrderItem.OrderID
    group by month([Order].OrderDate)
)
select *
from monthly_revenue
order by month_number

--2
with customer_spending as
(
    select Customer.CustomerID, FullName,
           sum(PaymentAmount) as total_spending
    from Customer
    join [Order]
    on Customer.CustomerID = [Order].CustomerID
    join Payment
    on [Order].OrderID = Payment.OrderID
    group by Customer.CustomerID, FullName
)
select *
from customer_spending
where total_spending > 10000
/*
Mission 7 — Window Functions
1. Rank customers by total spending using RANK(), highest spending first.
2. Rank products by total quantity sold using DENSE_RANK(), highest quantity first.
3. Display each payment together with the previous payment amount using LAG(), ordered by payment
date and payment ID.
4. Display a running total of payment amounts ordered by payment date and payment ID.
*/
--1
select Customer.CustomerID , FullName , sum(PaymentAmount) as 'total spending' ,
       RANK() over(order by sum(PaymentAmount) desc) as 'rank'
from Customer
join [Order]
on Customer.CustomerID = [Order].CustomerID
join Payment
on [Order].OrderID = Payment.OrderID
group by Customer.CustomerID , FullName


--2
select Product.ProductID , ProductName ,
       sum(Quantity) as 'total quantity sold' ,
       DENSE_RANK() over(order by sum(Quantity) desc) as 'rank'
from Product
join OrderItem
on Product.ProductID = OrderItem.ProductID
group by Product.ProductID , ProductName


--3
select PaymentID , PaymentDate , PaymentAmount ,
       LAG(PaymentAmount) over(order by PaymentDate , PaymentID) as 'previous payment'
from Payment


--4
select PaymentID , PaymentDate , PaymentAmount ,
       sum(PaymentAmount) over(order by PaymentDate , PaymentID) as 'running total'
from Payment
/*
Mission 8 — Views
1. Create a view named vw_revenue_by_month that displays monthly revenue.
2. Create a view named vw_best_selling_products that displays product name, total quantity sold, and
total revenue.
3. Create a view named vw_customer_summary that displays customer name, number of orders, and
total amount spent.
*/
--1
create view vw_revenue_by_month as
select month([Order].OrderDate) as month_number ,
       sum(OrderItem.Quantity * OrderItem.UnitPrice) as monthly_revenue
from [Order]
join OrderItem
on [Order].OrderID = OrderItem.OrderID
group by month([Order].OrderDate)


--2
create view vw_best_selling_products as
select Product.ProductName ,
       sum(OrderItem.Quantity) as total_quantity_sold ,
       sum(OrderItem.Quantity * OrderItem.UnitPrice) as total_revenue
from Product
join OrderItem
on Product.ProductID = OrderItem.ProductID
group by Product.ProductID , Product.ProductName


--3
create view vw_customer_summary as
select Customer.FullName ,
       count(distinct [Order].OrderID) as number_of_orders ,
       sum(Payment.PaymentAmount) as total_amount_spent
from Customer
left join [Order]
on Customer.CustomerID = [Order].CustomerID
left join Payment
on [Order].OrderID = Payment.OrderID
group by Customer.CustomerID , Customer.FullName


--4
select *
from vw_revenue_by_month

--5
select *
from vw_best_selling_products

--6
select *
from vw_customer_summary