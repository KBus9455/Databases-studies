
--1.	Dla każdego pracownika podaj na jakim stanowisku pracuje

SELECT [FirstName],[LastName],[Title] 
FROM [dbo].[Employees]

--2.	Znajdź różnice między najwyższa a najniższą cena produktów, nazwij kolumnę wyświetlająca wynik różnica

SELECT max([UnitPrice])-min([UnitPrice]) as roznica  
FROM [dbo].[Products]

--3.	Wybierz nazwy produkty i ich kategorii w kolejności alfabetycznej nazw kategorii

SELECT [ProductName],[CategoryName] 
FROM [Products],[Categories] 
WHERE  Products.CategoryID = Categories.CategoryID 
order by Categories.[CategoryName] ASC


--4.	Znajdź nazwiska pracowników którzy obsługiwali klienta o id = ALFKI (Orders, Employees)

SELECT [LastName] from Employees 
inner join Orders 
on Employees.EmployeeID = Orders.EmployeeID 
where CustomerId = 'ALFKI' 


--5.	Znajdź nazwiska pracowników, którzy realizowali zamówienie przed 1996-08-01

SELECT Distinct LastName From Employees 
inner join Orders 
on Employees.EmployeeID = Orders.EmployeeID 
WHERE Orders.[OrderDate]<'1996-08-01'

--6.	Znajdź nazwiska i imiona pracowników, którzy podczas zamówień korzystali ze statków amerykańskich

SELECT Distinct [FirstName],[LastName] 
FROM Employees inner join Orders 
on Employees.EmployeeID = Orders.EmployeeID  
WHERE Orders.ShipCountry = 'USA'

--7.	Wyświetl produkty zamówione w 96 roku

SELECT Distinct [ProductName] FROM Products 
inner join [Order Details] on Products.ProductID = [Order Details].ProductID  
inner join Orders on Orders.OrderID = [Order Details].OrderID 
WHERE  [OrderDate]between '1996-01-01' and '1996-12-31'


--8.	Policzyć średnie ceny produktów dla każdej z kategorii z wyjątkiem kategorii Seafood 

SELECT CategoryName, AVG(UnitPrice) as 'srednia'  
FROM [dbo].[Products] 
inner join [dbo].[Categories] 
on Products.[CategoryID] = [Categories].[CategoryID]
where Categories.CategoryName != 'Seafood'
Group by CategoryName

--9.	Podaj średnią wartość zamówień w każdej kategorii

SELECT avg([Order Details].[UnitPrice]), [CategoryName] FROM [dbo].[Categories] 
inner join Products 
on Products.CategoryID = Categories.CategoryID 
inner join [Order Details] 
on [Order Details].ProductID = Products.ProductID
group by Categories.CategoryName

--10.	Wypisz kategorie których średnie ceny są powyżej 10 tys

SELECT [CategoryName], avg([Products].UnitPrice ) FROM [dbo].[Categories] 
inner join [dbo].[Products] 
on Categories.CategoryID=Products.ProductID
group by [CategoryName] having avg([Products].UnitPrice) > 10

--11.	Wypisz najdłużej pracujące osoby na każdym stanowisku

SELECT LastName, FirstName, [Title]
FROM Employees as e1
where DATEDIFF(day, HireDate, GETDATE())  =
(SELECT max(DATEDIFF(day, HireDate, GETDATE()))FROM Employees as e2
where e1.[Title]=e2.[Title])
--1.	Wypisz klientów z Londynu 

SELECT ContactName FROM Customers 
WHERE [City]='London'

--2.	Znajdź nazwę firmy, czyli klienta, któremu przesłano towar statkiem amerykańskim 

SELECT Distinct [CompanyName] FROM [dbo].[Customers] 
INNER JOIN Orders 
ON Customers.CustomerID=Orders.CustomerID
WHERE [ShipCountry]='USA'

--3.	Ilu jest pracowników jest kierownikami 

SELECT COUNT(*) FROM Employees
WHERE [Title] LIKE '%Manager%'

--4.	Oblicz wiek pracowników (funkcja YEAR)

SELECT LastName,FirstName, DATEDIFF(year,[BirthDate], GETDATE()) FROM Employees

SELECT LastName,FirstName, YEAR(CURRENT_TIMESTAMP) - YEAR(BirthDate) AS Age FROM Employees

--5.	Znajdź pracownika o najdłuższym nazwisku (funkcja length) 

SELECT Lastname, FirstName FROM Employees
WHERE LEN([Lastname])=(
SELECT max(LEN([Lastname]))FROM Employees)


--6.	Podaj ilu pracowników mieszka w takich samych miastach

SELECT COUNT(*), City FROM Employees
GROUP BY City

--7.	Sprawdź czy do wszystkich klientów posiadasz numer faksu
IF(SELECT  COUNT(*) FROM Customers
 WHERE Fax is null) != 0
 BEGIN
 SELECT 'Nie wszyscy klienci  posiadaja numer faxu';
END
 ELSE
 BEGIN
 SELECT 'wszyscy posiadaja numer faksu';
 END