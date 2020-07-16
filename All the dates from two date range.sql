DECLARE 
	@FromDate date = '2020-01-01',
	@ToDate   date = '2020-01-05'

;WITH CTE
             AS (SELECT @FromDate AS [Date]
                 UNION ALL
                 SELECT DATEADD(DD, 1, [Date]) AS [Date]
                 FROM CTE
                 WHERE DATEADD(DD, 1, [Date]) <= @ToDate)
				 SELECT * FROM CTE
         
