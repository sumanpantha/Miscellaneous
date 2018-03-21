USE [Master];
GO
SET NOCOUNT ON;

--Table to hold all auto stats and their DROP statements
CREATE TABLE #commands
(
Database_Name        SYSNAME,
Table_Name              SYSNAME,
Stats_Name               SYSNAME,
cmd                            NVARCHAR(4000),
CONSTRAINT    PK_#commands PRIMARY KEY CLUSTERED (Database_Name, Table_Name, Stats_Name)
);

 

DECLARE Databases CURSOR
FOR
SELECT [name] FROM   sys.databases WHERE  database_id = 7;

DECLARE       
       @Database_Name SYSNAME, @cmd NVARCHAR(4000);
OPEN Databases;

FETCH NEXT FROM Databases INTO @Database_Name;
 
WHILE @@FETCH_STATUS = 0
BEGIN
-- Create all DROP statements for the database
    SET @cmd =    'SELECT 
	                     N''' + @Database_Name + ''', 
						 so.name,
                         ss.name,							
                         N''DROP STATISTICS [''+ ssc.name +'']''+''.[''+ so.name +'']''+ ''.[''+ ss.name + ''];''
                   FROM
       				   ['+ @Database_Name + '].sys.stats AS ss
                   INNER JOIN ['+ @Database_Name + '].sys.objects AS so ON ss.[object_id] = so.[object_id]
                   INNER JOIN ['+ @Database_Name + '].sys.schemas AS ssc ON so.schema_id = ssc.schema_id
                   WHERE         
				        ss.auto_created = 1 AND so.is_ms_shipped = 0';

--SELECT @cmd � DEBUG

--Execute and store in temp table
       INSERT INTO #commands 
	   EXECUTE  (@cmd);

--Next Database
       FETCH NEXT FROM Databases INTO   @Database_Name;
END;

GO

CLOSE         Databases;

DEALLOCATE    Databases;

DROP TABLE    #commands;

select * from #commands

--At this point, switch the query results output to �text� by clicking Ctrl + T or from the Query menu, select �Results to� and �Text�.

 


WITH Ordered_Cmd
AS
--Add an ordering column to the rows to mark database context
(
    SELECT 
       ROW_NUMBER() OVER ( PARTITION BY  Database_Name ORDER BY Database_Name, Table_Name, Stats_Name ) AS Row_Num, 
       * 
    FROM   
      #commands
)
SELECT  
     CASE WHEN   Row_Num = 1  THEN   REPLICATE(N'-',50) + NCHAR(10) + NCHAR(13) + N'USE [' + Database_Name + '];'+ NCHAR(10) + NCHAR(13) 
     ELSE  '' END + cmd FROM   Ordered_Cmd
ORDER BY      
      Database_Name, Table_Name, Stats_Name;

 

--CLEANUP

CLOSE         Databases;

DEALLOCATE    Databases;

DROP TABLE    #commands;

 