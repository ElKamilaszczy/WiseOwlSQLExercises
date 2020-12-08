/*
Using the tblAuthor and tblEpisode tables, create a stored procedure called spMoffats to list out the 32 episodes written by Steven Moffat in date order (with the most recent first):
Now amend your SQL so that it creates a different stored procedure called spRussell, listing out the 30 episodes penned by people called Russell:
Surely the moste efficient manner is to create SP which takes as an argument name of an author
*/
USE DoctorWho;
GO
CREATE OR ALTER PROCEDURE spAuthorsEpisodes @AuthorName nvarchar(100) = 'Steven Moffat'
AS
BEGIN
	SET NOCOUNT ON;
	SELECT te.Title, te.EpisodeDate FROM tblEpisode te INNER JOIN tblAuthor ta ON te.AuthorId = ta.AuthorId
	WHERE ta.AuthorName = @AuthorName
	ORDER BY te.EpisodeDate DESC
END;
GO
EXECUTE spAuthorsEpisodes @AuthorName = /*DEFAULT*/

