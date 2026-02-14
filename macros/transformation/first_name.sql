{% macro first_name(full_name) %}
  split_part({{full_name}},' ',1)
{% endmacro %}