
--Encrypt / Decrypt FUNCTION

ALTER FUNCTION [dbo].[fn_Encrypt]
( 
				@pClearString varchar(max)
)
RETURNS nvarchar(100)
AS
BEGIN

	DECLARE @vEncryptedString nvarchar(max);
	DECLARE @vIdx int;
	DECLARE @vBaseIncrement int;

	SET @vIdx = 1;
	SET @vBaseIncrement = 128;
	SET @vEncryptedString = '';

	WHILE @vIdx <= LEN(@pClearString)
	BEGIN
		SET @vEncryptedString = @vEncryptedString + NCHAR(ASCII(SUBSTRING(@pClearString, @vIdx, 1))+@vBaseIncrement+@vIdx-1);
		SET @vIdx = @vIdx + 1;

	END;

	RETURN @vEncryptedString;
END;


ALTER FUNCTION [dbo].[fn_Decrypt]
( 
				@pEncryptedString nvarchar(max)
)
RETURNS varchar(max)

AS
BEGIN

	DECLARE @vClearString varchar(max);

	SET @vClearString = '';

BEGIN
	SET @vClearString = dbo.f_ParseString( @pEncryptedString, 0, 128 );
END;

	RETURN @vClearString;

END;

