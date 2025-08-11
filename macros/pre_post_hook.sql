{% macro pre_hook_log()%}
	insert into model_audit_log1
            (model_name,
            environment,
            status,
            run_started_at) 
            values('{{this.identifier}}',
                    '{{target.name}}',
                    'STARTED',
                    current_timestamp)
{% endmacro %}

{% macro post_hook_log() %}
	        update model_audit_log1 
            set status='COMPLETED',
                run_completed_at = current_timestamp,
                row_count = (select count(*) from {{this}})
            where model_name = '{{this.identifier}}'
            and environment = '{{target.name}}'
            and run_completed_at is null
{% endmacro %}