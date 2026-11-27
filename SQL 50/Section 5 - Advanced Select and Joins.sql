#1731. The Number of Employees Which Report to Each Employee

with reports_to_cte as(
    select
        employee_id
        ,reports_to
        ,count(employee_id) as reports_count
        ,round(avg(age)) as average_age
    from 
        employees
    group by 
        reports_to
)

select 
    e.employee_id
    ,name
    ,reports_count
    ,average_age
from
    employees e
inner join
    reports_to_cte r
on e.employee_id = r.reports_to
order by 
        e.employee_id asc
;

#1789. Primary Department for Each Employee

with flagged_depts as(
    select 
        department_id as flagged_dept
        ,employee_id
    from employee
    where primary_flag = 'y'
    group by employee_id
)

select
    e.employee_id
    ,ifnull(
        flagged_dept
        ,
        case
            when
                count(department_id) = 1 
            then 
                department_id
            else
                -1
        end 
    ) 
    as department_id 
from 
    employee e 
left join 
    flagged_depts flg
on
    e.employee_id = flg.employee_id
group by    
    e.employee_id
;

#610. Triangle Judgement

# good one-line ver from solutions
# select *, if(x+y>z and y+z>x and x+z>y, "Yes","No") as triangle from triangle;

with longestline as (
    select
        x as _x
        ,y as _y
        ,z as _z
        ,case
            when x >= y AND x >= z then x
            when y >= x AND y >= z then y
            when z >= x AND z >= y then z
        end as longest
    from triangle
)

select 
    x
    ,y
    ,z
    ,case
        when longest = x and (y+z) > x then 'Yes'
        when longest = y and (x+z) > y then 'Yes'
        when longest = z and (x+y) > z then 'Yes'
        else 'No'
    end as triangle
from 
    triangle t
left join
    longestline
on
    x = _x and y = _y and z = _z
;

#180. Consecutive Numbers

with consecutiveNumsSource as
(
    select
        num 
        ,lead(num) over (order by id asc) as second
        ,lead(num, 2) over (order by id asc) as third
    from logs
)

select
    distinct num as ConsecutiveNums
from 
    consecutiveNumsSource
where 
    num = second and second = third;
	
#1164. Product Price at a Given Date

with prices as(
    select * 
    from 
        products
    where (product_id, change_date) IN
    (
        select
            product_id
            ,max(change_date)
        from 
            products
        where 
            change_date <= '2019-08-16'
        group by 
            product_id
    )
)

select
    p.product_id
    ,avg( coalesce(pr.new_price, 10) ) as price
from 
    products p
left join 
    prices pr
on
    p.product_id = pr.product_id
group by p.product_id;

#1204. Last Person to Fit in the Bus

with total_weight_cte as
(
    select
    *
    ,sum(weight) over (order by turn asc) as total_weight
    from queue
    order by turn
)

select
    person_name
from 
    total_weight_cte
where 
    total_weight <= 1000
order by 
    total_weight desc
limit 1;

#1907. Count Salary Categories

select 
    "Low Salary" as category
    ,count(case 
        when
            income < 20000
        then 
            1
        else 
            null
        end
        ) as accounts_count
from accounts
UNION ALL
select 
    "Average Salary" as category
    ,count(case 
        when
            income >= 20000 and income <= 50000 
        then 
            1
        else 
            null
        end
        ) as accounts_count
from accounts
UNION ALL
select 
    "High Salary" as category
    ,count(case 
        when
            income > 50000 
        then 
            1
        else 
            null
        end
        ) as accounts_count
from accounts;