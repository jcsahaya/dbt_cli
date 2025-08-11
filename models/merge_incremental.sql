{{
    config(
        materialized='incremental',
        unique_key='employee_id',
        incremental_strategy='merge'
    )
}}

with source_data as (
    select employee_id, first_name, 
    department_id, hire_date,
    MD5(first_name||department_id|| to_varchar(hire_date)) as row_hash
    from {{source('src','merge_emp')}}
)

select * from source_data

{% if is_incremental() %}
where employee_id not in (select employee_id from {{this}})
or row_hash !=(select row_hash from {{this}} where {{this}}.employee_id=source_data.employee_id)
{% endif %}