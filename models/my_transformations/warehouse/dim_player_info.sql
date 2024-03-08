with source as (
    select * 
    from {{ref('player_info')}}

)

, ppg_count as (
    select
    p.player_id
    , sum(case when avg_points > 20 then 1 else 0 end) as star_ppg_count
    from {{ref('player_game_logs_agg')}} p
    group by 1

)

, final as (
    select
    s.*
    , case when s.height_ft < 6 then '< 6ft'
           when s.height_ft = 6 and s.height_in < 4 then '6ft to 6-3'
           when s.height_ft = 6 and s.height_in >= 4 and s.height_in <8 then '6-4 to 6-7'
           when s.height_ft = 6 and s.height_in >= 8 and s.height_in <12 then '6-8 to 6-11'
           when s.height_ft = 7 then '> 7ft'
           end as height_cohort
    , case when greatest_75_member = TRUE then 'Legend'
           when star_ppg_count < 3 then 'Role Player'
           when star_ppg_count >= 3 and star_ppg_count < 6 then 'Star Player'
           when star_ppg_count >= 6 then 'Superstar'
           end as star_player_flag
    , case when s.seasons_played = 1 and s.roster_status = 'Active' then 'Rookie'
           when (s.seasons_played > 1 and s.seasons_played <=4) and s.roster_status = 'Active' then 'Developing'
           when (s.seasons_played > 4 and s.seasons_played <= 9) and s.roster_status = 'Active' then 'Established'
           when (s.seasons_played > 9 and s.seasons_played <=14) and s.roster_status = 'Active' then 'Veteran'
           when (s.seasons_played > 14) and s.roster_status = 'Active' then 'Late Veteran' 
           else 'Inactive' end as experience_cohort           
    from source s
    left join ppg_count pc on pc.player_id = s.player_id

)

select * from final