IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_JockeysMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_JockeysMerge]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_JockeysMerge]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.brisnet_Jockeys T
	USING (
			SELECT DISTINCT RaceDt
							,Jockey
							,JockeyStartsCurrentMeet
							,JockeyWinsCurrentMeet
							,JockeyPlacesCurrentMeet
							,JockeyShowsCurrentMeet
							,JockeyRecordCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int') JockeyStartCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int') JockeyPercentWinCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int') JockeyPercentPlaceCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int') JockeyPercentShowCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)') JockeyPercentROICurrentYear
							,JockeyRecordPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int') JockeyStartPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int') JockeyWinPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int') JockeyPlacePreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int') JockeyShowPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)') JockeyPercentROIPreviousYear
			FROM kelso.brisnet_dr2
			WHERE RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
		  ) S
	ON T.[Jockey] = S.[Jockey] 
	WHEN MATCHED AND T.[RaceDt] < S.[RaceDt] THEN
		UPDATE 
			SET T.[RaceDt] = S.[RaceDt],
				T.[JockeyWinCurrentMeet] = S.[JockeyWinsCurrentMeet],
				T.[JockeyPlacesCurrentMeet] = S.[JockeyPlacesCurrentMeet],
				T.[JockeyShowCurrentMeet] = S.[JockeyShowsCurrentMeet],
				T.[JockeyRecordCurrentYear] = S.[JockeyRecordCurrentYear],
				T.[JockeyStartCurrentYear] = S.[JockeyStartCurrentYear],
				T.[JockeyStartsCurrentMeet] = S.[JockeyStartsCurrentMeet],
				T.[JockeyPercentWinCurrentYear] = S.[JockeyPercentWinCurrentYear],
				T.[JockeyPercentPlaceCurrentYear] = S.[JockeyPercentPlaceCurrentYear],
				T.[JockeyPercentShowCurrentYear] = S.[JockeyPercentShowCurrentYear],
				T.[JockeyPercentROICurrentYear] = S.[JockeyPercentROICurrentYear],
				T.[JockeyRecordPreviousYear] = S.[JockeyRecordPreviousYear],
				T.[JockeyStartPreviousYear] = S.[JockeyStartPreviousYear],
				T.[JockeyWinPreviousYear] = S.[JockeyWinPreviousYear],
				T.[JockeyPlacePreviousYear] = S.[JockeyPlacePreviousYear],
				T.[JockeyShowPreviousYear] = S.[JockeyShowPreviousYear],
				T.[JockeyPercentROIPreviousYear] = S.[JockeyPercentROIPreviousYear],
				T.[ModifiedDt] = GETDATE()
    WHEN NOT MATCHED THEN  
		INSERT (
					[RaceDt],
					[JockeyId],
					[Jockey],
					[JockeyStartsCurrentMeet],
					[JockeyWinCurrentMeet],
					[JockeyPlacesCurrentMeet],
					[JockeyShowCurrentMeet],
					[JockeyRecordCurrentYear],
					[JockeyStartCurrentYear],
					[JockeyPercentWinCurrentYear],
					[JockeyPercentPlaceCurrentYear],
					[JockeyPercentShowCurrentYear],
					[JockeyPercentROICurrentYear],
					[JockeyRecordPreviousYear],
					[JockeyStartPreviousYear],
					[JockeyWinPreviousYear],
					[JockeyPlacePreviousYear],
					[JockeyShowPreviousYear],
					[JockeyPercentROIPreviousYear],
					[CreatedDt],
					[ModifiedDt]
			   )
			   VALUES
			   (
					S.[RaceDt],
					NEWID(),
					S.[Jockey],
					S.[JockeyStartsCurrentMeet],
					S.[JockeyWinsCurrentMeet],
					S.[JockeyPlacesCurrentMeet],
					S.[JockeyShowsCurrentMeet],
					S.[JockeyRecordCurrentYear],
					S.[JockeyStartCurrentYear],
					S.[JockeyPercentWinCurrentYear],
					S.[JockeyPercentPlaceCurrentYear],
					S.[JockeyPercentShowCurrentYear],
					S.[JockeyPercentROICurrentYear],
					S.[JockeyRecordPreviousYear],
					S.[JockeyStartPreviousYear],
					S.[JockeyWinPreviousYear],
					S.[JockeyPlacePreviousYear],
					S.[JockeyShowPreviousYear],
					S.[JockeyPercentROIPreviousYear],
					GETDATE(),
					GETDATE()
			   );
END

GO
