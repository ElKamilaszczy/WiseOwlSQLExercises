Use DoctorWho;
GO
DROP TABLE IF EXISTS #tblProblems;
GO
CREATE TABLE #tblProblems
(
	ProblemID int IDENTITY(1,1),
	TableName VARCHAR(30),
	Id int, /* ID from identity or PK column */
	ColumnName VARCHAR(30), -- Column where event occured --
	ColumnValue VARCHAR(200), -- Value of a column which failed
	ProblemName VARCHAR(200), -- Error message
);
GO
-- Check if there are any values in column Notes in the table tblEpisode --
-- Well, this solution will be too much hardcoded - only for specific column, values--
-- Good to mention that DDL statements ARE influenced by transactions (we can commit, rollback them) - the behaviour is different in Oracle - each DDL statement is separate transaction (automatically committed).
IF EXISTS (SELECT 1 FROM tblEpisode WHERE Notes IS NOT NULL)
BEGIN
	INSERT INTO #tblProblems (TableName, Id, ColumnName, ColumnValue, ProblemName)
	SELECT 'tblEpisode', e.EpisodeId, 'Notes', e.Notes, 'Notes field filled in' from tblEpisode e
	WHERE e.Notes IS NOT NULL;
	Print 'Problems occured - cannot drop column';
END;
ELSE
BEGIN
	ALTER TABLE tblEpisode DROP COLUMN Notes;
END;
IF EXISTS (SELECT 1 FROM tblEnemy e WHERE LEN(e.Description) > 75)
BEGIN
	INSERT INTO #tblProblems (TableName, Id, ColumnName, ColumnValue, ProblemName)
	SELECT 'tblEpisode', e.EnemyId, 'Description', e.Description, 'Description has '+cast(LEN(e.Description) as varchar(3))+ ' letters' from tblEnemy e
	WHERE LEN(e.Description) > 75;
	Print 'Problems occured - cannot change column size';
END;
ELSE
BEGIN
ALTER TABLE tblEnemy ALTER COLUMN Description VARCHAR(75);
END;
-- Check problems --
SELECT * FROM #tblProblems;


