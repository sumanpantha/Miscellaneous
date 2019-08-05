SELECT DISTINCT
		  -- o.id, 
		  o.name AS 'Procedure_Name' , 
		  oo.name AS 'Table_Name'
		  --,d.depid
	      --, d.depnumber  -- comment this out returns unique tables only
FROM 
		  sysdepends d, sysobjects o, sysobjects oo
WHERE 	
		  o.id=d.id
		  AND o.name= 'spRemitReportEndOfDay'   -- Stored Procedure Name
		  AND oo.id=d.depid
		  --and depnumber=1
ORDER BY 
		 o.name,oo.name
