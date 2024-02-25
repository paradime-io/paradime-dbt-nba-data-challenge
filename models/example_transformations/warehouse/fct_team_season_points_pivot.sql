WITH points_scored_pivoted AS (
  SELECT
    team_abbreviation,
    team_name,
    season,
    {{ dbt_utils.pivot('dim_home_away',
                       values=dbt_utils.get_column_values(ref('fct_team_season_points'), 'dim_home_away'),
                       agg='sum',
                       then_value='points_scored',
                       suffix='_points_scored',
                       quote_identifiers = false
                       )
                     }}
  FROM {{ ref('fct_team_season_points') }}
  GROUP BY 1, 2, 3
),
matches_played_pivoted AS (
  SELECT
    team_abbreviation,
    team_name,
    season,
    {{ dbt_utils.pivot('dim_home_away',
                       values=dbt_utils.get_column_values(ref('fct_team_season_points'), 'dim_home_away'),
                       agg='sum',
                       then_value='matches_played',
                       suffix='_matches_played',
                       quote_identifiers = false
                       )
                     }}
  FROM {{ ref('fct_team_season_points') }}
  GROUP BY 1, 2, 3
)

SELECT
  ps.team_abbreviation,
  ps.team_name,
  ps.season,
  ps.home_points_scored,
  ps.away_points_scored,
  mp.home_matches_played,
  mp.away_matches_played
FROM points_scored_pivoted AS ps
JOIN matches_played_pivoted AS mp
ON ps.team_abbreviation = mp.team_abbreviation
AND ps.season = mp.season
