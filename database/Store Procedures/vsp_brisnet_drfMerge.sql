USE FastTrackDev3;

IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_drfMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_drfMerge]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_drfMerge]
	@FileId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @TrackCd VARCHAR(75) = NULL;
	DECLARE @RaceDt DATE;
	DECLARE @RaceNum INT;

	IF NOT EXISTS (SELECT 0
				   FROM kelso.brisnet_Races
				   WHERE FileId = @FileId)
	BEGIN
		INSERT INTO kelso.brisnet_Races
		SELECT GETDATE()
			   ,GETDATE()
			   ,@FileId
			   ,NEWID()
			   ,D.TrackCd
			   ,ISNULL(T.TrackName, D.TrackCd)
			   ,CAST(D.[RaceDt] AS DATETIME)
			   ,CAST(D.[RaceNum] AS INT)
			   ,CAST(CAST(D.Distance AS DECIMAL(18,2)) / 220.00 AS DECIMAL(18,2))
			   ,D.Distance
			   ,CAST((CAST(D.Distance AS DECIMAL(18,2)) * 3.00) AS DECIMAL(18,2))
			   ,D.Surface 
			   ,D.RaceType 
			   ,D.Purse
			   ,D.ClaimingPrice
			   ,D.TrackRecord
		FROM kelso.brisnet_drf_staging D
		LEFT JOIN kelso.brisnet_Tracks T ON T.TrackCd = D.TrackCd;
	END

	DECLARE @brisnet_drf TABLE
	(
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[FileId] UNIQUEIDENTIFIER NOT NULL,
		[RaceId] UNIQUEIDENTIFIER NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NOT NULL,
		[RaceNum] [int] NULL,
		[Distance] [decimal](18, 2) NULL,
		[Surface] [char](1) NULL,
		[AllWeatherSurfaceFlag] [char](1) NULL,
		[RaceType] [varchar](5) NULL,
		[AgeSexRestrictions] [varchar](5) NULL,
		[Reserved9] [varchar](50) NULL,
		[Purse] [decimal](18, 0) NULL,
		[ClaimingPrice] [decimal](18, 0) NULL,
		[TrackRecord] [decimal](18, 2) NULL,
		[RaceConditions] [varchar](500) NULL,
		[LasixList] [varchar](500) NULL,
		[ButeList] [varchar](500) NULL,
		[CoupledList] [varchar](500) NULL,
		[MutuelList] [varchar](500) NULL,
		[SimulcastTrackCd] [varchar](3) NULL,
		[SimulcastTrackRaceNum] [varchar](50) NULL,
		[Reserved20] [varchar](500) NULL,
		[Reserved21] [varchar](500) NULL,
		[Reserved22] [varchar](500) NULL,
		[PostTimes] [varchar](50) NULL,
		[Reserved24] [varchar](500) NULL
	);

	INSERT INTO @brisnet_drf
	SELECT GETDATE()
		   ,GETDATE()
		   ,@FileId
	     ,[R].[RaceId]
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[Distance]
		   ,[SOURCE].[Surface]
		   ,[SOURCE].[AllWeatherSurfaceFlag]
		   ,[SOURCE].[RaceType]
		   ,[SOURCE].[AgeSexRestrictions]
		   ,[SOURCE].[Reserved9]
		   ,CASE WHEN ISNULL([SOURCE].[Purse], '') = '' THEN 0 ELSE [SOURCE].[Purse] END
		   ,CASE WHEN ISNULL([SOURCE].[ClaimingPrice], '') = '' THEN 0 ELSE [SOURCE].[ClaimingPrice] END
		   ,CASE WHEN ISNULL([SOURCE].[TrackRecord], '') = '' THEN 0 ELSE CAST([SOURCE].[TrackRecord] AS decimal(18,2)) END
		   ,[SOURCE].[RaceConditions]
		   ,[SOURCE].[LasixList]
		   ,[SOURCE].[ButeList]
		   ,[SOURCE].[CoupledList]
		   ,[SOURCE].[MutuelList]
		   ,[SOURCE].[SimulcastTrackCd]
		   ,[SOURCE].[SimulcastTrackRaceNum]
		   ,[SOURCE].[Reserved20]
		   ,[SOURCE].[Reserved21]
		   ,[SOURCE].[Reserved22]
		   ,[SOURCE].[PostTimes]
		   ,[SOURCE].[Reserved24]
	FROM kelso.brisnet_drf_staging SOURCE
	LEFT JOIN kelso.brisnet_Races R ON R.RaceDt = SOURCE.RaceDt
									   AND R.TrackCd = SOURCE.TrackCd
									   AND R.RaceNum = SOURCE.RaceNum
									   AND R.DistanceYard = SOURCE.Distance
	LEFT JOIN kelso.brisnet_drf DRF ON DRF.RaceDt = SOURCE.RaceDt
									   AND DRF.TrackCd = SOURCE.TrackCd
									   AND DRF.RaceNum = SOURCE.RaceNum
									   AND DRF.Distance = SOURCE.Distance;

	MERGE kelso.brisnet_drf AS [TARGET]
    USING @brisnet_drf [SOURCE]
    ON ([SOURCE].[RaceId] = [TARGET].[RaceId])
	WHEN MATCHED
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[Surface] = [SOURCE].[Surface]
			,[TARGET].[AllWeatherSurfaceFlag] = [SOURCE].[AllWeatherSurfaceFlag]
			,[TARGET].[RaceType] = [SOURCE].[RaceType]
			,[TARGET].[AgeSexRestrictions] = [SOURCE].[AgeSexRestrictions]
			,[TARGET].[Reserved9] = [SOURCE].[Reserved9]
			,[TARGET].[Purse] = [SOURCE].[Purse]
			,[TARGET].[ClaimingPrice] = [SOURCE].[ClaimingPrice] 
			,[TARGET].[TrackRecord] = [SOURCE].[TrackRecord]
			,[TARGET].[RaceConditions] = [SOURCE].[RaceConditions]
			,[TARGET].[LasixList] = [SOURCE].[LasixList]
			,[TARGET].[ButeList] = [SOURCE].[ButeList]
			,[TARGET].[CoupledList] = [SOURCE].[CoupledList]
			,[TARGET].[MutuelList] = [SOURCE].[MutuelList]
			,[TARGET].[SimulcastTrackCd] = [SOURCE].[SimulcastTrackCd]
			,[TARGET].[SimulcastTrackRaceNum] = [SOURCE].[SimulcastTrackRaceNum]
			,[TARGET].[Reserved20] = [SOURCE].[Reserved20]
			,[TARGET].[Reserved21] = [SOURCE].[Reserved21]
			,[TARGET].[Reserved22] = [SOURCE].[Reserved22]
			,[TARGET].[PostTimes] = [SOURCE].[PostTimes]
			,[TARGET].[Reserved24] = [SOURCE].[Reserved24]
	WHEN NOT MATCHED 
    THEN INSERT ([FileId]
	        ,[RaceId]
				  ,[CreatedDt]
			    ,[ModifiedDt]
			    ,[TrackCd]
			    ,[RaceDt]
			    ,[RaceNum]
			    ,[Distance]
			    ,[Surface]
			    ,[AllWeatherSurfaceFlag]
			    ,[RaceType]
			    ,[AgeSexRestrictions]
			    ,[Reserved9]
			    ,[Purse]
			    ,[ClaimingPrice]
			    ,[TrackRecord]
			    ,[RaceConditions]
			    ,[LasixList]
			    ,[ButeList]
			    ,[CoupledList]
			    ,[MutuelList]
			    ,[SimulcastTrackCd]
			    ,[SimulcastTrackRaceNum]
			    ,[Reserved20]
			    ,[Reserved21]
			    ,[Reserved22]
			    ,[PostTimes]
			    ,[Reserved24]) 
  VALUES ([SOURCE].[FileId]
				  ,[SOURCE].[RaceId]
				  ,GETDATE()
			    ,GETDATE()
			    ,[SOURCE].[TrackCd]
			    ,[SOURCE].[RaceDt]
			    ,[SOURCE].[RaceNum]
			    ,[SOURCE].[Distance]
			    ,[SOURCE].[Surface]
			    ,[SOURCE].[AllWeatherSurfaceFlag]
			    ,[SOURCE].[RaceType]
			    ,[SOURCE].[AgeSexRestrictions]
			    ,[SOURCE].[Reserved9]
			    ,[SOURCE].[Purse]
			    ,CASE WHEN [SOURCE].[ClaimingPrice] IS NULL THEN 0 ELSE [SOURCE].[ClaimingPrice] END
			    ,[SOURCE].[TrackRecord]
			    ,[SOURCE].[RaceConditions]
			    ,[SOURCE].[LasixList]
			    ,[SOURCE].[ButeList]
			    ,[SOURCE].[CoupledList]
			    ,[SOURCE].[MutuelList]
			    ,[SOURCE].[SimulcastTrackCd]
			    ,[SOURCE].[SimulcastTrackRaceNum]
			    ,[SOURCE].[Reserved20]
			    ,[SOURCE].[Reserved21]
			    ,[SOURCE].[Reserved22]
			    ,[SOURCE].[PostTimes]
			    ,[SOURCE].[Reserved24]);

	SELECT Id
		   ,FileId
		   ,RaceID 
		   ,RaceDt
		   ,TrackCd
		   ,TrackName
		   ,RaceNum
		   ,Furlong
		   ,DistanceFeet
		   ,Surface TurfInd
		   ,RaceType
	FROM kelso.brisnet_Races
	WHERE FileId = @FileId
	ORDER BY RaceNum;
END

GO
