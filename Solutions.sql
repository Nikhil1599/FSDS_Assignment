/*
Q 11. Create Student Table with ID as Primary Key and NOT NULL , Name as 20 Characters ,
Age as Int value both are NOT NULL and Address have  25 charter And Insert Any 5 Records?
 */
CREATE TABLE Students (
    ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Age INT NOT NULL,
    Address VARCHAR(25)
);
-- Inserting records
INSERT INTO Students (ID, Name, Age, Address) VALUES
    (1, 'Nikhilesh Singh', 23, '123 Mumbai'),
    (2, 'Neesha Diwakar', 22, 'Andheri'),
    (3, 'Harshit Singh', 21, 'Vikhroli'),
    (4, 'Adarsh Singh', 21, 'Virar'),
    (5, 'Arpita Mishra', 20, 'Borivali');
/*----------------------------------------------------------------------------*/
/* 
Q 12. Write an SQL query to find the youngest student in the "student" table
*/
SELECT * FROM Students ORDER BY Age ASC LIMIT 1;
/*----------------------------------------------------------------------------*/
/*
Q 13. Write an SQL query to retrieve the names and addresses of all persons from the 
"Person" table along with their corresponding addresses from the "Address" table.
*/
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LasttName VARCHAR(50) NOT NULL
);
CREATE TABLE Address (
    AddressID INT PRIMARY KEY,
    PersonID INT,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL
);
INSERT INTO Person (PersonID, FirstName, LasttName) VALUES (1, 'Nikhilesh', 'Singh'),
(2, 'Jharshit', 'Singh'), (3, 'Adarsh','Singh'), (4, 'Arpita',' Mishra'), (5, 'Neesha', 'Diwakar');
INSERT INTO Address (AddressID, PersonID, City, State) VALUES (1, 1, 'Thane','Maharashtra'),
(2, 2, 'Mumbai','Maharashtra'), (3, 3, 'Thane','Maharashtra'), (4, 4, 'Andheri','Maharashtra'), (5, 5, 'Borivali','Maharashtra');

SELECT p.FirstName,p.LasttName, a.City,a.State FROM Person p
JOIN Address a ON p.PersonID = a.PersonID;
/*----------------------------------------------------------------------------*/

/*
Q 14. Write an SQL query to fetch the second highest number from the "student" table.?
*/
SELECT DISTINCT Age FROM Student ORDER BY Age DESC LIMIT 1 OFFSET 1;
/*----------------------------------------------------------------------------*/

/* 
Q15. SQL Quary to get the nth highest salary from Employee table
*/
SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT 1 OFFSET (n - 1);

/* 
Q 16 Write a SQL query to find the median salary of each company.?
*/
SELECT Company,
       CASE
           WHEN COUNT(*) % 2 = 0 THEN
               (MAX(Salary) + MIN(Salary)) / 2.0
           ELSE
               PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary) OVER (PARTITION BY Company)
       END AS MedianSalary
FROM Employee
GROUP BY Company;

/*
Q17 Write a SQL to get the cumulative sum of an employee’s salary over a period of 3 
month but exclude the most recent month? The result should be display by id ascending and then by month decending ?
*/
SELECT
    EmployeeID,
    Month,
    SUM(Salary) OVER (PARTITION BY EmployeeID ORDER BY Month DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS CumulativeSum
FROM (
    SELECT
        EmployeeID,
        EXTRACT(MONTH FROM SalaryDate) AS Month,
        Salary
    FROM EmployeeSalary
) AS SalaryData
ORDER BY EmployeeID ASC, Month DESC;

/*
Q 19 Consider a database with two tables: "Orders" and "Customers." Write an SQL query to retrieve the top 5 customers who have made the most orders, 
along with the total count of their orders. Display the results in descending order of the order count and ascending order of customer names.
*/
SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY OrderCount DESC, c.CustomerName ASC
LIMIT 5;

/*
Q 20 Consider a database schema that represents an online bookstore with two tables: 
books and orders. The books table has columns: book_id, title, author, price, and stock_quantity. The orders table has columns: order_id, book_id, quantity, 
and order_date.Write an SQL query to find the top 3 bestselling products in terms of total quantity sold, along with their names and total quantities sold. 
*/
SELECT
    b.title AS ProductName,
    SUM(o.quantity) AS TotalQuantitySold
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY TotalQuantitySold DESC
LIMIT 3;










