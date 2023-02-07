IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_EntSelect]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_EntSelect]
GO

CREATE PROCEDURE [kelso].[vsp_EntSelect]
(
	@Id INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM kelso.ent
	WHERE RacID = @Id;
END

GO






