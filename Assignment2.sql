/*
1.	What is a result set?
	A result set is a set fo rows from a db, as well as metadata about the query such as the column names, and the types and sizes of each column.

2.	What is the difference between Union and Union All?
	Union extracts the rows that are being specified in the query while Union All extract all the rows including the duplicates from both the queries.

3.	What are the other Set Operators SQL Server has?
	INTERSECT, MINUS

4.	What is the difference between Union and Join?
	Union is used to combine the result-set of two or more SELECT statements. The data combined using UNION qstatement is into results into new distinct rows.
	JOIN in SQL is used to combine data from many tables based on a matched condition between them. The data combined using JOIN statement results into new columns.
	
5.	What is the difference between INNER JOIN and FULL JOIN?
	Inner join returns only the matching rows between both the tables, non-matching rows are eliminated. Full Join or Full Outer Join returns all rows from both the tables (left & right tables), including non-matching rows from both the tables.
	
6.	What is difference between left join and outer join?
	There really is no difference between a LEFT JOIN and a LEFT OUTER JOIN. Both versions of the syntax will produce the exact same result in PL/SQL. Some people do recommend including outer in a LEFT JOIN clause so it's clear that you're creating an outer join, but that's entirely optional.
	
7.	What is cross join?
	A cross join is a type of join that returns the Cartesian product of rows from the tables in the join. In other words, it combines each row from the first table with each row from the second table. This article demonstrates, with a practical example, how to do a cross join in Power Query.

8.	What is the difference between WHERE clause and HAVING clause?
	A HAVING clause is like a WHERE clause, but applies only to groups as a whole (that is, to the rows in the result set representing groups), whereas the WHERE clause applies to individual rows. A query can contain both a WHERE clause and a HAVING clause.
	
9.	Can there be multiple group by columns?
	Yes. A GROUP BY clause can contain two or more columns—or, in other words, a grouping can consist of two or more columns. 
*/


--1.	How many products can you find in the Production.Product table?
SELECT COUNT(*) 
FROM Production.Product

--2.	Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(ProductID)
FROM Production.Product 
WHERE ProductSubcategoryID IS NOT NULL

/*
3.	How many Products reside in each SubCategory? Write a query to display the results with the following titles.
ProductSubcategoryID CountedProducts
-------------------- ---------------
*/
SELECT ProductSubcategoryID, COUNT(ProductID) ProductNum
FROM Production.Product 
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

--4.	How many products that do not have a product subcategory. 
SELECT COUNT(ProductID) 
FROM Production.Product 
WHERE ProductSubcategoryID IS NULL

--5.	Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(Quantity)
FROM Production.ProductInventory
GROUP BY ProductID

/*
6.	 Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
              ProductID    TheSum
-----------        ----------
*/
SELECT ProductID, SUM(Quantity) TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100

/*
7.	Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
Shelf      ProductID    TheSum
---------- -----------        -----------
*/
SELECT Shelf, ProductID, SUM(Quantity) TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID, Shelf
HAVING SUM(Quantity) < 100

--8.	Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT ProductID, AVG(Quantity) TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID

/*
9.	Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
ProductID   Shelf      TheAvg
----------- ---------- -----------
*/
SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

/*
10.	Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
ProductID   Shelf      TheAvg
----------- ---------- -----------
*/
SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf

/*
11.	List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
Color           	Class 	TheCount   	 AvgPrice
--------------	- ----- 	----------- 	---------------------
Joins:
*/
SELECT Color, Class, COUNT(*) TheCount, AVG(ListPrice) AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class

/*
12.	  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following. 

Country                        Province
---------                          ----------------------
*/
SELECT c.Name AS Country, s.Name AS Province 
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode

/*
13.	Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
Country                        Province
---------                          ----------------------
        Using Northwnd Database: (Use aliases for all the Joins)
*/
SELECT c.Name AS Country, s.Name AS Province 
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name NOT IN ('Germany', 'Canada')

--14.	List all Products that has been sold at least once in last 25 years.
SELECT DISTINCT p.ProductID, p.ProductName
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
WHERE DATEDIFF(year, o.OrderDate, GETDATE()) < 25

--15.	List top 5 locations (Zip Code) where the products sold most.
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) Qty 
FROM Orders o JOIN [Order Details] od ON o.OrderID =  od.OrderID
WHERE o.ShipPostalCode IS NOT NULL
GROUP BY ShipPostalCode
ORDER BY qty DESC

--16.	List top 5 locations (Zip Code) where the products sold most in last 25 years.
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) as Qty 
FROM Orders o JOIN [Order Details] od ON o.OrderID =  od.OrderID 
WHERE o.ShipPostalCode IS NOT NULL AND DATEDIFF(year, o.OrderDate, GETDATE()) < 25
GROUP BY ShipPostalCode
ORDER BY qty DESC

--17.	 List all city names and number of customers in that city.     
SELECT City, count(customerID) NumOfCustomer
FROM Customers
GROUP BY City

--18.	List city names which have more than 2 customers, and number of customers in that city 
SELECT City, count(customerID) NumOfCustomer
FROM Customers
GROUP BY City
HAVING COUNT(customerID) > 2

--19.	List the names of customers who placed orders after 1/1/98 with order date.
SELECT DISTINCT c.CustomerID, c.CompanyName, c.ContactName 
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE OrderDate > '1998-1-1'

--20.	List the names of all customers with most recent order dates 
SELECT c.ContactName, MAX(o.OrderDate) MostRecentOrderDate
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.ContactName

--21.	Display the names of all customers  along with the  count of products they bought 
SELECT c.CustomerID, c.CompanyName, c.ContactName, SUM(od.Quantity) Qty 
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName
ORDER BY Qty

--22.	Display the customer ids who bought more than 100 Products with count of products.
SELECT c.CustomerID, SUM(od.Quantity) Qty 
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100
ORDER BY Qty

/*
23.	List all of the possible ways that suppliers can ship their products. Display the results as below
Supplier Company Name   	Shipping Company Name
---------------------------------            ----------------------------------
*/
SELECT DISTINCT sup.CompanyName, ship.CompanyName 
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID INNER JOIN Products p ON od.ProductID = p.ProductID RIGHT JOIN Suppliers sup ON p.SupplierID = sup.SupplierID INNER JOIN Shippers ship ON o.ShipVia = ship.ShipperID

--24.	Display the products order each day. Show Order date and Product Name.
SELECT o.OrderDate, p.ProductName 
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID INNER JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderDate, p.ProductName
ORDER BY o.OrderDate

--25.	Displays pairs of employees who have the same job title.
SELECT e1.Title, e1.LastName + ' ' + e1.FirstName AS Name1, e2.LastName + ' ' + e2.FirstName AS Name2 
FROM Employees e1 JOIN Employees e2 ON e1.Title = e2.Title 
WHERE e1.FirstName <> e2.FirstName OR e1.LastName <> e2.LastName

--26.	Display all the Managers who have more than 2 employees reporting to them.
SELECT T1.EmployeeId, T1.LastName, T1.FirstName,T2.ReportsTo, COUNT(T2.ReportsTo) Subordinate  
FROM Employees T1 JOIN Employees T2 ON T1.EmployeeId = T2.ReportsTo
WHERE T2.ReportsTo IS NOT NULL
GROUP BY T1.EmployeeId, T1.LastName, T1.FirstName,T2.ReportsTo
HAVING COUNT(T2.ReportsTo) > 2

/*
27.	Display the customers and suppliers by city. The results should have the following columns
City 
Name 
Contact Name,
Type (Customer or Supplier)
*/
SELECT c.City, c.CompanyName, c.ContactName, 'Customer' as Type
FROM Customers c
UNION
SELECT s.City, s.CompanyName, s.ContactName, 'Supplier' as Type
FROM Suppliers s