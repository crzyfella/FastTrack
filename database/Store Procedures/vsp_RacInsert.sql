IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_RacInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_RacInsert]
GO

CREATE PROCEDURE [kelso].[vsp_RacInsert]
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.rac 
	SELECT S.*
	FROM kelso.rac_staging S
	WHERE NOT EXISTS (
						SELECT *
						FROM kelso.rac
						WHERE RaceDt = S.RaceDt
							  AND TrackCd = S.TrackCd
							  AND RaceNum = S.RaceNum
					 );

	SELECT R.RacID, 
		   R.RaceDt, 
		   R.TrackCd, 
		   R.RaceNum, 
		   R.Distance,
		   ROUND (R.Distance / 660.0, 2) Furlong,
		   R.TurfInd 
	FROM kelso.rac R
		 JOIN kelso.rac_staging S ON S.RaceDt = R.RaceDt AND S.TrackCd = R.TrackCd AND S.RaceNum = R.RaceNum;
END;

GO