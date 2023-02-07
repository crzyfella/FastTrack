IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_RacesInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_RacesInsert]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_RacesInsert]
	@TrackCd VARCHAR(75),
	@RaceDt DATE,
	@RaceNum INT
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT 1 
			   FROM kelso.brisnet_drf_staging
			   WHERE TrackCd = @TrackCd
			   AND RaceDt = @RaceDt
			   AND RaceNum = @RaceNum)
	BEGIN
		INSERT INTO kelso.brisnet_Races
		SELECT NEWID()
			   ,GETDATE()
			   ,GETDATE()
			   ,D.TrackCd
			   ,T.TrackName
			   ,D.RaceDt
			   ,D.RaceNum
			   ,CAST(CAST(D.Distance AS DECIMAL(18, 2)) / 330.00 AS DECIMAL(18, 2))
			   ,D.Distance
		FROM kelso.brisnet_drf_staging D
		JOIN kelso.brisnet_Tracks T ON T.TrackCd = D.TrackCd;
	END
END
  
GO
