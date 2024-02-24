with
    source as (select * from {{ source('NBA', 'TEAM_STATS_BY_SEASON') }}),
    renamed as (
        select
            team_id,
            team_city,
            team_name,
            year as season,
            gp as games_played,
            wins,
            losses,
            conf_rank as conference_rank,
            div_rank as division_rank,
            po_wins as playoff_wins,
            po_losses as playoff_losses,
            nba_finals_appearance,
            fgm as field_goals_made,
            fga as field_goals_attempted,
            fg3m as three_pointers_made,
            fg3a as three_pointers_attempted,
            ftm as free_throws_made,
            fta as free_throws_attempted,
            oreb as offensive_rebounds,
            dreb as defensive_rebounds,
            reb as total_rebounds,
            ast as assists,
            pf as personal_fouls,
            stl as steals,
            tov as turnovers,
            blk as blocks,
            pts as points
        from source
    )

select *
from renamed
