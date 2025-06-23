{% macro full__name(a,b) %}
    concat(upper({{a}})||' '||upper({{b}}))
{% endmacro %}