Make Test.txt file with the contan below and save the file in the location C:\files\

Id|OrderName|OrderDate
1|Order|2019-07-23


Go To SSMS

DROP TABLE Orders

create table Orders
(
Id int , 
OrderName varchar(50),
OrderDate date
)


BULK INSERT Orders
FROM 'C:\files\Test.txt'
WITH 
  (    
    FIELDTERMINATOR = '|',	
	FIRSTROW = 2
  );


  select * from Orders
  
  
  
  
  
