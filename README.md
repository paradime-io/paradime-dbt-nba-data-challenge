# dbt™ Data Modeling Challenge - NBA Edition

## Table of Contents
- [Introduction](#introduction)
- [Data Sources](#data-sources)
- [Methodology](#methodology)
- [Tools Used](#tools-used)
- [Applied Techniques](#applied-techniques)
- [Visualizations](#visualizations)
  - [Team Playoff Appearances](#team-playoff-appearances)
  - [Player Playoff Games](#player-playoff-games)
  - [Top Playoff Scorers](#top-playoff-scorers)
  - [Top Regular Season Scorers](#top-regular-season-scorers)
  - [NBA Players by University](#nba-players-by-university)
- [Conclusions](#conclusions)
- [Bonus](#bonus)

## Introduction
Explore my submission for the dbt™ data modeling challenge - NBA Edition, Hosted by Paradime! This project aimed to use essential analytics engineering tools to develop strategic insights for NBA General Managers and interesting statistics for NBA fans. I created ETL pipelines, wrote a predictive model, visualized the data, and structured my analysis and recommendations in this document.

Paradime provided NBA player and team metrics, and I sourced some external data to assist with my analysis. I created relationships with the data using SQL and dbt to discover important insights, then visualized the data with Sigma. Since the data provided was analytical, I utilized an OLAP process that produced mostly denormalized fact and dimension tables in my data warehouse.

[My models and documentation are located in the Github repository here!](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/?tab=readme-ov-file#my-github-repo)

## Data Sources
My analysis leverages these NBA datasets provided by Paradime:

- `COMMON_PLAYER_INFO`: Player attributes including name, ID, age, weight, team, draft information, country, number of seasons played, roster status, and more.
- `GAMES`: Stat sheets for every game an NBA team has played, includes core dimensions and metrics such as team ID, game ID, points, field goals, and more.
- `PLAYER_GAME_LOGS`: Stat sheets for every game an NBA player has participated in, includes their core metrics for each game.
- `PLAYER_SALARIES_BY_SEASON`: Salary information for each player and season they played.
- `TEAM_SPEND_BY_SEASON`: Each team’s payroll, luxury tax spend, and active/dead spend for each season.
- `TEAM_STATS_BY_SEASON`: Aggregated core metrics for each team for each season.
- `TEAMS`: Team attributes including team name, ID, city, and other dimensions.

External datasets used to augment my analysis:

- `INFLATION_DATA`: Yearly inflation data based on the Consumer Price Index (CPI) from the Bureau of Labor Statistics. Used to create even comparisons when looking at player salary data across different seasons.
- `SALARY_CAP_BY_SEASON`: Maximum NBA salary cap for each season, as well as the minimum and maximum amount players could earn each season, according to the NBA’s collective bargaining agreement (CBA). This information came from Spotrac (https://www.spotrac.com/nba/cba/).

Additionally, I created a predictive model using Python with libraries such as Pandas, Snowflake, and scikit-learn to predict NBA players’ salaries based on core performance metrics.

## Methodology

### Tools Used
- **Paradime** for SQL, Python, dbt™.
- **Snowflake** for data storage and computing.
- **Sigma** for data visualization.

### Applied Techniques
#### For Combining Core Metrics:
- SQL and dbt™ to analyze the correlation between team spend and performance, transform seasonal player statistics for cohort analyses, determine if a player's predicted salary was over or under their current salary, and analyze how the style of play has changed in the NBA over the last 20+ seasons.

#### For the Predictive Salary Model:
- Python to predict salaries based on player performance metrics. A linear regression model was trained and used to make salary predictions, adjusted for inflation, salary cap, and legal salary bounds. The data is filtered for regular season and players who played a minimum of 30 games each season.

## Visualizations

### Team Playoff Appearances
Visualization of playoff appearances for all 30 NBA teams, highlighting the dominance of teams like the Los Angeles Lakers and the San Antonio Spurs.

### Player Playoff Games
Assessment of NBA players with the highest number of playoff game wins and their win percentages.

### Top Playoff Scorers
Showcases players who achieved the most points scored in any playoff season.

### Top Regular Season Scorers
Highlights NBA players who scored the most in regular seasons.

### NBA Players by University
Displays which universities have produced the most NBA players.

## Conclusions
This project extracts significant insights fromNBA data that NBA fans and General Managers would find interesting, such as:

- The dominance of teams like the Los Angeles Lakers and the San Antonio Spurs in playoff appearances.
- The critical role of "role" players, as highlighted by the insights into playoff games by player.
- The extraordinary achievements of players like LeBron James, Michael Jordan in the playoffs, and Wilt Chamberlain in the regular season.
- The influence of universities like Kentucky in producing NBA talent.

## Bonus
In addition to the analysis above, I explored some of the other features available in Paradime:

- **Data Catalog:** Used the Catalog tool to generate documentation for each model, which saved time when detailing each model.
- **Bolt Scheduler:** Explored Paradime’s scheduling tool and added a “paradime_schedules.yml” file to my repository for future workflows.
- **Data Lineage:** Tested the “Lineage” tab within the Paradime code editor to see how my models were tied together in real-time.
