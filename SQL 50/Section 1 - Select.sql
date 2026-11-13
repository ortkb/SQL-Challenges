#1757. Recyclable and Low Fat Products

SELECT product_id
FROM products
WHERE low_fats = 'Y' AND recyclable = 'Y';

#584. Find Customer Referee

SELECT name
FROM customer
WHERE referee_id != 2 OR isnull(referee_id);

#595. Big Countries

SELECT name, population, area
FROM world
WHERE 
area >= 3000000 
OR population >= 25000000;

#1148. Article Views I

SELECT DISTINCT
author_id as id
FROM views
WHERE viewer_id = author_id
ORDER BY id ASC;

#1683. Invalid Tweets

select tweet_id
from tweets
where LENGTH(content) > 15
;
