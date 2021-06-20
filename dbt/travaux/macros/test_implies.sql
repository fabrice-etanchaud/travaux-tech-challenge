{% macro implications(model, column_name, fields) %}

  select
    {{ column_name }}
    ,count(distinct (
       {%- for field in fields -%}
         coalesce(cast({{ field }} as text), '')
         {% if not loop.last %} || ';' || {% endif %}
       {%- endfor -%}
    )) as implications_count
  from
    {{ model }}
  group by
    {{ column_name }}

{% endmacro %}

{% macro test_implies(model, column_name, fields) %}

with dependency_error as (
  {{ implications(model, column_name, fields) }}
)

select count(*) 
from dependency_error
where implications_count > 1

{% endmacro %}

{% macro test_does_not_imply(model, column_name, fields) %}

with dependency_error as (
  {{ implications(model, column_name, fields) }}
)

select case when sum(implications_count) > count(*) then 0 else 1 end
from dependency_error

{% endmacro %}

