{{
    config(
        materialized='table',
        transient=false
    )
}}

select e.employee_id, concat(e.first_name||' '||e.last_name) as Full_Name, 
e.salary, e.department_id, e.manager_id, concat(e1.first_name||' '||e1.last_name) as Manager_Name 
from employees e
join employees e1 
on e.manager_id = e1.employee_id
where e.salary
    > (select avg(e1.salary) from employees e1 where e1.department_id = e.department_id)