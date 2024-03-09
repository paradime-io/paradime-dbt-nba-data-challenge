WITH source AS (
    SELECT
        distinct *
    FROM
        {{ source('NBA_API', 'PLAYBYPLAY') }}
),


renamed AS (
    SELECT
        case when len(gameId) = 8 then '00' || gameId else gameId end as game_id,
        actionId as action_id,
        {{ iso_duration_to_seconds('clock') }} as game_clock,
        case when {{ iso_duration_to_seconds('clock') }} <= 300 and period >= 4  and  ABS(scoreHome - scoreAway) <= 5 then true else false end as is_clutch_time,
        case when {{ iso_duration_to_seconds('clock') }} <= 75 and period >= 4  and  ABS(scoreHome - scoreAway) <= 5 then true else false end as is_clutch_squared_time,
        period,
        teamId as team_id,
        teamTricode as team_abbreviation,
        personId as player_id,
        playerName as player_family_name,
        playerNameI as player_name,
        xLegacy as shot_x_coordinate,
        yLegacy as shot_y_coordinate,
        shotDistance as shot_distance,
        shotResult as shot_result,
        CASE 
            WHEN shotResult = 'Made'
            AND (
                (location = 'h' AND scoreHome > scoreAway = TRUE AND LAG(scoreHome > scoreAway) OVER(PARTITION BY gameId ORDER BY actionId) = FALSE)
                OR 
                (location = 'v' AND scoreHome > scoreAway = FALSE AND LAG(scoreHome > scoreAway) OVER(PARTITION BY gameId ORDER BY actionId) = TRUE)
            )
            THEN TRUE
            ELSE FALSE 
        END AS go_ahead_shot,
        isFieldGoal::BOOLEAN as is_field_goal,
        scoreHome as score_home,
        scoreAway as score_away,
        pointsTotal as score_total,
        CASE WHEN location = 'h' then 'Home' else 'Away' END  as game_location,
        description as play_description,
        actionType as action_type,
        subType as action_sub_type,
        videoAvailable::BOOLEAN as video_available
    FROM
        source
)

SELECT
    distinct *
FROM
    renamed