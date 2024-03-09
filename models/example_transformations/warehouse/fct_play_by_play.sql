with

play_by_play as (

    select * from {{ ref('stg_play_by_play') }}

),

players as (

    select * from {{ ref('stg_common_player_info') }}

),

teams as (

    select * from {{ ref('stg_teams') }}

),

games as (

    select * from {{ ref('stg_games') }}

),

last_made_shot_base as (

    select 
        game_id, 
        action_id,
        ROW_NUMBER() OVER(PARTITION BY game_id ORDER BY action_id DESC) AS rn_shot_attempt
    from play_by_play
    where shot_result = 'Made'

),

last_made_shot as (
    select game_id, action_id, TRUE as last_made_shot from last_made_shot_base
    where rn_shot_attempt = 1
),

joined as (

    select
        play_by_play.*,
        players.birthdate,
        players.school,
        players.height,
        players.weight,
        players.position,
        players.games_played,
        players.greatest_75_member,
        teams.full_name,
        games.game_date,
        games.matchup,
        case
            when go_ahead_shot = TRUE AND last_made_shot.last_made_shot = TRUE  THEN TRUE
            else FALSE
        end as is_game_winner

    from play_by_play

    left join teams
        on play_by_play.team_id = teams.team_id
    left join players
        on play_by_play.player_id = players.player_id
    inner join games
        on play_by_play.game_id = '00' || games.game_id and  play_by_play.team_id = games.team_id
    left join last_made_shot
        on play_by_play.game_id = last_made_shot.game_id and play_by_play.action_id = last_made_shot.action_id

)

select * from joined
