DROP TABLE Orders

create table Orders
(
Id int , 
OrderName varchar(50),
OrderDate date,
FromDOB varchar(10),
ToDOB varchar(10)
)

/*
Create file with name Test on C:\files\

Id|OrderName|OrderDate|FromDOB|ToDOB
1|Bag|2010-08-21||
2|Shoes|2011-08-21||
3|T-Shirt|2012-08-21||
4|Shirt|2013-08-21||
5|Pant|2014-08-21||
6|Jel|2015-08-21||
7|Mango|2016-08-21||
*/

-- Trigger Start

CREATE TRIGGER [dbo].[DOBInsertUpdateTrigger] ON [dbo].[Orders]
FOR  INSERT 
AS 
BEGIN 
  SET NOCOUNT ON;
	DECLARE @Id INT,
  @FromDOB VARCHAR(50);
	SELECT 
		@Id = Id,
		@FromDOB = DATEPART(YEAR,INSERTED.OrderDate)
    FROM INSERTED
	
DECLARE cursor_product CURSOR
FOR SELECT 
        Id,
		DATEPART(YEAR,OrderDate) FromDOB
    FROM 
        Orders

OPEN cursor_product;

FETCH NEXT FROM cursor_product INTO 
    @Id, 
    @FromDOB;

WHILE @@FETCH_STATUS = 0
    BEGIN

       -- select @Id,@FromDOB
		UPDATE Orders
			SET FromDOB = @FromDOB
		WHERE  id = @id

        FETCH NEXT FROM cursor_product INTO 
            @Id, 
            @FromDOB;
    END;

CLOSE cursor_product;

DEALLOCATE cursor_product;
 
END
-- Trigger END

BULK INSERT Orders
FROM 'C:\files\Test.txt'
WITH 
  ( 
	 FIRSTROW = 2
    ,FIELDTERMINATOR = '|'
	,FIRE_TRIGGERS 
  );
-- Truncate table Orders

select * from Orders






insert into Orders(Id,OrderName,OrderDate)
VALUES(8,'Pizza','2019-01-01')

