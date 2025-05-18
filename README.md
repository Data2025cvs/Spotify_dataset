# Spotify_dataset

### Data Set link on Kaggle 
https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset/data

### Overview
This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using SQL. It involves performing SQL queries of varying complexity (**Level I**, **Level II**, **Level III**). The primary goals of the project are to practice advanced SQL skills(using SQL Server) and generate valuable insights from the dataset.


### Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:

Artist: The performer of the track.
Track: The name of the song.
Album: The album to which the track belongs.
Album_type: The type of album (e.g. single or album).
Various metrics such as danceability, energy, loudness, tempo etc.

### Practice SQL Queries


**--Level I**  
--1. Retrieve the names of all tracks that have more than 1 billion streams.  
``` sql
SELECT track, stream
FROM spotify
WHERE stream > 1000000000;
```

--2. List all albums along with their respective artists.  
``` sql
SELECT album, artist
FROM spotify
GROUP BY album, artist;
```

--3. Get the total number of comments for tracks where licensed = TRUE.  
``` sql
SELECT Licensed, SUM(Comments) total_comments
FROM spotify
GROUP BY Licensed
HAVING Licensed = 'TRUE';
```

--4. Find all tracks that belong to the album type single.  
``` sql
SELECT track
FROM spotify
WHERE Album_type = 'single';
```

--5. Count the total number of tracks by each artist.  
``` sql
SELECT artist, count(track) total_tracks
FROM spotify
GROUP  BY Artist;
```

**--Level II**  
--6. Calculate the average danceability of tracks in each album.  
``` sql
SELECT Album, ROUND(AVG(Danceability),2) avg_dabceability
FROM spotify
GROUP  BY Album;
```

--7. Find the top 5 tracks with the highest energy values.  
``` sql
SELECT TOP 5 Track
FROM spotify
ORDER BY Energy DESC;
```

--8. List all tracks along with their views and likes where official_video = TRUE.  
``` sql
SELECT Track, Views, Likes
FROM spotify
WHERE official_video = 'true';
```

--9. For each album, calculate the total views of all associated tracks.  
``` sql
SELECT Album, SUM(views) Total_views
FROM spotify
GROUP  BY Album;
```

--10. Retrieve the track names that have been streamed on Spotify more than YouTube.  
``` sql
SELECT Track
FROM spotify
WHERE most_playedon = 'spotify';
```

--Level III  
--11. Find the top 3 most-viewed tracks for each artist using window functions.  
``` sql
WITH CTE AS
(
SELECT *, rank() over (partition by artist order by views DESC) rn
FROM spotify
)

SELECT artist, track, rn
FROM CTE
WHERE rn in (1,2,3);
```

--12. Write a query to find tracks where the liveness score is above the average.  
``` sql
SELECT Track
FROM spotify
WHERE Liveness > (SELECT AVG(Liveness) FROM spotify) ;
```

--13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.  
``` sql
WITH CTE AS
(
SELECT Album, MAX(Energy) Highest_energy, MIN(Energy) Lowest_energy
FROM spotify
GROUP BY Album
)

SELECT Album, Highest_energy-Lowest_energy Differnce
FROM CTE
```

--14. Find tracks where the energy-to-liveness ratio is greater than 1.2.  
``` sql
SELECT Track, ROUND(Energy/Liveness, 2) Ratio
FROM spotify
WHERE liveness != 0 AND Energy/Liveness > 1.2 ; -- to avoid "Divide by zero" error
```

### Technology Stack  
Database: **SQL Sever**  
SQL Queries: DML, DQL, Aggregations, Subqueries, Common table Expressions, Window Functions
Tools: SQL Server Management Studio 20

