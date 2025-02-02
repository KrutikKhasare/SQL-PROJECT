-- Create Database
CREATE DATABASE OnlineBookstore;

-- Use database
Use OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

SET GLOBAL local_infile= 1;
SET SESSION local_infile= 1;
SHOW VARIABLES LIKE 'local_INFILE';

-- Import Data into Books Table [RIGHT CLICK ON  'books' TABLE DATA IMPORT WIZARD] [IN SCHEMAS]

-- Import Data into Customers Table [RIGHT CLICK ON 'customers' TABLE DATA IMPORT WIZARD] [IN SCHEMAS]

-- Import Data into Orders Table [RIGHT CLICK ON 'orders' TABLE DATA IMPORT WIZARD] [IN SCHEMAS]



-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books
WHERE Genre = 'Fiction';


-- 2) Find books published after the year 1950:

SELECT * FROM Books
WHERE Published_Year > 1950;


-- 3) List all customers from the Canada:

SELECT * FROM Customers
WHERE Country = 'Canada';

-- 4) Show orders placed in November 2023:

SELECT * FROM Orders
WHERE ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:

SELECT SUM(Stock) As TOTAL_STOCK FROM Books;

-- 6) Find the details of the most expensive book:

SELECT * FROM Books
ORDER BY PRICE DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders
WHERE Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Orders
WHERE Total_Amount > 20;

-- 9) List all genres available in the Books table:

SELECT DISTINCT(Genre) FROM Books;

-- 10) Find the book with the lowest stock:

SELECT * FROM Books
ORDER BY Stock
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(Total_Amount) FROM Orders;

-- Advance Questions : 

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve the total number of books sold for each genre:

SELECT B.Genre, SUM(O.Quantity) AS TOTAL_BOOKS_SOLD FROM Orders O 
JOIN Books B on  O.Book_ID = B.Book_ID
GROUP BY B.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(Price) AS AVERAGE_PRICE FROM Books
WHERE Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:

SELECT  O.Customer_ID, C.Name ,COUNT(O.Order_ID) AS ORDER_COUNT 
FROM Orders O
JOIN Customers C 
ON O.Customer_ID = C.Customer_ID
GROUP BY O.Customer_ID ,C.Name
HAVING COUNT(Order_ID) >=2;


-- 4) Find the most frequently ordered book:

SELECT B.Title,O.Book_ID,SUM(O.Quantity) AS ORDER_FREQUENCY FROM Orders O
JOIN Books B
ON O.Book_ID = B.Book_ID
GROUP BY B.Title,O.Book_ID
ORDER BY SUM(O.Quantity) DESC
LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price Desc
LIMIT 3; 

-- 6) Retrieve the total quantity of books sold by each author:

SELECT B.Author, SUM(O.Quantity) AS TOTAL_BOOKS_SOLD FROM Books B
JOIN Orders O 
ON B.Book_ID = O.Book_ID
GROUP BY B.Author
ORDER BY B.Author;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT C.CITY , O.Total_Amount FROM Customers C 
JOIN Orders O 
ON C.Customer_ID = O.Customer_ID
WHERE Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:

SELECT C.Customer_ID,C.Name,SUM(O.Total_Amount) AS TOTAL_SPEND FROM Customers C 
JOIN Orders O 
ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID,C.Name
ORDER BY TOTAL_SPEND DESC
LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT B.Book_ID,B.Title,B.Stock,COALESCE(SUM(O.Quantity),0) AS ORDERED_QUANTITY,B.STOCK - COALESCE(SUM(O.Quantity),0) AS STOCK_REMAINING
FROM Books B 
LEFT JOIN Orders O 
ON B.Book_ID = O.Book_ID
GROUP BY B.Book_ID;








