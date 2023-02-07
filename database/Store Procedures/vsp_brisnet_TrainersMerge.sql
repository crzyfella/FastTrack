USE FastTrackDev3;

IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_TrainersMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_TrainersMerge]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_TrainersMerge]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.brisnet_Trainers T
	USING (
			SELECT DISTINCT RaceDt
							,Trainer
							,TrainerStartsCurrentMeet
							,TrainerWinCurrentMeet
							,TrainerPlacesCurrentMeet
							,TrainerShowCurrentMeet
							,TrainerRecordCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int') TrainerStartCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int') TrainerPercentWinCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int') TrainerPercentPlaceCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int') TrainerPercentShowCurrentYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)') TrainerPercentROICurrentYear
							,TrainerRecordPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int') TrainerStartPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int') TrainerWinPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int') TrainerPlacePreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int') TrainerShowPreviousYear
							,CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)') TrainerPercentROIPreviousYear
			FROM kelso.brisnet_dr2
			WHERE RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
		  ) S
	ON T.[Trainer] = S.[Trainer] 
	WHEN MATCHED AND T.[RaceDt] < S.[RaceDt] THEN
		UPDATE 
			SET T.[RaceDt] = S.[RaceDt],
				T.[TrainerWinCurrentMeet] = S.[TrainerWinCurrentMeet],
				T.[TrainerPlacesCurrentMeet] = S.[TrainerPlacesCurrentMeet],
				T.[TrainerShowCurrentMeet] = S.[TrainerShowCurrentMeet],
				T.[TrainerRecordCurrentYear] = S.[TrainerRecordCurrentYear],
				T.[TrainerStartCurrentYear] = S.[TrainerStartCurrentYear],
				T.[TrainerStartsCurrentMeet] = S.[TrainerStartsCurrentMeet],
				T.[TrainerPercentWinCurrentYear] = S.[TrainerPercentWinCurrentYear],
				T.[TrainerPercentPlaceCurrentYear] = S.[TrainerPercentPlaceCurrentYear],
				T.[TrainerPercentShowCurrentYear] = S.[TrainerPercentShowCurrentYear],
				T.[TrainerPercentROICurrentYear] = S.[TrainerPercentROICurrentYear],
				T.[TrainerRecordPreviousYear] = S.[TrainerRecordPreviousYear],
				T.[TrainerStartPreviousYear] = S.[TrainerStartPreviousYear],
				T.[TrainerWinPreviousYear] = S.[TrainerWinPreviousYear],
				T.[TrainerPlacePreviousYear] = S.[TrainerPlacePreviousYear],
				T.[TrainerShowPreviousYear] = S.[TrainerShowPreviousYear],
				T.[TrainerPercentROIPreviousYear] = S.[TrainerPercentROIPreviousYear],
				T.[ModifiedDt] = GETDATE()
    WHEN NOT MATCHED THEN  
		INSERT (
					[RaceDt],
					[TrainerId],
					[Trainer],
					[TrainerStartsCurrentMeet],
					[TrainerWinCurrentMeet],
					[TrainerPlacesCurrentMeet],
					[TrainerShowCurrentMeet],
					[TrainerRecordCurrentYear],
					[TrainerStartCurrentYear],
					[TrainerPercentWinCurrentYear],
					[TrainerPercentPlaceCurrentYear],
					[TrainerPercentShowCurrentYear],
					[TrainerPercentROICurrentYear],
					[TrainerRecordPreviousYear],
					[TrainerStartPreviousYear],
					[TrainerWinPreviousYear],
					[TrainerPlacePreviousYear],
					[TrainerShowPreviousYear],
					[TrainerPercentROIPreviousYear],
					[CreatedDt],
					[ModifiedDt]
			   )
			   VALUES
			   (
					S.[RaceDt],
					NEWID(),
					S.[Trainer],
					S.[TrainerStartsCurrentMeet],
					S.[TrainerWinCurrentMeet],
					S.[TrainerPlacesCurrentMeet],
					S.[TrainerShowCurrentMeet],
					S.[TrainerRecordCurrentYear],
					S.[TrainerStartCurrentYear],
					S.[TrainerPercentWinCurrentYear],
					S.[TrainerPercentPlaceCurrentYear],
					S.[TrainerPercentShowCurrentYear],
					S.[TrainerPercentROICurrentYear],
					S.[TrainerRecordPreviousYear],
					S.[TrainerStartPreviousYear],
					S.[TrainerWinPreviousYear],
					S.[TrainerPlacePreviousYear],
					S.[TrainerShowPreviousYear],
					S.[TrainerPercentROIPreviousYear],
					GETDATE(),
					GETDATE()
			   );
END

GO
