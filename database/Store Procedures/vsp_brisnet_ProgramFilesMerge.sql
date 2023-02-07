IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_ProgramFilesMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_ProgramFilesMerge];
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_ProgramFilesMerge]
	@FileName VARCHAR(75)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ID INT = NULL;

	SELECT DISTINCT @FileName [FileName]
					,S.[RaceDt]
					,S.[TrackCd]
					,CASE WHEN ISNULL(S.[TrackCd], '') = '' THEN S.TrackCd ELSE T.TrackName END [TrackName]
	INTO #temp
	FROM kelso.brisnet_drf_staging S
	LEFT JOIN kelso.brisnet_Tracks T ON T.TrackCd = S.TrackCd;

	MERGE kelso.brisnet_ProgramFiles AS [TARGET]
    USING #temp [SOURCE]
    ON ([SOURCE].[FileName] = [TARGET].[FileName])
	WHEN MATCHED
	THEN UPDATE
		SET [Target].[ModifiedDt] = GETDATE()
			,@ID = [Target].[Id]
	WHEN NOT MATCHED 
    THEN INSERT ([FileName]
				 ,[RaceDt]
				 ,[TrackCd]
				 ,[TrackName]
				 ,[CreatedDt]
				 ,[ModifiedDt])
		VALUES([SOURCE].[FileName]
			   ,[SOURCE].[RaceDt]
			   ,[SOURCE].[TrackCd]
			   ,[SOURCE].[TrackName]
			   ,GETDATE()
			   ,GETDATE());

	SELECT ISNULL(@ID, CAST(SCOPE_IDENTITY() AS INT)) RaceProgramId
		   ,[RaceDt]
		   ,[TrackCd]
		   ,[TrackName]
	FROM #temp;
END
  
GO
