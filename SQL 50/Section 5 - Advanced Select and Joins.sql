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