#2356. Number of Unique Subjects Taught by Each Teacher

SELECT
    teacher_id
    ,count(distinct subject_id) as cnt
from 
    teacher
group by 
    teacher_id;

#1141. User Activity for the Past 30 Days I

select
    activity_date as day
    , count(distinct user_id) as active_users
from activity
where 
    activity_date 
    between
        date_add('2019-07-27', interval -29 day) AND '2019-07-27'
group by
    activity_date;

#1070. Product Sales Analysis III

with firstyearcte as
(
    select 
        product_id
        , min(year) as first_year
    from sales
    group by product_id
)

select
    s.product_id
    ,fy.first_year
    ,quantity
    ,price
from sales s
left join 
    firstyearcte as fy
on
    s.product_id = fy.product_id
where 
    s.year = fy.first_year;

#596. Classes With at Least 5 Students

select
    class
from 
    courses
group by
    class
having 
    count(distinct student) >= 5;

#1729. Find Followers Count

select
    user_id
    ,count(follower_id) as followers_count
from 
    followers
group by 
    user_id
order by 
    user_id asc;

#619. Biggest Single Number

with singleNumbers as
(
    select 
        num
    from 
        mynumbers
    group by 
        num
    having 
        count(num) = 1
)

select 
    max(num) as num
from 
    singlenumbers;

#1045. Customers Who Bought All Products

select 
    c.customer_id
from 
    customer c
left join 
    product p
on 
    c.product_key = p.product_key
group by 
    customer_id
having 
    count(distinct c.product_key) = (select count(distinct product_key) from product)
;