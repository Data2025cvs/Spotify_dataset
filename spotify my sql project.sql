SELECT *
FROM spotify

--Level I -
--1. Retrieve the names of all tracks that have more than 1 billion streams.

SELECT track, stream
FROM spotify
WHERE stream > 1000000000;

--2. List all albums along with their respective artists.

SELECT album, artist
FROM spotify
GROUP BY album, artist;

--3. Get the total number of comments for tracks where licensed = TRUE.

SELECT Licensed, SUM(Comments) total_comments
FROM spotify
GROUP BY Licensed
HAVING Licensed = 'TRUE';

--4. Find all tracks that belong to the album type single.

SELECT track
FROM spotify
WHERE Album_type = 'single';

--5. Count the total number of tracks by each artist.

SELECT artist, count(track) total_tracks
FROM spotify
GROUP  BY Artist;

--6. Calculate the average danceability of tracks in each album.

SELECT Album, ROUND(AVG(Danceability),2) avg_dabceability
FROM spotify
GROUP  BY Album;

--7. Find the top 5 tracks with the highest energy values.
SELECT TOP 5 Track
FROM spotify
ORDER BY Energy DESC;

--8. List all tracks along with their views and likes where official_video = TRUE.

SELECT Track, Views, Likes
FROM spotify
WHERE official_video = 'true';

--9. For each album, calculate the total views of all associated tracks.

SELECT Album, SUM(views) Total_views
FROM spotify
GROUP  BY Album;

--10. Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT Track
FROM spotify
WHERE most_playedon = 'spotify';

--11. Find the top 3 most-viewed tracks for each artist using window functions.

WITH CTE AS
(
SELECT *, rank() over (partition by artist order by views DESC) rn
FROM spotify
)

SELECT artist, track, rn
FROM CTE
WHERE rn in (1,2,3);

--12. Write a query to find tracks where the liveness score is above the average.

SELECT Track
FROM spotify
WHERE Liveness > (SELECT AVG(Liveness) FROM spotify) ;


--13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH CTE AS
(
SELECT Album, MAX(Energy) Highest_energy, MIN(Energy) Lowest_energy
FROM spotify
GROUP BY Album
)

SELECT Album, Highest_energy-Lowest_energy Differnce
FROM CTE

--14. Find tracks where the energy-to-liveness ratio is greater than 1.2.

SELECT Track, ROUND(Energy/Liveness, 2) Ratio
FROM spotify
WHERE liveness != 0 AND Energy/Liveness > 1.2 ; -- to avoid "Divide by zero" error


