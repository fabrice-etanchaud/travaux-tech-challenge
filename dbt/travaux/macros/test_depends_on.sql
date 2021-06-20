{% macro dependencies(model, column_name, fields) %}

  select
    {{ fields | join(', ') }}
    ,count(distinct {{ column_name }}) as dependencies_count
  from
    {{ model }}
  group by
    {{ fields | join(', ') }}

{% endmacro %}

{% macro test_depends_on(model, column_name, fields) %}

with dependency_error as (

  {{ dependencies(model, column_name, fields) }}

)

select count(*)
from dependency_error
where dependencies_count > 1
    
{% endmacro %}

{% macro test_does_not_depend_on(model, column_name, fields) %}

with dependency_error as (

  {{ dependencies(model, column_name, fields) }}

)

select case when sum(dependencies_count) > count(*) then 0 else 1 end
from dependency_error

{% endmacro %}

