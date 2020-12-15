/*
	Transfer commma separated string of ids into their names respectively 
	https://www.wiseowl.co.uk/sql/exercises/standard/archived/1797/
*/
SELECT * FROM tblTrainer;
DECLARE @ids VARCHAR(MAX);
SELECT @ids = SUBSTRING(
(SELECT ','+cast(TrainerId as varchar) FROM tblTrainer
FOR XML PATH('')),2, 2000
);
select @ids;
--Using STRING_SPLIT (FROM 2016)
DECLARE @names VARCHAR(MAX)
SELECT @names = SUBSTRING((
SELECT ', '+t.TrainerName FROM tblTrainer t
CROSS APPLY string_split(@ids, ',') ss
WHERE ss.value = t.TrainerId
FOR XML PATH('')
), 3, 2000);
SELECT @names;


-- Prior 2016 --
GO
CREATE OR ALTER PROC dbo.genNums(@howMany int)
AS
BEGIN
	WITH cte AS (SELECT 1 AS n FROM (VALUES(1), (1), (1), (1)) as t(n)),
	cte1 AS (SELECT 1 AS n FROM cte c CROSS JOIN cte c2),
	cte2 AS (SELECT 1 as n FROM cte1 c CROSS JOIN cte1 c2),
	row_nums AS (SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as rownum FROM cte2)
	SELECT TOP(@howMany) rownum FROM row_nums
END;
GO
CREATE OR ALTER FUNCTION dbo.mstvfSeparatedToTable (@list VARCHAR(MAX))
RETURNS @tbl TABLE
(
	Id int
)
AS
BEGIN
DECLARE @numOfIds int = LEN(@list) - LEN(REPLACE(@list, ',', '')) + 1;
DECLARE @inc int = 1, @indexOfComma int = 0, @indexOfPrevious int = 0, @substring VARCHAR(5) = '';
	WHILE @inc <= @numOfIds
	BEGIN
		SET @indexOfComma = CHARINDEX(',', @list, @indexOfComma+1);
		IF @indexOfComma = 0 
			BEGIN
			insert INTO @tbl VALUES(CAST((SUBSTRING(@list, @indexOfPrevious+1, LEN(@list))) AS INT));
			RETURN;
			END;
		SET @substring = SUBSTRING(@list, @indexOfPrevious+1, @indexOfComma - @indexOfPrevious - 1);
		INSERT INTO @tbl
		VALUES(CAST(@substring AS int));
		SET @indexOfPrevious = @indexOfComma;
		SET @inc = @inc + 1;
	END;
	RETURN;
END;
GO
-- Check --
SELECT * FROM tblTrainer;
DECLARE @ids VARCHAR(MAX);
SELECT @ids = SUBSTRING(
(SELECT ','+cast(TrainerId as varchar) FROM tblTrainer
FOR XML PATH('')),2, 2000
);
select @ids;
-- 21,93,1021,2936,3993,4085--
SELECT * FROM dbo.mstvfSeparatedToTable(@ids);
select SUBSTRING('12345', 1, 2);

select CHARINDEX('2', '2312', 1);