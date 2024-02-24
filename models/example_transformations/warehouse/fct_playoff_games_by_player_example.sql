with
    playoff_stats as (
        select
            player_id,
            player_name,
            count(*) as playoff_games,
            sum(case when win_loss = 'W' then 1 else 0 end) as playoff_wins
        from {{ ref('stg_player_game_logs') }}
        where game_type = 'Playoffs' and mins_played > 0
        group by player_id, player_name
    ),
    playoff_win_percentage as (
        select
            player_id,
            player_name,
            playoff_games,
            playoff_wins,
            (cast(playoff_wins as float) / playoff_games) as win_percentage
        from playoff_stats
    ),

    nba_greatest as (
        select player_id, greatest_75_member from {{ ref('stg_common_player_info') }}
    ),

    joined as (
        select pwp.*, ng.greatest_75_member
        from playoff_win_percentage pwp
        join nba_greatest ng on pwp.player_id = ng.player_id
    )

select
    player_id,
    case
        when greatest_75_member = 'true' then player_name || '*' else player_name
    end as player_name,
    playoff_games,
    playoff_wins,
    win_percentage
from joined
order by playoff_games desc, playoff_wins desc
