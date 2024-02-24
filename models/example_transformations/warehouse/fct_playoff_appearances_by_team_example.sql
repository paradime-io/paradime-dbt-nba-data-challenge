-- Calculate playoff appearances and percentages for NBA teams
-- Common Table Expressions (CTEs)
-- Select relevant team stats and identify the most recent season for each team
with
    recent_team_stats as (
        select
            team_id,
            team_name,
            season,
            -- Use ROW_NUMBER() to assign a unique rank (rn) to each row within a
            -- team's partition
            -- The rows are ordered by season in descending order for each team
            -- This ensures that the most recent season gets rn = 1 for each team
            row_number() over (partition by team_id order by season desc) as rn,
            -- Check if both playoff_wins and playoff_losses are equal to zero
            -- If true, set playoff_appearance to 0; otherwise, set it to 1
            case
                when playoff_wins = 0 and playoff_losses = 0 then 0 else 1
            end as playoff_appearance
        from {{ ref('stg_team_stats_by_season') }}
        where season not in ('2023-2024')
    ),

    -- Determine the most recent team name for each team
    most_recent_team_names as (
        select team_id, team_name from recent_team_stats where rn = 1
    ),

    -- Count seasons played and sum playoff appearances for each team
    seasons_played as (
        select
            team_id,
            count(team_id) as seasons_played,
            sum(playoff_appearance) as playoff_appearances
        from recent_team_stats
        group by team_id
    ),

    -- Calculate playoff appearance percentage for each team
    playoff_appearance_pct as (
        select
            sp.team_id,
            sp.seasons_played,
            sp.playoff_appearances,
            -- Calculate playoff appearance percentage (playoff_appearances /
            -- seasons_played)
            sp.playoff_appearances / sp.seasons_played as playoff_appearance_pct
        from seasons_played sp
    )

-- Final query to retrieve results
select
    pat.team_id,
    mrt.team_name,
    pat.seasons_played,
    pat.playoff_appearances,
    pat.playoff_appearance_pct
from playoff_appearance_pct pat
join most_recent_team_names mrt on pat.team_id = mrt.team_id
order by pat.playoff_appearances desc
