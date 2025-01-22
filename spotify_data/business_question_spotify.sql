use Spotify_hit_2023;
select * from clean_data_spotify;

# Which songs have the highest number of streams?
select track_name, `artist(s)_name`, streams
from clean_data_spotify
order by streams desc
limit 10;

# Which artist(s) have contributed to the most songs in the dataset?
select `artist(s)_name`, count(`artist(s)_name`) as songs_contributor
from clean_data_spotify
group by `artist(s)_name`
order by songs_contributor desc;

# What are the top 10 songs by number of Spotify playlists they are included in ?
select track_name, in_spotify_playlists
from clean_data_spotify
order by in_spotify_playlists desc
limit 10;

# Which songs appear in all four charts (Spotify, Apple, Deezer, SHazam)?
select track_name
from clean_data_spotify
where in_spotify_charts > 0 and in_apple_charts > 0 and in_deezer_charts > 0 and in_shazam_charts > 0;

# How many songs realeased in a specific year (e.g., 2022) are inclued in Spotify charts?
select track_name
from clean_data_spotify
where released_year = 2022 and in_spotify_charts > 0;

# Which songs with the hishgest rank on Shazam charts have the lowest danceability_%?
select track_name, in_shazam_charts, `danceability_%`
from clean_data_spotify
order by in_shazam_charts desc, `danceability_%` asc
limit 10;

# How many songs were released each year?
select released_year, count(track_name) as number_of_track_name
from clean_data_spotify
group by released_year
order by number_of_track_name desc;

# What is the most common month for releasing songs?
select released_month, count(released_month) as count_of_released_month
from clean_data_spotify
group by released_month
order by count_of_released_month desc;

# How does the average streams vary across release years?
select released_year, avg(streams) as average_streams
from clean_data_spotify
group by released_year
order by average_streams desc;

# Which key is most commonly used in the songs?
select `key`, count(`key`) as key_counted
from clean_data_spotify
group by `key`
order by key_counted desc;

# Which songs have the highest energy_% and are suitable for dancing (danceability_% > 80) ?
select track_name, `energy_%`
from clean_data_spotify
where `danceability_%` > 80
order by `energy_%` desc 
limit 1;

# Find the top 5 acoustic songs (acousticness_% > 70) with the most streams
select track_name, streams
from clean_data_spotify
where `acousticness_%` > 70
order by streams desc
limit 5; 

# Do songs with higher valence_% tend to have higher danceability_%?
SELECT 
    COUNT(*) AS total_pairs,
    SUM(CASE WHEN a.`danceability_%` > b.`danceability_%`  THEN 1 ELSE 0 END) AS consistent_pairs,
    SUM(CASE WHEN a.`danceability_%`  <= b.`danceability_%`  THEN 1 ELSE 0 END) AS inconsistent_pairs,
    SUM(CASE WHEN a.`danceability_%`  > b.`danceability_%`  THEN 1 ELSE 0 END) / COUNT(*) AS consistency_rate
FROM clean_data_spotify a
JOIN clean_data_spotify b ON a.track_name != b.track_name
WHERE a.`valence_%` > b.`valence_%`;


# Compare the average streams of songs included in Spotify playlists to those included in Apple playlists.
select track_name,
in_spotify_playlists / (in_spotify_playlists + in_apple_playlists) * 100 as spotify,
in_apple_playlists / (in_spotify_playlists + in_apple_playlists)  * 100 as apple
from clean_data_spotify;

# Do songs with more (artist_count > 1) have higher streams than solo artist songs?
select artist_count,
avg(streams)
from clean_data_spotify
where artist_count > 1
group by artist_count;

# List all songs released in the last 5 years that appear in Deezer charts and have a speechiness_% > 80 that are not in any Spotify playlists.
with song_last_5_years as (
select *
from clean_data_spotify
where released_year > 2018
order by released_year desc
)
select track_name, `speechiness_%`, in_spotify_playlists
from song_last_5_years
where `speechiness_%` > 80;

# Which artist(s) released songs with the highest average bpm?
select `artist(s)_name`, avg(bpm)
from clean_data_spotify
group by `artist(s)_name`
order by avg(bpm) desc
limit 1;

# Find songs with instrumentalness_% > 80 that are not in any spotify playlists.
select track_name , in_spotify_playlists
from clean_data_spotify
where `instrumentalness_%` > 80;

# Which artists have the most songs in Apple charts, and what is their average rank?
select `artist(s)_name`, in_apple_charts
from clean_data_spotify
order by in_apple_charts desc
limit 1;

# Identify the top 3 artists with the highest average streams per song?
select `artist(s)_name`, track_name, avg(streams)
from clean_data_spotify
group by `artist(s)_name`, track_name
order by avg(streams) desc
limit 3;

# Rank the months by the total streams of songs released in them.
select released_month,
sum(streams) as total_streams,
rank() over(order by sum(streams) desc) as rank_num
from clean_data_spotify
group by released_month
order by rank_num;

# Rank the stream of song in mode
select `mode`, track_name, streams,
rank() over(partition by `mode` order by streams desc) rank_in_mode
from clean_data_spotify; 

# Which songs have the highest combination of danceability_%, valence_%, and energy_%?
select track_name, `danceability_%` + `valence_%` + `energy_%` as combination,
rank() over (order by `danceability_%` + `valence_%` + `energy_%` desc) as rank_num
from clean_data_spotify
order by combination desc
limit 10;

# Find songs that rank in the top 10 on at least two platforms' chart?
select track_name, 
in_spotify_charts, in_apple_charts, 
in_deezer_charts, in_shazam_charts,
rank() over (order by in_spotify_charts desc, in_apple_charts desc) rank_num
from clean_data_spotify
order by in_spotify_charts desc, in_apple_charts desc
limit 10;

# Identify the oldest song in the dataset with streams greater than 1 million.
select track_name, released_year, streams
from clean_data_spotify
where streams > 1000000
order by released_year asc
limit 10;

