with aggregated_player_stats as (
    select
        pas.season,
        pas.team_id,
        t.full_name as team_name,
        round(avg(pas.effective_field_goal_percentage), 3) as effective_field_goal_percentage,
        round(avg(pas.true_shooting_percentage), 3) as true_shooting_percentage,
        round(avg(pas.rebound_percentage), 3) as rebound_percentage,
        round(avg(pas.steal_percentage), 3) as steal_percentage,
        round(avg(pas.block_percentage), 3) as block_percentage,
        round(avg(pas.per), 3) as per
    from {{ ref('player_advanced_stats')}} as pas
    left join {{ ref('stg_teams')}} as t
    on pas.team_id = t.team_id
    group by 
        pas.season,
        pas.team_id,
        t.full_name
),
aggregated_player_stats_ranked as (
    select 
        *,
        rank() over (partition by season order by effective_field_goal_percentage) as efg_pct_rank,
        rank() over (partition by season order by true_shooting_percentage) as ts_pct_rank,
        rank() over (partition by season order by steal_percentage) as stl_pct_rank,
        rank() over (partition by season order by block_percentage) as blk_pct_rank
    from aggregated_player_stats
), 
aggregated_team_stats as (    
    select 
        season,
        team_id,
        team_name,
        round(avg(points), 3) as points,
        round(avg(steals), 3) as steals,
        round(avg(blocks), 3) as blocks,
        round(avg(offensive_efficiency), 3) as offensive_efficiency,
        round(avg(defensive_efficiency), 3) as defensive_efficiency,
        round(avg(defensive_rebound_percentage), 3) as defensive_rebound_percentage
    from {{ ref('team_advanced_stats')}}
    group by 
        season,
        team_id,
        team_name
),
aggregated_team_stats_ranked as (
    select 
        *,
        rank() over (partition by season order by points) as points_rank,
        rank() over (partition by season order by steals) as steals_rank,
        rank() over (partition by season order by blocks) as blocks_rank,
        rank() over (partition by season order by offensive_efficiency) as offensive_efficiency_rank,
        rank() over (partition by season order by defensive_efficiency) as defensive_efficiency_rank,
        rank() over (partition by season order by defensive_rebound_percentage) as dreb_pct_rank
    from aggregated_team_stats
),
final_table as (
    select
        ts.season,
        ts.team_name,
        ts.points,
        ts.steals,
        ts.blocks,
        ts.offensive_efficiency,
        ts.defensive_efficiency,
        ts.defensive_rebound_percentage,
        ps.effective_field_goal_percentage,
        ps.true_shooting_percentage,
        ps.rebound_percentage,
        ps.steal_percentage,
        ps.block_percentage,
        ps.per,
        ts.points_rank,
        ts.steals_rank,
        ps.stl_pct_rank,
        ts.blocks_rank,
        ps.blk_pct_rank,
        ps.efg_pct_rank,
        ps.ts_pct_rank,
        ts.offensive_efficiency_rank,
        ts.defensive_efficiency_rank,
        ts.dreb_pct_rank,
        tsbs.conference_rank,
        tsbs.division_rank,
        case 
            when tsbs.nba_finals_appearance = 'LEAGUE CHAMPION'
            then TRUE
            else FALSE
        end as IS_CHAMP
    from aggregated_team_stats_ranked as ts
    left join aggregated_player_stats_ranked as ps
    on ts.team_id = ps.team_id
    and ts.season = ps.season
    left join {{ ref('stg_team_stats_by_season')}} as tsbs
    on ts.team_id = tsbs.team_id
    and ts.season = tsbs.season
)
select
    'top5' as top_n,
    count(*) as nr_of_champs,
    sum(
        case 
            when points_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_points,
    sum(
        case 
            when efg_pct_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_efg,
    sum(
        case 
            when ts_pct_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_ts,
    sum(
        case 
            when steals_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_steals,
    sum(
        case 
            when blocks_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_blocks,
    sum(
        case 
            when stl_pct_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_stl_pct,
    sum(
        case 
            when blk_pct_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_blk_pct,
    sum(
        case 
            when offensive_efficiency_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_off_eff,
    sum(
        case 
            when defensive_efficiency_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_def_eff,
    sum(
        case 
            when dreb_pct_rank in (1,2,3,4,5)
            then 1
            else 0
        end
    ) nr_of_champs_lead_dreb_pct
from final_table
WHERE IS_CHAMP
union 
select
    'top3' as top_n,
    count(*) as nr_of_champs,
    sum(
        case 
            when points_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_points,
    sum(
        case 
            when efg_pct_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_efg,
    sum(
        case 
            when ts_pct_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_ts,
    sum(
        case 
            when steals_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_steals,
    sum(
        case 
            when blocks_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_blocks,
    sum(
        case 
            when stl_pct_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_stl_pct,
    sum(
        case 
            when blk_pct_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_blk_pct,
    sum(
        case 
            when offensive_efficiency_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_off_eff,
    sum(
        case 
            when defensive_efficiency_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_def_eff,
    sum(
        case 
            when dreb_pct_rank in (1,2,3)
            then 1
            else 0
        end
    ) nr_of_champs_lead_dreb_pct
from final_table
WHERE IS_CHAMP
union
select
    'top1',
    count(*) as nr_of_champs,
    sum(
        case 
            when points_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_points,
    sum(
        case 
            when efg_pct_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_efg,
    sum(
        case 
            when ts_pct_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_ts,
    sum(
        case 
            when steals_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_steals,
    sum(
        case 
            when blocks_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_blocks,
    sum(
        case 
            when stl_pct_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_stl_pct,
    sum(
        case 
            when blk_pct_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_blk_pct,
    sum(
        case 
            when offensive_efficiency_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_off_eff,
    sum(
        case 
            when defensive_efficiency_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_def_eff,
    sum(
        case 
            when dreb_pct_rank = 1
            then 1
            else 0
        end
    ) nr_of_champs_lead_dreb_pct
from final_table
WHERE IS_CHAMP