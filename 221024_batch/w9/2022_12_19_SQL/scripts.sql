-- * 1) Select all fields from the restaurant table
SELECT * FROM RST.Restaurant;

-- * 2) Display all restaurants in Orlando, FL
SELECT rName as [In Orlando] 
FROM RST.Restaurant
WHERE rCity = 'Orlando';

-- * 3) Display top 5 restaurants in new york (score based)
SELECT TOP 5 rName as [Restaurant], rAddress as [Address], rCity as [City]
    , Avg(points) as [Score]
FROM RST.Restaurant as r, RST.Score as s
WHERE r.restID = s.restID
    AND rState = 'New York'
GROUP BY r.restID, rName, rAddress, rCity
ORDER BY Avg(points) DESC;

-- * 4) Display restaurants that achieved a score of over 90
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], MAX(points) as [Best Score]
FROM RST.Restaurant as r, RST.Score as s
WHERE r.restID = s.restID
GROUP BY r.restID, rName, rAddress, rCity
    , rState
HAVING MAX(points) > 90
ORDER BY MAX(points) DESC; 

-- * 5) Display restaurants that achieved a score between 80 and 100
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], MAX(points) as [Best Score]
FROM RST.Restaurant as r, RST.Score as s
WHERE r.restID = s.restID
GROUP BY r.restID, rName, rAddress, rCity
    , rState
HAVING MAX(points) > 80 AND MAX(points) < 100
ORDER BY MAX(points) DESC; 

-- * 5b) Same as (5), but using MAX() OVER()
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State]
    , [Best Score] = MAX(points) OVER(partition by r.restID ORDER BY MAX(points) DESC)
FROM RST.Restaurant as r, RST.Score as s
WHERE r.restID = s.restID
HAVING MAX(points) > 80 AND MAX(points) < 100; */


-- * 6) Display restaurants who do not serve American cuisine and have a score over 70
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], rCuisine as [Cuisine], AVG(points) as [Score]
FROM RST.Restaurant as r, RST.Score as s
WHERE r.restID = s.restID
    AND rCuisine != 'American'
GROUP BY r.restID, rName, rAddress, rCity
    , rState, rCuisine
HAVING AVG(points) > 60
ORDER BY AVG(points) DESC;

-- * 7) Display restaurants who do not serve American cuisine and have a score over 70 and are in Dallas
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rCuisine as [Cuisine], AVG(points) as [Score]
FROM RST.Restaurant as r, RST.Score as s
WHERE r.restID = s.restID
    AND rCuisine != 'American'
    AND rCity = 'Dallas'
GROUP BY r.restID, rName, rAddress, rCity
    , rCuisine
HAVING AVG(points) > 60
ORDER BY AVG(points) DESC;

-- * 8) Display restaurants that do not serve American cuisine, have a grade of A, are not from Seattle. 
-- *    Sort by cuisine in descending order
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rCuisine as [Cuisine], grade as [Grade]
FROM RST.Restaurant
WHERE rCuisine != 'American'
    AND grade = 'A' 
    AND rCity != 'Seattle'
ORDER BY rCuisine DESC;

-- * 9) Display id, name, city, and cuisine for all restaurants that contain "reg" in the name
SELECT restID as [ID], rName as [Name], rCity as [City], rCuisine as [Cuisine]
FROM RST.Restaurant
WHERE rName LIKE '%reg%';

-- * 10) Display restaurants in Los Angeles that serve Italian or Chinese food
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rCuisine as [Cuisine]
FROM RST.Restaurant
WHERE rCity = 'Los Angeles'
    AND rCuisine IN ('Italian', 'Chinese');

-- * 11) Display restaurants that achieved a score less than a 10
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], MIN(points) as [Lowest Score]
FROM RST.Restaurant as r, RST.Score as s
GROUP BY rName, rAddress, rCity, rState
HAVING MIN(points)<10;

-- * 12) Display restaurants that achieved a score over 50 from 2022-01-01 to 2022-06-30
-- *    sort in descending order by score
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], AVG(points) as [Achieved Score]
    , reviewdate as [Date]
FROM RST.Restaurant as r, RST.Score as s
WHERE reviewdate BETWEEN '2022-01-01' AND '2022-06-30'
GROUP BY rName, rAddress, rCity, rState, reviewdate
HAVING AVG(points) > 50
ORDER BY AVG(points) DESC;

-- * 13) Display restaurants' information, and menu items costing over $20
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], rCuisine as [Cuisine], itemName as [Item]
    , price as [Cost $]
FROM RST.Restaurant as r, RST.MenuItem as m
WHERE r.restID = m.restID
    AND price > 20.0000
ORDER BY price, rName ASC;

-- * 13b) Same as 13, but using explicit JOIN
SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], rCuisine as [Cuisine], itemName as [Item]
    , price as [Cost $]
FROM RST.Restaurant as r
INNER JOIN RST.MenuItem as m ON r.restID = m.restID
WHERE price > 20.0000
ORDER BY price, rName ASC;

-- * SELF JOIN : Select restaurants that share the same name
select r1.rName as [Name 1], r1.rAddress as [Address], r2.rName as [Name 2], r2.rAddress as [Address 2]
from RST.Restaurant as r1, RST.Restaurant as r2
where r1.restID <> r2.restID
    AND r1.rName = r2.rName
order by r1.rName;