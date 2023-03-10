IF EXISTS (SELECT * FROM sysobjects 
      WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_TrntStatInsert]') 
       AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
 DROP PROCEDURE [kelso].[vsp_brisnet_TrntStatInsert]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_TrntStatInsert]
AS
BEGIN
	INSERT INTO [kelso].[brisnet_TrntStat]([RaceId]
										   ,[CreateDt]
										   ,[TrackCd]
										   ,[RaceDt]
										   ,[RaceNum]
										   ,[HorseId]
										   ,[HorseName]
										   ,[TrntStatCategory]
										   ,[NumOfStarts]
										   ,[WinPercentage]
										   ,[InTheMoneyPercentage]
										   ,[ReturnOfInvestment])
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory1] 
		   ,[SOURCE].[NumOfStarts1]
		   ,[SOURCE].[WinPercentage1]
		   ,[SOURCE].[InTheMoneyPercentage1]
		   ,[SOURCE].[ReturnOfInvestment1]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											     AND [TARGET].[HorseName] = [SOURCE].[HorseName]
												 AND [TrntStatCategory] = [SOURCE].[TrntStatCategory1]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory1], '') != ''
	UNION 
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory2] 
		   ,[SOURCE].[NumOfStarts2]
		   ,[SOURCE].[WinPercentage2]
		   ,[SOURCE].[InTheMoneyPercentage2]
		   ,[SOURCE].[ReturnOfInvestment2]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory2], '') != ''
		AND [SOURCE].[TrntStatCategory2] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory3] 
		   ,[SOURCE].[NumOfStarts3]
		   ,[SOURCE].[WinPercentage3]
		   ,[SOURCE].[InTheMoneyPercentage3]
		   ,[SOURCE].[ReturnOfInvestment3]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory3], '') != ''
		AND [SOURCE].[TrntStatCategory3] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory4] 
		   ,[SOURCE].[NumOfStarts4]
		   ,[SOURCE].[WinPercentage4]
		   ,[SOURCE].[InTheMoneyPercentage4]
		   ,[SOURCE].[ReturnOfInvestment4]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory4], '') != ''
		AND [SOURCE].[TrntStatCategory4] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory5] 
		   ,[SOURCE].[NumOfStarts5]
		   ,[SOURCE].[WinPercentage5]
		   ,[SOURCE].[InTheMoneyPercentage5]
		   ,[SOURCE].[ReturnOfInvestment5]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory5], '') != ''
		AND [SOURCE].[TrntStatCategory5] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory6] 
		   ,[SOURCE].[NumOfStarts6]
		   ,[SOURCE].[WinPercentage6]
		   ,[SOURCE].[InTheMoneyPercentage6]
		   ,[SOURCE].[ReturnOfInvestment6]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory6], '') != ''
		AND [SOURCE].[TrntStatCategory6] NOT IN ([TARGET].[TrntStatCategory]);
END

GO



