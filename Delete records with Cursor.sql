BEGIN
	DECLARE @Id uniqueidentifier

	DECLARE  UserDeviceKeyID  CURSOR FOR
	select Id from UserDeviceKey
	where IsActive = 0
	--where UserId = '1B59C0A2-8400-4D4E-B8BC-F4DF13BF78CE';

	OPEN UserDeviceKeyID;
	FETCH NEXT FROM UserDeviceKeyID into @Id
	while @@FETCH_STATUS = 0 
		BEGIN 
			delete from UserDeviceKey WHERE Id = @Id
			--select * from UserDeviceKey WHERE Id = @Id
			fetch next from USerDeviceKeyID into @Id
		END
		close UserDeviceKeyID;
		deallocate UserDeviceKeyID;
END;
