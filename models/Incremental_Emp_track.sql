{{
    config(
        materialized='incremental',
        transient=true,
        unique_key='employee_id'
    )
}}

select 
    employee_id,
    first_name,
    email,
    phone_number 
from {{source("src","Incremental_Src_Emp")}}
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where employee_id > (select max(employee_id) from {{this}}) 
{% endif %}