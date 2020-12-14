/*
First store in variable first word of each episodetype in the tblEpisode table.
Separately, write a query to show the first word of each episode type, along with the episode's doctor name and id, and pivot this to show the following (DoctorName, (Normal, Christmas) - (these are two "first words" from episode type)

Since it would be tedious writing the episode types out longhand (and they may change in the future) combine your two queries to get a single one using dynamic SQL to show all of the episode types.
*/
USE DoctorWho;
GO
DECLARE @episodeTypes NVARCHAR(MAX) = N'';
SELECT @episodeTypes = SUBSTRING(
(
	SELECT ', ' + QUOTENAME(SUBSTRING(e.episodeType, 1, CHARINDEX(' ', e.EpisodeType, 1) - 1)) FROM tblEpisode e 
	group by e.EpisodeType
	FOR XML PATH('')
),3, 2000);
SELECT @episodeTypes;
-- Dynamic PIVOT --
DECLARE @stmt NVARCHAR(MAX) = N'';

SET @stmt = '
WITH cte AS
(
SELECT d.DoctorName, SUBSTRING(e.episodeType, 1, CHARINDEX('' '', e.EpisodeType, 1) - 1) as first_word,
e.episodeId FROM tblEpisode e INNER JOIN tblDoctor d ON e.DoctorId = d.DoctorId
)
SELECT  * FROM cte c
PIVOT (
COUNT(c.episodeid) FOR c.first_word IN ('+@episodeTypes+')
) AS d';
/* The problem was with ' QUOTENAME(SUBSTRING(e.episodeType, 1, CHARINDEX(' ', e.EpisodeType, 1) - 1))'
in SELECT list within CTE. the comparison in picot was [50th] against 50th,  therefore no results were found.
*/
EXEC(@stmt);
EXECUTE sp_executesql @stmt = @stmt;
