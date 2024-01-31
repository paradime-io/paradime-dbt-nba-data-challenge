{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
        {%- if custom_schema_name is none -%}

            {{ default_schema }}

    {%- else -%}

        {%- if target.name == 'dev' -%}

                    {{ custom_schema_name }}

        {%- else -%}
        
    {{ default_schema | trim }}_{{ custom_schema_name | trim }}  

        {% endif %}    

    {%- endif -%}
{%- endmacro %}