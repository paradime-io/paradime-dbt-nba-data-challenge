 
    SELECT 
        player_id
      , full_name
      , CAST(birthdate AS DATE) AS birthdate_full
      , YEAR(birthdate) AS birthdate_year
      , MONTH(birthdate) AS birthdate_month
      , school
      , country AS birth_country
      , CASE WHEN country = 'USA' THEN TRUE 
             ELSE FALSE 
        END AS is_country_usa
      , ROUND( (SPLIT_PART(height,'-',1) * 12) + SPLIT_PART(height,'-',2) , 0) AS height_inches
      , weight
      , jersey AS jersey_number
      , position
      , roster_status
      , games_played_current_season_flag
      , g_league_has_played
      , nba_has_played
      , games_played
      , seasons_played
      , team_id AS most_recent_team_id
      , team_name AS most_recent_team_name
      , team_city AS most_recent_team_city
      , last_year_played AS most_recent_year_played
      , draft_year
      , draft_round
      , draft_number
      , greatest_75_member AS is_greatest_75_member
    FROM 
        -- Reference to the source data table containing player information
        {{ ref('stg_common_player_info') }}
    GROUP BY ALL
    
