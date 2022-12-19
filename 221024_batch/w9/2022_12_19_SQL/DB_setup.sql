-- Single run script for creating the Restaurant Schema and tables
-- If RESTAURANTS schema is in the database and sans tables, just comment it out
-- If RESTAURANTS schema is not in the database yet, uncomment the CREATE SCHEMA and GO

--CREATE SCHEMA RESTAURANTS;
--GO

DROP TABLE RESTAURANTS.Score;
DROP TABLE RESTAURANTS.Menuitem;
DROP TABLE RESTAURANTS.Cuisine;
DROP TABLE RESTAURANTS.Restaurant;
DROP TABLE RESTAURANTS.Franchise;
GO


CREATE TABLE RESTAURANTS.Franchise (
    franchID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE RESTAURANTS.Restaurant (
    restID INT IDENTITY(1,1),
    franchise INT NOT NULL,
    rAddress VARCHAR(255) NOT NULL,
    rCity VARCHAR(255) NOT NULL,
    rState VARCHAR(255) NOT NULL,
    grade CHAR(1) NOT NULL,
    CONSTRAINT PK_Restaurant_restID PRIMARY KEY CLUSTERED (restID),
    CONSTRAINT FK_Restaurant_franchise FOREIGN KEY (franchise)
        REFERENCES RESTAURANTS.Franchise (franchID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CHECK (grade in ('A', 'B', 'C', 'D'))
);
GO

CREATE TABLE RESTAURANTS.Cuisine (
    cuisID INT IDENTITY(1,1),
    restID INT NOT NULL,
    cuisName NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Cuisine_cuisID PRIMARY KEY CLUSTERED (cuisID),
    CONSTRAINT FK_Cuisine_restID FOREIGN KEY (restID)
        REFERENCES RESTAURANTS.Restaurant (restID)
        ON DELETE CASCADE
);
GO

CREATE TABLE RESTAURANTS.MenuItem (
    itemID INT IDENTITY(1,1),
    restID INT NOT NULL,
    itemName NVARCHAR(255) NOT NULL,
    itemDescription NVARCHAR(255) NOT NULL,
    price DECIMAL(19,4) NOT NULL,
    CONSTRAINT PK_MenuItem_itemID PRIMARY KEY CLUSTERED (itemID),
    CONSTRAINT FK_MenuItem_restID FOREIGN KEY (restID)
        REFERENCES RESTAURANTS.Restaurant (restID)
        ON DELETE CASCADE,
    CHECK (price > 0)
);
GO

CREATE TABLE RESTAURANTS.Score (
    refID INT IDENTITY(1,1),
    restID INT NOT NULL,
    points TINYINT NOT NULL,
    reviewdate DATE NOT NULL,
    CONSTRAINT PK_Score_refID PRIMARY KEY CLUSTERED (refID),
    CONSTRAINT FK_Score_restID FOREIGN KEY (restID)
        REFERENCES RESTAURANTS.Restaurant (restID)
        ON DELETE CASCADE,
    CHECK (points BETWEEN 0 AND 100)
)