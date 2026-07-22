use pizza;
-- 1) Total Revenue:

SELECT
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales;

-- 2) Average Order Value:
SELECT
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Average_Order_Value
FROM pizza_sales;

-- 3) Total Pizza sold:
SELECT
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

-- 4. Total Orders:
SELECT
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT
    ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS Average_Pizzas_Per_Order
FROM pizza_sales;

-- 1. Daily Trend for Total Orders:
SELECT
    DAYNAME(order_date) AS day_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date),
         DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);

-- 2. Monthly Trend for Total Orders:
SELECT
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- 3. Percentage of Sales by Pizza Category:
SELECT
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND(SUM(total_price) * 100 /
          (SELECT SUM(total_price) FROM pizza_sales), 2) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_sales DESC;

-- 4. Percentage of Sales by Pizza Size:
SELECT
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND((SUM(total_price) * 100) /
          (SELECT SUM(total_price) FROM pizza_sales), 2) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_sales DESC;

-- 5. Total Pizzas Sold by Pizza Category:
SELECT
    pizza_category,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;

-- 6. Top 5 Best Sellers by Revenue:
SELECT
    pizza_name,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 7) Top 5 Best Sellers by Quantity:
SELECT
    pizza_name,
    SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;

-- 8) Top 5 Best Sellers by Total Orders:
SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

-- 9. Bottom 5 Sellers by Revenue
SELECT
    pizza_name,
    ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

-- 10) Bottom 5 Sellers by Quantity:
SELECT
    pizza_name,
    SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC
LIMIT 5;

-- 11) Bottom 5 Sellers by Total Orders:
SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5;