WITH match_up_array_details AS (
  -- Select all columns and add a new column named `match_up_array`.
  -- This column splits the `matchup` column based on the delimiter and sorts the resulting array.
  -- Use either `@` or `vs.` as delimiter depending on the format.
  SELECT
    *,
    CASE WHEN matchup LIKE '%@%' THEN ARRAY_SORT(SPLIT(matchup, ' @ '))
         ELSE ARRAY_SORT(SPLIT(matchup, ' vs. '))
    END AS match_up_array
  FROM {{ ref('stg_games') }}
  WHERE LOWER(game_type) LIKE '%playoff%'
)

SELECT
  *,
  -- Convert the `match_up_array` to a string with comma as separator.
  ARRAY_TO_STRING(match_up_array, ',') AS playoff_match_up_unique_str
FROM match_up_array_details
