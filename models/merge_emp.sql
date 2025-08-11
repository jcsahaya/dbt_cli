{{
    config(
        materialized='table',
        transient=false
    )
}}

select employee_id, first_name, department_id,
hire_date
from employees