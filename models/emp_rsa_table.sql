{{
    config(
        pre_hook=[pre_hook_log_rsa()],
        post_hook=[post_hook_log_rsa(),apply_rls_policy()]
    )
}}

select * from {{ref("Emp_With_Mgr")}}