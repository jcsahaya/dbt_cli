select *
from employees e1
where
    salary
    > (select avg(e2.salary) from employees e2 where e2.department_id = e1.department_id)
