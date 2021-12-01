
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



--11.	Wypisz najdłużej pracujące osoby na każdym stanowisku

