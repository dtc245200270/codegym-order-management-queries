CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

CREATE TABLE IF NOT EXISTS Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(25),
    cAge TINYINT
);

CREATE TABLE IF NOT EXISTS `Order` (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE IF NOT EXISTS Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);

CREATE TABLE IF NOT EXISTS OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);

INSERT INTO Customer VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO `Order` VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Product VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO OrderDetail VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- 1. Hiển thị thông tin oID, oDate, oTotalPrice
SELECT oID, oDate, oTotalPrice FROM `Order`;

-- 2. Hiển thị khách hàng và sản phẩm đã mua
SELECT c.Name AS CustomerName, p.pName AS ProductName
FROM Customer c
JOIN `Order` o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;

-- 3. Hiển thị khách hàng không mua sản phẩm nào
SELECT c.cID, c.Name
FROM Customer c
LEFT JOIN `Order` o ON c.cID = o.cID
WHERE o.oID IS NULL;

-- 4. Hiển thị mã hóa đơn, ngày bán và giá tiền từng hóa đơn
SELECT o.oID, o.oDate, SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
