--This query give the max lenght of all the columns of all tables in a database which has datatype NVARCHAR(MAX)
-- So that we can restrict to appropriate length size of the datatype.

SELECT 
	'select ''['+TABLE_NAME+'.'+COLUMN_NAME  +']'' as [TableAndColName] , Max(len(['+COLUMN_NAME+'])) AS ColMaxDataLength'+ ' FROM ['+TABLE_NAME+'] UNION ALL'  
FROM INFORMATION_SCHEMA.COLUMNS WHERE 
DATA_TYPE = 'nvarchar' and CHARACTER_MAXIMUM_LENGTH = -1
ORDER BY TABLE_NAME
