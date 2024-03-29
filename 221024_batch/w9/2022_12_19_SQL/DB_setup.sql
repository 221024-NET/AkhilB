-- * Single run script for creating the Restaurant Schema and tables
-- * If RESTAURANTS schema is in the database with no tables, just comment it out
-- * If RESTAURANTS schema is not in the database yet, uncomment the CREATE SCHEMA and GO
-- * After creation, run the script in dataseed.sql to populate the tables


--Drop procedures
DROP PROCEDURE IF EXISTS RST.GetScore;
GO

--Drop tables
DROP TABLE IF EXISTS RST.Score;
DROP TABLE IF EXISTS RST.Menuitem;
DROP TABLE IF EXISTS RST.Cuisine;
DROP TABLE IF EXISTS RST.Restaurant;
GO

--Drop schemas
DROP SCHEMA IF EXISTS RST;
GO

CREATE SCHEMA RST;
GO

--
CREATE TABLE RST.Restaurant (
    restID INT IDENTITY(1,1),
    rName VARCHAR(255) NOT NULL,
    rAddress VARCHAR(255) NOT NULL,
    rCity VARCHAR(255) NOT NULL,
    rState VARCHAR(255) NOT NULL,
    grade CHAR(1) NOT NULL,
    CONSTRAINT PK_Restaurant_restID PRIMARY KEY CLUSTERED (restID),
    CHECK (grade in ('A', 'B', 'C', 'D'))
);
GO

CREATE TABLE RST.Cuisine (
    cuisID INT IDENTITY(1,1),
    restID INT NOT NULL,
    cuisName NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Cuisine_cuisID PRIMARY KEY CLUSTERED (cuisID),
    CONSTRAINT FK_Cuisine_restID FOREIGN KEY (restID)
        REFERENCES RST.Restaurant (restID)
        ON DELETE CASCADE
);
GO

CREATE TABLE RST.MenuItem (
    itemID INT IDENTITY(1,1),
    restID INT NOT NULL,
    itemName NVARCHAR(255) NOT NULL,
    itemDescription NVARCHAR(255) NOT NULL,
    price DECIMAL(19,4) NOT NULL,
    CONSTRAINT PK_MenuItem_itemID PRIMARY KEY CLUSTERED (itemID),
    CONSTRAINT FK_MenuItem_restID FOREIGN KEY (restID)
        REFERENCES RST.Restaurant (restID)
        ON DELETE CASCADE,
    CHECK (price > 0)
);
GO

CREATE TABLE RST.Score (
    refID INT IDENTITY(1,1),
    restID INT NOT NULL,
    points TINYINT NOT NULL,
    reviewdate DATE NOT NULL,
    CONSTRAINT PK_Score_refID PRIMARY KEY CLUSTERED (refID),
    CONSTRAINT FK_Score_restID FOREIGN KEY (restID)
        REFERENCES RST.Restaurant (restID)
        ON DELETE CASCADE,
    CHECK (points BETWEEN 0 AND 100)
);
GO

--Procedure to get a restaurant's average score
CREATE PROCEDURE RST.GetScore @restaurant int 
AS
SELECT AVG(points)
FROM RST.Score
WHERE restID = @restaurant;
GO

-- * Now for the process of seeding everything
-- * Start by seeding the restaurants
INSERT INTO RST.Restaurant
    (rName, rAddress, rCity, rState, grade) 
    VALUES
    ('McDonald'+char(39)+'s', '10701 Narcoossee Rd', 'Orlando', 'Florida', 'B'),
    ('McDonald'+char(39)+'s', '6875 Sand Lake Rd', 'Orlando', 'Florida', 'C'),
    ('Red Lobster', '3552. E. Colonial Drive', 'Orlando', 'Florida', 'B'),
    ('Panda Express', '6000 Universal Blvd', 'Orlando', 'Florida', 'C'),
    ('McDonald'+char(39)+'s', '13 E State St', 'Mt. Morris', 'New York', 'B'),
    ('Panda Express', '663 9th Ave', 'New York City', 'New York', 'B'),
    ('Olive Garden', '178 Wolf Rd', 'Colonie', 'New York', 'A'),
    ('Red Lobster', '606 Sunrise Hwy', 'Valley Stream', 'New York', 'C'),
    ('Taco Bell', '732 NY-28', 'Oneonta', 'New York', 'D'),
    ('Buca di Beppo', '1540 Broadway', 'New York City', 'New York', 'A'),
    ('L'+char(26)+'L Hawaiian Barbecue', '3205 SW Cedar Hills Blvd '+char(23)+'23', 'Beaverton', 'Oregon', 'B'),
    ('Texas Roadhouse', '2323 South Rd', 'Poughkeepsie', 'New York', 'B'),
    ('Panda Express', '5500 Greenville Ave', 'Dallas', 'Texas', 'C'),
    ('Panda Express', '39718 Lyndon B Johnson Fwy', 'Dallas', 'Texas', 'B'),
    ('Denny'+char(39)+'s', '2030 Market Center Blvd', 'Dallas', 'Texas', 'A'),
    ('Red Lobster', '9069 Vantage Point Dr', 'Dallas', 'Texas', 'C'),
    ('Red Lobster', '22800 Vanowen St', 'Los Angeles', 'California', 'B'),
    ('Raising Cane'+char(39)+'s', '1750 W Olive Ave', 'Los Angeles', 'California', 'C'),
    ('Buca di Beppo', '17500 Ventura Blvd', 'Los Angeles', 'California', 'A'),
    ('Olive Garden', '4835 Venice Blvd', 'Los Angeles', 'California', 'B'),
    ('Panda Express', '524 E Washington Blvd', 'Los Angeles', 'California', 'C'),
    ('McDonald'+char(39)+'s', '1530 3rd Ave', 'Seattle', 'Washington', 'D'),
    ('Panda Express', '9999 Holman Rd', 'Seattle', 'Washington', 'C'),
    ('Regale Italian Eatery', '3850 S Las Vegas Blvd', 'Las Vegas', 'Nevada', 'A'),
    ('Regattabar', '1 Bennett St', 'Cambridge', 'Massachusetts', 'B');
GO

-- * Cuisine table
INSERT INTO RST.Cuisine
    (restID, cuisName)
    VALUES
    (1, 'American'),
    (2, 'American'),
    (3, 'American'),
    (5, 'American'),
    (8, 'American'),
    (12, 'American'),
    (15, 'American'),
    (16, 'American'),
    (17, 'American'),
    (18, 'American'),
    (22, 'American'),
    (25, 'American'),
    (4, 'Chinese'),
    (6, 'Chinese'),
    (13, 'Chinese'),
    (14, 'Chinese'),
    (21, 'Chinese'),
    (23, 'Chinese'),
    (7, 'Italian'),
    (10, 'Italian'),
    (19, 'Italian'),
    (20, 'Italian'),
    (24, 'Italian'),
    (9, 'Mexican'),
    (11, 'Hawaiian');
GO

-- * MenuItem next
INSERT INTO RST.MenuItem
    (restID, itemName, itemDescription, price)
    VALUES
    (1, 'Chicken Sandwich', 'Crispy Chicken, lettuce, mayo, bread', 5.43),
    (1, 'Big Mac', 'Two patties, lettuce, special sauce, extra middle bun', 7.03),
    (1, 'Quarter Pounder', 'Quarter pound of beef, ketchup, onions, lettuce, cheese', 6.19),
    (2, 'Chicken Sandwich', 'Crispy Chicken, lettuce, mayo, bread', 5.11),
    (2, 'Big Mac', 'Two patties, lettuce, special sauce, extra middle bun', 6.50),
    (2, 'Quarter Pounder', 'Quarter pound of beef, ketchup, onions, lettuce, cheese', 5.97),
    (5, 'Chicken Sandwich', 'Crispy Chicken, lettuce, mayo, bread', 6.16),
    (5, 'Big Mac', 'Two patties, lettuce, special sauce, extra middle bun', 8.11),
    (5, 'Quarter Pounder', 'Quarter pound of beef, ketchup, onions, lettuce, cheese', 6.94),
    (22, 'Chicken Sandwich', 'Crispy Chicken, lettuce, mayo, bread', 6.04),
    (22, 'Big Mac', 'Two patties, lettuce, special sauce, extra middle bun', 7.84),
    (22, 'Quarter Pounder', 'Quarter pound of beef, ketchup, onions, lettuce, cheese', 6.88),
    (4, 'Orange Chicken', 'Chicken fried and coated in orange sauce', 4.12),
    (4, 'Beijing Beef', 'Crispy beef frieed and tossed in spicy BBQ sauce', 4.60),
    (4, 'Honey Walnut Shrimp', 'Shrimp cooked in a honey sauce and served with walnuts', 5.11),
    (6, 'Orange Chicken', 'Chicken fried and coated in orange sauce', 4.86),
    (6, 'Beijing Beef', 'Crispy beef frieed and tossed in spicy BBQ sauce', 5.14),
    (6, 'Honey Walnut Shrimp', 'Shrimp cooked in a honey sauce and served with walnuts', 6.13),
    (13, 'Orange Chicken', 'Chicken fried and coated in orange sauce', 4.25),
    (13, 'Beijing Beef', 'Crispy beef frieed and tossed in spicy BBQ sauce', 4.43),
    (13, 'Honey Walnut Shrimp', 'Shrimp cooked in a honey sauce and served with walnuts', 5.21),
    (14, 'Orange Chicken', 'Chicken fried and coated in orange sauce', 4.31),
    (14, 'Beijing Beef', 'Crispy beef frieed and tossed in spicy BBQ sauce', 4.52),
    (14, 'Honey Walnut Shrimp', 'Shrimp cooked in a honey sauce and served with walnuts', 5.30),
    (21, 'Orange Chicken', 'Chicken fried and coated in orange sauce', 6.11),
    (21, 'Beijing Beef', 'Crispy beef frieed and tossed in spicy BBQ sauce', 6.23),
    (21, 'Honey Walnut Shrimp', 'Shrimp cooked in a honey sauce and served with walnuts', 8.14),
    (7, 'Fettuccine Alfredo', 'Fettuccine pasta tossed in creamy alfredo sauce', 17.40),
    (7, 'Zuppa Toscana', 'Tuscan soup with Italian sausage, kale, bacon and potatoes', 9.14),
    (7, 'Tiramisu cake', 'Coffee-flavored cake with ladyfingers and mascarpone cheese', 12.55),
    (20, 'Fettuccine Alfredo', 'Fettuccine pasta tossed in creamy alfredo sauce', 19.66),
    (20, 'Zuppa Toscana', 'Tuscan soup with Italian sausage, kale, bacon and potatoes', 11.21),
    (20, 'Tiramisu cake', 'Coffee-flavored cake with ladyfingers and mascarpone cheese', 15.30),
    (18, 'Caniac Combo', 'Five Chicken tenders, toast, slaw, and a drink', 18.40),
    (9, 'Bean burrito', 'Beans, onions, and cheese in a tortilla', 2.35),
    (10, 'Chicken Marsala', 'baby portobello mushrooms in a traditional Marsala wine reduction', 44.00),
    (10, 'Chicken Parmigiana', 'topped with marinara sauce, mozzarella & garnished with parsley', 43.00),
    (19, 'Chicken Marsala', 'baby portobello mushrooms in a traditional Marsala wine reduction', 46.00),
    (19, 'Chicken Parmigiana', 'topped with marinara sauce, mozzarella & garnished with parsley', 45.50),
    (3, 'Snow Crab Legs', 'North American crab, served with lemon and butter', 28.90),
    (3, 'Fish and Chips', 'Battered cod, served with coleslaw and tartar sauce', 14.40),
    (8, 'Snow Crab Legs', 'North American crab, served with lemon and butter', 30.30),
    (8, 'Fish and Chips', 'Battered cod, served with coleslaw and tartar sauce', 16.07),
    (16, 'Snow Crab Legs', 'North American crab, served with lemon and butter', 27.30),
    (16, 'Fish and Chips', 'Battered cod, served with coleslaw and tartar sauce', 14.06),
    (17, 'Snow Crab Legs', 'North American crab, served with lemon and butter', 32.50),
    (17, 'Fish and Chips', 'Battered cod, served with coleslaw and tartar sauce', 18.44),
    (11, 'BBQ Beef Bowl', 'BBQ Beef served with steamed veggies on rice', 17.88),
    (11, 'Chicken Katsu', 'Boneless, deep-fried chicken', 19.06),
    (12, 'Ribeye', '20oz Ribeye', 27.80),
    (12, 'Porterhouse', '23oz, Filet and strip on a T-bone', 28.90),
    (15, 'Premium Chicken Tenders', 'Chicken tenders with choice of dipping sauce and two sides', 11.50),
    (15, 'Chicken fried Chicken', 'Fried boneless chicken breasts in country gravy', 12.20);
GO

-- * Now for scores
-- * I won't come up with data here so I'll just run a python script that will generate the data for me
INSERT INTO RST.Score
    (restID, points, reviewdate)
    VALUES
    (14, 56, '2022-05-17'),
    (18, 15, '2022-08-25'),
    (23, 38, '2022-03-15'),
    (5, 88, '2022-02-15'),
    (18, 29, '2022-03-12'),
    (18, 32, '2022-10-16'),
    (10, 3, '2022-04-14'),
    (24, 57, '2022-06-19'),
    (8, 54, '2022-12-30'),
    (5, 63, '2022-09-16'),
    (7, 38, '2022-03-19'),
    (16, 35, '2022-04-18'),
    (18, 8, '2022-05-08'),
    (3, 84, '2022-06-24'),
    (3, 26, '2022-08-01'),
    (21, 42, '2022-06-26'),
    (13, 29, '2022-07-22'),
    (24, 4, '2022-04-02'),
    (3, 35, '2022-07-26'),
    (20, 10, '2022-03-19'),
    (11, 42, '2022-03-09'),
    (21, 34, '2022-10-25'),
    (19, 58, '2022-03-13'),
    (24, 84, '2022-09-02'),
    (9, 7, '2022-12-31'),
    (24, 89, '2022-03-31'),
    (13, 49, '2022-01-10'),
    (21, 7, '2022-05-25'),
    (10, 9, '2022-06-09'),
    (18, 22, '2022-07-04'),
    (24, 93, '2022-01-08'),
    (17, 22, '2022-11-01'),
    (9, 52, '2022-01-28'),
    (4, 8, '2022-02-22'),
    (4, 25, '2022-10-08'),
    (7, 21, '2022-08-19'),
    (12, 51, '2022-05-12'),
    (19, 65, '2022-08-08'),
    (18, 90, '2022-04-27'),
    (24, 1, '2022-03-20'),
    (11, 48, '2022-04-01'),
    (23, 42, '2022-03-12'),
    (21, 10, '2022-08-01'),
    (14, 68, '2022-11-10'),
    (10, 44, '2022-08-17'),
    (7, 32, '2022-07-21'),
    (20, 14, '2022-03-05'),
    (3, 66, '2022-04-08'),
    (10, 93, '2022-11-30'),
    (15, 66, '2022-12-16'),
    (2, 43, '2022-09-20'),
    (2, 83, '2022-12-04'),
    (19, 82, '2022-07-16'),
    (13, 73, '2022-03-04'),
    (21, 36, '2022-02-17'),
    (14, 49, '2022-10-20'),
    (1, 42, '2022-06-13'),
    (19, 80, '2022-11-05'),
    (24, 98, '2022-04-14'),
    (13, 18, '2022-04-24'),
    (15, 77, '2022-01-08'),
    (16, 75, '2022-09-01'),
    (17, 41, '2022-02-23'),
    (6, 100, '2022-04-23'),
    (7, 4, '2022-05-01'),
    (2, 41, '2022-08-01'),
    (25, 75, '2022-09-20'),
    (5, 25, '2022-03-12'),
    (5, 82, '2022-10-15'),
    (23, 66, '2022-04-21'),
    (10, 16, '2022-06-27'),
    (17, 28, '2022-10-23'),
    (25, 69, '2022-02-13'),
    (1, 61, '2022-10-07'),
    (12, 19, '2022-04-29'),
    (18, 1, '2022-07-23'),
    (13, 37, '2022-01-15'),
    (5, 5, '2022-07-17'),
    (12, 20, '2022-01-07'),
    (14, 87, '2022-08-12'),
    (6, 76, '2022-02-13'),
    (3, 24, '2022-03-14'),
    (19, 39, '2022-11-08'),
    (21, 1, '2022-01-13'),
    (12, 62, '2022-04-06'),
    (2, 37, '2022-04-24'),
    (5, 78, '2022-06-29'),
    (4, 22, '2022-04-18'),
    (14, 83, '2022-09-08'),
    (23, 94, '2022-04-08'),
    (22, 67, '2022-06-21'),
    (17, 33, '2022-06-17'),
    (16, 90, '2022-01-12'),
    (7, 69, '2022-10-28'),
    (3, 15, '2022-03-21'),
    (4, 74, '2022-05-07'),
    (18, 50, '2022-10-07'),
    (13, 94, '2022-11-18'),
    (15, 54, '2022-04-22'),
    (14, 60, '2022-10-04'),
    (1, 29, '2022-10-30'),
    (5, 36, '2022-02-10'),
    (11, 19, '2022-11-10'),
    (5, 32, '2022-03-03'),
    (23, 25, '2022-07-27'),
    (20, 25, '2022-04-05'),
    (1, 43, '2022-04-22'),
    (25, 40, '2022-08-18'),
    (4, 31, '2022-06-16'),
    (11, 14, '2022-01-16'),
    (5, 2, '2022-03-22'),
    (15, 58, '2022-10-09'),
    (14, 40, '2022-03-21'),
    (4, 49, '2022-09-25'),
    (1, 97, '2022-09-22'),
    (2, 10, '2022-03-26'),
    (25, 88, '2022-07-06'),
    (4, 99, '2022-06-05'),
    (7, 9, '2022-03-03'),
    (3, 67, '2022-03-10'),
    (6, 4, '2022-10-14'),
    (13, 86, '2022-07-02'),
    (12, 73, '2022-11-13'),
    (20, 77, '2022-01-07'),
    (11, 19, '2022-01-03'),
    (13, 45, '2022-05-16'),
    (2, 69, '2022-04-02'),
    (21, 49, '2022-10-15'),
    (18, 70, '2022-04-13'),
    (24, 89, '2022-12-22'),
    (16, 36, '2022-12-23'),
    (5, 100, '2022-04-16'),
    (6, 86, '2022-04-29'),
    (11, 56, '2022-05-31'),
    (7, 86, '2022-01-11'),
    (2, 43, '2022-12-17'),
    (1, 71, '2022-06-07'),
    (11, 21, '2022-10-26'),
    (23, 88, '2022-05-24'),
    (17, 5, '2022-10-09'),
    (8, 88, '2022-03-09'),
    (5, 27, '2022-12-25'),
    (7, 67, '2022-11-16'),
    (2, 10, '2022-04-21'),
    (3, 51, '2022-08-22'),
    (10, 60, '2022-09-13'),
    (24, 17, '2022-10-22'),
    (22, 8, '2022-06-03'),
    (1, 49, '2022-02-03'),
    (9, 9, '2022-04-10');
GO
-- * End of seeding