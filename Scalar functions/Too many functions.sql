/*
Function to count number of words in a title
	- count occurences of spaces in text + 1
*/
USE DoctorWho;
GO
CREATE OR ALTER FUNCTION dbo.fnWords (@EpisodeTitle VARCHAR(100))
RETURNS INT
AS
BEGIN
DECLARE @txt VARCHAR(100) = '';
SET @txt = LTRIM(RTRIM(@EpisodeTitle));
RETURN LEN(@txt) - LEN(REPLACE(@EpisodeTitle, ' ', '')) + 1;
END;
GO
SELECT Title, dbo.fnWords(Title) FROM tblEpisode;