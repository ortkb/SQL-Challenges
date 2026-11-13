#620. Not Boring Movies

SELECT *
FROM Cinema
WHERE description <> 'boring'
    AND id % 2 = 1 
ORDER BY rating desc;

#1251. Average Selling Price

select 
    p.product_id
    ,IFnull(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) AS average_price
from 
    prices p
left join 
    unitssold u
on
     p.product_id  = u.product_id
    AND u.purchase_date between p.start_date AND p.end_date
group by 
    p.product_id;

#1075. Project Employees I

select
    project_id
    , round( avg(experience_years), 2 )  as average_years
from 
    employee e 
join 
    project p
on 
    e.employee_id = p.employee_id
group by 
    project_id;

#1633. Percentage of Users Attended a Contest

select
    contest_id
    ,round (
        count(distinct user_id) / (select count(distinct user_id) from users) * 100
    , 2) as percentage
from 
    register
group by 
    contest_id
order by 
    percentage desc, contest_id asc;

#1211. Queries Quality and Percentage

with poor as (
    select 
        query_name
        ,count(rating) as poor_count
    from 
        queries 
    where 
        rating < 3
    group by 
        query_name
)

select
    q.query_name
    , round( avg(rating/position), 2 ) as quality
    , coalesce(( poor_count / count(rating) )* 100, 0) as poor_query_percentage
from 
    queries q
left join 
    poor 
on 
    q.query_name = poor.query_name
group by
    q.query_name;

#1193. Monthly Transactions I

select
    LEFT(DATE_FORMAT(trans_date, '%Y-%m-01'), 7) as month
    ,country
    ,count(id) as trans_count
    ,count(
        case 
            when    
                state = 'approved'
            then
                1
            else 
                null
            
            end
        ) as approved_count
    ,sum(amount) as trans_total_amount
    ,sum(
        case 
            when    
                state = 'approved'
            then
                amount
            else 
                0
            end 
    ) as approved_total_amount
from transactions
group by month, country

#1174. Immediate Food Delivery II

#550. Game Play Analysis IV


