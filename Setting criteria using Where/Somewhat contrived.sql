
/*
First show a list of all events which might have something to do water.  The Wise Owl interpretation of this is that one or more of the following is true:
    
	They take place in one of the island countries (8, 22, 30 and 35, corresponding to Japan, the Marshall Islands, Cuba and Sri Lanka respectively)
    Their EventDetails column contains the word Water (not the text Water, but the word)
    Their category is number 4 (Natural World)

This should return 11 rows.  Now add a criterion to show only those events which happened since 1970 (you may need to use parentheses to get this to give the correct answer).
*/
USE WorldEvents;
GO
select * from tblEvent
WHERE 
(CountryID IN (8, 22, 30, 35) OR 
REPLACE(EventDetails, ',', ' ') LIKE '% Water %' COLLATE Latin1_General_CI_AI -- Need to tacke situation, when the comma is after that word: 'water, which...' -> 'water which'. Also Collation to Case-insensitive.
OR CategoryId = 4)
AND EventDate > '19700101';
