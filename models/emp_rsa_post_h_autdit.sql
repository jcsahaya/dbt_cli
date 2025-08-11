{{
    config(
        pre_hook=[pre_hook_log3()],
        post_hook=[post_hook_log3(),apply_rls_policy()]
    )
}}

select * from {{ref("Emp_With_Mgr")}}