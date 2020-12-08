USE WorldEvents;
GO
SELECT CAST(A.cent AS varchar(2))+B.txt, COUNT(*) FROM tblEvent te
CROSS APPLY (VALUES(
	YEAR(te.EventDate)/100 + 1
	) 
) AS A(cent)
CROSS APPLY (VALUES(
	CASE 
		WHEN A.cent%10 = 1 AND A.cent%10 <> 11 THEN 'st century'
		WHEN A.cent%10 = 2 AND A.cent%10 <> 12 THEN 'nd century'
		WHEN A.cent%10 = 3 AND A.cent%10 <> 13 THEN 'rd century'
		ELSE 'th century'
	END
		)
	) AS B(txt)
GROUP BY CUBE(CAST(A.cent AS varchar(2))+B.txt)
/*
GROUP BY ROLLUP 
(CAST(A.cent AS varchar(2))+B.txt)
*/
/* GROUP BY GROUPING SETS (
CAST(A.cent AS varchar(2))+B.txt, ()
)
*/
