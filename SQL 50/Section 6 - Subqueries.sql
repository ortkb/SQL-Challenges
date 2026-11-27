# 1978. Employees Whose Manager Left the Company

select 
    employee_id
from 
    employees
where 
    salary < 30000 
    and manager_id not in (select employee_id from employees)
order by employee_id;

#626. Exchange Seats

select
    id
    ,case
        when 
            id % 2 = 0 
        then 
            LAG(student) over (order by id)
        when 
            id % 2 = 1 
            and id = (select count(*) from seat) 
        then 
            student
        else # when id % 2 = 1
            lead(student) over (order by id)
    end as student
from seat;

#1341. Movie Rating

with topuser as (
    select
        u.user_id
        ,name as results
        ,count(mr.movie_id) as review_count
    from users u
    inner join 
        movierating mr
    on
        u.user_id = mr.user_id
    group by 
        u.user_id, name
    order by
        count(mr.movie_id) desc, name asc
    limit 1
)

, topfilm as (
    select 
        mr.movie_id
        ,title as results
        ,avg(rating)
    from 
        movierating mr
    inner join 
        movies m
    on 
        mr.movie_id = m.movie_id
    where 
        date_format(created_at, '%Y-%m-01') = '2020-02-01'
    group by 
        mr.movie_id
    order by avg(rating) desc, title asc
    limit 1
)

select results from topuser
UNION ALL
select results from topfilm;

#1321. Restaurant Growth

with dates as (
select
    visited_on
    ,sum(amount) over w as amount
    ,round((sum(amount) over w)/7, 2) as average_amount
from 
    customer
window 
    w as ( order by visited_on range between interval 6 day preceding and current row)
order by 
    visited_on asc
)

select 
    *
from 
    dates
where 
    datediff(
        visited_on, 
        (select min(visited_on) from customer)) >= 6
group by visited_on;

#602. Friend Requests II: Who Has the Most Friends

with counts as (
select
    accepter_id as id
from 
    requestaccepted

UNION ALL

select
    requester_id as id
from 
    requestaccepted
)

select
    id
    ,count(id) as num
from 
    counts
group by 
    id
order by num desc
limit 1;

#585. Investments in 2016

with 2025_check as (
select 
    tiv_2015
from 
    insurance 
group by 
    tiv_2015
having 
    count(tiv_2015) > 1
)

,latlon_check as (
select 
    concat(lat, '-' ,lon) as latlon
from 
    insurance 
group by 
    latlon
having count(concat(lat, '-',lon)) = 1
) 

select 
    round(sum(tiv_2016), 2) as tiv_2016
from 
    insurance i
inner join 
    2025_check 
on 
    i.tiv_2015 = 2025_check.tiv_2015
inner join  
    latlon_check
on
    concat(i.lat, '-' ,i.lon) = latlon_check.latlon
;

#185. Department Top Three Salaries

with rankings as (
    select
        d.name as Department
        ,e.name as Employee
        ,e.salary as Salary
        ,dense_rank() over (partition by d.name order by salary desc) as salary_rank
    from 
        employee e
    left join 
        department d
    on 
        e.departmentId = d.id
    -- group by 
    --     d.name
    order by 
        department asc, salary desc
)

select 
    Department
    ,Employee
    ,Salary
from 
    rankings
where 
    salary_rank <= 3;
