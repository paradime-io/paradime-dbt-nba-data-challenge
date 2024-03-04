WITH logs AS (SELECT * FROM {{ref('stg_player_game_logs')}}),

{% set game_types=['Regular Season','Playoffs'] -%}

{% for game_type in game_types%}

{{game_type|lower()|replace(' ','_')}}_stats AS (
    SELECT
        player_id,
        season,
        SUM(field_goals_made) AS {{game_type|lower()|replace(' ','_')}}_field_goals_made,        
        SUM(field_goals_attempted) AS {{game_type|lower()|replace(' ','_')}}_field_goals_attempted,      
        SUM(field_goals_made) / NULLIF(SUM(field_goals_attempted), 0) AS {{game_type|lower()|replace(' ','_')}}_field_goal_pct,       
        SUM(three_point_made) AS {{game_type|lower()|replace(' ','_')}}_three_point_made,
        SUM(three_point_attempted) AS {{game_type|lower()|replace(' ','_')}}_three_point_attempted,       
        SUM(three_point_made) / NULLIF(SUM(three_point_attempted), 0) AS {{game_type|lower()|replace(' ','_')}}_three_point_pct, 
        SUM(free_throws_made) AS {{game_type|lower()|replace(' ','_')}}_free_throws_made,
        SUM(free_throws_attempted) AS {{game_type|lower()|replace(' ','_')}}_free_throws_attempted,
        SUM(free_throws_made) / NULLIF(SUM(free_throws_attempted), 0) AS {{game_type|lower()|replace(' ','_')}}_free_throw_pct,
        AVG(total_rebounds) AS {{game_type|lower()|replace(' ','_')}}_avg_rebounds,
        AVG(assists) AS {{game_type|lower()|replace(' ','_')}}_avg_assists,
        AVG(blocks) AS {{game_type|lower()|replace(' ','_')}}_avg_blocks,
        AVG(steals) AS {{game_type|lower()|replace(' ','_')}}_avg_steals,
        AVG(points) AS {{game_type|lower()|replace(' ','_')}}_avg_points,
        SUM(plus_minus) AS {{game_type|lower()|replace(' ','_')}}_plus_minus,
        SUM(CASE WHEN mins_played > 0 THEN 1 ELSE 0 END) AS {{game_type|lower()|replace(' ','_')}}_games_played
    FROM
        logs
    WHERE 
        game_type='{{game_type}}'
    GROUP BY 1,2
),
{%endfor%}

joined AS (
    SELECT
        *
    FROM
        regular_season_stats
    LEFT JOIN
        playoffs_stats
    USING(player_id,season)
)

SELECT * FROM joined
