CREATE FUNCTION fnReturnRate
( 
	@Rate DECIMAL(18,8) 
)
RETURNS VARCHAR(50)
AS
BEGIN
/*
	SELECT [dbo].fnReturnRate(35.3325)
*/
	DECLARE @RateValue			VARCHAR(50);
    DECLARE @DotPosition		int;
	DECLARE @PrecisionLength	int;
	DECLARE @ScaleLenght		int;
	SET @DotPosition = ( SELECT CHARINDEX('.',@Rate) ) 	
	SET @PrecisionLength = @DotPosition - 1	
	SET @ScaleLenght = 5 - @PrecisionLength

	IF (@PrecisionLength = 5) 
	BEGIN
		set @RateValue = ( select LEFT(@Rate,5))
	END
	ELSE
	BEGIN
		set @RateValue = (select LEFT(ROUND(@Rate,@ScaleLenght),6))
	END   

	return @RateValue;
END;
