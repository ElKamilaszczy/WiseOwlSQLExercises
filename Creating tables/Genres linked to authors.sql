Use Books;
GO
DROP TABLE IF EXISTS dbo.tblGenre, dbo.Genre;
IF EXISTS (SELECT 1 FROM sys.sysobjects s WHERE s.id = OBJECT_ID('tblGenre'))
DROP TABLE dbo.tblGenre;
 GO
CREATE TABLE dbo.tblGenre
(
	GenreID INT NOT NULL IDENTITY(1,1),
	GenreName VARCHAR(20) NOT NULL,
	Rating int NULL,
	CONSTRAINT PK_GenreID PRIMARY KEY CLUSTERED (GenreID)
);
GO
INSERT INTO dbo.tblGenre (GenreName, Rating)
VALUES('Romance', 3), ('SF', 7), ('Thriller', 5), ('Humour', 3);
GO
-- Add column to tblAuthor (of course first we need to check existence of that column and delete if exists)
IF EXISTS (SELECT 1 FROM sys.sysobjects s INNER JOIN sys.syscolumns c ON s.id = c.id AND s.name = 'tblAuthor'
WHERE c.name = 'GenreID')
BEGIN
	ALTER TABLE tblAuthor DROP COLUMN GenreID;
END;
ALTER TABLE tblAuthor ADD GenreID INT NULL;
GO
-- Foreign Key--
ALTER TABLE tblAuthor ADD CONSTRAINT FK_GenreID_tblGenre FOREIGN KEY (GenreID) REFERENCES tblGenre(GenreID);
-- Update --
UPDATE A
SET A.GenreID = g.GenreID
FROM tblAuthor A
INNER JOIN tblGenre g ON A.AuthorId = g.GenreId
