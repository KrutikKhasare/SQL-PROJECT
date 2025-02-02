BOOKSTORE SALES ANALYSIS
📌 Project Overview

This project is a Bookstore Sales Analysis using SQL, where I worked with three datasets:

Orders (containing order details and quantities)

Books (containing book details like price, stock, and names)

Customers (containing customer information)

The goal of this project is to extract meaningful insights from the data using advanced SQL queries, focusing on sales trends, customer behavior, and inventory management.

📂 Dataset Description

The dataset consists of three tables:

1️⃣ BOOKS Table

2️⃣ CUSTOMERS Table

3️⃣ ORDERS Table

📊 SQL Queries & Insights

1️⃣ Most Frequently Ordered Books

Finds the books that were ordered the most:

SELECT b.book_name, SUM(o.quantity) AS total_quantity
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_name
ORDER BY total_quantity DESC;

✅ Insight: Identifies top-selling books.

2️⃣ Stock Remaining After Fulfilling Orders

Calculates how many books are left in stock:

SELECT b.book_name,
(b.stock_quantity - COALESCE(SUM(o.quantity), 0)) AS remaining_stock
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.book_name, b.stock_quantity;

✅ Insight: Helps in inventory management.

3️⃣ Top 5 Customers Who Ordered the Most Books

Finds the most valuable customers based on total books ordered:

SELECT c.customer_name, SUM(o.quantity) AS total_books_ordered
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_books_ordered DESC
LIMIT 5;

✅ Insight: Helps in customer segmentation and loyalty programs.

✅ Insight: Helps measure business performance.

🔧 Technologies Used

SQL (for querying and analysis)

MySQL / PostgreSQL (database management)
