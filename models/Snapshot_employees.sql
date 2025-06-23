{{
    config(
        materialized='table',
        transient=false
    )
}}

select employee_id, first_name,last_name,
salary,department_id from employees