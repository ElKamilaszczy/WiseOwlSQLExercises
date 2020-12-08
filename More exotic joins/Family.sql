/*
Create a query which links 3 tables using outer joins, which show hierarchy tree for each row
*/
-- Using self joins --
USE worldEvents;
GO
select tf1.FamilyID, tf1.FamilyName, CONCAT
(tf3.FamilyName+' > ', tf2.FamilyName+' > ', tf1.FamilyName) from tblFamily tf1
LEFT OUTER JOIN tblFamily tf2 ON tf1.ParentFamilyID = tf2.FamilyId
LEFT OUTER JOIN tblFamily tf3 ON tf2.ParentFamilyId = tf3.FamilyId
ORDER BY 2;
-- Using Hierarchical query --
WITH hierarchy (FamilyId, FamilyName, HierarchyTree) AS
(
SELECT tf1.FamilyId, tf1.FamilyName, tf1.FamilyName FROM tblFamily tf1 WHERE ParentFamilyID IS NULL
UNION ALL
SELECT tf1.FamilyId, tf1.FamilyName, CAST(h.hierarchyTree +' > ' +tf1.FamilyName as nvarchar(255)) as HierarchyTree FROM
hierarchy h INNER JOIN tblFamily tf1 ON h.FamilyId = tf1.ParentFamilyId
)
select * from hierarchy;
-- Using MVT function --
GO
CREATE OR ALTER FUNCTION mvt_family
RETURNS @tbl TABLE (
	FamilyId int,
	FamilyName nvarchar(50),
	FamilyTree nvarchar(255)
)
AS
BEGIN
	INSERT INTO @tbl(FamilyId, FamilyName, FamilyTree)
	SELECT FamilyID, FamilyName, FamilyName
	FROM tblFamily WHERE ParentFamilyID IS NULL;
	RETURN;

END;
GO
select * from mvt_family;