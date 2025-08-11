{{
    config(
        materialized='table'
    )
}}

select id, name, sal, sum(sal) over (order by id) as cummulative_sal from Cum_Sal