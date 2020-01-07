SELECT DB_NAME(database_id) DatabaseName,
OBJECT_NAME(object_id) ProcedureName,
cached_time, last_execution_time, execution_count,
total_elapsed_time/execution_count AS avg_elapsed_time,
type_desc
FROM sys.dm_exec_procedure_stats
--where DB_NAME(database_id) = 'MMESV2DB'
--and  OBJECT_NAME(object_id) = 'spReportMCDPerformanceAgent'
ORDER BY execution_count desc;
