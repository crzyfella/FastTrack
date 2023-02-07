IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorseHistoryStatsInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorseHistoryStatsInsert]
GO

CREATE PROCEDURE [kelso].[vsp_HorseHistoryStatsInsert]
AS
BEGIN
	SET NOCOUNT ON;

	
	WITH CTE AS
	(
		SELECT HorseHistoryID,
			   HorseID, 
			   RaceDt, 
			   TrackCd,
			   RaceNum,
			   Distance,
			   Furlong,
			   TurfInd,
			   TrackCondition,
			   FirstCallTime,
			   SecondCallTime,
			   FinalTime,
			   AdditionalFractionalTime,
			   FirstCallPosition, 
			   SecondCallPosition, 
			   StretchCallPosition,
			   FinalCallPosition,
			   FirstCallBeatenLengths,
			   SecondCallBeatenLengths,
			   StretchCallBeatenLengths,
			   FinalBeatenLengths,
			   CASE
				WHEN (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN (FirstCallTime = FinalTime OR FirstCallTime = 0) THEN NULL
				WHEN FirstCallTime < 17.0 AND FirstCallPosition = 1 THEN FirstCallTime
				WHEN FirstCallTime < 17.0 THEN FirstCallTime + ROUND(FirstCallBeatenLengths / 5.0, 1)
			   END Furlong_1,
			   CASE
				WHEN Distance <= (660.0 * 6.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance <= (660.0 * 6.0) AND (FirstCallTime = FinalTime OR FirstCallTime = 0) THEN NULL
				WHEN Distance <= (660.0 * 6.0) AND FirstCallTime < 17.0 THEN NULL
				WHEN Distance <= (660.0 * 6.0) AND FirstCallPosition = 1 THEN FirstCallTime
				WHEN Distance <= (660.0 * 6.0) THEN FirstCallTime + ROUND(FirstCallBeatenLengths / 5.0, 1)
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND FirstCallTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND FirstCallPosition = 1 THEN FirstCallTime
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) THEN FirstCallTime + ROUND(FirstCallBeatenLengths / 5.0, 1)
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND AdditionalFractionalTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND FirstCallPosition = 1 THEN AdditionalFractionalTime
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) THEN AdditionalFractionalTime + ROUND(FirstCallBeatenLengths / 5.0, 1)
			   END Furlong_2,
			   CASE
				WHEN Distance BETWEEN (660.0 * 3.5) AND (660.0 * 4.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance BETWEEN (660.0 * 3.5) AND (660.0 * 4.0) AND (ISNULL(SecondCallTime, 0.0) = 0.0 OR StretchCallPosition = 0) THEN NULL
				WHEN Distance BETWEEN (660.0 * 3.5) AND (660.0 * 4.0) AND StretchCallPosition = 1 THEN SecondCallTime 
				WHEN Distance BETWEEN (660.0 * 3.5) AND (660.0 * 4.0) THEN SecondCallTime + ROUND(StretchCallBeatenLengths / 5.0, 1) 
			   END Furlong_3,
			   CASE 
				WHEN Distance BETWEEN (660.0 * 4.5) AND (660.0 * 5.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance BETWEEN (660.0 * 4.5) AND (660.0 * 5.0) AND (SecondCallTime = FinalTime OR SecondCallTime = 0) THEN NULL
				WHEN Distance BETWEEN (660.0 * 4.5) AND (660.0 * 5.0) AND SecondCallPosition = 1 THEN SecondCallTime
				WHEN Distance BETWEEN (660.0 * 4.5) AND (660.0 * 5.0) THEN SecondCallTime + ROUND(SecondCallBeatenLengths / 5.0, 1)
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) AND SecondCallTime = 0 THEN NULL
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) AND SecondCallPosition = 1 THEN SecondCallTime
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) THEN SecondCallTime + ROUND(SecondCallBeatenLengths / 5.0, 1)
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND SecondCallTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND SecondCallPosition = 1 THEN SecondCallTime
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) THEN SecondCallTime + ROUND(SecondCallBeatenLengths / 5.0, 1)
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND FirstCallTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND SecondCallPosition = 1 THEN FirstCallTime
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) THEN FirstCallTime + ROUND(SecondCallBeatenLengths / 5.0, 1)
				WHEN Distance >= (660.0 * 9.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 9.0) AND FirstCallTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 9.0) AND FirstCallPosition = 1 THEN FirstCallTime
				WHEN Distance >= (660.0 * 9.0) THEN FirstCallTime + ROUND(FirstCallBeatenLengths / 5.0, 1)
			   END Furlong_4,
			   CASE
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) AND AdditionalFractionalTime = 0 THEN NULL
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) AND StretchCallPosition = 1 THEN AdditionalFractionalTime
				WHEN Distance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) THEN AdditionalFractionalTime + ROUND(StretchCallBeatenLengths / 5.0, 1)
			   END Furlong_5,
			   CASE
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND AdditionalFractionalTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) AND StretchCallPosition = 1 THEN AdditionalFractionalTime
				WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 8.0) THEN AdditionalFractionalTime + ROUND(StretchCallBeatenLengths / 5.0, 1)
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND SecondCallTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) AND StretchCallPosition = 1 THEN SecondCallTime
				WHEN Distance >= (660.0 * 8.0) AND Distance < (660.0 * 9.0) THEN SecondCallTime + ROUND(StretchCallBeatenLengths / 5.0, 1)
				WHEN Distance >= (660.0 * 9.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 9.0) AND SecondCallTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 9.0) AND SecondCallPosition = 1 THEN SecondCallTime
				WHEN Distance >= (660.0 * 9.0) THEN SecondCallTime + ROUND(SecondCallBeatenLengths / 5.0, 1)
			   END Furlong_6,
			   CASE
				WHEN Distance >= (660.0 * 9.0) AND (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN Distance >= (660.0 * 9.0) AND AdditionalFractionalTime = 0 THEN NULL
				WHEN Distance >= (660.0 * 9.0) AND StretchCallPosition = 1 THEN AdditionalFractionalTime
				WHEN Distance >= (660.0 * 9.0) THEN AdditionalFractionalTime + ROUND(StretchCallBeatenLengths / 5.0, 1)
			   END Furlong_8,
			   CASE
				WHEN (ISNULL(FinalTime, 0.0) = 0.0 OR FinalBeatenLengths = 99.75) THEN NULL
				WHEN FinalCallPosition = 1 THEN FinalTime
				ELSE FinalTime + ROUND(FinalBeatenLengths / 5.0, 1) 
			   END FinishTime
		FROM kelso.HorseHistory
	)
	INSERT INTO kelso.HorseHistoryStats
	(
		HorseHistoryID,
			   HorseID, 
			   RaceDt, 
			   TrackCd,
			   RaceNum,
			   Distance,
			   Furlong,
			   TurfInd,
			   TrackCondition,
			   FirstCallTime,
			   SecondCallTime,
			   FinalTime,
			   AdditionalFractionalTime,
			   FirstCallPosition, 
			   SecondCallPosition, 
			   StretchCallPosition,
			   FinalCallPosition,
			   FirstCallBeatenLengths,
			   SecondCallBeatenLengths,
			   StretchCallBeatenLengths,
			   FinalBeatenLengths,
			    C.Furlong_1,
		   Furlong_2,
		   Furlong_3,
		   Furlong_4,
		   Furlong_5,
		   Furlong_6,
		   Furlong_8,
		   FinishTime,
		  OverallPace,
		  FirstCallPace,
		  SecondCallPace,
		  StretchCallPace,
		  FinishCallPace
	) 
	SELECT C.HorseHistoryID,
		   C.HorseID, 
		   C.RaceDt, 
		   C.TrackCd,
		   C.RaceNum,
		   C.Distance,
		   C.Furlong,
		   C.TurfInd,
		   C.TrackCondition,
		   C.FirstCallTime,
		   C.SecondCallTime,
	       C.FinalTime,
		   C.AdditionalFractionalTime,
		   C.FirstCallPosition, 
		   C.SecondCallPosition, 
		   C.StretchCallPosition,
		   C.FinalCallPosition,
		   C.FirstCallBeatenLengths,
		   C.SecondCallBeatenLengths,
		   C.StretchCallBeatenLengths,
		   C.FinalBeatenLengths,
		   C.Furlong_1,
		   C.Furlong_2,
		   C.Furlong_3,
		   C.Furlong_4,
		   C.Furlong_5,
		   C.Furlong_6,
		   C.Furlong_8,
		   C.FinishTime,
		  CASE
			WHEN FinishTime IS NOT NULL THEN ROUND(Distance / FinishTime, 2)
		  END OverallPace,
		  CASE
			WHEN Distance >= (660.0 * 4.5) AND Distance < (660.0 * 5.5) THEN NULL
			WHEN Distance >= (660.0 * 5.5) AND Distance < (660.0 * 9.0) AND Furlong_2 IS NOT NULL THEN ROUND((660.0 * 2.0) / Furlong_2, 2)
			WHEN Distance >= (660.0 * 9.0) AND Furlong_4 IS NOT NULL THEN ROUND((660.0 * 4.0) / Furlong_4, 2)
		  END FirstCallPace,
		  CASE 
			WHEN Distance >= (660.0 * 3.5) AND Distance < (660.0 * 4.5) AND Furlong_2 IS NOT NULL AND Furlong_3 IS NOT NULL THEN ROUND((660.0 * 2.0) / Furlong_2, 2)
			WHEN Distance >= (660.0 * 4.5) AND Distance < (660.0 * 5.5) AND Furlong_2 IS NOT NULL AND Furlong_4 IS NOT NULL THEN ROUND((660.0 * 2.0) / Furlong_2, 2)
			WHEN Distance >= (660.0 * 5.5) AND Distance < (660.0 * 9.0) AND Furlong_2 IS NOT NULL AND Furlong_4 IS NOT NULL THEN ROUND((660.0 * 2.0) / (Furlong_4 - Furlong_2), 2)
			WHEN Distance >= (660.0 * 9.0) AND Furlong_4 IS NOT NULL AND Furlong_6 IS NOT NULL THEN ROUND((660.0 * 2.0) / (Furlong_6 - Furlong_4), 2)
		  END SecondCallPace,
		  CASE
			WHEN Distance >= (660.0 * 0.5) AND Distance < (660.0 * 3.5) AND Furlong_1 IS NOT NULL AND Furlong_2 IS NULL THEN ROUND((660.0 * 1.0) / Furlong_1, 2)
			WHEN Distance >= (660.0 * 0.5) AND Distance < (660.0 * 3.5) AND Furlong_1 IS NULL AND Furlong_2 IS NOT NULL THEN ROUND((660.0 * 2.0) / Furlong_2, 2)
			WHEN Distance >= (660.0 * 3.5) AND Distance < (660.0 * 4.5) AND Furlong_2 IS NOT NULL AND Furlong_3 IS NOT NULL THEN ROUND((660.0 * 1.0) / (Furlong_3 - Furlong_2), 2)
			WHEN Distance >= (660.0 * 3.5) AND Distance < (660.0 * 4.5) AND Furlong_2 IS NOT NULL AND Furlong_3 IS NULL THEN ROUND((660.0 * 2.0) / Furlong_2, 2)
			WHEN Distance >= (660.0 * 4.5) AND Distance < (660.0 * 5.5) AND Furlong_2 IS NOT NULL AND Furlong_4 IS NOT NULL THEN ROUND((660.0 * 2.0) / (Furlong_4 - Furlong_2), 2)
			WHEN Distance >= (660.0 * 5.5) AND Distance < (660.0 * 6.5) AND Furlong_4 IS NOT NULL AND Furlong_5 IS NOT NULL THEN ROUND((660.0 * 1.0) / (Furlong_5 - Furlong_4), 2)
			WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 9.0) AND Furlong_4 IS NOT NULL AND Furlong_6 IS NOT NULL THEN ROUND((660.0 * 2.0) / (Furlong_6 - Furlong_4), 2)
			WHEN  Distance >= (660.0 * 9.0) AND Furlong_6 IS NOT NULL AND Furlong_8 IS NOT NULL THEN ROUND((660.0 * 2.0) / (Furlong_8 - Furlong_6), 2)
		  END StretchCallPace,
		  CASE
			WHEN Distance >= (660.0 * 0.5) AND Distance < (660.0 * 3.5) AND Furlong_1 IS NOT NULL AND Furlong_2 IS NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 1.0)) / (FinishTime - Furlong_1), 2)
			WHEN Distance >= (660.0 * 0.5) AND Distance < (660.0 * 3.5) AND Furlong_2 IS NOT NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 2.0)) / (FinishTime - Furlong_2), 2)
			WHEN Distance >= (660.0 * 3.5) AND Distance < (660.0 * 4.5) AND Furlong_3 IS NOT NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 3.0)) / (FinishTime - Furlong_3), 2)
			WHEN Distance >= (660.0 * 3.5) AND Distance < (660.0 * 4.5) AND Furlong_2 IS NOT NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 2.0)) / (FinishTime - Furlong_2), 2)
			WHEN Distance >= (660.0 * 4.5) AND Distance < (660.0 * 5.5) AND Furlong_4 IS NOT NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 4.0)) / (FinishTime - Furlong_4), 2)
			WHEN Distance >= (660.0 * 5.5) AND Distance < (660.0 * 6.5) AND Furlong_5 IS NOT NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 5.0)) / (FinishTime - Furlong_5), 2)
			WHEN Distance >= (660.0 * 6.5) AND Distance < (660.0 * 9.0) AND Furlong_6 IS NOT NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 6.0)) / (FinishTime - Furlong_6), 2)
			WHEN Distance >= (660.0 * 9.0) AND Furlong_8 IS NOT NULL AND FinishTime IS NOT NULL THEN ROUND((Distance - (660.0 * 8.0)) / (FinishTime - Furlong_8), 2)
		  END FinishCallPace 
	FROM CTE C
	WHERE C.HorseHistoryID NOT IN (
									SELECT HorseHistoryID
									FROM kelso.HorseHistoryStats
								  );

END;

GO