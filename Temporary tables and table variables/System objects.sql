/*

*/
DROP TABLE IF EXISTS #userObjects;

SELECT CASE type WHEN 'FN' then 'Scalar function' when 'P' then 'Stored proc' END AS ObjectType ,name as ObjectName, CAST(create_date as date) as DateCreated  INTO #userObjects FROM sys.objects 
WHERE type IN ('FN', 'P')
AND is_ms_shipped = 0; -- -> as it sounds - when 1 then we know, that this object is "shipped" by M$

SELECT * FROM #userObjects;