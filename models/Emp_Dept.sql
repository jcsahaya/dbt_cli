{{
    config(
        materialized='table',
        transient=false
    )
}}

select e.employee_id, concat(e.first_name||' '||e.last_name) as Full_Name, 
e.salary, d.department_name, e.manager_id, concat(e1.first_name||' '||e1.last_name) as Manager_Name 
from employees e
join employees e1 
on e.manager_id = e1.employee_id
join departments d
on e.department_id = d.department_id