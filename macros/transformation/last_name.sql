{% macro last_name(full_name) %}
  trim(right({{ full_name }},length({{ full_name }})-position(' ' in {{ full_name }})))
{% endmacro %}