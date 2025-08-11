{% macro pre_hook_log2()%}
	insert into model_audit_log2
            (model_name,
            environment,
            table_type,
            status,
            run_started_at) 
            values('{{this.identifier}}',
                    '{{target.name}}',
                    '{{config.get("materialized")}}',
                    'STARTED',
                    current_timestamp)
{% endmacro %}

{% macro post_hook_log2() %}
	        update model_audit_log2 
            set status='COMPLETED',
                run_completed_at = current_timestamp,
                row_count = (select count(*) from {{this}})
            where model_name = '{{this.identifier}}'
            and environment = '{{target.name}}'
            and run_completed_at is null
{% endmacro %}

{% macro pre_hook_log3()%}
	insert into model_audit_log3
            (model_name,
            environment,
            table_type,
            is_transient,            
            status,
            run_started_at) 
            values('{{this.identifier}}',
                    '{{target.name}}',
                    '{{config.get("materialized","unknown")}}',
                    {% if config.get("transient", false) %} TRUE {% else %} FALSE {% endif %},
                    'STARTED',
                    current_timestamp)
{% endmacro %}

{% macro post_hook_log3() %}
	        update model_audit_log3 
            set status='COMPLETED',
                run_completed_at = current_timestamp,
                row_count = (select count(*) from {{this}})
            where model_name = '{{this.identifier}}'
            and environment = '{{target.name}}'
            and run_completed_at is null
{% endmacro %}

{% macro pre_hook_log_rsa() %}
    insert into rsa_audit_log (model_name,run_by,event,run_at)
    values('{{this.name}}','{{target.name}}','end',current_timestamp);
{% endmacro %}

{% macro post_hook_log_rsa() %}
    insert into rsa_audit_log (model_name,run_by,event,run_at)
    values('{{this.name}}','{{target.name}}','end',current_timestamp());
{% endmacro %}

{% macro apply_rls_policy(policy_name='rls_policy',column_name='department_id') %}
    alter table {{this}} add row access policy {{policy_name}} on ({{column_name}});
{% endmacro %}