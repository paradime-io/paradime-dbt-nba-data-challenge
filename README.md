# dbt™ Data Modeling Challenge - NBA Edition

# Creating a Consistency Metric for the NBA

## Introduction
Inspired by Shai Gilgeous-Alexander, who seems to be scoring 31-34 points every single night in the 2023-24 season, this project is examining consistency of NBA players throughout the league's history.
We'll define a metric for consistency, identify the most consistent seasons of all time, and look for tends as the league continues to move forward. 

## Data Sources
My analysis leverages several key datasets:
From Paradime:
- *PLAYER_GAME_LOGS*
- *TEAM_STATS_BY_SEASON*
- *COMMON_PLAYER_INFO*
- *TEAMS*


Homegrown:
- *MVPs*: a ChatGPT-generated csv of the MVPs in the league's history

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **Hex** for data visualization.

### Applied Techniques
- SQL and dbt™ to generate a series of models that calculate game score and then aggregate up to different time granularities (season + career).
- Used Hex to create a dashboard to display my results.

Please find my results and visualization in my hex dashboard here: https://app.hex.tech/ea814f0e-cd2a-417f-988c-ed7c32754bd4/app/d02ef761-e6de-483a-ba03-905f406ddb50/latest#results 

## Conclusions
This project successfully extracts significant insights from NBA data that NBA fans would find interesting, such as: 
- Creating another lens through which to view NBA player excellence. It's really just fun to look through all the historic seasons.
- Putting Shai's incredible 2023-24 season in perspective!
- Nikola Jokic! The most consistent playoff performer of all time!
