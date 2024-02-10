WITH playoff_stats AS (
    SELECT
        player_id,
        player_name,
        COUNT(*) AS playoff_games,
        SUM(CASE WHEN win_loss = 'W' THEN 1 ELSE 0 END) AS playoff_wins
    FROM
        {{ ref('stg_player_game_logs') }}
    WHERE
        game_type = 'Playoffs'
    AND
        mins_played > 0
    GROUP BY
        player_id,
        player_name
),
playoff_win_percentage AS (
    SELECT
        player_id,
        player_name,
        playoff_games,
        playoff_wins,
        (CAST(playoff_wins AS FLOAT) / playoff_games) AS win_percentage
    FROM
        playoff_stats
), 

nba_greatest AS (
    SELECT
        player_id,
        greatest_75_member
    FROM
        {{ ref('stg_common_player_info') }}
),

joined AS (
    SELECT
        pwp.*,
        ng.greatest_75_member
    FROM 
        playoff_win_percentage pwp
    JOIN nba_greatest ng ON
        pwp.player_id = ng.player_id
)

SELECT
    player_id,
    CASE 
        WHEN greatest_75_member = 'true' THEN player_name || '*'
        ELSE player_name
    END AS player_name,
    playoff_games,
    playoff_wins,
    win_percentage
FROM
    joined
ORDER BY
    playoff_games DESC, playoff_wins DESC
