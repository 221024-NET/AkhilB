-- ! 1) Select all fields from the restaurant table
/* SELECT * FROM RESTAURANTS.Restaurant;  */

-- ! 2) Display all restaurants in Orlando, FL
/* SELECT rName as [In Orlando]
FROM RESTAURANTS.Restaurant
WHERE rCity = 'Orlando'; */

-- ! 3) Display top 5 restaurants in new york (score based)
/* SELECT TOP 5 rName as [Restaurant], rAddress as [Address], rCity as [City], rState as [State]
    , Avg(points) as [Score]
FROM RESTAURANTS.Restaurant, RESTAURANTS.Score
WHERE RESTAURANTS.Restaurant.restID = RESTAURANTS.Score.restID
    AND rState = 'New York'
GROUP BY RESTAURANTS.Restaurant.restID, rName, rAddress, rCity, rState
ORDER BY Avg(points) DESC; */

-- ! 4) Display restaurants that achieved a score of over 90
-- ! Looks like with the data entered, no restaurant had an average score above 90, so we'll have to settle for 70's
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], MAX(points) as [Best Score]
FROM RESTAURANTS.Restaurant, RESTAURANTS.Score
WHERE RESTAURANTS.Restaurant.restID = RESTAURANTS.Score.restID
GROUP BY RESTAURANTS.Restaurant.restID, rName, rAddress, rCity
    , rState
HAVING MAX(points) > 90
ORDER BY MAX(points) DESC;  */

-- ! 5) Display restaurants that achieved a score between 80 and 100
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], MAX(points) as [Best Score]
FROM RESTAURANTS.Restaurant, RESTAURANTS.Score
WHERE RESTAURANTS.Restaurant.restID = RESTAURANTS.Score.restID
GROUP BY RESTAURANTS.Restaurant.restID, rName, rAddress, rCity
    , rState
HAVING MAX(points) > 80 AND MAX(points) < 100
ORDER BY MAX(points) DESC;  */

-- ! 6) Display restaurants who do not serve American cuisine and have an average score over 70
-- ! Depending on what the python script generates, we might not see anything above 70
-- !    so I'll alter this accordingly
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], rCuisine as [Cuisine], AVG(points) as [Score]
FROM RESTAURANTS.Restaurant, RESTAURANTS.Score
WHERE RESTAURANTS.Restaurant.restID = RESTAURANTS.Score.restID
    AND rCuisine != 'American'
GROUP BY RESTAURANTS.Restaurant.restID, rName, rAddress, rCity
    , rState, rCuisine
HAVING AVG(points) > 60
ORDER BY AVG(points) DESC; */

-- ! 7) Display restaurants who do not serve American cuisine and have a score over 70 and are in Dallas
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rCuisine as [Cuisine], AVG(points) as [Score]
FROM RESTAURANTS.Restaurant, RESTAURANTS.Score
WHERE RESTAURANTS.Restaurant.restID = RESTAURANTS.Score.restID
    AND rCuisine != 'American'
    AND rCity = 'Dallas'
GROUP BY RESTAURANTS.Restaurant.restID, rName, rAddress, rCity
    , rCuisine
HAVING AVG(points) > 60
ORDER BY AVG(points) DESC; */

-- ! 8) Display restaurants that do not serve American cuisine, have a grade of A, are not from Seattle. 
-- !    Sort by cuisine in descending order
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rCuisine as [Cuisine], grade as [Grade]
FROM RESTAURANTS.Restaurant
WHERE rCuisine != 'American'
    AND grade = 'A' 
    AND rCity != 'Seattle'
ORDER BY rCuisine DESC; */

-- ! 9) Display id, name, city, and cuisine for all restaurants that contain "reg" in the name
/* SELECT restID as [ID], rName as [Name], rCity as [City], rCuisine as [Cuisine]
FROM RESTAURANTS.Restaurant
WHERE rName LIKE '%reg%'; */

-- ! 10) Display restaurants in Los Angeles that serve Italian or Chinese food
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rCuisine as [Cuisine]
FROM RESTAURANTS.Restaurant
WHERE rCity = 'Los Angeles'
    AND rCuisine IN ('Italian', 'Chinese'); */

-- ! 11) Display restaurants that achieved a score less than a 10
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], MIN(points) as [Lowest Score]
FROM RESTAURANTS.Restaurant, RESTAURANTS.Score
GROUP BY rName, rAddress, rCity, rState
HAVING MIN(points)<10; */

-- ! 12) Display restaurants that achieved a score over 50 from 2022-01-01 to 2022-06-30
-- !    sort in descending order by score
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], MAX(points) as [Achieved Score]
    , reviewdate as [Date]
FROM RESTAURANTS.Restaurant, RESTAURANTS.Score
GROUP BY rName, rAddress, rCity, rState, reviewdate
HAVING MAX(points) > 50
    AND reviewdate BETWEEN '2022-01-01' AND '2022-06-30'
ORDER BY MAX(points) DESC; */

-- ! 13) Display restaurants' information, and menu items costing over $20
/* SELECT rName as [Restaurant], rAddress as [Address], rCity as [City]
    , rState as [State], rCuisine as [Cuisine], itemName as [Item]
    , price as [Cost +' ' char(24)]
FROM RESTAURANTS.Restaurant, RESTAURANTS.MenuItem
WHERE RESTAURANTS.Restaurant.restID = RESTAURANTS.MenuItem.restID
    AND price > 20.0000
ORDER BY price, rName ASC; */