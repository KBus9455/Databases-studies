--1.	Spo?ród klientów z Londynu wybierz tych których nazwa zaczyna na si? na A, B lub C

SELECT * FROM [Customers]
WHERE [City]='London' AND [CompanyName] like '[a-c]%'

--2.	Wy?wietl informacje o zamówieniach z czerwca 1996 obs?ugiwanych na wschodzie, których warto?? przekroczy?a ?redni? warto?? wszystkich zamówie?

SELECT *
FROM [Order Details] INNER JOIN ORDERS
ON [Order Details].OrderID=Orders.OrderID
INNER JOIN Employees
ON Employees.EmployeeID=Orders.EmployeeID
INNER JOIN EmployeeTerritories
ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
INNER JOIN Territories
ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
INNER JOIN Region
ON Territories.RegionID = Region.RegionID
WHERE Quantity*UnitPrice > (select AVG([UnitPrice]*[Quantity])
from [Order Details])
AND RegionDescription ='Eastern'
AND Year(OrderDate)=1996
AND Month(OrderDate) = 6;
--3.	Znale?? produkty o cenach najni?szych w swoich kategoriach

SELECT ProductName, CategoryName, UnitPrice FROM Products  as P1 INNER JOIN Categories ON p1.CategoryID = Categories.CategoryID
WHERE UnitPrice = (SELECT min(UnitPrice) From Products as P2
					WHERE p1.CategoryID = p2.CategoryID)

--4.	Podaj ilu pracowników mieszka w takich samych miastach

SELECT City, Count(*) FROM Employees 
GROUP BY City 

--5. Wskaza? produkt, którego nikt inny nie zamawia?

SELECT Productname FROM Products 
WHERE UnitsOnOrder =0 And Discontinued=0

--6.	Którzy klienci najcz??ciej zamawiali

SELECT CompanyName, Count(OrderId) As Ilo??Zamowien FROM Customers INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY CompanyName
Order BY Count(OrderId) DESC


--7.	Napisz kwerend?, która zwróci list? miast, w których mieszkaj? zarówno klienci, jak i pracownicy

SELECT E.City FROM Employees E
INTERSECT
(SELECT C.City FROM Customers C )
