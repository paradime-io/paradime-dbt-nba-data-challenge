
with stg_team_games as (
    select * from {{ ref('int_team_game_logs_per_season_agg') }}
),

stg_team_spend_by_season as (
    select * from {{ ref('stg_team_spend_by_season') }}
),

final as (
    select
        --  stg_team_games.season,
        substring(stg_team_games.season, 3, 6) as season_start,
        stg_team_games.team_name,
        max(stg_team_spend_by_season.team_payroll),
        sum(stg_team_games.win_counter) as win_counter,
        sum(stg_team_games.loss_counter) as loss_counter,
        div0(max(stg_team_spend_by_season.team_payroll), sum(stg_team_games.win_counter)) as spend_per_win
    from stg_team_games
    inner join stg_team_spend_by_season
        on stg_team_games.team_id = stg_team_spend_by_season.team_id
        and stg_team_games.season = stg_team_spend_by_season.season
    group by 1, 2
)

select * from final
