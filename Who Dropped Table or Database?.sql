Ref :: https://blog.sqlauthority.com/2015/09/12/sql-server-who-dropped-table-or-database/

Let’s look at the events captured by the default trace.

SELECT DISTINCT Trace.EventID, TraceEvents.NAME AS Event_Desc
FROM   ::fn_trace_geteventinfo(1) Trace
,sys.trace_events TraceEvents
WHERE Trace.eventID = TraceEvents.trace_event_id

Here is what we would get in SQL Server 2014

Event_ID	Event_Desc
18	Audit Server Starts And Stops
20	Audit Login Failed
22	ErrorLog
46	Object:Created
47	Object:Deleted
55	Hash Warning
69	Sort Warnings
79	Missing Column Statistics
80	Missing Join Predicate
81	Server Memory Change
92	Data File Auto Grow
93	Log File Auto Grow
94	Data File Auto Shrink
95	Log File Auto Shrink
102	Audit Database Scope GDR Event
103	Audit Schema Object GDR Event
104	Audit Addlogin Event
105	Audit Login GDR Event
106	Audit Login Change Property Event
108	Audit Add Login to Server Role Event
109	Audit Add DB User Event
110	Audit Add Member to DB Role Event
111	Audit Add Role Event
115	Audit Backup/Restore Event
116	Audit DBCC Event
117	Audit Change Audit Event
152	Audit Change Database Owner
153	Audit Schema Object Take Ownership Event
155	FT:Crawl Started
156	FT:Crawl Stopped
164	Object:Altered
167	Database Mirroring State Change
175	Audit Server Alter Trace Event
218	Plan Guide Unsuccessful

As we can see there are various interesting events. Object:Altered, Object:Created and Object:Deleted 
can help us in identifying who dropped, altered or created any object. 
Once we get event class ID for the event of interest, we can use below query and replace the Event class ID.

-- read all available traces.
DECLARE @current VARCHAR(500);
DECLARE @start VARCHAR(500);
DECLARE @indx INT;
SELECT @current = path
FROM sys.traces
WHERE is_default = 1;
SET @current = REVERSE(@current)
SELECT @indx = PATINDEX('%\%', @current)
SET @current = REVERSE(@current)
SET @start = LEFT(@current, LEN(@current) - @indx) + '\log.trc';
-- CHNAGE FILER AS NEEDED
SELECT *
FROM::fn_trace_gettable(@start, DEFAULT)
WHERE EventClass IN (92,93) -- growth event
ORDER BY StartTime DESC

In above, I have used EventClass 92 and 93 to track database auto-growth events. 
Here is the query to find who dropped / created or altered object in database or database itself.

-- read all available traces.
DECLARE @current VARCHAR(500);
DECLARE @start VARCHAR(500);
DECLARE @indx INT;
SELECT @current = path
FROM sys.traces
WHERE is_default = 1;
SET @current = REVERSE(@current)
SELECT @indx = PATINDEX('%\%', @current)
SET @current = REVERSE(@current)
SET @start = LEFT(@current, LEN(@current) - @indx) + '\log.trc';
-- CHNAGE FILER AS NEEDED
SELECT CASE EventClass
WHEN 46 THEN 'Object:Created'
WHEN 47 THEN 'Object:Deleted'
WHEN 164 THEN 'Object:Altered'
END, DatabaseName, ObjectName, HostName, ApplicationName, LoginName, StartTime
FROM::fn_trace_gettable(@start, DEFAULT)
WHERE EventClass IN (46,47,164) AND EventSubclass = 0 AND DatabaseID <> 2
ORDER BY StartTime DESC
