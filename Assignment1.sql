--1.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p

--2.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.ListPrice != 0

--3.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.Color IS NULL

--4.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.Color IS NOT NULL

--5.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.Color IS NOT NULL AND p.ListPrice > 0

--6.	Write a query that concatenates the columns Name and Color from the Production. Product table by excluding the rows that are null for color.
SELECT p.Name, p.Color
FROM Production.Product p
WHERE p.Color IS NOT NULL

--7.	Write a query that generates the following result set  from Production.Product:
/*
Name And Color
--------------------------------------------------
NAME: LL Crankarm  --  COLOR: Black
NAME: ML Crankarm  --  COLOR: Black
NAME: HL Crankarm  --  COLOR: Black
NAME: Chainring Bolts  --  COLOR: Silver
NAME: Chainring Nut  --  COLOR: Silver
NAME: Chainring  --  COLOR: Black
*/

SELECT p.Name, p.Color
FROM Production.Product p 
WHERE p.Color IS NOT NULL AND p.ProductID < 330

--8.	Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
SELECT p.ProductID, p.Name
FROM Production.Product p 
WHERE p.ProductID >= 400 AND p.ProductID <= 500

--9.	Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
SELECT p.ProductID, p.Name, p.Color
FROM Production.Product p 
WHERE p.Color IN('Black', 'Blue')

--10.	Write a query to get a result set on products that begins with the letter S. 
SELECT *
FROM Production.Product
WHERE Name LIKE 'S%'

--11.	Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
/*
Name                                               ListPrice
-------------------------------------------------- -----------
Seat Lug                                           0,00
Seat Post                                          0,00
Seat Stays                                         0,00
Seat Tube                                          0,00
Short-Sleeve Classic Jersey, L                     53,99
Short-Sleeve Classic Jersey, M                     53,99
*/
SELECT p.Name, p.ListPrice
FROM Production.Product p 
ORDER BY p.Name
 
--12.	 Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
/*
Name                                               ListPrice
-------------------------------------------------- ----------
Adjustable Race                                    0,00
All-Purpose Bike Stand                             159,00
AWC Logo Cap                                       8,99
Seat Lug                                           0,00
Seat Post                                          0,00
*/
SELECT p.Name, p.ListPrice
FROM Production.Product p 
WHERE p.Name LIKE 'A%' OR p.Name LIKE 'S%'
ORDER BY p.Name
             
--13.	Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
SELECT p.Name, p.ListPrice
FROM Production.Product p 
WHERE p.Name LIKE 'SPO%' AND p.Name NOT LIKE 'SPOK%'
ORDER BY p.Name
 
--14.	Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
SELECT DISTINCT p.Color 
FROM Production.Product p 
ORDER BY p.Color DESC

--15.	Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result
SELECT DISTINCT p.ProductSubcategoryID, p.Color
FROM Production.Product p 
WHERE p.ProductSubcategoryID IS NOT NULL AND p.Color IS NOT NULL