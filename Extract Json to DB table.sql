--Extract the json values into tabular format.

DECLARE @json NVARCHAR(MAX) = N'[{"Id":"993009","Title":"CARD RELOAD - FPX RELOAD","ApprovalCode":"993009","Amount":500.00,"Date":"2019-10-16T15:49:00","IsCashOut":false,"IsCashIn":false,"ReferenceNo":"6012","ReceiverId":null,"CustomerId":"00000000-0000-0000-0000-000000000000","ServiceId":0,"CurrencyName":"MYR","IsMultiCurrency":false,"SPAN":null,"RPAN":null,"Sender":null,"Receiver":null,"TransactionMessage":null,"Time":null,"TotalTopUp":null,"TotalSpend":null}]'

IF (@json is null or LTRIM(RTRIM(@json)) = '')
BEGIN 
SET @json = N'[]'
END
   
SELECT *  
FROM OPENJSON(@json)  
  WITH ([Id] int '$.Id',
	[Time] DATETIME '$.Date',
    [Title] nvarchar(500) '$.Title',
	[ApprovalCode] nvarchar(50) '$.ApprovalCode',
	[Amount] DECIMAL(32,2) '$.Amount',
	[IsCashOut] bit '$.IsCashOut',
	[IsCashIn]  bit '$.IsCashIn',
	[ReferenceNo] varchar(50) '$.ReferenceNo',
	[CurrencyName] varchar(50) '$.CurrencyName',
	[TransactionMessage] varchar(500) '$.TransactionMessage',
	[IsMultiCurrency] bit '$.IsMultiCurrency',
	[ServiceId] int '$.ServiceId')
	
