# dbt™ Data Modeling Challenge - NBA Edition

Welcome to the [Paradime dbt™ Data Modeling Challenge - NBA Edition](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#)!

## Table of Contents
1. [Getting Started](#getting-started)
   - [Registration and Verification](#step-1-registration-and-verification)
   - [Account Set-Up](#step-2-account-set-up)
   - [Paradime Account Configuration](#step-3-paradime-account-configuration)
   - [Kickstart Your Project](#step-4-kickstart-your-project)
2. [Competition Details](#competition-details)
3. [Building Your Project](#building-your-project)
4. [Example Submission](#example-submission)

---

## Getting Started

### Step 1: Registration and Verification
- **Submit Your Application**: Fill out the [registration form](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-registration-form).
- **Verification by Paradime**: We'll review your application against the [participation requirements](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-judges).

### Step 2: Account Set-Up
After verification, you'll receive two emails from Paradime:
1. **Snowflake Account Credentials**: Contains your Snowflake account details. Search for an email with subject line "*Start Your NBA Data Modeling Challenge – Your Snowflake Credentials*."
2. **Paradime Platform Invitation**: An invitation to access the Paradime Platform. Search for an email with the subject line "*[Paradime] Activate your account*."

### Step 3: Paradime Account Configuration
- **Access Paradime**: Use the provided credentials to log into your account. Join the Paradime workspace using the invite email.
- **Snowflake Integration**: Add Snowflake credentials (Username, Password, Role, Database) to Paradime.
- **Act Fast - Limited Time Activation**: The links to activate your Paradime account expire within 24 hours!
[Arcade]

### Step 4: Kickstart Your Project
- **Create a New Branch**: Open the Paradime Editor and create a new branch. Your branch name should follow this format: "nba-<your_email>"
- **Start Developing**: Begin crafting SQL queries, developing dbt™ models, and generating insights!
   ![Start Developing in Paradime](link_to_arcade_screenshot)
note: If you login to snowflake, your default role is public. Swith your role to the one we provide in the email "NAME_ANALYTICS" (role name also provided in snowflake email. 

**Need Help?**: Join the #nba-challenge channel on [Slack](https://paradimers.slack.com/join/shared_invite/zt-1mzax4sb8-jgw~hXRlDHAx~KN0az18bw#/shared-invite/email) for assistance.

---

## Competition Details
- **[Entry Requirements](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**
- **[Competition Deliverables](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**
- **[Judging Criteria](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**

---
## Building Your Project

Now that you're set up, you have until March 8, 2024 to complete and submit your project!

### Step 1: Getting to Know the Paradime Editor
- [Using the Editor](https://docs.paradime.io/app-help/welcome-to-paradime.io/tutorials/getting-started-with-the-paradime-ide#discover-editor-core-functionalities)
- [Working with Git](https://docs.paradime.io/app-help/welcome-to-paradime.io/tutorials/getting-started-with-the-paradime-ide#working-with-git)
- [Creating Your First dbt Model](https://docs.paradime.io/app-help/welcome-to-paradime.io/tutorials/getting-started-with-the-paradime-ide#create-and-run-your-first-dbt-tm-model)

### Step 2: Getting to Know the NBA Data

Paradime has pre-loaded your Snowflake account with 7 historical NBA datasets, offering comprehensive and detailed statistics about games, players, teams, salaries, and more, typically covering the years 1947-2023. Familiarize yourself with these datasets through various resources:

- **In Snowflake**: Directly explore the datasets in [Snowflake](https://app.snowflake.com/kbuwhsf/xrb98600) for hands-on analysis.
- **GitHub Repository Resources**:
  - [Staging Files](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/main/models/sources): These files provide a preliminary view and structure of the datasets available in this repository.
  - [schema.yml File](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/schema.yml): This file contains schema definitions, helping you understand the data models and their relationships.
- **Paradime Catalog UI**: Use the [Paradime Catalog UI](https://app.paradime.io/catalog/search) for an interactive exploration of the datasets, featuring intuitive search and navigation.

### Step 3: Generating Insights
Your goal is to build dbt™ models that reveal compelling insights for NBA fans and/or General Managers. With the 7 unique data sets provided, the potential insights are endless. Get creative, and if you need some inspiration, check out the insights in the [example submission](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#visualizations), and here are some additional suggestions:
- Who are the best 2nd round draft picks? Who are the best international players?
    - Data Required: *[common_player_info](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_common_player_info.sql)*
- Historically, which teams are the most efficient spenders (total payroll / wins)?
    - Data Required: *[team_spend_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_spend_by_season.sql)*, *[team_stats_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_stats_by_season.sql)*
- Which players have the biggest discrepancy between regular season and playoff performance?
    - Data Required: *[player_game_logs](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_game_logs.sql)*
- Which players have the worst +/- in NBA history?
    - Data Required: *[[player_game_logs](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_game_logs.sql)]*
- Who are the most overpaid/underpaid players in NBA history?
    - Data Required: *[player_salaries_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_salaries_by_season.sql)*, *[player_game_logs](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_game_logs.sql)*
- Worst regular season teams to win NBA finals? Best regular season teams to lose NBA finals?
    - Data Required: *[team_stats_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_stats_by_season.sql)*

### Creating Data Visualizations
Choose any data visualization tool, including excel and google sheets. Here are some common methods:
- **Cloud BI Platforms**: BI, Lightdash, Metabase, Preset, Tableau, Looker, Sigma, etc.
   - use your snowflake credentials to connect.
- **[Snowflake's Snowsight](https://docs.snowflake.com/en/user-guide/ui-snowsight-visualizations)** - Create visualizations directly within a your provided Snowflake account
- **[Download CSV](https://docs.paradime.io/app-help/code-ide/data-preview#download-csv)** - Simply download a .csv and build vizualizations in Excel, Google Sheets, etc.
   - This method was used in the [example submission](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#visualizations)
With the snowflake credentials we provided, simply use them to build visualizations in the tool of your choice: like Power BI, Lightdash, Metabase, Preset, Tableau, Looker, Sigma, etc.

### Submitting Your Project
**Submission deadline:** March 8th, 2024
When you're finished, submit the following to Parker Rogers (parker@paradime.io):
- Your GitHub repo containing your dbt™ models ([Example](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#my-github-repo))
- A README.md narrating your project ([Example](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#example-submission))
- Data visualizations and and insights, ideally in your README.md ([Example](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#visualizations))

# Example Submission
Here's an example project that fulfills all requirements and would be elligble eligible for cash prizes. Feel free to use this template for your submission, but ensure your insights are unique!

## Table of Contents
1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Methodology](#methodology)
   - [Tools Used](#tools-used)
   - [Applied Techniques](#applied-techniques)
4. [Visualizations](#visualizations)
   - [Team Playoff Appearances](#team-playoff-appearances)
   - [Player Playoff Games](#player-playoff-games)
   - [Top Playoff Scorers](#top-playoff-scorers)
   - [Top Regular Season Scorers](#top-regular-season-scorers)
   - [NBA Players by University](#nba-players-by-university)
5. [Conclusions](#conclusions)

## Introduction
Explore my project for the _dbt™ data modeling challenge - NBA Edition_, Hosted by [Paradime](https://www.paradime.io/)! This project dives into the analysis and visualization of NBA statistics, designed for basketball enthusiasts and analysts.

### [My GitHub repo](https://github.com/jpooksy/paradime-dbt-nba-challenge)

## Data Sources
My analysis leverages three key NBA datasets from Paradime:
- *PLAYER_GAME_LOGS*
- *TEAM_STATS_BY_SEASON*
- *COMMON_PLAYER_INFO*

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™, and CSV exports.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **Google Sheets** for data visualization.

### Applied Techniques
- SQL and dbt™ to transform _stg_player_game_logs_ into seasonal player statistics
- SQL and dbt™ to transform _stg_player_game_logs_ and _stg_common_player_info_ to understand
  playoff and regular season performance by individual players
- SQL and dbt™ to transform _stg_common_player_info_ for insights on NBA players' college backgrounds.
- SQL and dbt™ to transform _stg_team_stats_by_season_ for insights on NBA Teams' historical playoff performance.

## Visualizations
### Team Playoff Appearances
Visualization of playoff appearances for all 30 NBA teams, including their playoff appearance rates.

![Team Playoff Appearances](https://github.com/jpooksy/dbt_Data_Modeling_Challenge_NBA/assets/107123308/48b10c60-8388-495b-9901-f8306b0b8a56)

*Insights:*
The Los Angeles Lakers' dominance in playoff appearances, and the San Antonio Spurs' highest playoff appearance rate.
The Spurs have only missed the playoffs 9 times!

### Player Playoff Games
Assessment of NBA players with the highest number of playoff game wins and their win percentages. The '*' next to NBA Player name indicates if they're 
a member of the [NBA Greatest 75 Team](https://www.nba.com/news/nba-75th-anniversary-team-announced)

![Player Playoff Games](https://github.com/jpooksy/dbt_Data_Modeling_Challenge_NBA/assets/107123308/a58f3f0a-9028-45ea-8ed3-ad94f07cd117)

*Insights:* 
LeBron James has the most playoff wins of any player, but here's what's most interesting: 
Of the 25 players with the most playoff wins, only 12 of them are members of the [NBA Greatest 75 team](https://www.nba.com/news/nba-75th-anniversary-team-announced). 
There are several players listed that impact playoff wins and compliment their team's best players, but aren't known 
as on the the all time greats, such as: Derek Fisher, Robert Horry, Danny Green. 

### Top Playoff Scorers
Showcases players who achieved the the most points scored in any playoff season.

![Top Playoff Scorers](https://github.com/jpooksy/dbt_Data_Modeling_Challenge_NBA/assets/107123308/0100299f-7fd8-463d-81cf-f7eb6a5f0068)

*Insights:* 
Michael Jordan, LeBron James, and Kobe Bryant are the only players having three seasons within the top 25 
highest most points scored in a playoff season.

### Top Regular Season Scorers
Highlights NBA players who scored the most in regular seasons.

![Top Regular Season Scorers](https://github.com/jpooksy/dbt_Data_Modeling_Challenge_NBA/assets/107123308/d3fc94d0-7cd7-41ca-bc94-4b285f300eb3)

*Insights:* 
Wilt Champerlain is one of the best regular season scorer of all time. In addition to having the most points scored 
in any regular season ever (4,029), he also has six season in the top 25. The only other player with 6 top 25 seasons is Michael Jordan.
In the chart above, notice that Wilt Champerlain doesn't appear once in the top 25 playoff scorers of all time 👀.


### NBA Players by University
Displays which universities have produced the most NBA players.

![NBA Players by University](https://github.com/jpooksy/dbt_Data_Modeling_Challenge_NBA/assets/107123308/a84b3b2d-c51b-4267-bb0b-d5941517bbc8)

*Insights:* 
Kentucky has produced the most NBA players in NBA history by a significant margin.... Go Wildcats! 

## Conclusions
This project offers key insights for NBA enthusiasts, such as:
This project successfully extracts significant insights from NBA data that NBA fans would find interesting, such as: 

- The dominance of teams like the Los Angeles Lakers and the San Antonio Spurs in playoff appearances
- The critical role of "role" players, as highlighted by the playoff games by player insights,
- The extraordinary achievements of players like LeBron James, Michael Jordan in he playoffs, and Wilt Chamberlain in the regular season. 
- The influence of universities like Kentucky in producing NBA talent.
