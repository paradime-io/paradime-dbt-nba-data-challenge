with stg_player_salaries as (
    select * from {{ ref('stg_player_salaries_by_season') }}
),

nba_greatest AS (
    SELECT
        player_id,
        school,
        greatest_75_member
    FROM
        {{ ref('stg_common_player_info') }}
),

-- Getting salaries grouped by number of seasons played by the players
final as (
    select
        substring(stg_player_salaries.season, 1, 4) as season_start,
        stg_player_salaries.player_id,
        stg_player_salaries.player_name,
        nba_greatest.school,
        -- Could add dataset to adjust salary to inflation over time.
        replace(ltrim(stg_player_salaries.salary, '$'), ',', '')::int as salary,
        row_number() over(partition by
                stg_player_salaries.player_id,
                stg_player_salaries.player_name
            order by season_start asc) as season_number_per_player
    from stg_player_salaries
    inner join nba_greatest
        on stg_player_salaries.player_id = nba_greatest.player_id
)

select * from final
