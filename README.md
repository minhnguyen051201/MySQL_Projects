# MySQL Projects

This repository contains self-contained SQL analyses and data preparation workflows for two datasets: COVID-19 public health data and Spotify streaming metrics. Each directory provides example queries, data-loading instructions, and exploratory analyses that can be run directly in MySQL.

## Repository structure
- `covid_data/`: Exploratory queries, window functions, and stored procedure examples built around COVID-19 case and vaccination data.
- `spotify_data/`: Cleaning steps, analytical questions, and advanced window functions using a 2023 Spotify hits dataset.

## Prerequisites
- MySQL 8.x (tested with MySQL Server 8; adjust syntax if using an earlier version).
- A MySQL client such as MySQL Workbench, the MySQL CLI, or any SQL IDE.
- Optional: Python 3.10+ if you want to open `spotify_data/encoding_data.ipynb` for additional data cleaning steps.

## Getting started
1. Clone the repository and start your MySQL server.
2. Create the databases used by the scripts:
   ```sql
   CREATE DATABASE Covid_Data;
   CREATE DATABASE Spotify_hit_2023;
   ```
3. Import the provided CSV files into their respective databases:
   - COVID data: `covid_data/data/CovidDeath.csv` → `CovidDeath` table; `covid_data/data/CovidVaccinations.csv` → `CovidVaccinations` table.
   - Spotify data: `spotify_data/clean_data_spotify.csv` → `clean_data_spotify` table.

   Use your preferred import method (MySQL Workbench table import wizard or `LOAD DATA INFILE`). Ensure date columns are loaded as strings if you plan to reuse the conversion statements in `covid_data/covid_query.sql`.

4. Run the SQL scripts in your client of choice. The scripts are designed to be executed independently; comments inside each file describe the intent of every block.

## COVID-19 analysis highlights
- `covid_query.sql` converts raw date strings, inspects cases and deaths, and calculates mortality rates.
- `join_union.sql`, `groupby_orderby.sql`, `subqueries_windowfunction.sql`, and `cte_temptable.sql` demonstrate joins, aggregation, subqueries, and window functions for trend analysis.
- `stored_procedure.sql` contains examples of stored procedures, triggers, and scheduled events for automating data maintenance.

## Spotify analysis highlights
- `business_question_spotify.sql` answers core business questions such as top-streamed tracks, prolific artists, and multi-platform chart coverage.
- `advance_spotify_script.sql` shows analytic window functions (ranking, running totals, percentage contributions) and summary statistics by musical attributes.
- `spotify-2023.csv` and `spotify_data.xlsx` provide raw data sources; `clean_data_spotify.csv` is the curated dataset used by the scripts.

## Suggested workflow
1. Load the curated tables as described above.
2. Run the baseline exploratory scripts (`covid_query.sql` and `business_question_spotify.sql`) to validate the data and understand key metrics.
3. Experiment with the advanced scripts to extend the analyses—e.g., adjusting filters, adding partitions to window functions, or incorporating additional chart metrics.

## Notes
- The SQL uses explicit schema names (e.g., `USE Covid_Data;`). Update the database names in the scripts if your environment differs.
- Event scheduling in `stored_procedure.sql` requires `event_scheduler` to be enabled on the MySQL server.
- Ensure file paths in `LOAD DATA INFILE` statements match your MySQL server’s secure file directory settings.
