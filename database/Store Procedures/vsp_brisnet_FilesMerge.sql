USE FastTrackDev3;

IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_FilesMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_FilesMerge];
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_FilesMerge]
	@FileName VARCHAR(75)
	,@Type VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Id INT = 0;
	DECLARE @FileId UNIQUEIDENTIFIER = NEWID();
	DECLARE @temp TABLE
	(
		[FileName] VARCHAR(50), 
		[RaceDt]   DATETIME, 
		[TrackCd]  VARCHAR(50),
		[TrackName]  VARCHAR(50)
	);

	IF @Type = 'Result'
	BEGIN
		INSERT INTO @temp
		SELECT DISTINCT @FileName [FileName]
			   ,S.[RaceDt]
			   ,S.[TrackCd]
			   ,CASE WHEN ISNULL(S.[TrackCd], '') = '' THEN S.TrackCd ELSE T.TrackName END [TrackName]
		FROM kelso.brisnet_xrd_staging S
		LEFT JOIN kelso.brisnet_Tracks T ON T.TrackCd = S.TrackCd;
	END
	ELSE
	BEGIN
		INSERT INTO @temp
		SELECT DISTINCT @FileName [FileName]
						,S.[RaceDt]
						,S.[TrackCd]
						,CASE WHEN ISNULL(S.[TrackCd], '') = '' THEN S.TrackCd ELSE T.TrackName END [TrackName]
		FROM kelso.brisnet_drf_staging S
		LEFT JOIN kelso.brisnet_Tracks T ON T.TrackCd = S.TrackCd;
	END

	MERGE kelso.brisnet_Files AS [TARGET]
    USING @temp [SOURCE]
    ON ([SOURCE].[FileName] = [TARGET].[FileName] AND [SOURCE].[RaceDt] = [TARGET].[RaceDt])
	WHEN MATCHED
	THEN UPDATE
		SET @Id = [Target].[Id]
			  ,@FileId = [Target].[FileId]
	WHEN NOT MATCHED 
    THEN INSERT ( [FileId]
				 ,[FileName]
				 ,[RaceDt]
				 ,[TrackCd]
				 ,[TrackName]
				 ,[CreatedDt]
				 ,[ModifiedDt]
				 ,[Type])
		VALUES( @FileId
		     ,[SOURCE].[FileName]
			   ,[SOURCE].[RaceDt]
			   ,[SOURCE].[TrackCd]
			   ,[SOURCE].[TrackName]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
			   ,GETDATE()
			   ,GETDATE()
			   ,@Type);

	IF (@Id = 0)
	BEGIN
		SELECT @Id = IDENT_CURRENT('brisnet_Files');
	END

	SELECT @Id Id
		   ,@FileId FileId
		   ,[RaceDt]
		   ,[TrackCd]
		   ,[TrackName]
	FROM @temp;
END
  
GO
