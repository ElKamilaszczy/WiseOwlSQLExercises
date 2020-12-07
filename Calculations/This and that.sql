/*
The aim of this exercise is to find this and that in the EventDetails column (in that order).  Your final query should show this: EventName, EventDate, thisPosition, thatPosition, Offset (distance between both)
*/
WITH thisNthat as
(
SELECT tc.EventName, tc.EventDate, tc.EventDetails,CHARINDEX('this', tc.EventDetails, 1) as thisPosition,
CHARINDEX('that', tc.EventDetails, 1) as thatPosition, CHARINDEX('that', tc.EventDetails, 1) - CHARINDEX('this', tc.EventDetails, 1) as Offset  FROM tblEvent tc
WHERE tc.EventDetails LIKE '%this%' COLLATE Latin1_General_CI_AI AND tc.EventDetails LIKE '%that%' COLLATE Latin1_General_CI_AI AND CHARINDEX('this', tc.EventDetails, 1) < CHARINDEX('that', tc.EventDetails, 1)
)
select * from thisNthat;
