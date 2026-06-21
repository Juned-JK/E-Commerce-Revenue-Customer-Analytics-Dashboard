create database ecommerce;
use ecommerce;

# 📊 Revenue Analysis
-- Total Revenue
select sum(Revenue) from ecommerce_data;

-- Monthly Revenue Trend
select `month`, sum(Revenue) from ecommerce_data group by `month`;

-- Quarterly Revenue Trend
select `Quarter`, sum(Revenue) from ecommerce_data group by `Quarter`;

-- Revenue by Country
select country, sum(Revenue) from ecommerce_data group by country;

-- Revenue by Product
select `Description`, sum(Revenue) from ecommerce_data group by `Description`;
--------------------------------------------------------------------------------------------------------------


# 🛒 Order Analysis
-- Total Orders
select count(distinct InvoiceNo) from ecommerce_data;

-- Average Order Value (AOV)
select avg(Revenue) from ecommerce_data;

-- Orders by Month
select `month`, Count(invoiceNo) from ecommerce_data group by `month`;

-- Orders by Country
select country, Count(invoiceNo) from ecommerce_data group by country;

-- Largest Single Order
select customerID, InvoiceNo, Country, `description`, Revenue from ecommerce_data where Revenue = (select max(Revenue) from ecommerce_data);
--------------------------------------------------------------------------------------------------------------


# 👥 Customer Analysis
-- Total Unique Customers
select count(distinct customerID) from ecommerce_data;

-- Top 10 Customers by Revenue
select customerId, country, Revenue from ecommerce_data order by Revenue desc limit 10;

-- Top 10 Customers by Number of Orders
select customerid, count(distinct invoiceNo) as number_of_orders from ecommerce_data group by customerid order by number_of_orders desc limit 10;

-- Average Customer Spend
select ROUND(SUM(Revenue) / COUNT(DISTINCT InvoiceNo), 2) as AVG_customer_spend from ecommerce_data;
--------------------------------------------------------------------------------------------------------------


# 📦 Product Analysis
-- Top 10 Products by Revenue
select `description`, sum(Revenue) as Total_Revenue from ecommerce_data group by `description` order by Total_Revenue desc limit 10;

-- Top 10 Products by Quantity Sold
select `description`, sum(Quantity) as Total_Quantity_sold from ecommerce_data group by `description` order by Total_Quantity_sold desc limit 10;

-- Lowest Selling Products
select `description`, sum(Quantity) as Total_Quantity_sold from ecommerce_data group by `description` order by Total_Quantity_sold limit 100;
--------------------------------------------------------------------------------------------------------------


# 🌍 Geographic Analysis
-- Top Countries by Revenue
select country, sum(revenue) as total_revenue from ecommerce_data group by country order by total_revenue desc limit 10;

-- Top Countries by Orders
select country, count(invoiceNo) as total_orders from ecommerce_data group by country order by total_orders desc limit 10;

-- Top Countries by Customers
select country, count(distinct customerID) as total_Unique_customers from ecommerce_data group by country order by total_Unique_customers desc limit 10;
--------------------------------------------------------------------------------------------------------------


# 📈 Time Analysis
-- Best Selling Month
select `month`, count(invoiceNo) as total_orders from ecommerce_data group by `month` order by total_orders desc;

-- Worst Selling Month
select `month`, count(invoiceNo) as total_orders from ecommerce_data group by `month` order by total_orders;

-- Best Selling Quarter
select `quarter`, count(invoiceNo) as total_orders from ecommerce_data group by `quarter` order by total_orders desc;

-- Worst Selling Quarter
select `quarter`, count(invoiceNo) as total_orders from ecommerce_data group by `quarter` order by total_orders;

-- Best Selling Days
select `day`, count(invoiceNo) as total_orders from ecommerce_data group by `day` order by total_orders desc;

-- Worst Selling Days
select `day`, count(invoiceNo) as total_orders from ecommerce_data group by `day` order by total_orders;
--------------------------------------------------------------------------------------------------------------


# 💰 Pricing Analysis
-- Highest Priced Products
select `description` , unitprice from ecommerce_data order by unitprice desc limit 10;

-- Lowest Priced Products
select `description` , unitprice from ecommerce_data order by unitprice limit 10;

-- Average Product Price
select  avg(unitprice) from ecommerce_data;

-- Revenue from Top 10 Customers
SELECT ROUND(SUM(Total_Revenue), 2) AS Revenue_From_Top_10_Customers FROM ( SELECT CustomerID, SUM(Revenue) AS Total_Revenue FROM ecommerce_data GROUP BY CustomerID ORDER BY Total_Revenue DESC LIMIT 10 )t;
--------------------------------------------------------------------------------------------------------------

-- Repeat Customer Analysis (Customers with multiple purchases)
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Number_of_Orders, ROUND(SUM(Revenue),2) AS Total_Revenue FROM ecommerce_data GROUP BY CustomerID 
HAVING COUNT(DISTINCT InvoiceNo) > 1 ORDER BY Number_of_Orders DESC;

-- Top 10 customers Revenue VS Total Revenue
SELECT ROUND(SUM(Total_Revenue), 2) AS Revenue_From_Top_10_Customers_AND_Total_revenue FROM ( SELECT CustomerID, SUM(Revenue) AS Total_Revenue FROM ecommerce_data GROUP BY CustomerID ORDER BY Total_Revenue DESC LIMIT 10 )t
union
select ROUND(SUM(Revenue), 2)from ecommerce_Data;

-- Customer Segmentation (High Value/Medium Value/Low Value)
SELECT Customer_Segment, COUNT(*) AS Number_of_Customers FROM ( SELECT CustomerID, CASE
	WHEN SUM(Revenue) >= 10000 THEN 'High Value'
	WHEN SUM(Revenue) >= 5000 THEN 'Medium Value'
	ELSE 'Low Value'
	END AS Customer_Segment FROM ecommerce_data WHERE CustomerID IS NOT NULL GROUP BY CustomerID)t
GROUP BY Customer_Segment;