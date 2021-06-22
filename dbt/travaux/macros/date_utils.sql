{% macro timestamp_to_key(timestamp_column) -%}
coalesce(cast(to_char({{ timestamp_column }}::timestamp, 'YYYYMMDD') as int), 0)
{%- endmacro %}

{% macro timestamp_to_date(timestamp_column, dim_name) %}
  {{ timestamp_to_key(timestamp_column) }} as {{ dim_name }}_date
{% endmacro %}

{% macro timestamp_to_time(timestamp_column, dim_name) %}
case
  when {{ timestamp_column }} is null
    then '00:00:00+00':: time
    else cast({{ timestamp_column }} as time)
  end as {{ dim_name }}_time
{% endmacro %}

{% macro timestamp_to_dimension(timestamp_column, dim_name) %}
{{ timestamp_to_date(timestamp_column, dim_name) }}
,{{ timestamp_to_time(timestamp_column, dim_name) }}
{% endmacro %}
