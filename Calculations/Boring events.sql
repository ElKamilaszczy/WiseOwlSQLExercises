/*
Write a query to list out all of the non-boring events:
As the above query shows, a boring event is one which doesn't begin and end with the same letter, and which doesn't begin and end with a vowel.
*/
WITH descs AS (
SELECT EventName, CASE 
WHEN LEFT(EventName, 1) COLLATE Latin1_General_CI_AI = RIGHT(EventName, 1) COLLATE Latin1_General_CI_AI
	THEN 'Same Letter'
WHEN LEFT(EventName, 1) COLLATE Latin1_General_CI_AI LIKE '[aeiou]' AND RIGHT(EventName, 1) COLLATE Latin1_General_CI_AI LIKE '[aeiou]'
	THEN 'Begins and ends with vowel'
ELSE '1'
END as verdict
FROM tblEvent
)
SELECT * FROM descs WHERE verdict <> '1';