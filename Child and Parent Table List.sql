select 
    object_name(parent_object_id) [ChildTable], 
    object_name(referenced_object_id) [ParentTable]
from 
    sys.foreign_keys
WHERE 
    object_name(referenced_object_id) ='TableName'
    
