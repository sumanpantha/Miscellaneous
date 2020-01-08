select 
    object_name(parent_object_id), 
    object_name(referenced_object_id)
from 
    sys.foreign_keys
WHERE 
    object_name(referenced_object_id) ='TableName'
    
