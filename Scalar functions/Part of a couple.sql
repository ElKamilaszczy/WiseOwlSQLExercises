/*
The aim of this exercise is to create a function called fnEpisodeDescription such that you can count how many episodes there are of each type:
	- if there is "Part 1" in Description, then 'First part',
	- when "Part 2" exists within Description, then "Second part"
	- otherwise 'single episode'
*/
Use DoctorWho;
GO
CREATE OR ALTER FUNCTION dbo.fnEpisodeDescription (@EpisodeTitle VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
/*
 RETURN (CASE WHEN @EpisodeTitle LIKE '%Part 1%' COLLATE Latin1_General_CI_AI THEN 'First Part'
WHEN @EpisodeTitle LIKE '%Part 2%' COLLATE Latin1_General_CI_AI THEN 'Second Part'
ELSE 'Single' END); 
*/
RETURN CASE WHEN CHARINDEX('Part 1', @EpisodeTitle) <> 0 THEN 'First part'
WHEN CHARINDEX('Part 2', @EpisodeTitle) <> 0 THEN 'sECOND part'
ELSE 'Single' END;
END;
GO
-- count number of episodes of each typE
SELECT dbo.fnEpisodeDescription(Title) AS 'Episode type',
COUNT(*) AS 'Number of episodes'
FROM
tblEpisode
GROUP BY
dbo.fnEpisodeDescription(Title)
