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