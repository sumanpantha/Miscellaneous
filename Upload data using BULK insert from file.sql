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
  
  
  -----EG:
  
  CREATE TABLE [dbo].[ServerLog](
	[date] [varchar](50) NULL,
	[time] [varchar](50) NULL,
	[s-ip] [nvarchar](1000) NULL,
	[cs-method] [nvarchar](1000) NULL,
	[cs-uri-stem] [nvarchar](1000) NULL,
	[cs-uri-query] [nvarchar](1000) NULL,
	[s-port] [nvarchar](1000) NULL,
	[cs-username] [nvarchar](1000) NULL,
	[c-ip] [nvarchar](1000) NULL,
	[cs(User-Agent)] [nvarchar](1000) NULL,
	[cs(Referer)] [nvarchar](1000) NULL,
	[sc-status] [nvarchar](1000) NULL,
	[sc-substatus] [nvarchar](1000) NULL,
	[sc-win32-status] [nvarchar](1000) NULL,
	[time-taken] [nvarchar](200) NULL
) ON [PRIMARY]
GO


BULK INSERT ServerLog
FROM 'E:\MMP\Log\AppServer\u_ex191106_46.txt'
WITH 
  (    
    FIELDTERMINATOR = ' ',	
	FIRSTROW = 2
  );
  
  
  
  
  
