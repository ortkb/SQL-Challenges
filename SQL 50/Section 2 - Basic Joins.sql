#1378. Replace Employee ID With The Unique Identifier

SELECT unique_id, name
FROM employees
LEFT JOIN EmployeeUNI
ON employees.id = EmployeeUNI.id;

#1068. Product Sales Analysis I

SELECT product_name, year, price
FROM sales
LEFT JOIN product 
ON sales.product_id = product.product_id;

#1581. Customer Who Visited but Did Not Make Any Transactions

SELECT customer_id, COUNT(distinct visits.visit_id) as count_no_trans
FROM visits
LEFT JOIN Transactions
ON visits.visit_id = transactions.visit_id
WHERE amount = 0 or ISNULL(amount)
GROUP BY customer_id;

#197. Rising Temperature

SELECT 
w1.id
FROM WEATHER as w1
LEFT JOIN WEATHER as w2 on w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY) 
WHERE w1.temperature > w2.temperature;

#1661. Average Time of Process per Machine

with values_cte as (
    select 
        machine_id
        ,process_id
    ,min(CASE WHEN activity_type = 'start' THEN timestamp END) as starttime
    ,min(case when activity_type = 'end' then timestamp end) as endtime
    from activity
    group by machine_id, process_id
)

select 
machine_id
,ROUND(AVG(endtime - starttime), 3) as processing_time
from values_cte
group by machine_id;

#577. Employee Bonus

select 
    name
    ,bonus
from employee
left join bonus on employee.empId = bonus.empId
where bonus IS NULL OR bonus < 1000;

#1280. Students and Examinations

Select
    s.student_id
    ,s.student_name
    ,subj.subject_name
    ,count(e.subject_name) as attended_exams
from 
    students s
cross join
    subjects subj
left join
    examinations e
on
    s.student_id = e.student_id
    AND subj.subject_name = e.subject_name 
group by
    s.student_id
    ,subj.subject_name
order by 
    s.student_id
;

#570. Managers with at Least 5 Direct Reports

#1934. Confirmation Rate

with confirmed as 
(
    select 
        s.user_id
        ,count(c.user_id) as all_count
        ,count(     
            case 
            when action = 'confirmed' then 1
            else null end
        ) as confirmed_count
    from 
        confirmations c
    right join 
        signups s
    on
        s.user_id = c.user_id
    group by
        s.user_id
)

select 
    user_id
    ,round(
        case 
            when 
                all_count > 0
            then 
                confirmed_count/all_count
            else
                0
            end 
    , 2)as confirmation_rate
from 
    confirmed




