IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_ProgramGet]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
  DROP PROCEDURE [kelso].[vsp_brisnet_ProgramGet];
END
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_ProgramGet]
(
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT TrackName
	FROM kelso.brisnet_Races
	WHERE RaceDt = @RaceDt
	ORDER BY TrackName;
END

GO









