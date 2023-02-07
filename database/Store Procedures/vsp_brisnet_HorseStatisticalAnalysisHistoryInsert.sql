IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_HorseStatisticalAnalysisHistory]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_HorseStatisticalAnalysisHistory]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_HorseStatisticalAnalysisHistory]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.brisnet_HorseStatisticalAnalysisHistory( CreatedDt
																,ModifiedDt
																,RaceId
																,RaceDt
																,HorseId
																,HorseName
																,TrackCd
																,BrisRunStyle
																,QuirinSpeedPoints
																,Bris2fPaceFig
																,Bris4fPaceFig
																,Bris6fPaceFig
																,BrisLatePace
																,BestBRISSpeedAllWeather
																,BestBRISSpeedDistance
																,BestBRISSpeedFastTrack
																,BestBRISSpeedOffTrack
																,BestBRISSpeedTurf)
	SELECT GETDATE()
		   ,GETDATE()
		   ,DR.RaceId
		   ,DR.RaceDt
		   ,H.HorseId
		   ,DR.HorseName
		   ,DR.TrackCd
		   ,DR.BrisRunStyle
		   ,DR.QuirinSpeedPoints
		   ,DR.Bris2fPaceFig
		   ,DR.Bris4fPaceFig
		   ,DR.Bris6fPaceFig
		   ,DR.BrisLatePace
		   ,DR.BestBRISSpeedAllWeather
		   ,DR.BestBRISSpeedDistance
		   ,DR.BestBRISSpeedFastTrack
		   ,DR.BestBRISSpeedOffTrack
		   ,DR.BestBRISSpeedTurf
	FROM kelso.brisnet_dr2 DR
			LEFT JOIN kelso.brisnet_HorseStatisticalAnalysisHistory ST ON (ST.RaceId = DR.RaceId AND ST.HorseName = DR.HorseName)
			JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
		AND ST.RaceId IS NULL;

END

GO