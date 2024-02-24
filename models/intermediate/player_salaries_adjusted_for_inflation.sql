with
    player_salaries as (
        select player_id, player_name, rank, season, salary_usd
        from {{ ref('stg_player_salaries_by_season') }}
    ),

    season_year_split as (
        select
            *,
            split_part(season, '-', 1)::int as season_start_year,
            split_part(season, '-', 1)::int + 1 as season_end_year
        from player_salaries
    ),

    season_inflation as (
        select
            year - 1 as season_start_year,
            year as season_end_year,
            (_1800_dollar_value + _1800_dollar_value / (1 + inflation_vs_previous_year))
            / 2 as _1800_dollar_value
        from {{ ref('stg_extra__hist_inflation') }}
    ),

    _2024_value as (
        select _1800_dollar_value
        from {{ ref('stg_extra__hist_inflation') }}
        where year = 2024
    ),

    inflation_adj_salaries as (
        select
            season_year_split.*,
            (
                round(
                    (
                        _2024_value._1800_dollar_value
                        / season_inflation._1800_dollar_value
                    )
                    * salary_usd
                )
            )::int as _2024_adjusted_salary
        from season_year_split
        inner join season_inflation using (season_start_year, season_end_year)
        full join _2024_value
    )

select *
from inflation_adj_salaries
