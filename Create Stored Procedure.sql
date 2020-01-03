IF EXISTS
(
    SELECT 'x'
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[spName]')
          AND type IN(N'P', N'PC')
)
    DROP PROCEDURE [dbo].[spName];
GO
CREATE PROCEDURE [dbo].[spName] 
( 
    @FromDate DATETIME,
    @ToDate   DATETIME
)    
AS
BEGIN 
END;

