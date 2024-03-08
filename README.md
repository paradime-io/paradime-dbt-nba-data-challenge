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
- **Verification by Paradime**: We'll review your application against the [entry requirements](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2).

### Step 2: Account Set-Up
After verification, you'll receive two emails from Paradime:
1. **Snowflake Account Credentials**: Contains your Snowflake account details. Search for an email with subject line "*Start Your NBA Data Modeling Challenge – Your Snowflake Credentials*."
2. **Paradime Platform Invitation**: An invitation to access the Paradime Platform. Search for an email with the subject line "*[Paradime] Activate your account*."

### Step 3: Paradime Account Configuration
- **Access Paradime**: Use the provided credentials to log into your account. Join the Paradime workspace using the invite email.
- **Snowflake Integration**: Add Snowflake credentials (Username, Password, Role, Database) to Paradime.
- **Act Fast - Limited Time Activation**: The links to activate your Paradime account expire within 24 hours!

Note: A step-by-step tutorial is available in you Snowflake credentials email, "*Start Your NBA Data Modeling Challenge – Your Snowflake Credentials*".

### Step 4: Kickstart Your Project
- **Create a New Branch**: Open the Paradime Editor and create a new branch. Your branch name should follow this format: "nba-<your_email>"
- **Start Developing**: Begin crafting SQL queries, developing dbt™ models, and generating insights!
   ![Start Developing in Paradime](link_to_arcade_screenshot)
note: If you login to snowflake, your default role is public. Swith your role to the one we provide in the email "NAME_ANALYTICS" (role name also provided in snowflake email. 

**Need Help?**: Check out [this step-by-step video tutorial](https://app.arcade.software/share/9JaKC9DmaGYBTW1sWlhf), and join the #nba-challenge channel on [Slack](https://paradimers.slack.com/join/shared_invite/zt-1mzax4sb8-jgw~hXRlDHAx~KN0az18bw#/shared-invite/email) for assistance.

---

## Competition Details
- **[Entry Requirements](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**
- **[Competition Deliverables](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**
- **[Judging Criteria](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**

---
## Building Your Project

Now that you're set up, you have until March 8, 2024 to complete and submit your project!

### Step 1: Getting to Know the Paradime

- **The Paradime Editor**: Dive into the Paradime Editor with this step-by-step, [interactive guide](https://app.arcade.software/share/9JaKC9DmaGYBTW1sWlhf). It's designed to familiarize you with the core functionalities and of the editor, and get your familiar with the Project. 
- **Paradime Help Docs**: For a comprehensive understanding of all the features and how to make the most of Paradime for your project, explore the [Paradime Help Docs](https://docs.paradime.io/app-help/welcome-to-paradime.io/readme).

### Step 2: Getting to Know the NBA Data

Paradime has pre-loaded your Snowflake account with 7 historical NBA datasets, offering comprehensive and detailed statistics about games, players, teams, salaries, and more, typically covering the years 1947-2023. Familiarize yourself with these datasets through various resources:

- **In Snowflake**: Directly explore the datasets in [Snowflake](https://app.snowflake.com/kbuwhsf/xrb98600) for hands-on analysis.
- **GitHub Repository Resources**:
  - [Staging Files](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/main/models/sources): These files provide a preliminary view and structure of the datasets available in this repository.
  - [schema.yml File](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/schema.yml): This file contains schema definitions, helping you understand the data models and their relationships.
- **Paradime Catalog UI**: Use the [Paradime Catalog UI](https://app.paradime.io/catalog/search) for an interactive exploration of the datasets, featuring intuitive search and navigation.

### Step 3: Generating Insights

Your primary goal is to construct dbt™ models that unearth compelling insights, captivating NBA fans and/or General Managers. With seven distinct datasets at your disposal, the possibilities for discovery are virtually limitless. This is your playground to innovate and explore the depths of NBA data.

Before diving in, ensure you're familiar with the [Judging Criteria](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2) so you've got a chance to win the [$500-$1500 Amazon gift cards](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-whats-in-it-for-you)!

Need a spark of inspiration? Check out the [example submission](https://github.com/paradime-io/paradime-dbt-nba-data-challenge?tab=readme-ov-file#example-submission), and here are some additional suggestions to kickstart your analytical journey:

- **Second-Round Draft Picks**: Who stands out among the historically best second-round picks?
      - Data Required: *[common_player_info](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_common_player_info.sql)*
- **International Player Impact**: Which international players (Not born in the USA) have made the biggest mark in the NBA?
      - Data Required: *[common_player_info](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_common_player_info.sql)*
- **Efficiency in Spending**: Analyze which teams/players have gotten the most (or least!) value for their money.
      - Data Required: *[team_spend_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_spend_by_season.sql)*, *[team_stats_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_stats_by_season.sql)*
- **Performance Shifts**: Investigate players whose performance changes between the regular season and playoffs.
      - Data Required: *[player_game_logs](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_game_logs.sql)*
- **Contracts and Contributions**: Who are the NBA's most overpaid or underpaid players?
   - Data Required: *[player_salaries_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_salaries_by_season.sql)*, *[player_game_logs](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_game_logs.sql)*
- **Unexpected Playoff Outcomes**: Explore the anomalies - teams that defied odds, or underperformed, in the Playoffs
  - Data Required: *[team_stats_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_stats_by_season.sql)*

### Creating Data Visualizations
When it comes to visualizing your insights, you have a variety of tools at your disposal, including basic options like Excel and Google Sheets. Here are some common methods you can consider:
- **Cloud BI Platforms**: Utilize platforms like Power BI, Lightdash, Metabase, Preset, Tableau, Looker, Sigma, and more. Simply use the Snowflake credentials we provided to connect these platforms to your data.
- **[Snowflake's Snowsight](https://docs.snowflake.com/en/user-guide/ui-snowsight-visualizations)**: Create visualizations directly within your provided Snowflake account, taking advantage of Snowflake's built-in visualization capabilities.
- **[Download CSV](https://docs.paradime.io/app-help/code-ide/data-preview#download-csv)**: For a straightforward approach, export the data behind your dbt™ models from Snowflake to .csv files. This method was used in the [example submission](https://github.com/paradime-io/paradime-dbt-nba-data-challenge?tab=readme-ov-file#example-submission). Please note: if you opt for exporting to .csv, our judges will verify that the exported data accurately reflects the data behind your dbt™ models!

Remember, the choice of tool is yours – select one that best fits your style and project needs!

### Submitting Your Project
**Submission Deadline:** March 8th, 2024
Once your project is complete, please submit the following materials to Parker Rogers (parker@paradime.io) with Subject Line "<your_name> - NBA Data Modeling Challenge Submission":
- **GitHub Repository**: Send the link to your GitHub repository containing your dbt™ models.
- **README.md**: Include a README file that narrates your project's story, methodology, and insights. Check out this [example README](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#example-submission).
- **Data Visualizations and Insights**: Showcase your findings, ideally within your README.md. For inspiration, refer to these [example visualizations](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#visualizations).

We look forward to seeing your creative and insightful analyses!

# Actual Submission

## Table of Contents
1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Methodology](#methodology)
    - [Tools Used](#tools-used)
    - [Applied Techniques](#applied-techniques)
4. [Visualizations](#visualizations)
    - Salary Progression for Top Players(#salary-progression-for-top-players)
    - Salary per Team(#salary-per-team)
    - Player Efficiency Ratio(#player-efficiency-ratio)

## Introduction
Explore my project for the _dbt™ data modeling challenge - NBA Edition_, Hosted by [Paradime](https://www.paradime.io/)! This project dives into the analysis and visualization of NBA statistics, designed for basketball enthusiasts and analysts.

### [My GitHub repo](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/nba-quentin.coviaux%40rebtel.com)

## Data Sources
My analysis leverages three key NBA datasets from Paradime:
- *PLAYER_SALARIES_BY_SEASON*
- *TEAM_SPEND_BY_SEASON*
- *PLAYER_GAMES_LOGS*

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **[Sigma]** for data visualization.

### Applied Techniques
- SQL and dbt™ to transform multiple metrics, such as salary or PER.

## Visualizations

### Salary Progression for Top Players
Here we're trying to see the salary progression for NBA Greatest 75 Players based on the number of seasons they've played.

#### Overall results
![Salary by Season Number for Greatest 75 members](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/AllPlayers-SalaryProgression.png)

While this view is a bit cluttered, we see a sort of "bridge" around year 10-11 for almost all players that indicates that within a decade, most of the players peak in salary. After this, we see some players regressing, suggesting their results may suffer.
It is unclear here however, how correlated are players' results with their salary. Have they first had poor results then changed team/salary, or are those two metrics unrelated?

Let's look at some players evolution over time.


#### Kevin Garnett
![Kevin Garnett Salary Progression](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/KevinGarnett-SalaryProgression.png)

Kevin Garnett has a few interesting points about him:
- While humble beginnings in terms of earnings, around year 4 he's scored a pretty big increase - not doubt as a result of a promising talents starting in the league.
- He is the player that stayed for the longest time, with 22 seasons played.
- We can also see that he's had probably multiple setback during his career, with multiple drop in salary.

We can try to see the impact of his wins on his salary with the following graph.

![Kevin Garnett Wins over time](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/WinsKevinGarnett.png)

Here we see a drop of wins between seasons 2003-04 and 2004-05, matched with a drop of salary (Year 9-10). Curiously both drops of wins and salary occur the same year - where we might expect it to be distinct events happening over the course of multiple seasons.
In a more predictable manner, between Year 14-15, we could attribute the decrease of salary with the low season wins.


#### Dick Nowitzik
![Dick Nowitzik Salary Progression](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/DickNowitzik-SalaryProgression.png)

Dick Nowitzik has a fairly stable salary progression, except from his Year 19 (Season 2016-17). Whatever happened there set him back and he stopped his career shortly after.


#### LeBron vs. Curry 
![LeBron vs. Curry Salary Progression](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/LeBron-Curry-SalaryProgression.png)

LeBron is undisputably one of the best player to have ever played NBA. His compensation has been quite rewarding as his salary has only ever increased.
Comparing to Stephen Curry though, Curry seemingly has climbed this particular ladder a bit faster, as with around 6 fewer seasons played, he is already ahead of LeBron.


Caveats:
- It would be interesting to adjust the salary with inflation to compare old salaries with more recent ones.

Future improvement:
- Correlate salary with win/loss ratio


### Salary per Team

Without going to granular, we can start looking at team salary for three, randomly handpicked, teams.
![Team Payroll with Wins](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/TeamPayRollWithWins.png)

The Y-axis defines the season's payroll and the bubbles' size shows the amount of wins during that season. There are a couple of interesting points we can see here:
- Over the seasons 1998-99 to 2000-01, the Bulls didn't seem to have a very high payroll, which in turn rewarded them with a low win counter - all pretty predictable. Payroll has slowly increased over time (although doesn't take into account inflation), and their wins has also increased.
- The Knicks on the other hand, has a different story. During the seasons 2004-05 to 2008-09, they threw a lot of money at players but without much success to their team wins - proving that you need more than just talented/expensive players in a team game. While their investment has varied over the years, they seem to continously struggle with winning games.

#### Charlotte

Let's dive a bit into Charlotte
![Charlotte Tough Patch](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/CharlotteToughPatch.png)

We are plotting here, based on the season's payroll, the average Spend per Win on that particular season. The season of 2011-12 must have been a particularly tough year for Charlotte's team.
During the season, they achieved only 7 victories, despite great resources spent. As anyone knows, nothing works better than a rebranding to start anew, which might explain why the changed Team name two years later, returning to a historical naming.


### Player Efficiency Ratio

For any NBA fan, there seems to be one predominant metric to follow, PER.
![Player Efficiency Ratio](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/nba-quentin.coviaux%40rebtel.com/images/PER75Greatest.png)

Unfortunately, the metric here seems skewed and wasn't fixed on time. After comparison with the actuals, the numbers presented here do not match what one could find online.
**However**, if the metric is incorrect, we can hope that it is equally incorrect for everyone. With this in mind (and a ginormous pinch of salt), if we plot PER with another metric, Points per Game (PPG), we see something fairly interesting ~~and predictable~~.
Yellow dots are players belonging to the Greatest 75 Members club. These players seem to concentrate on the high PER and high PPG side of things. While nothing tremendously surprising, it gives a good view of this select group - and that some players there, in blue, might be considered to join this club?


