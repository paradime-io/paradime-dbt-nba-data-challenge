WITH source AS (
    SELECT
        *
    FROM
        {{ source('NBA_API', 'PLAYBYPLAY') }}
),


renamed AS (
    SELECT
        gameId as game_id,
        actionId as action_id,
        {{ iso_duration_to_seconds('clock') }} as game_clock,
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
        isFieldGoal::BOOLEAN as is_field_goal,
        scoreHome as score_home,
        scoreAway as score_away,
        pointsTotal as score_total,
        location as game_location,
        description as play_description,
        actionType as action_type,
        subType as action_sub_type,
        videoAvailable::BOOLEAN as video_available
    FROM
        source
)

SELECT
    *
FROM
    renamed