IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_RaceParticipantsInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_RaceParticipantsInsert]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_RaceParticipantsInsert]
	@FileId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @RaceId TABLE ( RaceId UNIQUEIDENTIFIER NOT NULL);

	INSERT INTO @RaceId
	SELECT r.RaceId
	FROM kelso.brisnet_Races r 
	WHERE r.FileId = @FileId
	AND RaceId NOT IN (
		SELECT RaceId
		FROM [kelso].[brisnet_RaceParticipants]
	);

	INSERT INTO kelso.brisnet_RaceParticipants
	SELECT GETDATE(),
	   GETDATE(),
	   dr2.RaceId, 
	   dr2.TrackCd, 
	   dr2.RaceDt, 
	   dr2.RaceNum, 
	   r.Furlong,
	   r.DistanceYard,
	   r.DistanceFeet,
	   r.Surface,
	   dr2.PostPosition, 
	   h.HorseId,
	   dr2.HorseName, 
	   j.JockeyId,
	   dr2.Jockey,
	   dr2.JockeyStartsCurrentMeet,
	   dr2.JockeyWinsCurrentMeet,
	   dr2.JockeyPlacesCurrentMeet,
	   dr2.JockeyShowsCurrentMeet,
	   dr2.JockeyRecordCurrentYear,
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int'), 
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int'), 
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int'), 
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)'), 
	   dr2.JockeyRecordPreviousYear,
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int'), 
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int'), 
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int'), 
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int'), 
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.JockeyRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)'), 
	   t.TrainerId,
	   dr2.Trainer,
	   dr2.TrainerStartsCurrentMeet,
	   dr2.TrainerWinCurrentMeet,
	   dr2.TrainerPlacesCurrentMeet,
	   dr2.TrainerShowCurrentMeet,
	   dr2.TrainerRecordCurrentYear,
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordCurrentYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)'),
	   dr2.TrainerRecordPreviousYear,
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[1]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[2]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[3]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[4]', 'int'),
	   CAST('<x>' + REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(dr2.TrainerRecordPreviousYear)), ' ', '<>'),'><', ''), '<>', ' '), ' ', '</x><x>') + '</x>' AS XML).value('x[5]', 'decimal(18,2)')
	FROM kelso.brisnet_dr2 dr2
	JOIN kelso.brisnet_Horses h ON h.HorseName = dr2.HorseName
	JOIN kelso.brisnet_Jockeys j ON j.Jockey = dr2.Jockey
	JOIN kelso.brisnet_Trainers t ON t.Trainer = dr2.Trainer
	JOIN kelso.brisnet_Races r ON r.RaceId = dr2.RaceId
	WHERE dr2.RaceId IN (SELECT RaceId FROM @RaceId);
END

GO
