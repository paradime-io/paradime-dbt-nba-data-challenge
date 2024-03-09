{% macro iso_duration_to_seconds(column_name) %}
    -- Extract minutes and seconds directly, assuming no significant value after .00S
    (SPLIT_PART((SPLIT_PART({{ column_name }}, 'PT', 2)::VARCHAR), 'M', 1)::INT * 60) + 
    (SPLIT_PART(SPLIT_PART((SPLIT_PART({{ column_name }}, 'PT', 2)::VARCHAR), 'M', 2), 'S', 1)::FLOAT) 
{% endmacro %}
