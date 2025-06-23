{% snapshot snapshot_name %}
    {{
        config(
            unique_key='employee_id',
            strategy='check',
            check_cols=['first_name','last_name','salary','department_id']
        )
    }}

    select * from {{ref("Snapshot_employees")}}
 {% endsnapshot %}