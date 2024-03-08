
with stg_games as (
    select * from {{ ref('stg_games') }}
),

stg_player_games as (
    select * from {{ ref('stg_player_game_logs') }}
),

-- Formula taken from our good friend, Mr. GPT
team_possessions as (
    SELECT
        team_id,
        game_id,
        0.96 * (
            SUM(coalesce(field_goals_attempted, 0))
            + SUM(coalesce(turnovers, 0))
            + 0.44 * SUM(coalesce(free_throws_attempted, 0))
            - SUM(coalesce(offensive_rebounds, 0))
        )
        AS team_possessions
    FROM stg_games
    group by 1, 2
),

player_stats as (
    SELECT 
        player_id,
        player_name,
        --  game_id,
        count(*) as total_games,
        sum(points) AS total_points,
        sum(total_rebounds) AS total_rebounds,
        sum(assists) AS assists,
        sum(steals) AS steals,
        sum(blocks) AS blocks,
        sum(field_goals_attempted) AS field_goals_attempted,
        sum(field_goals_made) AS field_goals_made,
        sum(free_throws_attempted) AS free_throws_attempted,
        sum(free_throws_made) AS free_throws_made,
        sum(turnovers) AS turnovers,
        sum(team_possessions) AS team_possessions
    FROM stg_player_games
    left join team_possessions
        on stg_player_games.team_id = team_possessions.team_id
        and stg_player_games.game_id = team_possessions.game_id
    GROUP BY 1, 2
)

SELECT
    player_id,
    player_name,
    div0((total_points + (total_rebounds + assists + steals + blocks) - (field_goals_attempted - field_goals_made) - (free_throws_attempted - free_throws_made) + turnovers), team_possessions) AS player_efficiency_ratio,
    --  div0((total_points
    --      + (coalesce(total_rebounds, 0) + coalesce(assists, 0) + coalesce(steals, 0) + coalesce(blocks, 0))
    --      - (coalesce(field_goals_attempted, 0) - coalesce(field_goals_made, 0))
    --      - (coalesce(free_throws_attempted, 0) - coalesce(free_throws_made, 0))
    --      + coalesce(turnovers, 0))
    --  , team_possessions) AS player_efficiency_ratio,
    div0(total_points, total_games) as points_per_game,
    * exclude(player_id, player_name)
FROM player_stats