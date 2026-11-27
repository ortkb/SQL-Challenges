#1667. Fix Names in a Table

select
    user_id
    ,concat(upper(left(name, 1)), lower(mid(name, 2))) as name
from
    users
order by user_id;

#1527. Patients With a Condition

select 
    * 
from 
    patients
where 
    conditions like 'DIAB1%'
    or conditions like '% DIAB1%';
	
#196. Delete Duplicate Emails

with minid_cte as (
    select
        email
        ,min(id) as minid
    from person
    group by 
        email
)

delete
    person
from 
    person 
left join 
    minid_cte
on
    person.id = minid_cte.minid
where 
    person.id <> minid
    or minid IS NULL;
	
#176. Second Highest Salary

select 
    max(salary) as SecondHighestSalary
from 
    employee
where salary <
    (
        select
            max(salary)
        from 
            employee
    );
	
#1484. Group Sold Products By The Date

select
    sell_date
    ,count(distinct product) as num_sold
    ,group_concat(distinct product order by product separator ",") as products
from 
	activities
group by 
	sell_date;
	
#1327. List the Products Ordered in a Period

select
    p.product_name
    ,sum(unit) as unit
from 
    products p 
left join 
    orders o
on 
    p.product_id = o.product_id
where 
    DATE_FORMAT(order_date, '%Y-%m-01') = '2020-02-01'
group by 
    p.product_id
having 
    sum(unit) >= 100;
	
#1517. Find Users With Valid E-Mails

select
    *
from 
    users
where 
    regexp_like(mail, '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$', 'c');
	