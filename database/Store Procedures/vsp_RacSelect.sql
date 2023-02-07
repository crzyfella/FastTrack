IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_RacSelect]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_RacSelect]
GO

CREATE PROCEDURE [kelso].[vsp_RacSelect]
(
	@Id INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM kelso.rac
	WHERE RacID = @Id;
END

GO






