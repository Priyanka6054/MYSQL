show databases;

create database SalesPeople;
USE SalesPeople;
drop database SalesPeople;

-- Table 1: SalesPeople
-- Create SalesPeople table
CREATE TABLE SalesPeople (Snum INT PRIMARY KEY, Sname VARCHAR(50) UNIQUE, City VARCHAR(20), Comm INT);

INSERT INTO SalesPeople (Snum, Sname, City, Comm) VALUES
    (1001, 'Peel', 'London', 12),
    (1002, 'Serres', 'Sanjose', 13),
    (1004, 'Motika', 'London', 11),
    (1007, 'Rifkin', 'Barcelona', 15),
    (1003, 'Axelrod', 'Newyork', 10);
    
SELECT * FROM SalesPeople;


-- Table 2: Customers
-- Create Customers table
CREATE TABLE Customers (Cnum INT PRIMARY KEY, Cname VARCHAR(60), City VARCHAR(50) NOT NULL,
 Snum INT, FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum));

INSERT INTO Customers (Cnum, Cname, City, Snum) VALUES
    (2001, 'Hoffman', 'London', 1001),
    (2002, 'Giovanni', 'Rome', 1003),
    (2003, 'Liu', 'Sanjose', 1002),
    (2004, 'Grass', 'Berlin', 1002),
    (2006, 'Clemens', 'London', 1001),
    (2008, 'Cisneros', 'Sanjose', 1007),
    (2007, 'Pereira', 'Rome', 1004);

SELECT * FROM Customers;

-- Table 3: Orders
-- Create Orders table
CREATE TABLE Orders (Onum INT PRIMARY KEY, Amt DECIMAL(10, 2), Odate DATE, Cnum INT, Snum INT,
    FOREIGN KEY (Cnum) REFERENCES Customers(Cnum),
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum));

INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES
    (3001, 18.69, '1990-03-10', 2008, 1007),
    (3003, 767.19, '1990-03-10', 2001, 1001),
    (3002, 1900.10, '1990-03-10', 2007, 1004),
    (3005, 5160.45, '1990-03-10', 2003, 1002),
    (3006, 1098.16, '1990-03-10', 2008, 1007),
    (3009, 1713.23, '1990-04-10', 2002, 1003),
    (3007, 75.75, '1990-04-10', 2004, 1002),
    (3008, 4273.00, '1990-05-10', 2006, 1001),
    (3010, 1309.95, '1990-06-10', 2004, 1002),
    (3011, 9891.88, '1990-06-10', 2006, 1001);

SELECT * FROM Orders;

-- 1 Count the number of Salesperson whose name begin with ‘a’/’A’.
SELECT COUNT(*)
FROM SalesPeople
WHERE UPPER(SUBSTR(Sname, 1, 1)) = 'A';


-- 2 Display all the Salesperson whose all orders worth is more than Rs. 2000.
SELECT S.Snum, S.Sname, SUM(O.Amt) AS TotalOrderAmount
FROM SalesPeople S
JOIN Customers C ON S.Snum = C.Snum
JOIN Orders O ON C.Cnum = O.Cnum
GROUP BY S.Snum, S.Sname
HAVING SUM(O.Amt) > 2000;

-- 3 Count the number of Salesperson belonging to Newyork.
SELECT COUNT(*)
FROM SalesPeople
WHERE City = 'Newyork';


-- 4 Display the number of Salespeople belonging to London and belonging to Paris.
SELECT City, COUNT(*) AS NumSalespeople
FROM SalesPeople
WHERE City IN ('London', 'Paris')
GROUP BY City;


-- 5 Display the number of orders taken by each Salesperson and their date of orders.
SELECT S.Snum, S.Sname, O.Onum, O.Odate
FROM SalesPeople S
JOIN Orders O ON S.Snum = O.Snum;  

-- or

SELECT Odate, Snum, COUNT(*)
FROM Orders
GROUP BY Odate, Snum;