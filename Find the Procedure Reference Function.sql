SELECT 
    o.name AS ReferencingObject, 
    sd.referenced_entity_name AS ReferencedObject
FROM sys.sql_expression_dependencies  AS sd
INNER JOIN sys.objects AS o
    ON o.object_id = sd.referencing_id
WHERE sd.referenced_entity_name = 'ufn_GetAllTransactionDateWiseOnlyBranch'; -- Function Name
