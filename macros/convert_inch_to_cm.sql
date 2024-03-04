{% macro convert_inch_to_cm(height) -%}

ROUND((CAST(SPLIT_PART({{height}},'-',1) AS INTEGER)*30.48)+(CAST(SPLIT_PART({{height}},'-',2) AS INTEGER)*2.54))

{%- endmacro %}