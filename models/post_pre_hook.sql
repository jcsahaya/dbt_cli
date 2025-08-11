{{
    config(
        materialized='table',
        pre_hook=[
            "insert into model_audit_log
            (model_name,
            environment,
            status,
            run_started_at) 
            values('{{this.identifier}}',
                    '{{target.name}}',
                    'STARTED',
                    current_timestamp)"
        ],
        post_hook=[
            " update model_audit_log 
            set status='COMPLETED',
                run_completed_at = current_timestamp
            where model_name = '{{this.identifier}}'
            and environment = '{{target.name}}'
            and run_completed_at is null"
        ]
    )
}}

select employee_id, first_name,department_id
from {{source('src','merge_emp')}}