{% set all_cols = ['team_id','points','FIELD_GOALS_MADE','FIELD_GOALS_ATTEMPTED','FIELD_GOAL_PCT','THREE_POINT_MADE','blocks'] %}

WITH final AS (
SELECT *
FROM {{ ref('stg_games') }}
)

SELECT game_id,
    {% for column in all_cols -%}
    MAX(CASE WHEN wl='W' THEN {{ column }} ELSE 0 END) AS w_{{ column }},
    MAX(CASE WHEN wl='L' THEN {{ column }} ELSE 0 END) AS l_{{ column }}
    {%- if not loop.last -%}
    ,
    {%- endif %}
    {% endfor -%}
FROM final 
GROUP BY 1 
ORDER BY 1