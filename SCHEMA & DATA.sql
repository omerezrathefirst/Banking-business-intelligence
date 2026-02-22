-- ==========================================
-- FULL DATABASE SCRIPT – banking_practice
-- 20 Customers | 30 Accounts | 60 Transactions
-- ==========================================

DROP DATABASE IF EXISTS banking_practice;
CREATE DATABASE banking_practice;
USE banking_practice;

-- ======================
-- 1. CUSTOMERS
-- ======================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    city VARCHAR(50),
    kyc_level VARCHAR(20),
    status VARCHAR(20)
);

INSERT INTO customers VALUES
(1,'Omer Ezra','Ramat Gan','Level 2','active'),
(2,'Dana Levi','Tel Aviv','Level 1','active'),
(3,'Yossi Cohen','Haifa','Level 3','inactive'),
(4,'Maya Ben','Jerusalem','Level 2','active'),
(5,'Eli Katz','Netanya','Level 1','active'),
(6,'Ron Tal','Ashdod','Level 2','active'),
(7,'Shir Mor','Rishon','Level 1','active'),
(8,'Amit Bar','Petah Tikva','Level 3','active'),
(9,'Noa Gal','Holon','Level 2','inactive'),
(10,'Itay Peretz','Bat Yam','Level 1','active'),
(11,'Lior Shani','Herzliya','Level 3','active'),
(12,'Gal Cohen','Kfar Saba','Level 2','active'),
(13,'Tamar Levi','Eilat','Level 1','inactive'),
(14,'Daniel Azulay','Rehovot','Level 2','active'),
(15,'Bar Weiss','Ashkelon','Level 3','active'),
(16,'Eden Mizrahi','Modiin','Level 1','active'),
(17,'Or Ben Ami','Nazareth','Level 2','active'),
(18,'Yarden Klein','Hadera','Level 3','active'),
(19,'Shay Rubin','Beersheba','Level 1','inactive'),
(20,'Moran David','Tiberias','Level 2','active');

-- ======================
-- 2. ACCOUNTS
-- ======================

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    branch VARCHAR(50),
    open_account_date DATE,
    close_account_date DATE NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO accounts VALUES
(101,1,'Ramat Gan','2015-06-01',NULL),
(102,2,'Tel Aviv','2018-09-15',NULL),
(103,3,'Haifa','2010-03-20','2022-01-01'),
(104,4,'Jerusalem','2021-11-10',NULL),
(105,5,'Netanya','2000-05-05',NULL),
(106,1,'Ramat Gan','2012-01-01','2019-01-01'),
(107,6,'Ashdod','2017-03-01',NULL),
(108,7,'Rishon','2019-05-12',NULL),
(109,8,'Petah Tikva','2011-08-20',NULL),
(110,9,'Holon','2014-01-01','2023-01-01'),
(111,10,'Bat Yam','2022-06-15',NULL),
(112,11,'Herzliya','2005-04-10',NULL),
(113,12,'Kfar Saba','2016-09-09',NULL),
(114,13,'Eilat','2000-02-02','2020-02-02'),
(115,14,'Rehovot','2018-12-12',NULL),
(116,15,'Ashkelon','2013-03-03',NULL),
(117,16,'Modiin','2021-01-01',NULL),
(118,17,'Nazareth','2010-07-07',NULL),
(119,18,'Hadera','2008-05-05',NULL),
(120,19,'Beersheba','2012-11-11','2022-11-11'),
(121,20,'Tiberias','2019-09-09',NULL),
(122,6,'Ashdod','2010-01-01','2018-01-01'),
(123,8,'Petah Tikva','2015-06-06',NULL),
(124,10,'Bat Yam','2003-03-03',NULL),
(125,12,'Kfar Saba','2007-07-07',NULL),
(126,15,'Ashkelon','2020-10-10',NULL),
(127,16,'Modiin','2014-04-04',NULL),
(128,18,'Hadera','2016-08-08',NULL),
(129,20,'Tiberias','2011-12-12',NULL),
(130,14,'Rehovot','2009-09-09',NULL);

-- ======================
-- 3. TRANSACTIONS
-- ======================

CREATE TABLE transactions (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_date DATE,
    txn_type VARCHAR(30),
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO transactions (txn_id, account_id, txn_date, txn_type, amount, status) VALUES
(1,101,'2024-01-10','deposit',5000,'approved'),
(2,101,'2024-02-15','withdrawal',2000,'approved'),
(3,102,'2024-03-01','card_purchase',1500,'approved'),
(4,102,'2024-03-05','card_purchase',3000,'declined'),
(5,103,'2021-12-10','withdrawal',10000,'approved'),
(6,104,'2024-04-01','deposit',8000,'approved'),
(7,105,'2024-01-01','deposit',20000,'approved'),
(8,105,'2024-02-01','withdrawal',5000,'approved'),
(9,105,'2024-03-01','card_purchase',7000,'approved'),
(10,101,'2024-05-01','card_purchase',1200,'approved'),
(11,107,'2024-01-01','deposit',4000,'approved'),
(12,108,'2024-02-02','withdrawal',1500,'approved'),
(13,109,'2024-03-03','card_purchase',2200,'approved'),
(14,110,'2023-01-01','deposit',5000,'approved'),
(15,111,'2024-04-10','deposit',6000,'approved'),
(16,112,'2024-05-05','withdrawal',3000,'approved'),
(17,113,'2024-06-06','card_purchase',1200,'declined'),
(18,114,'2019-01-01','deposit',9000,'approved'),
(19,115,'2024-07-07','deposit',10000,'approved'),
(20,116,'2024-08-08','withdrawal',4500,'approved'),
(21,117,'2024-09-09','card_purchase',800,'approved'),
(22,118,'2024-10-10','deposit',7500,'approved'),
(23,119,'2024-11-11','withdrawal',2000,'approved'),
(24,120,'2021-05-05','card_purchase',600,'approved'),
(25,121,'2024-12-12','deposit',3000,'approved'),
(26,123,'2024-01-15','card_purchase',2000,'approved'),
(27,124,'2024-02-20','withdrawal',5000,'approved'),
(28,125,'2024-03-25','deposit',9000,'approved'),
(29,126,'2024-04-30','card_purchase',400,'approved'),
(30,127,'2024-05-15','deposit',6500,'approved'),
(31,128,'2024-06-20','withdrawal',3500,'approved'),
(32,129,'2024-07-25','card_purchase',1800,'approved'),
(33,130,'2024-08-30','deposit',7200,'approved'),
(34,101,'2024-06-01','deposit',2500,'approved'),
(35,102,'2024-07-01','withdrawal',1100,'approved'),
(36,104,'2024-08-01','card_purchase',950,'approved'),
(37,105,'2024-09-01','deposit',3000,'approved'),
(38,107,'2024-10-01','withdrawal',1700,'approved'),
(39,108,'2024-11-01','card_purchase',2100,'approved'),
(40,109,'2024-12-01','deposit',4500,'approved'),
(41,111,'2024-01-20','card_purchase',1300,'approved'),
(42,112,'2024-02-22','deposit',5000,'approved'),
(43,113,'2024-03-18','withdrawal',2200,'approved'),
(44,115,'2024-04-25','card_purchase',1400,'approved'),
(45,116,'2024-05-30','deposit',8000,'approved'),
(46,117,'2024-06-12','withdrawal',1000,'approved'),
(47,118,'2024-07-17','card_purchase',2600,'approved'),
(48,119,'2024-08-19','deposit',9000,'approved'),
(49,121,'2024-09-23','withdrawal',1200,'approved'),
(50,123,'2024-10-27','deposit',3100,'approved'),
(51,124,'2024-11-29','card_purchase',700,'approved'),
(52,125,'2024-12-30','withdrawal',3300,'approved'),
(53,126,'2024-03-01','deposit',4400,'approved'),
(54,127,'2024-04-01','card_purchase',1500,'approved'),
(55,128,'2024-05-01','deposit',5100,'approved'),
(56,129,'2024-06-01','withdrawal',2300,'approved'),
(57,130,'2024-07-01','card_purchase',1900,'approved'),
(58,101,'2024-08-01','withdrawal',1600,'approved'),
(59,102,'2024-09-01','deposit',2800,'approved'),
(60,105,'2024-10-01','card_purchase',3100,'approved');

