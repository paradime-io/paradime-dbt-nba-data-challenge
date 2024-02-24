  SELECT 
    age,
    {{ dbt_utils.pivot('season',
                       values=dbt_utils.get_column_values(ref('fct_player_season_age_points'), 'season', order_by='season desc'),
                       agg='sum',
                       then_value='season_points_percentage'
                       )
                     }}
  FROM {{ ref('fct_player_season_age_points') }}
  GROUP BY age