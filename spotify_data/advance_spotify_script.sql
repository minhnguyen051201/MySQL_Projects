select *
from clean_data_spotify;

# Find the rank of each song by streams within its release year (Using window function)
select track_name,
       streams,
       released_year,
       rank() over (order by streams desc)
from clean_data_spotify;

# Calculate the running total of streams for each artist
select `artist(s)_name`,
       streams,
       released_year,
       sum(streams) over (partition by `artist(s)_name` order by streams) as rolling_total
from clean_data_spotify;


# Determine the percentage of total streams each song contributes to the artist's total streams
select `artist(s)_name`,
       streams,
       track_name,
       released_year,
       sum(streams) over (partition by `artist(s)_name`)                   as total_streams,
       (streams / sum(streams) over (partition by `artist(s)_name`)) * 100 as rolling_total
from clean_data_spotify;


# Find the average danceability score of songs for each key and mode combination
select distinct `key`,
                mode,
                avg(`danceability_%`) over (partition by `key`, `mode`) as avg_danceability
from clean_data_spotify;


# Another way with group by
select `key`, mode, avg(`danceability_%`)
from clean_data_spotify
group by `key`, mode
order by `key`;

# Find the top 3 songs by streams for each year.
# Use: Common Table Expression (CTE) to calculate ranks using a window function and filter for rank <= 3.
with rank_by_year as (select track_name,
                             released_year,
                             streams,
                             rank() over (partition by released_year order by streams desc) as rank_by_year
                      from clean_data_spotify)
select track_name, released_year, streams, rank_by_year
from rank_by_year
where rank_by_year <= 3
order by released_year desc, rank_by_year;

# Identify the artists whose average energy percentage across all their songs is above 80%.
# Use: CTE to compute average energy_% for each artist and then filter the results.
with average_energy_artist as (select `artist(s)_name`,
                                      avg(`energy_%`) as avg_energy
                               from clean_data_spotify
                               group by `artist(s)_name`)
select `artist(s)_name`, avg_energy
from average_energy_artist
where avg_energy > 80;

# Create a list of songs that have the highest rank across all platforms combined (Spotify, Apple, Deezer, Shazam).
# Use: CTE to unpivot and rank songs by their chart positions across platforms.
# Convert the charts of all platform into rows
with unpivot_chart as (select track_name, `artist(s)_name`, 'Spotify' as platform, in_spotify_charts as chart_rank
                       from clean_data_spotify
                       where in_spotify_charts is not null

                       union all
                       select track_name, `artist(s)_name`, 'Apple' as platform, in_apple_charts as chart_rank
                       from clean_data_spotify
                       where in_apple_charts is not null

                       union all
                       select track_name, `artist(s)_name`, 'Deezer' as platform, in_deezer_charts as chart_rank
                       from clean_data_spotify
                       where in_deezer_charts is not null

                       union all
                       select track_name, `artist(s)_name`, 'Shazam' as platform, in_shazam_charts as chart_rank
                       from clean_data_spotify
                       where in_shazam_charts is not null),
     rank_song as (select track_name,
                          `artist(s)_name`,
                          avg(chart_rank)                             as average_charts,
                          rank() over (order by avg(chart_rank) desc) as rank_by_platform
                   from unpivot_chart
                   group by track_name, `artist(s)_name`)
select track_name, `artist(s)_name`, average_charts, rank_by_platform
from rank_song;
















