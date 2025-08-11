{{
    config(
        materialized='table',
        transient=false
    )
}}

select  
    employee_id,
    first_name,
    email,
    phone_number
from employees 