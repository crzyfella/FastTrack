USE [master]
GO
/****** Object:  Database [FastTrackDev3]    Script Date: 2/7/2023 2:13:20 PM ******/
CREATE DATABASE [FastTrackDev3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FastTrackDev3', FILENAME = N'C:\FastTrack\DB\MSSQL\Data\FastTrackDev3.mdf' , SIZE = 9117696KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FastTrackDev3_log', FILENAME = N'C:\FastTrack\DB\MSSQL\Data\FastTrackDev3_log.ldf' , SIZE = 2695168KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [FastTrackDev3] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FastTrackDev3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FastTrackDev3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FastTrackDev3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FastTrackDev3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FastTrackDev3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FastTrackDev3] SET ARITHABORT OFF 
GO
ALTER DATABASE [FastTrackDev3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FastTrackDev3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FastTrackDev3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FastTrackDev3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FastTrackDev3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FastTrackDev3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FastTrackDev3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FastTrackDev3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FastTrackDev3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FastTrackDev3] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FastTrackDev3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FastTrackDev3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FastTrackDev3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FastTrackDev3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FastTrackDev3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FastTrackDev3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FastTrackDev3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FastTrackDev3] SET RECOVERY FULL 
GO
ALTER DATABASE [FastTrackDev3] SET  MULTI_USER 
GO
ALTER DATABASE [FastTrackDev3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FastTrackDev3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FastTrackDev3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FastTrackDev3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FastTrackDev3] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'FastTrackDev3', N'ON'
GO
ALTER DATABASE [FastTrackDev3] SET QUERY_STORE = OFF
GO
USE [FastTrackDev3]
GO
/****** Object:  Schema [kelso]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE SCHEMA [kelso]
GO
/****** Object:  UserDefinedTableType [kelso].[ProcessTableType]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE TYPE [kelso].[ProcessTableType] AS TABLE(
	[ProcessID] [int] NULL,
	[RacID] [int] NULL,
	[EntID] [int] NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ChangeDt] [datetime] NOT NULL,
	[RaceDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[Distance] [float] NULL,
	[Furlong] [float] NULL,
	[RaceNum] [int] NULL,
	[TurfInd] [int] NULL,
	[HorseID] [int] NULL,
	[HorseName] [varchar](50) NULL,
	[PolePosition] [varchar](20) NULL,
	[LastRaceDt] [datetime] NULL,
	[NumOfDaysSinceLastRace] [int] NULL,
	[LastWorkoutDt] [datetime] NULL,
	[NumOfDaysSinceLastWorkout] [int] NULL,
	[BettingLine] [float] NULL,
	[StartsThisYr] [int] NULL,
	[WinThisYr] [int] NULL,
	[WinsPerc] [float] NULL,
	[Top3Finishes] [int] NULL,
	[Top3FinishesWinPerc] [float] NULL,
	[LifetimeStarts] [int] NULL,
	[LifetimeWins] [int] NULL,
	[LifetimeWinsPerc] [float] NULL,
	[LifetimeTop3Finish] [int] NULL,
	[Top3FinishesLifetimePerc] [float] NULL,
	[TurfStarts] [int] NULL,
	[TurfWins] [int] NULL,
	[TurfWinsPerc] [float] NULL,
	[TurfTop3Finishes] [int] NULL,
	[Top3FinishesTurfPerc] [float] NULL,
	[NonTurfStarts] [int] NULL,
	[NonTurfWins] [int] NULL,
	[NonTurfWinsPerc] [float] NULL,
	[NonTurfTop3Finishes] [int] NULL,
	[Top3FinishesNonTurfPerc] [float] NULL,
	[TrackStart] [int] NULL,
	[TrackEarnings] [float] NULL,
	[TrackWins] [int] NULL,
	[TrackTop3Finishes] [int] NULL,
	[DistanceStart] [int] NULL,
	[DistanceEarnings] [float] NULL,
	[DistanceWins] [int] NULL,
	[DistanceTop3Finishes] [int] NULL,
	[TurfRating] [int] NULL,
	[SpeedRating] [float] NULL,
	[TrackVariant] [float] NULL,
	[AdvancedSpeedFigure] [float] NULL,
	[PTSEarlyPaceRating] [float] NULL,
	[PTSLatePaceRating] [float] NULL,
	[PTSTruePaceRating] [float] NULL,
	[PTSSpeedRating] [float] NULL,
	[OffTrackRating] [int] NULL,
	[JockeyStarts] [int] NULL,
	[JockeyWins] [int] NULL,
	[JockeyTop3Finishes] [int] NULL,
	[JockeyWinningPerc] [float] NULL,
	[JockeyLifetimeWinningPerc] [float] NULL,
	[TrainerLifetimeWinningPerc] [float] NULL,
	[LastWorkoutRankingPercentage] [float] NULL,
	[LastWorkoutDistance] [float] NULL,
	[Workout4FurlongAvg] [float] NULL,
	[Workout5FurlongAvg] [float] NULL,
	[Workout6FurlongAvg] [float] NULL,
	[Workout7FurlongAvg] [float] NULL,
	[Workout8FurlongAvg] [float] NULL,
	[WorkoutTop3RankingAvg] [float] NULL,
	[Workout3MonthAvg] [float] NULL,
	[Workout6MonthAvg] [float] NULL,
	[Workout4FurlongBest] [float] NULL,
	[Workout5FurlongBest] [float] NULL,
	[Workout6FurlongBest] [float] NULL,
	[Workout7FurlongBest] [float] NULL,
	[Workout8FurlongBest] [float] NULL,
	[WorkoutAvgCurrentMonth] [float] NULL,
	[Workout4FurlongCurrentMonth] [float] NULL,
	[Workout5FurlongCurrentMonth] [float] NULL,
	[Workout6FurlongCurrentMonth] [float] NULL,
	[Workout7FurlongCurrentMonth] [float] NULL,
	[Workout8FurlongCurrentMonth] [float] NULL,
	[WorkoutAvgPreviousMonth] [float] NULL,
	[Workout4FurlongPreviousMonth] [float] NULL,
	[Workout5FurlongPreviousMonth] [float] NULL,
	[Workout6FurlongPreviousMonth] [float] NULL,
	[Workout7FurlongPreviousMonth] [float] NULL,
	[Workout8FurlongPreviousMonth] [float] NULL,
	[WorkoutAvgPrevious2Month] [float] NULL,
	[Workout4FurlongPrevious2Month] [float] NULL,
	[Workout5FurlongPrevious2Month] [float] NULL,
	[Workout6FurlongPrevious2Month] [float] NULL,
	[Workout7FurlongPrevious2Month] [float] NULL,
	[Workout8FurlongPrevious2Month] [float] NULL,
	[WorkoutAvgPrevious3Month] [float] NULL,
	[Workout4FurlongPrevious3Month] [float] NULL,
	[Workout5FurlongPrevious3Month] [float] NULL,
	[Workout6FurlongPrevious3Month] [float] NULL,
	[Workout7FurlongPrevious3Month] [float] NULL,
	[Workout8FurlongPrevious3Month] [float] NULL,
	[WorkoutSameTrackBest] [float] NULL,
	[WorkoutSameTrackBest3] [float] NULL,
	[WorkoutSameTrackAvg] [float] NULL,
	[CalculateTimeMethod] [varchar](3) NULL,
	[CalculateTime] [float] NULL,
	[CalculateTimePercentageAvg] [float] NULL,
	[CalculateTimeUsingPaceAvg] [float] NULL,
	[CalculateTimeUsingPaceOverallAvg] [float] NULL,
	[CalculateTimeTrendCorrelation] [float] NULL,
	[CalculateTimeTrendIntercept] [float] NULL,
	[CalculateTimeTrendR2] [float] NULL,
	[CalculateTimeTrendSlope] [float] NULL,
	[Furlong5Time] [float] NULL,
	[Furlong5TimeRankingPerc] [float] NULL,
	[Furlong6Time] [float] NULL,
	[Furlong6TimeRankingPerc] [float] NULL,
	[Furlong8Time] [float] NULL,
	[Furlong8TimeRankingPerc] [float] NULL,
	[FinishResult] [int] NULL,
	[CalculateTimeUsingPaceOverallRankingPerc] [float] NULL
)
GO
/****** Object:  UserDefinedFunction [kelso].[fn_GetNormalDistributionCalc]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [kelso].[fn_GetNormalDistributionCalc]
(
    @ZScore FLOAT
)
    RETURNS FLOAT
AS
BEGIN 
	DECLARE @result FLOAT;
    DECLARE @L FLOAT;
    DECLARE @K FLOAT;
    DECLARE @dCND FLOAT;
    DECLARE @pi FLOAT;
    DECLARE @a1 FLOAT;
    DECLARE @a2 FLOAT;
    DECLARE @a3 FLOAT;
    DECLARE @a4 FLOAT;
    DECLARE @a5 FLOAT;

    SELECT @L = 0.0;
    SELECT @K = 0.0;
    SELECT @dCND = 0.0;

    SELECT @a1 = 0.31938153;
    SELECT @a2 = -0.356563782;
    SELECT @a3 = 1.781477937;
    SELECT @a4 = -1.821255978;
    SELECT @a5 = 1.330274429;
    
    SELECT @L = Abs(@ZScore);
	
	IF @L >= 30.000
	BEGIN
		SELECT @result = NULL;
	END				
	ELSE
	BEGIN
		-- perform calculation
		SELECT @K = 1.0 / (1.0 + 0.2316419 * @L)
		SELECT @dCND = 1.0 - 1.0 / SQRT(2 * PI()) * EXP(-@L * @L / 2.0) * (@a1 * @K + @a2 * @K * @K + @a3 * POWER(@K, 3.0) + @a4 * POWER(@K, 4.0) + @a5 * POWER (@K, 5.0))
			
		IF (@ZScore < 0)
			SELECT @result = 1.0 - @dCND
		ELSE
			SELECT @result = @dCND	
	END
	
	RETURN @result;
END
GO
/****** Object:  Table [kelso].[brisnet_Workouts]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_Workouts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HorseId] [uniqueidentifier] NOT NULL,
	[HorseName] [varchar](50) NOT NULL,
	[WorkoutDate] [datetime] NULL,
	[WorkoutTrack] [varchar](10) NULL,
	[WorkoutDistance] [decimal](18, 0) NULL,
	[WorkoutTime] [decimal](18, 2) NULL,
	[WorkoutTrackCondition] [varchar](5) NULL,
	[WorkoutDescription] [varchar](5) NULL,
	[MainInnerTrackIndicator] [varchar](5) NULL,
	[NumberOfWorkouts] [varchar](5) NULL,
	[WorkoutRank] [varchar](5) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20221102-144514]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20221102-144514] ON [kelso].[brisnet_Workouts]
(
	[Id] ASC,
	[HorseId] ASC,
	[HorseName] ASC,
	[WorkoutDate] ASC,
	[WorkoutTrack] ASC,
	[WorkoutDistance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [kelso].[vw_Brisnet_WorkoutStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [kelso].[vw_Brisnet_WorkoutStats] AS 
	SELECT WorkoutTrack, 
		   WorkoutDistance, 
		   CAST(WorkoutDistance / 220.00 AS DECIMAL(10, 2)) Furlong,
		   AVG(WorkoutTime) AvgTime, 
		   MIN(WorkoutTime) MinTime,
		   MAX(WorkoutTime) MaxTime,
		   STDEV(WorkoutTime) SDVTime,
		   COUNT(1) RecCount
	FROM kelso.brisnet_Workouts
	GROUP BY WorkoutTrack, WorkoutDistance;
GO
/****** Object:  Table [kelso].[brisnet_HorseHistory]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_HorseHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HorseId] [uniqueidentifier] NULL,
	[HorseName] [varchar](75) NULL,
	[RaceDt] [date] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceNum] [int] NULL,
	[TrackCondition] [varchar](2) NULL,
	[Distance] [decimal](18, 2) NULL,
	[Surface] [char](1) NULL,
	[NumOfEntrants] [int] NULL,
	[PostPosition] [int] NULL,
	[Equipment] [char](1) NULL,
	[Medication] [int] NULL,
	[TripComment] [varchar](100) NULL,
	[ExtraCommentLine] [varchar](200) NULL,
	[WinnerMargin] [decimal](18, 2) NULL,
	[SecondPlaceMargin] [decimal](18, 2) NULL,
	[ThirdPlaceMargin] [decimal](18, 2) NULL,
	[Odds] [decimal](18, 2) NULL,
	[RaceClassification] [varchar](25) NULL,
	[ClaimingPrice] [decimal](18, 2) NULL,
	[Purse] [decimal](18, 2) NULL,
	[StartCallPosition] [varchar](5) NULL,
	[FirstCallPosition] [varchar](5) NULL,
	[SecondCallPosition] [varchar](5) NULL,
	[GateCallPosition] [varchar](5) NULL,
	[StretchCallPosition] [varchar](5) NULL,
	[FinishPosition] [varchar](5) NULL,
	[MoneyPosition] [varchar](5) NULL,
	[StartCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[StartCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[FirstCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[FirstCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[SecondCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[SecondCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[StretchBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[StretchBtnLngthsOnly] [decimal](18, 2) NULL,
	[FinishBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[FinishCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[BrisRaceShapeSecondCall] [decimal](18, 2) NULL,
	[Bris2FPace] [int] NULL,
	[Bris4FPace] [int] NULL,
	[Bris6FPace] [int] NULL,
	[Bris8FPace] [int] NULL,
	[Bris10FPace] [int] NULL,
	[BrisLateFPace] [int] NULL,
	[BrisRaceShapeFirstCall] [int] NULL,
	[BrisSpeedRating] [int] NULL,
	[SpeedRating] [int] NULL,
	[TrackVariant] [int] NULL,
	[TwoFurlongFraction] [decimal](18, 2) NULL,
	[ThreeFurlongFraction] [decimal](18, 2) NULL,
	[FourFurlongFraction] [decimal](18, 2) NULL,
	[FiveFurlongFraction] [decimal](18, 2) NULL,
	[SixFurlongFraction] [decimal](18, 2) NULL,
	[SevenFurlongFraction] [decimal](18, 2) NULL,
	[EightFurlongFraction] [decimal](18, 2) NULL,
	[TenFurlongFraction] [decimal](18, 2) NULL,
	[TwelveFurlongFraction] [decimal](18, 2) NULL,
	[FourteenFurlongFraction] [decimal](18, 2) NULL,
	[SixteenFurlongFraction] [decimal](18, 2) NULL,
	[Fraction1] [decimal](18, 2) NULL,
	[Fraction2] [decimal](18, 2) NULL,
	[Fraction3] [decimal](18, 2) NULL,
	[FinalTime] [decimal](18, 2) NULL,
	[JockeyId] [int] NULL,
	[Jockey] [varchar](30) NULL,
	[RaceType] [varchar](2) NULL,
	[FavoriteIndicator] [int] NULL,
	[FrontBandagesIndicator] [int] NULL,
	[BrisSpeedParPrior] [int] NULL,
	[LowClaimingPriceOfRace] [decimal](18, 2) NULL,
	[HighClaimingPriceOfRace] [decimal](18, 2) NULL,
	[ExtendedStartComment] [varchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220315-135742]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220315-135742] ON [kelso].[brisnet_HorseHistory]
(
	[HorseId] ASC,
	[HorseName] ASC,
	[RaceDt] ASC,
	[TrackCd] ASC,
	[RaceNum] ASC,
	[Distance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  View [kelso].[vw_Brisnet_TrackStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [kelso].[vw_Brisnet_TrackStats] AS 

SELECT TrackCd,
       Distance,
	   CAST(Distance / 220.00 AS DECIMAL(10, 2)) Furlong,
	   Surface,
	   TrackCondition,
	   AVG(FinalTime) AvgTime,
	   MAX(FinalTime) MaxTime,
	   MIN(FinalTime) MinTime,
	   STDEV(FinalTime) SDVTime,
	   COUNT(1) RecCount
FROM kelso.brisnet_HorseHistory
GROUP BY TrackCd, Distance, Surface, TrackCondition;

GO
/****** Object:  Table [kelso].[HorseHistoryStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[HorseHistoryStats](
	[HorseHistoryStatsID] [int] IDENTITY(1,1) NOT NULL,
	[HorseHistoryID] [int] NOT NULL,
	[HorseID] [int] NULL,
	[RaceDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceNum] [varchar](10) NULL,
	[Distance] [float] NULL,
	[Furlong] [float] NULL,
	[TurfInd] [int] NULL,
	[TrackCondition] [varchar](3) NULL,
	[FirstCallTime] [float] NULL,
	[SecondCallTime] [float] NULL,
	[FinalTime] [float] NULL,
	[AdditionalFractionalTime] [float] NULL,
	[FirstCallPosition] [int] NULL,
	[SecondCallPosition] [int] NULL,
	[StretchCallPosition] [int] NULL,
	[FinalCallPosition] [int] NULL,
	[FirstCallBeatenLengths] [float] NULL,
	[SecondCallBeatenLengths] [float] NULL,
	[StretchCallBeatenLengths] [float] NULL,
	[FinalBeatenLengths] [float] NULL,
	[Furlong_1] [float] NULL,
	[Furlong_2] [float] NULL,
	[Furlong_3] [float] NULL,
	[Furlong_4] [float] NULL,
	[Furlong_5] [float] NULL,
	[Furlong_6] [float] NULL,
	[Furlong_8] [float] NULL,
	[FinishTime] [float] NULL,
	[OverallPace] [float] NULL,
	[FirstCallPace] [float] NULL,
	[SecondCallPace] [float] NULL,
	[StretchCallPace] [float] NULL,
	[FinishCallPace] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190625-054934]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190625-054934] ON [kelso].[HorseHistoryStats]
(
	[HorseHistoryStatsID] ASC,
	[HorseHistoryID] ASC,
	[HorseID] ASC,
	[RaceDt] ASC,
	[TrackCd] ASC,
	[RaceNum] ASC,
	[Distance] ASC,
	[TurfInd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [kelso].[vw_5FurlongStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_5FurlongStats] AS 
WITH CTE AS
(
SELECT TrackCd,
	   TurfInd,
	   TrackCondition,
	   CASE 
		WHEN Furlong_5 IS NOT NULL THEN Furlong_5
		WHEN Distance = (660.0 * 5.0) THEN FinishTime
	   END FurlongTime
FROM kelso.HorseHistoryStats
WHERE ( Furlong_5 IS NOT NULL
        OR Distance = (660.0 * 5.0) )
)
SELECT TrackCd,
       TurfInd,
	   TrackCondition,
	   ROUND(AVG(FurlongTime), 2) AvgFurlongTime,
	   MIN(FurlongTime) MinFurlongTime,
	   MAX(FurlongTime) MaxFurlongTime,
	   ROUND(STDEV(FurlongTime), 2) StdevFurlongTime,
	   COUNT(1) CntRec
FROM CTE
GROUP BY TrackCd,
	     TurfInd,
	     TrackCondition
GO
/****** Object:  View [kelso].[vw_6FurlongStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_6FurlongStats] AS 
WITH CTE AS
(
SELECT TrackCd,
	   TurfInd,
	   TrackCondition,
	   CASE 
		WHEN Furlong_6 IS NOT NULL THEN Furlong_6
		WHEN Distance = (660.0 * 6.0) THEN FinishTime
	   END FurlongTime
FROM kelso.HorseHistoryStats
WHERE ( Furlong_6 IS NOT NULL
        OR Distance = (660.0 * 6.0) )
)
SELECT TrackCd,
       TurfInd,
	   TrackCondition,
	   ROUND(AVG(FurlongTime), 2) AvgFurlongTime,
	   MIN(FurlongTime) MinFurlongTime,
	   MAX(FurlongTime) MaxFurlongTime,
	   ROUND(STDEV(FurlongTime), 2) StdevFurlongTime,
	   COUNT(1) CntRec
FROM CTE
GROUP BY TrackCd,
	     TurfInd,
	     TrackCondition
GO
/****** Object:  Table [kelso].[WorkoutHistory]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[WorkoutHistory](
	[WorkoutHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[HorseID] [int] NULL,
	[HorseName] [varchar](100) NULL,
	[WorkOutDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[Distance] [float] NULL,
	[Furlong] [float] NULL,
	[TurfInd] [smallint] NULL,
	[TrainingTrackInd] [smallint] NULL,
	[TrackCond] [varchar](5) NULL,
	[WorkOutTime] [float] NULL,
	[BulletInd] [smallint] NULL,
	[BreezingInd] [smallint] NULL,
	[WorkOutRank] [smallint] NULL,
	[WorkOutTotalNum] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  View [kelso].[vw_PercentageDiffWorkoutRaces]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [kelso].[vw_PercentageDiffWorkoutRaces] AS 

SELECT MAIN.Distance,
       AVG(MAIN.RaceTime) RaceTime,
	   AVG(MAIN.WorkoutTime) WorkoutTime,
	   (AVG(MAIN.RaceTime) / AVG(MAIN.WorkoutTime)) PercDiff 
FROM
(
	SELECT HH.TrackCd,
		   HH.Distance,
		   WH.Furlong,
		   HH.AvgFinishTime RaceTime,
		   HH.AvgFinishTime / HH.Distance PaceRaceTime,
		   WH.AvgTime WorkoutTime,
		   WH.AvgTime / HH.Distance PaceWorkoutTime,
		   WHO.AvgTime WorkoutTimeOverall,
		   WHO.AvgTime / HH.Distance PaceWorkoutTimeOverall,
		   CASE
			WHEN WH.AvgTime IS NULL AND WHO.AvgTime IS NULL THEN 0.0
			WHEN WH.AvgTime IS NULL THEN HH.AvgFinishTime / WHO.AvgTime
			ELSE HH.AvgFinishTime / WH.AvgTime 
		   END PercentageDiff
	FROM
	(
		SELECT TrackCd, Distance, AVG(FinishTime) AvgFinishTime
		FROM kelso.HorseHistoryStats
		GROUP BY TrackCd, Distance
	) HH
	LEFT OUTER JOIN  
	(
		SELECT TrackCd, 
			   Distance, 
			   Furlong,
			   AVG(WorkOutTime) AvgTime,
			   STDEV(WorkoutTime) StdvAvgTime,
			   COUNT(1) RecCnt
		FROM kelso.WorkoutHistory
		GROUP BY TrackCd, Distance, Furlong
	) WH ON WH.TrackCd = HH.TrackCd AND WH.Distance = HH.Distance
	LEFT OUTER JOIN  
	(
		SELECT Distance, 
			   Furlong,
			   AVG(WorkOutTime) AvgTime,
			   STDEV(WorkoutTime) StdvAvgTime,
			   COUNT(1) RecCnt
		FROM kelso.WorkoutHistory
		GROUP BY Distance, Furlong
	) WHO ON WHO.Distance = HH.Distance
) MAIN
WHERE MAIN.WorkoutTime IS NOT NULL
GROUP BY MAIN.Distance
GO
/****** Object:  View [kelso].[vw_8FurlongStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_8FurlongStats] AS 
WITH CTE AS
(
SELECT TrackCd,
	   TurfInd,
	   TrackCondition,
	   CASE 
		WHEN Furlong_8 IS NOT NULL THEN Furlong_8
		WHEN Distance = (660.0 * 8.0) THEN FinishTime
	   END FurlongTime
FROM kelso.HorseHistoryStats
WHERE ( Furlong_8 IS NOT NULL
        OR Distance = (660.0 * 8.0) )
)
SELECT TrackCd,
       TurfInd,
	   TrackCondition,
	   ROUND(AVG(FurlongTime), 2) AvgFurlongTime,
	   MIN(FurlongTime) MinFurlongTime,
	   MAX(FurlongTime) MaxFurlongTime,
	   ROUND(STDEV(FurlongTime), 2) StdevFurlongTime,
	   COUNT(1) CntRec
FROM CTE
GROUP BY TrackCd,
	     TurfInd,
	     TrackCondition
GO
/****** Object:  View [kelso].[vw_PercentageDiffWorkoutRacesTrack]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_PercentageDiffWorkoutRacesTrack] AS 

SELECT HH.TrackCd,
	   HH.Distance,
	   WH.Furlong,
	   HH.AvgFinishTime RaceTime,
	   HH.Distance / HH.AvgFinishTime PacePerSecond,
	   WH.AvgTime WorkoutTime,
	   HH.Distance / WH.AvgTime PaceWorkoutTime,
	   WHO.AvgTime WorkoutTimeOverall,
	   HH.Distance / WHO.AvgTime  PaceWorkoutTimeOverall,
	   CASE
		WHEN WH.AvgTime IS NULL AND WHO.AvgTime IS NULL THEN 0.0
		WHEN WH.AvgTime IS NULL THEN HH.AvgFinishTime / WHO.AvgTime
		ELSE HH.AvgFinishTime / WH.AvgTime 
	   END PercentageDiff
FROM
(
	SELECT TrackCd, Distance, AVG(FinishTime) AvgFinishTime
	FROM kelso.HorseHistoryStats
	GROUP BY TrackCd, Distance
) HH
LEFT OUTER JOIN  
(
	SELECT TrackCd, 
		   Distance, 
		   Furlong,
		   AVG(WorkOutTime) AvgTime,
		   STDEV(WorkoutTime) StdvAvgTime,
		   COUNT(1) RecCnt
	FROM kelso.WorkoutHistory
	GROUP BY TrackCd, Distance, Furlong
) WH ON WH.TrackCd = HH.TrackCd AND WH.Distance = HH.Distance
LEFT OUTER JOIN  
(
	SELECT Distance, 
		   Furlong,
		   AVG(WorkOutTime) AvgTime,
		   STDEV(WorkoutTime) StdvAvgTime,
		   COUNT(1) RecCnt
	FROM kelso.WorkoutHistory
	GROUP BY Distance, Furlong
) WHO ON WHO.Distance = HH.Distance
GO
/****** Object:  View [kelso].[vw_Brisnet_FractionStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [kelso].[vw_Brisnet_FractionStats] AS 

SELECT TrackCd,
	   Surface, 
	   Distance, 
	   CAST((Distance / 220.00) AS DECIMAL(10, 2)) Furlong,
	   MIN(Fraction1) MinFraction1,
	   MAX(Fraction1) MaxFraction1,
	   AVG(Fraction1) AvgFraction1,
	   STDEV(Fraction1) SDevFraction1,
	   MIN(Fraction2) MinFraction2,
	   MAX(Fraction2) MaxFraction2,
	   AVG(Fraction2) AvgFraction2,
	   STDEV(Fraction2) SDevFraction2,
	   MIN(Fraction3) MinFraction3,
	   MAX(Fraction3) MaxFraction3,
	   AVG(Fraction3) AvgFraction3,
	   STDEV(Fraction3) SDevFraction3,
	   MIN(FinalTime) MinFinalTime,
	   MAX(FinalTime) MaxFinalTime,
	   AVG(FinalTime) AvgFinalTime,
	   STDEV(FinalTime) SDevFinalTime,
	   CASE WHEN Distance = 1100.00 THEN MIN(FinalTime - Fraction2) ELSE MIN(FinalTime - Fraction3) END MinStretchTime, 
	   CASE WHEN Distance = 1100.00 THEN MAX(FinalTime - Fraction2) ELSE MAX(FinalTime - Fraction3) END MaxStretchTime,
	   CASE WHEN Distance = 1100.00 THEN AVG(FinalTime - Fraction2) ELSE AVG(FinalTime - Fraction3) END AvgStretchTime, 
	   CASE WHEN Distance = 1100.00 THEN STDEV(FinalTime - Fraction2) ELSE STDEV(FinalTime - Fraction3) END SDevStretchTime, 
	   COUNT(1) RecCount
FROM kelso.brisnet_HorseHistory
WHERE Distance >= 1100.00
	AND (( Distance > 1100.00 AND Fraction1 > 0 AND Fraction2 > 0 AND Fraction3 > 0 AND FinalTime > 0)
		  OR (Distance = 1100.00 AND Fraction1 > 0 AND Fraction2 > 0 AND FinalTime > 0))
GROUP BY TrackCd, Distance, Surface;

GO
/****** Object:  View [kelso].[vw_HorseHistoryStatsTrackCondition]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_HorseHistoryStatsTrackCondition] AS
SELECT TrackCd,
	   Distance,
	   TurfInd,
	   TrackCondition,
	   AVG(FinishTime) AvgFinishTime,
	   MIN(FinishTime) MinFinishTime,
	   MAX(FinishTime) MaxFinishTime,
	   STDEV(FinishTime) StdevFinishTime,
	   COUNT(1) RecCnt
FROM kelso.HorseHistoryStats
GROUP BY TrackCd,
		 Distance,
		 TurfInd,
		 TrackCondition
GO
/****** Object:  View [kelso].[vw_HorseHistoryPercentageRanking]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_HorseHistoryPercentageRanking] AS
SELECT HS.*,
	   C.AvgFinishTime,
	   C.MinFinishTime,
	   C.MaxFinishTime,
	   C.StdevFinishTime,
	   CASE
		WHEN ISNULL(C.StdevFinishTime, 0.0) = 0.0 THEN NULL
		ELSE ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - C.AvgFinishTime) / C.StdevFinishTime)) * 100.00, 2.0)
	   END PercentRanking
FROM kelso.HorseHistoryStats HS
	 JOIN kelso.vw_HorseHistoryStatsTrackCondition C ON C.TrackCd = HS.TrackCd
														AND C.Distance = HS.Distance
														AND C.TurfInd = HS.TurfInd
														AND C.TrackCondition = HS.TrackCondition

GO
/****** Object:  View [kelso].[vw_HorseHistoryStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_HorseHistoryStats] AS
SELECT TrackCd,
	   Distance,
	   AVG(FinishTime) AvgFinishTime,
	   MIN(FinishTime) MinFinishTime,
	   MAX(FinishTime) MaxFinishTime,
	   STDEV(FinishTime) StdevFinishTime,
	   COUNT(1) RecCnt
FROM kelso.HorseHistoryStats
GROUP BY TrackCd,
		 Distance
GO
/****** Object:  View [kelso].[vw_HorseHistoryStatsTurfInd]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [kelso].[vw_HorseHistoryStatsTurfInd] AS
SELECT TrackCd,
	   Distance,
	   TurfInd,
	   AVG(FinishTime) AvgFinishTime,
	   MIN(FinishTime) MinFinishTime,
	   MAX(FinishTime) MaxFinishTime,
	   STDEV(FinishTime) StdevFinishTime,
	   COUNT(1) RecCnt
FROM kelso.HorseHistoryStats
GROUP BY TrackCd,
		 Distance,
		 TurfInd
GO
/****** Object:  View [kelso].[vw_WorkoutStats]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [kelso].[vw_WorkoutStats] AS 
SELECT TrackCd, 
	   Distance,
	   Furlong,
	   TurfInd,
	   TrackCond,
	   MIN(WorkOutTime) WorkoutTimeMin, 
	   MAX(WorkOutTime) WorkoutTimeMax,
	   ROUND(AVG(WorkOutTime), 3) WorkoutTimeAvg,
	   ROUND(STDEV(WorkoutTime), 3) WorkoutTimeStdv,
	   COUNT(1) RecCnt  
FROM kelso.WorkoutHistory
GROUP BY TrackCd,
		 Distance,
		 Furlong,
		 TurfInd,
		 TrackCond




GO
/****** Object:  Table [kelso].[HorseHistory]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[HorseHistory](
	[HorseHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[HorseID] [int] NULL,
	[HorseName] [varchar](100) NULL,
	[RaceDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceNum] [varchar](10) NULL,
	[Distance] [float] NULL,
	[Furlong] [float] NULL,
	[InnerInd] [int] NULL,
	[TurfInd] [int] NULL,
	[TrackCondition] [varchar](3) NULL,
	[StateBredInd] [int] NULL,
	[ClassString] [varchar](250) NULL,
	[ExtendedClassInfo] [varchar](250) NULL,
	[Purse] [float] NULL,
	[ClaimingPrice] [float] NULL,
	[RaceClass] [int] NULL,
	[StkHandicapGrade] [int] NULL,
	[FirstCallTime] [float] NULL,
	[SecondCallTime] [float] NULL,
	[FinalTime] [float] NULL,
	[AdditionalFractionalTime] [float] NULL,
	[PostPosition] [int] NULL,
	[StartCallPosition] [int] NULL,
	[FirstCallPosition] [int] NULL,
	[SecondCallPosition] [int] NULL,
	[StretchCallPosition] [int] NULL,
	[FinalCallPosition] [int] NULL,
	[FirstCallBeatenLengths] [float] NULL,
	[SecondCallBeatenLengths] [float] NULL,
	[StretchCallBeatenLengths] [float] NULL,
	[FinalBeatenLengths] [float] NULL,
	[Furlong2] [float] NULL,
	[Furlong3] [float] NULL,
	[Furlong4] [float] NULL,
	[Furlong5] [float] NULL,
	[Furlong6] [float] NULL,
	[Furlong8] [float] NULL,
	[FinnishTime] [float] NULL,
	[RankingPercentage] [float] NULL,
	[JockeyName] [varchar](100) NULL,
	[LasixInd] [int] NULL,
	[FavoriteFlagInd] [int] NULL,
	[PostTimeOdds] [float] NULL,
	[FavortismOddRanking] [int] NULL,
	[SpeedRating] [float] NULL,
	[TrackVariant] [float] NULL,
	[AdvancedSpeedFigure] [float] NULL,
	[PTSEarlyPaceRating] [float] NULL,
	[PTSLatePaceRating] [float] NULL,
	[PTSTruePaceRating] [float] NULL,
	[TroubleLine] [nvarchar](250) NULL,
	[ExtendedTroubleLineInfo] [varchar](250) NULL,
	[NumberOfEntrants] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190603-230549]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190603-230549] ON [kelso].[HorseHistory]
(
	[HorseID] ASC,
	[RaceDt] ASC,
	[TrackCd] ASC,
	[RaceNum] ASC,
	[Distance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [kelso].[vw_HorsesInformation]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [kelso].[vw_HorsesInformation] AS 
WITH WorkoutCTE AS
(
SELECT TrackCd, HorseID, Distance, AVG(WorkOutTime) WorkOutTime, COUNT(1) RecCount
FROM kelso.WorkoutHistory
GROUP BY HorseID, TrackCd, Distance
),
RacingCTE AS
(
	SELECT HorseID, TrackCd, Distance, AVG(FinnishTime) FinnishTime, COUNT(1) RecCount
	FROM kelso.HorseHistory
	GROUP BY HorseID, TrackCd, Distance
)
SELECT R.*,
	   CASE WHEN R.FinnishTime = 0 THEN NULL
	   ELSE (R.Distance / R.FinnishTime) END Pace,
	   W.WorkOutTime,
	   CASE WHEN W.WorkOutTime IS NOT NULL THEN (R.Distance / W.WorkOutTime) 
	   ELSE NULL END WorkoutPace,
	   W.RecCount WorkoutRecCount
FROM RacingCTE R
	 LEFT JOIN WorkoutCTE W ON W.TrackCd = R.TrackCd AND R.HorseID = W.HorseID AND R.Distance = W.Distance 

GO
/****** Object:  Table [kelso].[brisnet_dr2]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_dr2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[RaceId] [uniqueidentifier] NOT NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[PostPosition] [varchar](5) NULL,
	[Entry] [varchar](5) NULL,
	[ClaimingPrice] [decimal](18, 2) NULL,
	[Trainer] [varchar](100) NULL,
	[TrainerStartsCurrentMeet] [int] NULL,
	[TrainerWinCurrentMeet] [int] NULL,
	[TrainerPlacesCurrentMeet] [int] NULL,
	[TrainerShowCurrentMeet] [int] NULL,
	[Jockey] [varchar](100) NULL,
	[ApprenticeWeight] [int] NULL,
	[JockeyStartsCurrentMeet] [varchar](100) NULL,
	[JockeyWinsCurrentMeet] [varchar](100) NULL,
	[JockeyPlacesCurrentMeet] [varchar](100) NULL,
	[JockeyShowsCurrentMeet] [varchar](100) NULL,
	[Owner] [varchar](100) NULL,
	[TrainerRecordCurrentYear] [varchar](30) NULL,
	[TrainerRecordPreviousYear] [varchar](30) NULL,
	[JockeyRecordCurrentYear] [varchar](30) NULL,
	[JockeyRecordPreviousYear] [varchar](30) NULL,
	[OwnersSilks] [varchar](100) NULL,
	[HorseName] [varchar](100) NULL,
	[YearOfBirth] [int] NULL,
	[HorseFoalingMonth] [int] NULL,
	[Reserved28] [varchar](50) NULL,
	[Sex] [char](1) NULL,
	[HorseColor] [varchar](50) NULL,
	[Weight] [int] NULL,
	[Sire] [varchar](50) NULL,
	[SireSire] [varchar](50) NULL,
	[Dam] [varchar](150) NULL,
	[DamSire] [varchar](150) NULL,
	[Breeder] [varchar](150) NULL,
	[StateCountry] [varchar](25) NULL,
	[AuctionPrice] [decimal](18, 0) NULL,
	[InfoSoldAtAuction] [varchar](25) NULL,
	[Reserved40] [varchar](150) NULL,
	[AEIndicator] [char](1) NULL,
	[Medication1stLasixInfo] [int] NULL,
	[Medication1stWithOutLasixInfo] [int] NULL,
	[EquipmentChange] [int] NULL,
	[LifeTimeRecordTodayDistanceStarts] [int] NULL,
	[LifeTimeRecordTodayDistanceWins] [int] NULL,
	[LifeTimeRecordTodayDistancePlaces] [int] NULL,
	[LifeTimeRecordTodayDistanceShows] [int] NULL,
	[LifeTimeRecordTodayDistanceEarning] [decimal](18, 2) NULL,
	[LifeTimeRecordTodayTrackStarts] [int] NULL,
	[LifeTimeRecordTodayTrackWins] [int] NULL,
	[LifeTimeRecordTodayTrackPlaces] [int] NULL,
	[LifeTimeRecordTodayTrackShows] [int] NULL,
	[LifeTimeRecordTodayTrackEarning] [decimal](18, 2) NULL,
	[LifeTimeTurfRecordStarts] [int] NULL,
	[LifeTimeTurfRecordWins] [int] NULL,
	[LifeTimeTurfRecordPlaces] [int] NULL,
	[LifeTimeTurfRecordShows] [int] NULL,
	[LifeTimeTurfRecordEarning] [decimal](18, 2) NULL,
	[LifeTimeWetRecordStarts] [int] NULL,
	[LifeTimeWetRecordWins] [int] NULL,
	[LifeTimeWetRecordPlaces] [int] NULL,
	[LifeTimeWetRecordShows] [int] NULL,
	[LifeTimeWetRecordEarning] [decimal](18, 2) NULL,
	[CurrentRecordYear] [int] NULL,
	[CurrentRecordStarts] [int] NULL,
	[CurrentRecordWins] [int] NULL,
	[CurrentRecordPlaces] [int] NULL,
	[CurrentRecordShows] [int] NULL,
	[CurrentRecordEarning] [decimal](18, 2) NULL,
	[PreviousRecordYear] [int] NULL,
	[PreviousRecordStarts] [int] NULL,
	[PreviousRecordWins] [int] NULL,
	[PreviousRecordPlaces] [int] NULL,
	[PreviousRecordShows] [int] NULL,
	[PreviousRecordEarning] [decimal](18, 2) NULL,
	[LifetimeRecordStarts] [int] NULL,
	[LifetimeRecordWins] [int] NULL,
	[LifetimeRecordPlaces] [int] NULL,
	[LifetimeRecordShows] [int] NULL,
	[LifetimeRecordEarning] [decimal](18, 2) NULL,
	[Workout1Date] [datetime] NULL,
	[Workout2Date] [datetime] NULL,
	[Workout3Date] [datetime] NULL,
	[Workout4Date] [datetime] NULL,
	[Workout5Date] [datetime] NULL,
	[Workout6Date] [datetime] NULL,
	[Workout7Date] [datetime] NULL,
	[Workout8Date] [datetime] NULL,
	[Workout9Date] [datetime] NULL,
	[Workout10Date] [datetime] NULL,
	[Workout11Date] [datetime] NULL,
	[Workout12Date] [datetime] NULL,
	[Workout1Time] [decimal](18, 2) NULL,
	[Workout2Time] [decimal](18, 2) NULL,
	[Workout3Time] [decimal](18, 2) NULL,
	[Workout4Time] [decimal](18, 2) NULL,
	[Workout5Time] [decimal](18, 2) NULL,
	[Workout6Time] [decimal](18, 2) NULL,
	[Workout7Time] [decimal](18, 2) NULL,
	[Workout8Time] [decimal](18, 2) NULL,
	[Workout9Time] [decimal](18, 2) NULL,
	[Workout10Time] [decimal](18, 2) NULL,
	[Workout11Time] [decimal](18, 2) NULL,
	[Workout12Time] [decimal](18, 2) NULL,
	[Workout1Track] [varchar](10) NULL,
	[Workout2Track] [varchar](10) NULL,
	[Workout3Track] [varchar](10) NULL,
	[Workout4Track] [varchar](10) NULL,
	[Workout5Track] [varchar](10) NULL,
	[Workout6Track] [varchar](10) NULL,
	[Workout7Track] [varchar](10) NULL,
	[Workout8Track] [varchar](10) NULL,
	[Workout9Track] [varchar](10) NULL,
	[Workout10Track] [varchar](10) NULL,
	[Workout11Track] [varchar](10) NULL,
	[Workout12Track] [varchar](10) NULL,
	[Workout1Distance] [decimal](18, 2) NULL,
	[Workout2Distance] [decimal](18, 2) NULL,
	[Workout3Distance] [decimal](18, 2) NULL,
	[Workout4Distance] [decimal](18, 2) NULL,
	[Workout5Distance] [decimal](18, 2) NULL,
	[Workout6Distance] [decimal](18, 2) NULL,
	[Workout7Distance] [decimal](18, 2) NULL,
	[Workout8Distance] [decimal](18, 2) NULL,
	[Workout9Distance] [decimal](18, 2) NULL,
	[Workout10Distance] [decimal](18, 2) NULL,
	[Workout11Distance] [decimal](18, 2) NULL,
	[Workout12Distance] [decimal](18, 2) NULL,
	[WorkoutTrackCondition1] [varchar](5) NULL,
	[WorkoutTrackCondition2] [varchar](5) NULL,
	[WorkoutTrackCondition3] [varchar](5) NULL,
	[WorkoutTrackCondition4] [varchar](5) NULL,
	[WorkoutTrackCondition5] [varchar](5) NULL,
	[WorkoutTrackCondition6] [varchar](5) NULL,
	[WorkoutTrackCondition7] [varchar](5) NULL,
	[WorkoutTrackCondition8] [varchar](5) NULL,
	[WorkoutTrackCondition9] [varchar](5) NULL,
	[WorkoutTrackCondition10] [varchar](5) NULL,
	[WorkoutTrackCondition11] [varchar](5) NULL,
	[WorkoutTrackCondition12] [varchar](5) NULL,
	[Workout1Description] [varchar](5) NULL,
	[Workout2Description] [varchar](5) NULL,
	[Workout3Description] [varchar](5) NULL,
	[Workout4Description] [varchar](5) NULL,
	[Workout5Description] [varchar](5) NULL,
	[Workout6Description] [varchar](5) NULL,
	[Workout7Description] [varchar](5) NULL,
	[Workout8Description] [varchar](5) NULL,
	[Workout9Description] [varchar](5) NULL,
	[Workout10Description] [varchar](5) NULL,
	[Workout11Description] [varchar](5) NULL,
	[Workout12Description] [varchar](5) NULL,
	[MainInnerTrackIndicator1] [varchar](5) NULL,
	[MainInnerTrackIndicator2] [varchar](5) NULL,
	[MainInnerTrackIndicator3] [varchar](5) NULL,
	[MainInnerTrackIndicator4] [varchar](5) NULL,
	[MainInnerTrackIndicator5] [varchar](5) NULL,
	[MainInnerTrackIndicator6] [varchar](5) NULL,
	[MainInnerTrackIndicator7] [varchar](5) NULL,
	[MainInnerTrackIndicator8] [varchar](5) NULL,
	[MainInnerTrackIndicator9] [varchar](5) NULL,
	[MainInnerTrackIndicator10] [varchar](5) NULL,
	[MainInnerTrackIndicator11] [varchar](5) NULL,
	[MainInnerTrackIndicator12] [varchar](5) NULL,
	[NumberOfWorkout1] [varchar](5) NULL,
	[NumberOfWorkout2] [varchar](5) NULL,
	[NumberOfWorkout3] [varchar](5) NULL,
	[NumberOfWorkout4] [varchar](5) NULL,
	[NumberOfWorkout5] [varchar](5) NULL,
	[NumberOfWorkout6] [varchar](5) NULL,
	[NumberOfWorkout7] [varchar](5) NULL,
	[NumberOfWorkout8] [varchar](5) NULL,
	[NumberOfWorkout9] [varchar](5) NULL,
	[NumberOfWorkout10] [varchar](5) NULL,
	[NumberOfWorkout11] [varchar](5) NULL,
	[NumberOfWorkout12] [varchar](5) NULL,
	[WorkoutRank1] [varchar](5) NULL,
	[WorkoutRank2] [varchar](5) NULL,
	[WorkoutRank3] [varchar](5) NULL,
	[WorkoutRank4] [varchar](5) NULL,
	[WorkoutRank5] [varchar](5) NULL,
	[WorkoutRank6] [varchar](5) NULL,
	[WorkoutRank7] [varchar](5) NULL,
	[WorkoutRank8] [varchar](5) NULL,
	[WorkoutRank9] [varchar](5) NULL,
	[WorkoutRank10] [varchar](5) NULL,
	[WorkoutRank11] [varchar](5) NULL,
	[WorkoutRank12] [varchar](5) NULL,
	[BrisRunStyle] [varchar](5) NULL,
	[QuirinSpeedPoints] [int] NULL,
	[Reserved191Reserved] [varchar](50) NULL,
	[Reserved192Reserved] [varchar](50) NULL,
	[Bris2fPaceFig] [int] NULL,
	[Bris4fPaceFig] [int] NULL,
	[Bris6fPaceFig] [int] NULL,
	[BrisSpeedFig] [int] NULL,
	[BrisLatePace] [int] NULL,
	[Reserved198] [varchar](50) NULL,
	[Reserved199] [varchar](50) NULL,
	[ProgramPostPosition] [int] NULL,
	[ProgramNumber] [varchar](5) NULL,
	[MorningLine] [decimal](18, 2) NULL,
	[NumOfDaySinceLastRace] [int] NULL,
	[RaceConditionLine1] [varchar](275) NULL,
	[RaceConditionLine2] [varchar](275) NULL,
	[RaceConditionLine3] [varchar](275) NULL,
	[RaceConditionLine4] [varchar](275) NULL,
	[RaceConditionLine5] [varchar](275) NULL,
	[RaceConditionLine6] [varchar](275) NULL,
	[LifetimeStartsAllWeather] [int] NULL,
	[LifetimeWinsAllWeather] [int] NULL,
	[LifetimePlacesAllWeather] [int] NULL,
	[LifetimeShowsAllWeather] [int] NULL,
	[LifetimeEarningsAllWeather] [decimal](18, 2) NULL,
	[BestBRISSpeedAllWeather] [int] NULL,
	[Reserved216] [varchar](50) NULL,
	[LowClaimingPrice] [decimal](18, 2) NULL,
	[StatebredFlag] [char](1) NULL,
	[WagerTypes219] [varchar](150) NULL,
	[WagerTypes220] [varchar](150) NULL,
	[WagerTypes221] [varchar](150) NULL,
	[WagerTypes222] [varchar](150) NULL,
	[WagerTypes223] [varchar](150) NULL,
	[WagerTypes224] [varchar](150) NULL,
	[WagerTypes225] [varchar](150) NULL,
	[WagerTypes226] [varchar](150) NULL,
	[WagerTypes227] [varchar](150) NULL,
	[SireStudFee] [decimal](18, 2) NULL,
	[BestBRISSpeedFastTrack] [int] NULL,
	[BestBRISSpeedTurf] [int] NULL,
	[BestBRISSpeedOffTrack] [int] NULL,
	[BestBRISSpeedDistance] [int] NULL,
	[Reserved233] [varchar](250) NULL,
	[Reserved234] [varchar](250) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20221112-064513]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20221112-064513] ON [kelso].[brisnet_dr2]
(
	[RaceId] ASC,
	[TrackCd] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC,
	[PostPosition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_dr2_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_dr2_staging](
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[PostPosition] [varchar](5) NULL,
	[Entry] [varchar](12) NULL,
	[ClaimingPrice] [varchar](25) NULL,
	[Trainer] [varchar](100) NULL,
	[TrainerStartsCurrentMeet] [varchar](12) NULL,
	[TrainerWinCurrentMeet] [varchar](12) NULL,
	[TrainerPlacesCurrentMeet] [varchar](12) NULL,
	[TrainerShowCurrentMeet] [varchar](12) NULL,
	[Jockey] [varchar](100) NULL,
	[ApprenticeWeight] [varchar](12) NULL,
	[JockeyStartsCurrentMeet] [varchar](12) NULL,
	[JockeyWinsCurrentMeet] [varchar](12) NULL,
	[JockeyPlacesCurrentMeet] [varchar](12) NULL,
	[JockeyShowsCurrentMeet] [varchar](12) NULL,
	[Owner] [varchar](100) NULL,
	[TrainerRecordCurrentYear] [varchar](30) NULL,
	[TrainerRecordPreviousYear] [varchar](30) NULL,
	[JockeyRecordCurrentYear] [varchar](30) NULL,
	[JockeyRecordPreviousYear] [varchar](30) NULL,
	[OwnersSilks] [varchar](100) NULL,
	[HorseName] [varchar](100) NULL,
	[YearOfBirth] [varchar](12) NULL,
	[HorseFoalingMonth] [varchar](12) NULL,
	[Reserved28] [varchar](50) NULL,
	[Sex] [char](1) NULL,
	[HorseColor] [varchar](50) NULL,
	[Weight] [varchar](12) NULL,
	[Sire] [varchar](50) NULL,
	[SireSire] [varchar](50) NULL,
	[Dam] [varchar](50) NULL,
	[DamSire] [varchar](50) NULL,
	[Breeder] [varchar](100) NULL,
	[StateCountry] [varchar](25) NULL,
	[AuctionPrice] [varchar](25) NULL,
	[InfoSoldAtAuction] [varchar](25) NULL,
	[Reserved40] [varchar](250) NULL,
	[AEIndicator] [char](1) NULL,
	[Medication1stLasixInfo] [varchar](12) NULL,
	[Medication1stWithOutLasixInfo] [varchar](12) NULL,
	[EquipmentChange] [varchar](12) NULL,
	[LifeTimeRecordTodayDistanceStarts] [varchar](12) NULL,
	[LifeTimeRecordTodayDistanceWins] [varchar](12) NULL,
	[LifeTimeRecordTodayDistancePlaces] [varchar](12) NULL,
	[LifeTimeRecordTodayDistanceShows] [varchar](12) NULL,
	[LifeTimeRecordTodayDistanceEarning] [varchar](25) NULL,
	[LifeTimeRecordTodayTrackStarts] [varchar](12) NULL,
	[LifeTimeRecordTodayTrackWins] [varchar](12) NULL,
	[LifeTimeRecordTodayTrackPlaces] [varchar](12) NULL,
	[LifeTimeRecordTodayTrackShows] [varchar](12) NULL,
	[LifeTimeRecordTodayTrackEarning] [varchar](25) NULL,
	[LifeTimeTurfRecordStarts] [varchar](12) NULL,
	[LifeTimeTurfRecordWins] [varchar](12) NULL,
	[LifeTimeTurfRecordPlaces] [varchar](12) NULL,
	[LifeTimeTurfRecordShows] [varchar](12) NULL,
	[LifeTimeTurfRecordEarning] [varchar](25) NULL,
	[LifeTimeWetRecordStarts] [varchar](12) NULL,
	[LifeTimeWetRecordWins] [varchar](12) NULL,
	[LifeTimeWetRecordPlaces] [varchar](12) NULL,
	[LifeTimeWetRecordShows] [varchar](12) NULL,
	[LifeTimeWetRecordEarning] [varchar](25) NULL,
	[CurrentRecordYear] [varchar](12) NULL,
	[CurrentRecordStarts] [varchar](12) NULL,
	[CurrentRecordWins] [varchar](12) NULL,
	[CurrentRecordPlaces] [varchar](12) NULL,
	[CurrentRecordShows] [varchar](12) NULL,
	[CurrentRecordEarning] [varchar](25) NULL,
	[PreviousRecordYear] [varchar](12) NULL,
	[PreviousRecordStarts] [varchar](12) NULL,
	[PreviousRecordWins] [varchar](12) NULL,
	[PreviousRecordPlaces] [varchar](12) NULL,
	[PreviousRecordShows] [varchar](12) NULL,
	[PreviousRecordEarning] [varchar](25) NULL,
	[LifetimeRecordStarts] [varchar](12) NULL,
	[LifetimeRecordWins] [varchar](12) NULL,
	[LifetimeRecordPlaces] [varchar](12) NULL,
	[LifetimeRecordShows] [varchar](12) NULL,
	[LifetimeRecordEarning] [varchar](25) NULL,
	[Workout1Date] [varchar](25) NULL,
	[Workout2Date] [varchar](25) NULL,
	[Workout3Date] [varchar](25) NULL,
	[Workout4Date] [varchar](25) NULL,
	[Workout5Date] [varchar](25) NULL,
	[Workout6Date] [varchar](25) NULL,
	[Workout7Date] [varchar](25) NULL,
	[Workout8Date] [varchar](25) NULL,
	[Workout9Date] [varchar](25) NULL,
	[Workout10Date] [varchar](25) NULL,
	[Workout11Date] [varchar](25) NULL,
	[Workout12Date] [varchar](25) NULL,
	[Workout1Time] [varchar](25) NULL,
	[Workout2Time] [varchar](25) NULL,
	[Workout3Time] [varchar](25) NULL,
	[Workout4Time] [varchar](25) NULL,
	[Workout5Time] [varchar](25) NULL,
	[Workout6Time] [varchar](25) NULL,
	[Workout7Time] [varchar](25) NULL,
	[Workout8Time] [varchar](25) NULL,
	[Workout9Time] [varchar](25) NULL,
	[Workout10Time] [varchar](25) NULL,
	[Workout11Time] [varchar](25) NULL,
	[Workout12Time] [varchar](25) NULL,
	[Workout1Track] [varchar](10) NULL,
	[Workout2Track] [varchar](10) NULL,
	[Workout3Track] [varchar](10) NULL,
	[Workout4Track] [varchar](10) NULL,
	[Workout5Track] [varchar](10) NULL,
	[Workout6Track] [varchar](10) NULL,
	[Workout7Track] [varchar](10) NULL,
	[Workout8Track] [varchar](10) NULL,
	[Workout9Track] [varchar](10) NULL,
	[Workout10Track] [varchar](10) NULL,
	[Workout11Track] [varchar](10) NULL,
	[Workout12Track] [varchar](10) NULL,
	[Workout1Distance] [varchar](25) NULL,
	[Workout2Distance] [varchar](25) NULL,
	[Workout3Distance] [varchar](25) NULL,
	[Workout4Distance] [varchar](25) NULL,
	[Workout5Distance] [varchar](25) NULL,
	[Workout6Distance] [varchar](25) NULL,
	[Workout7Distance] [varchar](25) NULL,
	[Workout8Distance] [varchar](25) NULL,
	[Workout9Distance] [varchar](25) NULL,
	[Workout10Distance] [varchar](25) NULL,
	[Workout11Distance] [varchar](25) NULL,
	[Workout12Distance] [varchar](25) NULL,
	[WorkoutTrackCondition1] [varchar](5) NULL,
	[WorkoutTrackCondition2] [varchar](5) NULL,
	[WorkoutTrackCondition3] [varchar](5) NULL,
	[WorkoutTrackCondition4] [varchar](5) NULL,
	[WorkoutTrackCondition5] [varchar](5) NULL,
	[WorkoutTrackCondition6] [varchar](5) NULL,
	[WorkoutTrackCondition7] [varchar](5) NULL,
	[WorkoutTrackCondition8] [varchar](5) NULL,
	[WorkoutTrackCondition9] [varchar](5) NULL,
	[WorkoutTrackCondition10] [varchar](5) NULL,
	[WorkoutTrackCondition11] [varchar](5) NULL,
	[WorkoutTrackCondition12] [varchar](5) NULL,
	[Workout1Description] [varchar](5) NULL,
	[Workout2Description] [varchar](5) NULL,
	[Workout3Description] [varchar](5) NULL,
	[Workout4Description] [varchar](5) NULL,
	[Workout5Description] [varchar](5) NULL,
	[Workout6Description] [varchar](5) NULL,
	[Workout7Description] [varchar](5) NULL,
	[Workout8Description] [varchar](5) NULL,
	[Workout9Description] [varchar](5) NULL,
	[Workout10Description] [varchar](5) NULL,
	[Workout11Description] [varchar](5) NULL,
	[Workout12Description] [varchar](5) NULL,
	[MainInnerTrackIndicator1] [varchar](5) NULL,
	[MainInnerTrackIndicator2] [varchar](5) NULL,
	[MainInnerTrackIndicator3] [varchar](5) NULL,
	[MainInnerTrackIndicator4] [varchar](5) NULL,
	[MainInnerTrackIndicator5] [varchar](5) NULL,
	[MainInnerTrackIndicator6] [varchar](5) NULL,
	[MainInnerTrackIndicator7] [varchar](5) NULL,
	[MainInnerTrackIndicator8] [varchar](5) NULL,
	[MainInnerTrackIndicator9] [varchar](5) NULL,
	[MainInnerTrackIndicator10] [varchar](5) NULL,
	[MainInnerTrackIndicator11] [varchar](5) NULL,
	[MainInnerTrackIndicator12] [varchar](5) NULL,
	[NumberOfWorkout1] [varchar](5) NULL,
	[NumberOfWorkout2] [varchar](5) NULL,
	[NumberOfWorkout3] [varchar](5) NULL,
	[NumberOfWorkout4] [varchar](5) NULL,
	[NumberOfWorkout5] [varchar](5) NULL,
	[NumberOfWorkout6] [varchar](5) NULL,
	[NumberOfWorkout7] [varchar](5) NULL,
	[NumberOfWorkout8] [varchar](5) NULL,
	[NumberOfWorkout9] [varchar](5) NULL,
	[NumberOfWorkout10] [varchar](5) NULL,
	[NumberOfWorkout11] [varchar](5) NULL,
	[NumberOfWorkout12] [varchar](5) NULL,
	[WorkoutRank1] [varchar](5) NULL,
	[WorkoutRank2] [varchar](5) NULL,
	[WorkoutRank3] [varchar](5) NULL,
	[WorkoutRank4] [varchar](5) NULL,
	[WorkoutRank5] [varchar](5) NULL,
	[WorkoutRank6] [varchar](5) NULL,
	[WorkoutRank7] [varchar](5) NULL,
	[WorkoutRank8] [varchar](5) NULL,
	[WorkoutRank9] [varchar](5) NULL,
	[WorkoutRank10] [varchar](5) NULL,
	[WorkoutRank11] [varchar](5) NULL,
	[WorkoutRank12] [varchar](5) NULL,
	[BrisRunStyle] [varchar](5) NULL,
	[QuirinSpeedPoints] [varchar](12) NULL,
	[Reserved191Reserved] [varchar](50) NULL,
	[Reserved192Reserved] [varchar](50) NULL,
	[Bris2fPaceFig] [varchar](12) NULL,
	[Bris4fPaceFig] [varchar](12) NULL,
	[Bris6fPaceFig] [varchar](12) NULL,
	[BrisSpeedFig] [varchar](12) NULL,
	[BrisLatePace] [varchar](12) NULL,
	[Reserved198] [varchar](250) NULL,
	[Reserved199] [varchar](250) NULL,
	[ProgramPostPosition] [varchar](12) NULL,
	[ProgramNumber] [varchar](5) NULL,
	[MorningLine] [varchar](25) NULL,
	[NumOfDaySinceLastRace] [varchar](12) NULL,
	[RaceConditionLine1] [varchar](500) NULL,
	[RaceConditionLine2] [varchar](500) NULL,
	[RaceConditionLine3] [varchar](500) NULL,
	[RaceConditionLine4] [varchar](500) NULL,
	[RaceConditionLine5] [varchar](500) NULL,
	[RaceConditionLine6] [varchar](500) NULL,
	[LifetimeStartsAllWeather] [varchar](12) NULL,
	[LifetimeWinsAllWeather] [varchar](12) NULL,
	[LifetimePlacesAllWeather] [varchar](12) NULL,
	[LifetimeShowsAllWeather] [varchar](12) NULL,
	[LifetimeEarningsAllWeather] [varchar](25) NULL,
	[BestBRISSpeedAllWeather] [varchar](12) NULL,
	[Reserved216] [varchar](250) NULL,
	[LowClaimingPrice] [varchar](25) NULL,
	[StatebredFlag] [varchar](5) NULL,
	[WagerTypes219] [varchar](500) NULL,
	[WagerTypes220] [varchar](500) NULL,
	[WagerTypes221] [varchar](500) NULL,
	[WagerTypes222] [varchar](500) NULL,
	[WagerTypes223] [varchar](500) NULL,
	[WagerTypes224] [varchar](500) NULL,
	[WagerTypes225] [varchar](500) NULL,
	[WagerTypes226] [varchar](500) NULL,
	[WagerTypes227] [varchar](500) NULL,
	[SireStudFee] [varchar](25) NULL,
	[BestBRISSpeedFastTrack] [varchar](12) NULL,
	[BestBRISSpeedTurf] [varchar](12) NULL,
	[BestBRISSpeedOffTrack] [varchar](12) NULL,
	[BestBRISSpeedDistance] [varchar](12) NULL,
	[Reserved233] [varchar](250) NULL,
	[Reserved234] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_dr3]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_dr3](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[RaceId] [uniqueidentifier] NOT NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[HorseId] [uniqueidentifier] NULL,
	[HorseName] [varchar](75) NULL,
	[PostPosition] [int] NULL,
	[PreviousRaceDate] [datetime] NULL,
	[NumOfDaysSincePreviousRace] [int] NULL,
	[PreviousTrackName] [varchar](30) NULL,
	[PreviousTrackCd] [varchar](3) NULL,
	[PreviousRaceNum] [int] NULL,
	[TrackCondition] [varchar](2) NULL,
	[Distance] [decimal](18, 2) NULL,
	[Surface] [char](1) NULL,
	[SpecialChuteIndicator] [char](1) NULL,
	[NumOfEntrants] [int] NULL,
	[PreviousPostPosition] [int] NULL,
	[Equipment] [char](1) NULL,
	[Reserved18] [varchar](50) NULL,
	[Medication] [int] NULL,
	[TripComment] [varchar](100) NULL,
	[WinnerName] [varchar](50) NULL,
	[SecondPlaceFinisherName] [varchar](50) NULL,
	[ThirdPlaceFinisherName] [varchar](50) NULL,
	[WinnerWeight] [int] NULL,
	[SecondPlaceWeight] [int] NULL,
	[ThirdPlaceWeight] [int] NULL,
	[WinnerMargin] [decimal](18, 2) NULL,
	[SecondPlaceMargin] [decimal](18, 2) NULL,
	[ThirdPlaceMargin] [decimal](18, 2) NULL,
	[ExtraCommentLine] [varchar](200) NULL,
	[Weight] [int] NULL,
	[Odds] [decimal](18, 2) NULL,
	[Entry] [char](1) NULL,
	[RaceClassification] [varchar](25) NULL,
	[ClaimingPrice] [decimal](18, 2) NULL,
	[Purse] [decimal](18, 2) NULL,
	[StartCallPosition] [varchar](5) NULL,
	[FirstCallPosition] [varchar](5) NULL,
	[SecondCallPosition] [varchar](5) NULL,
	[GateCallPosition] [varchar](5) NULL,
	[StretchCallPosition] [varchar](5) NULL,
	[FinishPosition] [varchar](5) NULL,
	[MoneyPosition] [varchar](5) NULL,
	[StartCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[StartCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[FirstCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[FirstCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[SecondCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[SecondCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[Reserved50] [varchar](250) NULL,
	[Reserved51] [varchar](250) NULL,
	[StretchBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[StretchBtnLngthsOnly] [decimal](18, 2) NULL,
	[FinishBtnLngthLdrMargin] [decimal](18, 2) NULL,
	[FinishCallBtnLngthsOnly] [decimal](18, 2) NULL,
	[BrisRaceShapeSecondCall] [decimal](18, 2) NULL,
	[Bris2FPace] [int] NULL,
	[Bris4FPace] [int] NULL,
	[Bris6FPace] [int] NULL,
	[Bris8FPace] [int] NULL,
	[Bris10FPace] [int] NULL,
	[BrisLateFPace] [int] NULL,
	[BrisRaceShapeFirstCall] [int] NULL,
	[Reserved64] [int] NULL,
	[BrisSpeedRating] [int] NULL,
	[SpeedRating] [int] NULL,
	[TrackVariant] [int] NULL,
	[TwoFurlongFraction] [decimal](18, 2) NULL,
	[ThreeFurlongFraction] [decimal](18, 2) NULL,
	[FourFurlongFraction] [decimal](18, 2) NULL,
	[FiveFurlongFraction] [decimal](18, 2) NULL,
	[SixFurlongFraction] [decimal](18, 2) NULL,
	[SevenFurlongFraction] [decimal](18, 2) NULL,
	[EightFurlongFraction] [decimal](18, 2) NULL,
	[TenFurlongFraction] [decimal](18, 2) NULL,
	[TwelveFurlongFraction] [decimal](18, 2) NULL,
	[FourteenFurlongFraction] [decimal](18, 2) NULL,
	[SixteenFurlongFraction] [decimal](18, 2) NULL,
	[Fraction1] [decimal](18, 2) NULL,
	[Fraction2] [decimal](18, 2) NULL,
	[Fraction3] [decimal](18, 2) NULL,
	[Reserved82] [varchar](250) NULL,
	[Reserved83] [varchar](250) NULL,
	[FinalTime] [decimal](18, 2) NULL,
	[ClaimedCd] [varchar](10) NULL,
	[Trainer] [varchar](100) NULL,
	[Jockey] [varchar](100) NULL,
	[ApprenticeWtAllow] [int] NULL,
	[RaceType] [varchar](2) NULL,
	[AgeAndSexRestrictions] [varchar](3) NULL,
	[StatebredFlag] [char](1) NULL,
	[RestrictedQualifierFlag] [char](1) NULL,
	[FavoriteIndicator] [int] NULL,
	[FrontBandagesIndicator] [int] NULL,
	[BrisSpeedParPrior] [int] NULL,
	[BarShoe] [char](1) NULL,
	[CompanyLineCode] [varchar](5) NULL,
	[LowClaimingPriceOfRace] [decimal](18, 2) NULL,
	[HighClaimingPriceOfRace] [decimal](18, 2) NULL,
	[Reserved100] [varchar](250) NULL,
	[CodeForPriorStart] [char](1) NULL,
	[Reserved101] [varchar](250) NULL,
	[Reserved102] [varchar](250) NULL,
	[Reserved103] [varchar](250) NULL,
	[Reserved104] [varchar](250) NULL,
	[Reserved105] [varchar](250) NULL,
	[Reserved106] [varchar](250) NULL,
	[ExtendedStartComment] [varchar](250) NULL,
	[SealedTrackIndicator] [char](1) NULL,
	[PrevAllWeatherSurfaceFlag] [char](1) NULL,
	[Reserved110] [varchar](250) NULL,
	[Reserved111] [varchar](250) NULL,
	[Reserved112] [varchar](250) NULL,
	[Reserved113] [varchar](250) NULL,
	[Reserved114] [varchar](250) NULL,
	[Reserved115] [varchar](250) NULL,
	[Reserved116] [varchar](250) NULL,
	[Reserved117] [varchar](250) NULL,
	[Reserved118] [varchar](250) NULL,
	[Reserved119] [varchar](250) NULL,
	[Reserved120] [varchar](250) NULL,
	[Reserved121] [varchar](250) NULL,
	[Reserved122] [varchar](250) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-184521]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-184521] ON [kelso].[brisnet_dr3]
(
	[RaceId] ASC,
	[TrackCd] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC,
	[HorseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_dr3_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_dr3_staging](
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[PostPosition] [varchar](25) NULL,
	[PreviousRaceDate] [varchar](8) NULL,
	[NumOfDaysSincePreviousRace] [varchar](25) NULL,
	[PreviousTrackName] [varchar](30) NULL,
	[PreviousTrackCd] [varchar](3) NULL,
	[PreviousRaceNum] [varchar](25) NULL,
	[TrackCondition] [varchar](2) NULL,
	[Distance] [varchar](25) NULL,
	[Surface] [char](1) NULL,
	[SpecialChuteIndicator] [char](1) NULL,
	[NumOfEntrants] [varchar](25) NULL,
	[PreviousPostPosition] [varchar](25) NULL,
	[Equipment] [char](1) NULL,
	[Reserved18] [varchar](50) NULL,
	[Medication] [varchar](25) NULL,
	[TripComment] [varchar](100) NULL,
	[WinnerName] [varchar](50) NULL,
	[SecondPlaceFinisherName] [varchar](50) NULL,
	[ThirdPlaceFinisherName] [varchar](50) NULL,
	[WinnerWeight] [varchar](25) NULL,
	[SecondPlaceWeight] [varchar](25) NULL,
	[ThirdPlaceWeight] [varchar](25) NULL,
	[WinnerMargin] [varchar](25) NULL,
	[SecondPlaceMargin] [varchar](25) NULL,
	[ThirdPlaceMargin] [varchar](25) NULL,
	[ExtraCommentLine] [varchar](200) NULL,
	[Weight] [varchar](25) NULL,
	[Odds] [varchar](25) NULL,
	[Entry] [char](1) NULL,
	[RaceClassification] [varchar](25) NULL,
	[ClaimingPrice] [varchar](25) NULL,
	[Purse] [varchar](25) NULL,
	[StartCallPosition] [varchar](5) NULL,
	[FirstCallPosition] [varchar](5) NULL,
	[SecondCallPosition] [varchar](5) NULL,
	[GateCallPosition] [varchar](5) NULL,
	[StretchCallPosition] [varchar](5) NULL,
	[FinishPosition] [varchar](5) NULL,
	[MoneyPosition] [varchar](5) NULL,
	[StartCallBtnLngthLdrMargin] [varchar](25) NULL,
	[StartCallBtnLngthsOnly] [varchar](25) NULL,
	[FirstCallBtnLngthLdrMargin] [varchar](25) NULL,
	[FirstCallBtnLngthsOnly] [varchar](25) NULL,
	[SecondCallBtnLngthLdrMargin] [varchar](25) NULL,
	[SecondCallBtnLngthsOnly] [varchar](25) NULL,
	[Reserved50] [varchar](50) NULL,
	[Reserved51] [varchar](50) NULL,
	[StretchBtnLngthLdrMargin] [varchar](25) NULL,
	[StretchBtnLngthsOnly] [varchar](25) NULL,
	[FinishBtnLngthLdrMargin] [varchar](25) NULL,
	[FinishCallBtnLngthsOnly] [varchar](25) NULL,
	[BrisRaceShapeSecondCall] [varchar](25) NULL,
	[Bris2FPace] [varchar](25) NULL,
	[Bris4FPace] [varchar](25) NULL,
	[Bris6FPace] [varchar](25) NULL,
	[Bris8FPace] [varchar](25) NULL,
	[Bris10FPace] [varchar](25) NULL,
	[BrisLateFPace] [varchar](25) NULL,
	[BrisRaceShapeFirstCall] [varchar](25) NULL,
	[Reserved64] [varchar](25) NULL,
	[BrisSpeedRating] [varchar](25) NULL,
	[SpeedRating] [varchar](25) NULL,
	[TrackVariant] [varchar](25) NULL,
	[TwoFurlongFraction] [varchar](25) NULL,
	[ThreeFurlongFraction] [varchar](25) NULL,
	[FourFurlongFraction] [varchar](25) NULL,
	[FiveFurlongFraction] [varchar](25) NULL,
	[SixFurlongFraction] [varchar](25) NULL,
	[SevenFurlongFraction] [varchar](25) NULL,
	[EightFurlongFraction] [varchar](25) NULL,
	[TenFurlongFraction] [varchar](25) NULL,
	[TwelveFurlongFraction] [varchar](25) NULL,
	[FourteenFurlongFraction] [varchar](25) NULL,
	[SixteenFurlongFraction] [varchar](25) NULL,
	[Fraction1] [varchar](25) NULL,
	[Fraction2] [varchar](25) NULL,
	[Fraction3] [varchar](25) NULL,
	[Reserved82] [varchar](250) NULL,
	[Reserved83] [varchar](250) NULL,
	[FinalTime] [varchar](25) NULL,
	[ClaimedCd] [varchar](10) NULL,
	[Trainer] [varchar](100) NULL,
	[Jockey] [varchar](100) NULL,
	[ApprenticeWtAllow] [varchar](25) NULL,
	[RaceType] [varchar](2) NULL,
	[AgeAndSexRestrictions] [varchar](3) NULL,
	[StatebredFlag] [char](1) NULL,
	[RestrictedQualifierFlag] [char](1) NULL,
	[FavoriteIndicator] [varchar](25) NULL,
	[FrontBandagesIndicator] [varchar](25) NULL,
	[BrisSpeedParPrior] [varchar](25) NULL,
	[BarShoe] [char](1) NULL,
	[CompanyLineCode] [varchar](5) NULL,
	[LowClaimingPriceOfRace] [varchar](25) NULL,
	[HighClaimingPriceOfRace] [varchar](25) NULL,
	[Reserved100] [varchar](50) NULL,
	[CodeForPriorStart] [char](1) NULL,
	[Reserved101] [varchar](250) NULL,
	[Reserved102] [varchar](250) NULL,
	[Reserved103] [varchar](250) NULL,
	[Reserved104] [varchar](250) NULL,
	[Reserved105] [varchar](250) NULL,
	[Reserved106] [varchar](250) NULL,
	[ExtendedStartComment] [varchar](250) NULL,
	[SealedTrackIndicator] [char](1) NULL,
	[PrevAllWeatherSurfaceFlag] [char](1) NULL,
	[Reserved110] [varchar](500) NULL,
	[Reserved111] [varchar](500) NULL,
	[Reserved112] [varchar](500) NULL,
	[Reserved113] [varchar](500) NULL,
	[Reserved114] [varchar](500) NULL,
	[Reserved115] [varchar](500) NULL,
	[Reserved116] [varchar](500) NULL,
	[Reserved117] [varchar](500) NULL,
	[Reserved118] [varchar](500) NULL,
	[Reserved119] [varchar](500) NULL,
	[Reserved120] [varchar](500) NULL,
	[Reserved121] [varchar](500) NULL,
	[Reserved122] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_dr4]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_dr4](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RaceId] [uniqueidentifier] NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[HorseId] [uniqueidentifier] NULL,
	[HorseName] [varchar](75) NULL,
	[PostPosition] [int] NULL,
	[BRISPrimePowerRating] [decimal](18, 2) NULL,
	[BRISDirtPedigreeRating] [varchar](5) NULL,
	[BRISMudPedigreeRating] [varchar](5) NULL,
	[BRISTurfPedigreeRating] [varchar](5) NULL,
	[BRISDistPedigreeRating] [varchar](5) NULL,
	[BestBRISSpeedLife] [int] NULL,
	[BestBRISSpeedMostRecentYr] [int] NULL,
	[BestBRISSpeedSecondMostRecentYr] [int] NULL,
	[BestBRISSpeedTrack] [int] NULL,
	[NumOfStartsFASTDirt] [int] NULL,
	[NumOfWinsFASTDirt] [int] NULL,
	[NumOfPlacesFASTDirt] [int] NULL,
	[NumOfShowsFASTDirt] [int] NULL,
	[NumOfEarningsFASTDirt] [decimal](18, 2) NULL,
	[TrntStatCategory1] [varchar](20) NULL,
	[NumOfStarts1] [int] NULL,
	[WinPercentage1] [decimal](18, 2) NULL,
	[InTheMoneyPercentage1] [decimal](18, 2) NULL,
	[ReturnOfInvestment1] [decimal](18, 2) NULL,
	[TrntStatCategory2] [varchar](20) NULL,
	[NumOfStarts2] [int] NULL,
	[WinPercentage2] [decimal](18, 2) NULL,
	[InTheMoneyPercentage2] [decimal](18, 2) NULL,
	[ReturnOfInvestment2] [decimal](18, 2) NULL,
	[TrntStatCategory3] [varchar](20) NULL,
	[NumOfStarts3] [int] NULL,
	[WinPercentage3] [decimal](18, 2) NULL,
	[InTheMoneyPercentage3] [decimal](18, 2) NULL,
	[ReturnOfInvestment3] [decimal](18, 2) NULL,
	[TrntStatCategory4] [varchar](20) NULL,
	[NumOfStarts4] [int] NULL,
	[WinPercentage4] [decimal](18, 2) NULL,
	[InTheMoneyPercentage4] [decimal](18, 2) NULL,
	[ReturnOfInvestment4] [decimal](18, 2) NULL,
	[TrntStatCategory5] [varchar](20) NULL,
	[NumOfStarts5] [int] NULL,
	[WinPercentage5] [decimal](18, 2) NULL,
	[InTheMoneyPercentage5] [decimal](18, 2) NULL,
	[ReturnOfInvestment5] [decimal](18, 2) NULL,
	[TrntStatCategory6] [varchar](20) NULL,
	[NumOfStarts6] [int] NULL,
	[WinPercentage6] [decimal](18, 2) NULL,
	[InTheMoneyPercentage6] [decimal](18, 2) NULL,
	[ReturnOfInvestment6] [decimal](18, 2) NULL,
	[Reserved49] [varchar](250) NULL,
	[JKYDistanceTurfLabel] [varchar](20) NULL,
	[JKYDistanceTurfStarts] [int] NULL,
	[JKYDistanceTurfWins] [int] NULL,
	[JKYDistanceTurfPlaces] [int] NULL,
	[JKYDistanceTurfShows] [int] NULL,
	[JKYDistanceTurfROI] [decimal](18, 2) NULL,
	[JKYDistanceTurfEarnings] [decimal](18, 2) NULL,
	[Reserved57] [varchar](250) NULL,
	[Reserved58] [varchar](250) NULL,
	[Reserved59] [varchar](250) NULL,
	[Reserved60] [varchar](250) NULL,
	[Reserved61] [varchar](250) NULL,
	[Reserved62] [varchar](250) NULL,
	[Reserved63] [varchar](250) NULL,
	[Reserved64] [varchar](250) NULL,
	[Reserved65] [varchar](250) NULL,
	[Reserved66] [varchar](250) NULL,
	[Reserved67] [varchar](250) NULL,
	[Reserved68] [varchar](250) NULL,
	[Reserved69] [varchar](250) NULL,
	[Reserved70] [varchar](250) NULL,
	[Reserved71] [varchar](250) NULL,
	[Reserved72] [varchar](250) NULL,
	[Reserved73] [varchar](250) NULL,
	[Reserved74] [varchar](250) NULL,
	[Reserved75] [varchar](250) NULL,
	[Reserved76] [varchar](250) NULL,
	[Reserved77] [varchar](250) NULL,
	[Reserved78] [varchar](250) NULL,
	[Reserved79] [varchar](250) NULL,
	[Reserved80] [varchar](250) NULL,
	[Reserved81] [varchar](250) NULL,
	[Reserved82] [varchar](250) NULL,
	[Reserved83] [varchar](250) NULL,
	[Reserved84] [varchar](250) NULL,
	[Reserved85] [varchar](250) NULL,
	[Reserved86] [varchar](250) NULL,
	[Reserved87] [varchar](250) NULL,
	[Reserved88] [varchar](250) NULL,
	[Reserved89] [varchar](250) NULL,
	[Reserved90] [varchar](250) NULL,
	[Reserved91] [varchar](250) NULL,
	[Reserved92] [varchar](250) NULL,
	[Reserved93] [varchar](250) NULL,
	[Reserved94] [varchar](250) NULL,
	[Reserved95] [varchar](250) NULL,
	[Reserved96] [varchar](250) NULL,
	[Reserved97] [varchar](250) NULL,
	[Reserved98] [varchar](250) NULL,
	[Reserved99] [varchar](250) NULL,
	[Reserved100] [varchar](250) NULL,
	[Reserved101] [varchar](250) NULL,
	[Reserved102] [varchar](250) NULL,
	[Reserved103] [varchar](250) NULL,
	[Reserved104] [varchar](250) NULL,
	[Reserved105] [varchar](250) NULL,
	[Reserved106] [varchar](250) NULL,
	[Reserved107] [varchar](250) NULL,
	[Reserved108] [varchar](250) NULL,
	[Reserved109] [varchar](250) NULL,
	[Reserved110] [varchar](250) NULL,
	[Reserved111] [varchar](250) NULL,
	[Reserved112] [varchar](250) NULL,
	[Reserved113] [varchar](250) NULL,
	[Reserved114] [varchar](250) NULL,
	[Reserved115] [varchar](250) NULL,
	[Reserved116] [varchar](250) NULL,
	[Reserved117] [varchar](250) NULL,
	[Reserved118] [varchar](250) NULL,
	[Reserved119] [varchar](250) NULL,
	[Reserved120] [varchar](250) NULL,
	[Reserved121] [varchar](250) NULL,
	[Reserved122] [varchar](250) NULL,
	[Reserved123] [varchar](250) NULL,
	[Reserved124] [varchar](250) NULL,
	[Reserved125] [varchar](250) NULL,
	[Reserved126] [varchar](250) NULL,
	[Reserved127] [varchar](250) NULL,
	[Reserved128] [varchar](250) NULL,
	[Reserved129] [varchar](250) NULL,
	[Reserved130] [varchar](250) NULL,
	[Reserved131] [varchar](250) NULL,
	[Reserved132] [varchar](250) NULL,
	[Reserved133] [varchar](250) NULL,
	[Reserved134] [varchar](250) NULL,
	[Reserved135] [varchar](250) NULL,
	[Reserved136] [varchar](250) NULL,
	[Reserved137] [varchar](250) NULL,
	[Reserved138] [varchar](250) NULL,
	[Reserved139] [varchar](250) NULL,
	[Reserved140] [varchar](250) NULL,
	[Reserved141] [varchar](250) NULL,
	[Reserved142] [varchar](250) NULL,
	[Reserved143] [varchar](250) NULL,
	[Reserved144] [varchar](250) NULL,
	[Reserved145] [varchar](250) NULL,
	[Reserved146] [varchar](250) NULL,
	[Reserved147] [varchar](250) NULL,
	[Reserved148] [varchar](250) NULL,
	[Reserved149] [varchar](250) NULL,
	[Reserved150] [varchar](250) NULL,
	[Reserved151] [varchar](250) NULL,
	[Reserved152] [varchar](250) NULL,
	[Reserved153] [varchar](250) NULL,
	[Reserved154] [varchar](250) NULL,
	[Reserved155] [varchar](250) NULL,
	[Reserved156] [varchar](250) NULL,
	[Reserved157] [varchar](250) NULL,
	[Reserved158] [varchar](250) NULL,
	[Reserved159] [varchar](250) NULL,
	[Reserved160] [varchar](250) NULL,
	[Reserved161] [varchar](250) NULL,
	[Reserved162] [varchar](250) NULL,
	[Reserved163] [varchar](250) NULL,
	[Reserved164] [varchar](250) NULL,
	[Reserved165] [varchar](250) NULL,
	[Reserved166] [varchar](250) NULL,
	[Reserved167] [varchar](250) NULL,
	[Reserved168] [varchar](250) NULL,
	[Reserved169] [varchar](250) NULL,
	[Reserved170] [varchar](250) NULL,
	[Reserved171] [varchar](250) NULL,
	[Reserved172] [varchar](250) NULL,
	[Reserved173] [varchar](250) NULL,
	[Reserved174] [varchar](250) NULL,
	[Reserved175] [varchar](250) NULL,
	[Reserved176] [varchar](250) NULL,
	[Reserved177] [varchar](250) NULL,
	[Reserved178] [varchar](250) NULL,
	[Reserved179] [varchar](250) NULL,
	[Reserved180] [varchar](250) NULL,
	[Reserved181] [varchar](250) NULL,
	[Reserved182] [varchar](250) NULL,
	[Reserved183] [varchar](250) NULL,
	[Reserved184] [varchar](250) NULL,
	[Reserved185] [varchar](250) NULL,
	[Reserved186] [varchar](250) NULL,
	[Reserved187] [varchar](250) NULL,
	[Reserved188] [varchar](250) NULL,
	[Reserved189] [varchar](250) NULL,
	[Reserved190] [varchar](250) NULL,
	[Reserved191] [varchar](250) NULL,
	[Reserved192] [varchar](250) NULL,
	[Reserved193] [varchar](250) NULL,
	[Reserved194] [varchar](250) NULL,
	[Reserved195] [varchar](250) NULL,
	[Reserved196] [varchar](250) NULL,
	[Reserved197] [varchar](250) NULL,
	[Reserved198] [varchar](250) NULL,
	[Reserved199] [varchar](250) NULL,
	[Reserved200] [varchar](250) NULL,
	[Reserved201] [varchar](250) NULL,
	[Reserved202] [varchar](250) NULL,
	[Reserved203] [varchar](250) NULL,
	[Reserved204] [varchar](250) NULL,
	[Reserved205] [varchar](250) NULL,
	[Reserved206] [varchar](250) NULL,
	[Reserved207] [varchar](250) NULL,
	[Reserved208] [varchar](250) NULL,
	[Reserved209] [varchar](250) NULL,
	[Reserved210] [varchar](250) NULL,
	[Reserved211] [varchar](250) NULL,
	[Reserved212] [varchar](250) NULL,
	[Reserved213] [varchar](250) NULL,
	[Reserved214] [varchar](250) NULL,
	[Reserved215] [varchar](250) NULL,
	[Reserved216] [varchar](250) NULL,
	[Reserved217] [varchar](250) NULL,
	[Reserved218] [varchar](250) NULL,
	[Reserved219] [varchar](250) NULL,
	[Reserved220] [varchar](250) NULL,
	[Reserved221] [varchar](250) NULL,
	[Reserved222] [varchar](250) NULL,
	[Reserved223] [varchar](250) NULL,
	[Reserved224] [varchar](250) NULL,
	[Reserved225] [varchar](250) NULL,
	[Reserved226] [varchar](250) NULL,
	[Reserved227] [varchar](250) NULL,
	[Reserved228] [varchar](250) NULL,
	[Reserved229] [varchar](250) NULL,
	[Reserved230] [varchar](250) NULL,
	[Reserved231] [varchar](250) NULL,
	[Reserved232] [varchar](250) NULL,
	[Reserved233] [varchar](250) NULL,
	[Reserved234] [varchar](250) NULL,
	[Reserved235] [varchar](250) NULL,
	[Reserved236] [varchar](250) NULL,
	[Reserved237] [varchar](250) NULL,
	[Reserved238] [varchar](250) NULL,
	[Reserved239] [varchar](250) NULL,
	[Reserved240] [varchar](250) NULL,
	[Reserved241] [varchar](250) NULL,
	[Reserved242] [varchar](250) NULL,
	[Reserved243] [varchar](250) NULL,
	[Reserved244] [varchar](250) NULL,
	[Reserved245] [varchar](250) NULL,
	[Reserved246] [varchar](250) NULL,
	[Reserved247] [varchar](250) NULL,
	[Reserved248] [varchar](250) NULL,
	[Reserved249] [varchar](250) NULL,
	[Reserved250] [varchar](250) NULL,
	[Reserved251] [varchar](250) NULL,
	[Reserved252] [varchar](250) NULL,
	[Reserved253] [varchar](250) NULL,
	[Reserved254] [varchar](250) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-185000]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-185000] ON [kelso].[brisnet_dr4]
(
	[RaceId] ASC,
	[TrackCd] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC,
	[HorseId] ASC,
	[HorseName] ASC,
	[PostPosition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_dr4_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_dr4_staging](
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[PostPosition] [varchar](25) NULL,
	[BRISPrimePowerRating] [varchar](25) NULL,
	[BRISDirtPedigreeRating] [varchar](5) NULL,
	[BRISMudPedigreeRating] [varchar](5) NULL,
	[BRISTurfPedigreeRating] [varchar](5) NULL,
	[BRISDistPedigreeRating] [varchar](5) NULL,
	[BestBRISSpeedLife] [varchar](25) NULL,
	[BestBRISSpeedMostRecentYr] [varchar](25) NULL,
	[BestBRISSpeedSecondMostRecentYr] [varchar](25) NULL,
	[BestBRISSpeedTrack] [varchar](25) NULL,
	[NumOfStartsFASTDirt] [varchar](25) NULL,
	[NumOfWinsFASTDirt] [varchar](25) NULL,
	[NumOfPlacesFASTDirt] [varchar](25) NULL,
	[NumOfShowsFASTDirt] [varchar](25) NULL,
	[NumOfEarningsFASTDirt] [varchar](25) NULL,
	[TrntStatCategory1] [varchar](250) NULL,
	[NumOfStarts1] [varchar](25) NULL,
	[WinPercentage1] [varchar](25) NULL,
	[InTheMoneyPercentage1] [varchar](25) NULL,
	[ReturnOfInvestment1] [varchar](25) NULL,
	[TrntStatCategory2] [varchar](250) NULL,
	[NumOfStarts2] [varchar](25) NULL,
	[WinPercentage2] [varchar](25) NULL,
	[InTheMoneyPercentage2] [varchar](25) NULL,
	[ReturnOfInvestment2] [varchar](25) NULL,
	[TrntStatCategory3] [varchar](250) NULL,
	[NumOfStarts3] [varchar](25) NULL,
	[WinPercentage3] [varchar](25) NULL,
	[InTheMoneyPercentage3] [varchar](25) NULL,
	[ReturnOfInvestment3] [varchar](25) NULL,
	[TrntStatCategory4] [varchar](250) NULL,
	[NumOfStarts4] [varchar](25) NULL,
	[WinPercentage4] [varchar](25) NULL,
	[InTheMoneyPercentage4] [varchar](25) NULL,
	[ReturnOfInvestment4] [varchar](25) NULL,
	[TrntStatCategory5] [varchar](250) NULL,
	[NumOfStarts5] [varchar](25) NULL,
	[WinPercentage5] [varchar](25) NULL,
	[InTheMoneyPercentage5] [varchar](25) NULL,
	[ReturnOfInvestment5] [varchar](25) NULL,
	[TrntStatCategory6] [varchar](250) NULL,
	[NumOfStarts6] [varchar](25) NULL,
	[WinPercentage6] [varchar](25) NULL,
	[InTheMoneyPercentage6] [varchar](25) NULL,
	[ReturnOfInvestment6] [varchar](25) NULL,
	[Reserved49] [varchar](50) NULL,
	[JKYDistanceTurfLabel] [varchar](20) NULL,
	[JKYDistanceTurfStarts] [varchar](25) NULL,
	[JKYDistanceTurfWins] [varchar](25) NULL,
	[JKYDistanceTurfPlaces] [varchar](25) NULL,
	[JKYDistanceTurfShows] [varchar](25) NULL,
	[JKYDistanceTurfROI] [varchar](25) NULL,
	[JKYDistanceTurfEarnings] [varchar](25) NULL,
	[Reserved57] [varchar](500) NULL,
	[Reserved58] [varchar](500) NULL,
	[Reserved59] [varchar](500) NULL,
	[Reserved60] [varchar](500) NULL,
	[Reserved61] [varchar](500) NULL,
	[Reserved62] [varchar](500) NULL,
	[Reserved63] [varchar](500) NULL,
	[Reserved64] [varchar](500) NULL,
	[Reserved65] [varchar](500) NULL,
	[Reserved66] [varchar](500) NULL,
	[Reserved67] [varchar](500) NULL,
	[Reserved68] [varchar](500) NULL,
	[Reserved69] [varchar](500) NULL,
	[Reserved70] [varchar](500) NULL,
	[Reserved71] [varchar](500) NULL,
	[Reserved72] [varchar](500) NULL,
	[Reserved73] [varchar](500) NULL,
	[Reserved74] [varchar](500) NULL,
	[Reserved75] [varchar](500) NULL,
	[Reserved76] [varchar](500) NULL,
	[Reserved77] [varchar](500) NULL,
	[Reserved78] [varchar](500) NULL,
	[Reserved79] [varchar](500) NULL,
	[Reserved80] [varchar](500) NULL,
	[Reserved81] [varchar](500) NULL,
	[Reserved82] [varchar](500) NULL,
	[Reserved83] [varchar](500) NULL,
	[Reserved84] [varchar](500) NULL,
	[Reserved85] [varchar](500) NULL,
	[Reserved86] [varchar](500) NULL,
	[Reserved87] [varchar](500) NULL,
	[Reserved88] [varchar](500) NULL,
	[Reserved89] [varchar](500) NULL,
	[Reserved90] [varchar](500) NULL,
	[Reserved91] [varchar](500) NULL,
	[Reserved92] [varchar](500) NULL,
	[Reserved93] [varchar](500) NULL,
	[Reserved94] [varchar](500) NULL,
	[Reserved95] [varchar](500) NULL,
	[Reserved96] [varchar](500) NULL,
	[Reserved97] [varchar](500) NULL,
	[Reserved98] [varchar](500) NULL,
	[Reserved99] [varchar](500) NULL,
	[Reserved100] [varchar](500) NULL,
	[Reserved101] [varchar](500) NULL,
	[Reserved102] [varchar](500) NULL,
	[Reserved103] [varchar](500) NULL,
	[Reserved104] [varchar](500) NULL,
	[Reserved105] [varchar](500) NULL,
	[Reserved106] [varchar](500) NULL,
	[Reserved107] [varchar](500) NULL,
	[Reserved108] [varchar](500) NULL,
	[Reserved109] [varchar](500) NULL,
	[Reserved110] [varchar](500) NULL,
	[Reserved111] [varchar](500) NULL,
	[Reserved112] [varchar](500) NULL,
	[Reserved113] [varchar](500) NULL,
	[Reserved114] [varchar](500) NULL,
	[Reserved115] [varchar](500) NULL,
	[Reserved116] [varchar](500) NULL,
	[Reserved117] [varchar](500) NULL,
	[Reserved118] [varchar](500) NULL,
	[Reserved119] [varchar](500) NULL,
	[Reserved120] [varchar](500) NULL,
	[Reserved121] [varchar](500) NULL,
	[Reserved122] [varchar](500) NULL,
	[Reserved123] [varchar](500) NULL,
	[Reserved124] [varchar](500) NULL,
	[Reserved125] [varchar](500) NULL,
	[Reserved126] [varchar](500) NULL,
	[Reserved127] [varchar](500) NULL,
	[Reserved128] [varchar](500) NULL,
	[Reserved129] [varchar](500) NULL,
	[Reserved130] [varchar](500) NULL,
	[Reserved131] [varchar](500) NULL,
	[Reserved132] [varchar](500) NULL,
	[Reserved133] [varchar](500) NULL,
	[Reserved134] [varchar](500) NULL,
	[Reserved135] [varchar](500) NULL,
	[Reserved136] [varchar](500) NULL,
	[Reserved137] [varchar](500) NULL,
	[Reserved138] [varchar](500) NULL,
	[Reserved139] [varchar](500) NULL,
	[Reserved140] [varchar](500) NULL,
	[Reserved141] [varchar](500) NULL,
	[Reserved142] [varchar](500) NULL,
	[Reserved143] [varchar](500) NULL,
	[Reserved144] [varchar](500) NULL,
	[Reserved145] [varchar](500) NULL,
	[Reserved146] [varchar](500) NULL,
	[Reserved147] [varchar](500) NULL,
	[Reserved148] [varchar](500) NULL,
	[Reserved149] [varchar](500) NULL,
	[Reserved150] [varchar](500) NULL,
	[Reserved151] [varchar](500) NULL,
	[Reserved152] [varchar](500) NULL,
	[Reserved153] [varchar](500) NULL,
	[Reserved154] [varchar](500) NULL,
	[Reserved155] [varchar](500) NULL,
	[Reserved156] [varchar](500) NULL,
	[Reserved157] [varchar](500) NULL,
	[Reserved158] [varchar](500) NULL,
	[Reserved159] [varchar](500) NULL,
	[Reserved160] [varchar](500) NULL,
	[Reserved161] [varchar](500) NULL,
	[Reserved162] [varchar](500) NULL,
	[Reserved163] [varchar](500) NULL,
	[Reserved164] [varchar](500) NULL,
	[Reserved165] [varchar](500) NULL,
	[Reserved166] [varchar](500) NULL,
	[Reserved167] [varchar](500) NULL,
	[Reserved168] [varchar](500) NULL,
	[Reserved169] [varchar](500) NULL,
	[Reserved170] [varchar](500) NULL,
	[Reserved171] [varchar](500) NULL,
	[Reserved172] [varchar](500) NULL,
	[Reserved173] [varchar](500) NULL,
	[Reserved174] [varchar](500) NULL,
	[Reserved175] [varchar](500) NULL,
	[Reserved176] [varchar](500) NULL,
	[Reserved177] [varchar](500) NULL,
	[Reserved178] [varchar](500) NULL,
	[Reserved179] [varchar](500) NULL,
	[Reserved180] [varchar](500) NULL,
	[Reserved181] [varchar](500) NULL,
	[Reserved182] [varchar](500) NULL,
	[Reserved183] [varchar](500) NULL,
	[Reserved184] [varchar](500) NULL,
	[Reserved185] [varchar](500) NULL,
	[Reserved186] [varchar](500) NULL,
	[Reserved187] [varchar](500) NULL,
	[Reserved188] [varchar](500) NULL,
	[Reserved189] [varchar](500) NULL,
	[Reserved190] [varchar](500) NULL,
	[Reserved191] [varchar](500) NULL,
	[Reserved192] [varchar](500) NULL,
	[Reserved193] [varchar](500) NULL,
	[Reserved194] [varchar](500) NULL,
	[Reserved195] [varchar](500) NULL,
	[Reserved196] [varchar](500) NULL,
	[Reserved197] [varchar](500) NULL,
	[Reserved198] [varchar](500) NULL,
	[Reserved199] [varchar](500) NULL,
	[Reserved200] [varchar](500) NULL,
	[Reserved201] [varchar](500) NULL,
	[Reserved202] [varchar](500) NULL,
	[Reserved203] [varchar](500) NULL,
	[Reserved204] [varchar](500) NULL,
	[Reserved205] [varchar](500) NULL,
	[Reserved206] [varchar](500) NULL,
	[Reserved207] [varchar](500) NULL,
	[Reserved208] [varchar](500) NULL,
	[Reserved209] [varchar](500) NULL,
	[Reserved210] [varchar](500) NULL,
	[Reserved211] [varchar](500) NULL,
	[Reserved212] [varchar](500) NULL,
	[Reserved213] [varchar](500) NULL,
	[Reserved214] [varchar](500) NULL,
	[Reserved215] [varchar](500) NULL,
	[Reserved216] [varchar](500) NULL,
	[Reserved217] [varchar](500) NULL,
	[Reserved218] [varchar](500) NULL,
	[Reserved219] [varchar](500) NULL,
	[Reserved220] [varchar](500) NULL,
	[Reserved221] [varchar](500) NULL,
	[Reserved222] [varchar](500) NULL,
	[Reserved223] [varchar](500) NULL,
	[Reserved224] [varchar](500) NULL,
	[Reserved225] [varchar](500) NULL,
	[Reserved226] [varchar](500) NULL,
	[Reserved227] [varchar](500) NULL,
	[Reserved228] [varchar](500) NULL,
	[Reserved229] [varchar](500) NULL,
	[Reserved230] [varchar](500) NULL,
	[Reserved231] [varchar](500) NULL,
	[Reserved232] [varchar](500) NULL,
	[Reserved233] [varchar](500) NULL,
	[Reserved234] [varchar](500) NULL,
	[Reserved235] [varchar](500) NULL,
	[Reserved236] [varchar](500) NULL,
	[Reserved237] [varchar](500) NULL,
	[Reserved238] [varchar](500) NULL,
	[Reserved239] [varchar](500) NULL,
	[Reserved240] [varchar](500) NULL,
	[Reserved241] [varchar](500) NULL,
	[Reserved242] [varchar](500) NULL,
	[Reserved243] [varchar](500) NULL,
	[Reserved244] [varchar](500) NULL,
	[Reserved245] [varchar](500) NULL,
	[Reserved246] [varchar](500) NULL,
	[Reserved247] [varchar](500) NULL,
	[Reserved248] [varchar](500) NULL,
	[Reserved249] [varchar](500) NULL,
	[Reserved250] [varchar](500) NULL,
	[Reserved251] [varchar](500) NULL,
	[Reserved252] [varchar](500) NULL,
	[Reserved253] [varchar](500) NULL,
	[Reserved254] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_drf]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_drf](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[FileId] [uniqueidentifier] NOT NULL,
	[RaceId] [uniqueidentifier] NOT NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NOT NULL,
	[RaceNum] [int] NULL,
	[Distance] [decimal](18, 0) NULL,
	[Surface] [char](1) NULL,
	[AllWeatherSurfaceFlag] [char](1) NULL,
	[RaceType] [varchar](5) NULL,
	[AgeSexRestrictions] [varchar](5) NULL,
	[Reserved9] [varchar](50) NULL,
	[Purse] [decimal](18, 0) NULL,
	[ClaimingPrice] [decimal](18, 0) NULL,
	[TrackRecord] [decimal](18, 0) NULL,
	[RaceConditions] [varchar](500) NULL,
	[LasixList] [varchar](500) NULL,
	[ButeList] [varchar](500) NULL,
	[CoupledList] [varchar](500) NULL,
	[MutuelList] [varchar](500) NULL,
	[SimulcastTrackCd] [varchar](3) NULL,
	[SimulcastTrackRaceNum] [varchar](50) NULL,
	[Reserved20] [varchar](500) NULL,
	[Reserved21] [varchar](500) NULL,
	[Reserved22] [varchar](500) NULL,
	[PostTimes] [varchar](50) NULL,
	[Reserved24] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-185039]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-185039] ON [kelso].[brisnet_drf]
(
	[FileId] ASC,
	[RaceId] ASC,
	[TrackCd] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_drf_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_drf_staging](
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[Distance] [varchar](25) NULL,
	[Surface] [char](1) NULL,
	[AllWeatherSurfaceFlag] [char](1) NULL,
	[RaceType] [varchar](5) NULL,
	[AgeSexRestrictions] [varchar](5) NULL,
	[Reserved9] [varchar](50) NULL,
	[Purse] [varchar](25) NULL,
	[ClaimingPrice] [varchar](25) NULL,
	[TrackRecord] [varchar](25) NULL,
	[RaceConditions] [varchar](500) NULL,
	[LasixList] [varchar](500) NULL,
	[ButeList] [varchar](500) NULL,
	[CoupledList] [varchar](500) NULL,
	[MutuelList] [varchar](500) NULL,
	[SimulcastTrackCd] [varchar](3) NULL,
	[SimulcastTrackRaceNum] [varchar](10) NULL,
	[Reserved20] [varchar](500) NULL,
	[Reserved21] [varchar](500) NULL,
	[Reserved22] [varchar](500) NULL,
	[PostTimes] [varchar](50) NULL,
	[Reserved24] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_Files]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_Files](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[FileId] [uniqueidentifier] NOT NULL,
	[FileName] [varchar](100) NOT NULL,
	[RaceDt] [datetime] NOT NULL,
	[TrackCd] [varchar](10) NOT NULL,
	[TrackName] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[FileProcess] [bit] NULL,
	[FileProcessDate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-185102]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-185102] ON [kelso].[brisnet_Files]
(
	[FileId] ASC,
	[FileName] ASC,
	[RaceDt] ASC,
	[TrackCd] ASC,
	[TrackName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_Horses]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_Horses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[RaceDt] [datetime] NULL,
	[HorseId] [uniqueidentifier] NOT NULL,
	[HorseName] [varchar](100) NOT NULL,
	[Sex] [char](1) NULL,
	[YearOfBirth] [int] NULL,
	[HorseFoalingMonth] [int] NULL,
	[Weight] [int] NULL,
	[Sire] [varchar](50) NULL,
	[SireSire] [varchar](50) NULL,
	[Dam] [varchar](150) NULL,
	[DamSire] [varchar](150) NULL,
	[Breeder] [varchar](150) NULL,
	[StateCountry] [varchar](25) NULL,
	[LifeTimeRecordTodayDistanceStarts] [int] NULL,
	[LifeTimeRecordTodayDistanceWins] [int] NULL,
	[LifeTimeRecordTodayDistancePlaces] [int] NULL,
	[LifeTimeRecordTodayDistanceShows] [int] NULL,
	[LifeTimeRecordTodayDistanceEarning] [decimal](18, 2) NULL,
	[LifeTimeRecordTodayTrackStarts] [int] NULL,
	[LifeTimeRecordTodayTrackWins] [int] NULL,
	[LifeTimeRecordTodayTrackPlaces] [int] NULL,
	[LifeTimeRecordTodayTrackShows] [int] NULL,
	[LifeTimeRecordTodayTrackEarning] [decimal](18, 2) NULL,
	[LifeTimeTurfRecordStarts] [int] NULL,
	[LifeTimeTurfRecordWins] [int] NULL,
	[LifeTimeTurfRecordPlaces] [int] NULL,
	[LifeTimeTurfRecordShows] [int] NULL,
	[LifeTimeTurfRecordEarning] [decimal](18, 2) NULL,
	[LifeTimeWetRecordStarts] [int] NULL,
	[LifeTimeWetRecordWins] [int] NULL,
	[LifeTimeWetRecordPlaces] [int] NULL,
	[LifeTimeWetRecordShows] [int] NULL,
	[LifeTimeWetRecordEarning] [decimal](18, 2) NULL,
	[CurrentRecordYear] [int] NULL,
	[CurrentRecordStarts] [int] NULL,
	[CurrentRecordWins] [int] NULL,
	[CurrentRecordPlaces] [int] NULL,
	[CurrentRecordShows] [int] NULL,
	[CurrentRecordEarning] [decimal](18, 2) NULL,
	[PreviousRecordYear] [int] NULL,
	[PreviousRecordStarts] [int] NULL,
	[PreviousRecordWins] [int] NULL,
	[PreviousRecordPlaces] [int] NULL,
	[PreviousRecordShows] [int] NULL,
	[PreviousRecordEarning] [decimal](18, 2) NULL,
	[LifetimeRecordStarts] [int] NULL,
	[LifetimeRecordWins] [int] NULL,
	[LifetimeRecordPlaces] [int] NULL,
	[LifetimeRecordShows] [int] NULL,
	[LifetimeRecordEarning] [decimal](18, 2) NULL,
	[LifetimeStartsAllWeather] [int] NULL,
	[LifetimeWinsAllWeather] [int] NULL,
	[LifetimePlacesAllWeather] [int] NULL,
	[LifetimeShowsAllWeather] [int] NULL,
	[LifetimeEarningsAllWeather] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-184639]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-184639] ON [kelso].[brisnet_Horses]
(
	[RaceDt] ASC,
	[HorseId] ASC,
	[HorseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_HorseStatisticalAnalysisHistory]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_HorseStatisticalAnalysisHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[RaceId] [uniqueidentifier] NOT NULL,
	[RaceDt] [datetime] NOT NULL,
	[HorseId] [uniqueidentifier] NOT NULL,
	[HorseName] [varchar](75) NOT NULL,
	[TrackCd] [varchar](10) NULL,
	[BrisRunStyle] [varchar](5) NULL,
	[QuirinSpeedPoints] [int] NULL,
	[Bris2fPaceFig] [int] NULL,
	[Bris4fPaceFig] [int] NULL,
	[Bris6fPaceFig] [int] NULL,
	[BrisLatePace] [int] NULL,
	[BestBRISSpeedAllWeather] [int] NULL,
	[BestBRISSpeedDistance] [int] NULL,
	[BestBRISSpeedFastTrack] [int] NULL,
	[BestBRISSpeedOffTrack] [int] NULL,
	[BestBRISSpeedTurf] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-185159]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-185159] ON [kelso].[brisnet_HorseStatisticalAnalysisHistory]
(
	[RaceId] ASC,
	[RaceDt] ASC,
	[HorseId] ASC,
	[HorseName] ASC,
	[TrackCd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_Jockeys]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_Jockeys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedDt] [datetime] NULL,
	[RaceDt] [datetime] NULL,
	[JockeyId] [uniqueidentifier] NOT NULL,
	[Jockey] [varchar](100) NOT NULL,
	[JockeyStartsCurrentMeet] [int] NULL,
	[JockeyWinCurrentMeet] [int] NULL,
	[JockeyPlacesCurrentMeet] [int] NULL,
	[JockeyShowCurrentMeet] [int] NULL,
	[JockeyRecordCurrentYear] [varchar](30) NULL,
	[JockeyStartCurrentYear] [int] NULL,
	[JockeyPercentWinCurrentYear] [int] NULL,
	[JockeyPercentPlaceCurrentYear] [int] NULL,
	[JockeyPercentShowCurrentYear] [int] NULL,
	[JockeyPercentROICurrentYear] [decimal](18, 2) NULL,
	[JockeyRecordPreviousYear] [varchar](30) NULL,
	[JockeyStartPreviousYear] [int] NULL,
	[JockeyWinPreviousYear] [int] NULL,
	[JockeyPlacePreviousYear] [int] NULL,
	[JockeyShowPreviousYear] [int] NULL,
	[JockeyPercentROIPreviousYear] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-184805]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-184805] ON [kelso].[brisnet_Jockeys]
(
	[RaceDt] ASC,
	[JockeyId] ASC,
	[Jockey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_RaceClassification]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_RaceClassification](
	[ClassificationType] [varchar](5) NULL,
	[ClassificationDesc] [varchar](50) NULL,
	[ClassificationRating] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_RaceParticipants]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_RaceParticipants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[RaceId] [uniqueidentifier] NOT NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[Furlong] [decimal](18, 2) NULL,
	[DistanceYard] [decimal](18, 2) NULL,
	[DistanceFeet] [decimal](18, 2) NULL,
	[Surface] [varchar](10) NULL,
	[PostPosition] [varchar](5) NULL,
	[HorseId] [uniqueidentifier] NOT NULL,
	[HorseName] [varchar](100) NULL,
	[JockeyId] [uniqueidentifier] NOT NULL,
	[Jockey] [varchar](100) NULL,
	[JockeyStartsCurrentMeet] [int] NULL,
	[JockeyWinCurrentMeet] [int] NULL,
	[JockeyPlacesCurrentMeet] [int] NULL,
	[JockeyShowCurrentMeet] [int] NULL,
	[JockeyRecordCurrentYear] [varchar](30) NULL,
	[JockeyStartCurrentYear] [int] NULL,
	[JockeyWinCurrentYear] [int] NULL,
	[JockeyPlaceCurrentYear] [int] NULL,
	[JockeyShowCurrentYear] [int] NULL,
	[JockeyROICurrentYear] [decimal](18, 2) NULL,
	[JockeyRecordPreviousYear] [varchar](30) NULL,
	[JockeyStartPreviousYear] [int] NULL,
	[JockeyWinPreviousYear] [int] NULL,
	[JockeyPlacePreviousYear] [int] NULL,
	[JockeyShowPreviousYear] [int] NULL,
	[JockeyROIPreviousYear] [decimal](18, 2) NULL,
	[TrainerId] [uniqueidentifier] NOT NULL,
	[Trainer] [varchar](100) NULL,
	[TrainerStartsCurrentMeet] [int] NULL,
	[TrainerWinCurrentMeet] [int] NULL,
	[TrainerPlacesCurrentMeet] [int] NULL,
	[TrainerShowCurrentMeet] [int] NULL,
	[TrainerRecordCurrentYear] [varchar](30) NULL,
	[TrainerStartCurrentYear] [int] NULL,
	[TrainerWinCurrentYear] [int] NULL,
	[TrainerPlaceCurrentYear] [int] NULL,
	[TrainerShowCurrentYear] [int] NULL,
	[TrainerROICurrentYear] [decimal](18, 2) NULL,
	[TrainerRecordPreviousYear] [varchar](30) NULL,
	[TrainerStartPreviousYear] [int] NULL,
	[TrainerWinPreviousYear] [int] NULL,
	[TrainerPlacePreviousYear] [int] NULL,
	[TrainerShowPreviousYear] [int] NULL,
	[TrainerROIPreviousYear] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_Races]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_Races](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedDt] [datetime] NOT NULL,
	[FileId] [uniqueidentifier] NOT NULL,
	[RaceId] [uniqueidentifier] NOT NULL,
	[TrackCd] [varchar](10) NOT NULL,
	[TrackName] [varchar](50) NOT NULL,
	[RaceDt] [datetime] NOT NULL,
	[RaceNum] [int] NULL,
	[Furlong] [decimal](18, 2) NULL,
	[DistanceYard] [decimal](18, 2) NULL,
	[DistanceFeet] [decimal](18, 2) NULL,
	[Surface] [varchar](10) NULL,
	[RaceType] [varchar](10) NULL,
	[Purse] [decimal](18, 0) NULL,
	[ClaimingPrice] [decimal](18, 0) NULL,
	[TrackRecord] [decimal](18, 0) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-184827]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-184827] ON [kelso].[brisnet_Races]
(
	[FileId] ASC,
	[RaceId] ASC,
	[TrackCd] ASC,
	[TrackName] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_Tracks]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_Tracks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TrackCd] [varchar](10) NOT NULL,
	[State] [varchar](50) NULL,
	[TrackName] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_Trainers]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_Trainers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedDt] [datetime] NULL,
	[RaceDt] [datetime] NOT NULL,
	[TrainerId] [uniqueidentifier] NOT NULL,
	[Trainer] [varchar](100) NOT NULL,
	[TrainerStartsCurrentMeet] [int] NULL,
	[TrainerWinCurrentMeet] [int] NULL,
	[TrainerPlacesCurrentMeet] [int] NULL,
	[TrainerShowCurrentMeet] [int] NULL,
	[TrainerRecordCurrentYear] [varchar](30) NULL,
	[TrainerStartCurrentYear] [int] NULL,
	[TrainerPercentWinCurrentYear] [int] NULL,
	[TrainerPercentPlaceCurrentYear] [int] NULL,
	[TrainerPercentShowCurrentYear] [int] NULL,
	[TrainerPercentROICurrentYear] [decimal](18, 2) NULL,
	[TrainerRecordPreviousYear] [varchar](30) NULL,
	[TrainerStartPreviousYear] [int] NULL,
	[TrainerWinPreviousYear] [int] NULL,
	[TrainerPlacePreviousYear] [int] NULL,
	[TrainerShowPreviousYear] [int] NULL,
	[TrainerPercentROIPreviousYear] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_TrntStat]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_TrntStat](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RaceId] [uniqueidentifier] NULL,
	[CreateDt] [datetime] NOT NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[HorseId] [uniqueidentifier] NULL,
	[HorseName] [varchar](75) NULL,
	[TrntStatCategory] [varchar](20) NULL,
	[NumOfStarts] [int] NULL,
	[WinPercentage] [decimal](18, 2) NULL,
	[InTheMoneyPercentage] [decimal](18, 2) NULL,
	[ReturnOfInvestment] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220125-185300]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220125-185300] ON [kelso].[brisnet_TrntStat]
(
	[RaceId] ASC,
	[TrackCd] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC,
	[HorseId] ASC,
	[HorseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_xrd]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_xrd](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RaceId] [uniqueidentifier] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[ReservedString1] [varchar](250) NULL,
	[Surface] [varchar](1) NULL,
	[ReservedString2] [varchar](250) NULL,
	[ReservedString3] [varchar](250) NULL,
	[ReservedString4] [varchar](250) NULL,
	[ReservedString5] [varchar](250) NULL,
	[ReservedString6] [varchar](250) NULL,
	[ReservedString7] [varchar](250) NULL,
	[ReservedString8] [varchar](250) NULL,
	[ReservedString9] [varchar](250) NULL,
	[ReservedString10] [varchar](250) NULL,
	[ReservedString11] [varchar](250) NULL,
	[FinalTime] [decimal](18, 2) NULL,
	[TrackCondition] [varchar](2) NULL,
	[PostPosition] [int] NULL,
	[EntryFlag] [varchar](250) NULL,
	[HorseId] [uniqueidentifier] NULL,
	[HorseName] [varchar](100) NULL,
	[ReservedString12] [varchar](250) NULL,
	[ReservedString13] [varchar](250) NULL,
	[ReservedString14] [varchar](250) NULL,
	[ReservedString15] [varchar](250) NULL,
	[ReservedString16] [varchar](250) NULL,
	[ReservedString17] [varchar](250) NULL,
	[ReservedString18] [varchar](250) NULL,
	[ReservedString19] [varchar](250) NULL,
	[ReservedString20] [varchar](250) NULL,
	[FinishPosition] [int] NULL,
	[ReservedString21] [varchar](250) NULL,
	[WagerType10] [varchar](50) NULL,
	[WagerType11] [varchar](50) NULL,
	[WagerType12] [varchar](50) NULL,
	[WagerType13] [varchar](50) NULL,
	[WagerType14] [varchar](50) NULL,
	[HorseOdd] [decimal](18, 2) NULL,
	[ReservedString22] [varchar](250) NULL,
	[ReservedString23] [varchar](250) NULL,
	[ReservedString24] [varchar](250) NULL,
	[ReservedString25] [varchar](250) NULL,
	[ReservedString26] [varchar](250) NULL,
	[ReservedString27] [varchar](250) NULL,
	[ReservedString28] [varchar](250) NULL,
	[ReservedString29] [varchar](250) NULL,
	[ReservedString30] [varchar](250) NULL,
	[ReservedString31] [varchar](250) NULL,
	[starter_field_size] [int] NULL,
	[official_finish_position] [int] NULL,
	[official_program_num] [varchar](3) NULL,
	[ReservedString32] [varchar](250) NULL,
	[ReservedString33] [varchar](250) NULL,
	[ReservedString34] [varchar](250) NULL,
	[ReservedString35] [varchar](250) NULL,
	[WinningNums10] [varchar](50) NULL,
	[WinningNums11] [varchar](50) NULL,
	[WinningNums12] [varchar](50) NULL,
	[WinningNums13] [varchar](50) NULL,
	[WinningNums14] [varchar](50) NULL,
	[TwoDollarsPayoff10] [decimal](18, 2) NULL,
	[TwoDollarsPayoff11] [decimal](18, 2) NULL,
	[TwoDollarsPayoff12] [decimal](18, 2) NULL,
	[TwoDollarsPayoff13] [decimal](18, 2) NULL,
	[TwoDollarsPayoff14] [decimal](18, 2) NULL,
	[Pool10] [decimal](18, 2) NULL,
	[Pool11] [decimal](18, 2) NULL,
	[Pool12] [decimal](18, 2) NULL,
	[Pool13] [decimal](18, 2) NULL,
	[Pool14] [decimal](18, 2) NULL,
	[BetAmt10] [decimal](18, 2) NULL,
	[BetAmt11] [decimal](18, 2) NULL,
	[BetAmt12] [decimal](18, 2) NULL,
	[BetAmt13] [decimal](18, 2) NULL,
	[BetAmt14] [decimal](18, 2) NULL,
	[TwoDollarsWinPayOff] [decimal](18, 2) NULL,
	[TwoDollarsPlacePayOff] [decimal](18, 2) NULL,
	[TwoDollarsShowPayOff] [decimal](18, 2) NULL,
	[WagerType1] [varchar](50) NULL,
	[WagerType2] [varchar](50) NULL,
	[WagerType3] [varchar](50) NULL,
	[WagerType4] [varchar](50) NULL,
	[WagerType5] [varchar](50) NULL,
	[WagerType6] [varchar](50) NULL,
	[WagerType7] [varchar](50) NULL,
	[WagerType8] [varchar](50) NULL,
	[WagerType9] [varchar](50) NULL,
	[WinningNums1] [varchar](50) NULL,
	[WinningNums2] [varchar](50) NULL,
	[WinningNums3] [varchar](50) NULL,
	[WinningNums4] [varchar](50) NULL,
	[WinningNums5] [varchar](50) NULL,
	[WinningNums6] [varchar](50) NULL,
	[WinningNums7] [varchar](50) NULL,
	[WinningNums8] [varchar](50) NULL,
	[WinningNums9] [varchar](50) NULL,
	[TwoDollarsPayoff1] [decimal](18, 2) NULL,
	[TwoDollarsPayoff2] [decimal](18, 2) NULL,
	[TwoDollarsPayoff3] [decimal](18, 2) NULL,
	[TwoDollarsPayoff4] [decimal](18, 2) NULL,
	[TwoDollarsPayoff5] [decimal](18, 2) NULL,
	[TwoDollarsPayoff6] [decimal](18, 2) NULL,
	[TwoDollarsPayoff7] [decimal](18, 2) NULL,
	[TwoDollarsPayoff8] [decimal](18, 2) NULL,
	[TwoDollarsPayoff9] [decimal](18, 2) NULL,
	[Pool1] [decimal](18, 2) NULL,
	[Pool2] [decimal](18, 2) NULL,
	[Pool3] [decimal](18, 2) NULL,
	[Pool4] [decimal](18, 2) NULL,
	[Pool5] [decimal](18, 2) NULL,
	[Pool6] [decimal](18, 2) NULL,
	[Pool7] [decimal](18, 2) NULL,
	[Pool8] [decimal](18, 2) NULL,
	[Pool9] [decimal](18, 2) NULL,
	[BetAmt1] [decimal](18, 2) NULL,
	[BetAmt2] [decimal](18, 2) NULL,
	[BetAmt3] [decimal](18, 2) NULL,
	[BetAmt4] [decimal](18, 2) NULL,
	[BetAmt5] [decimal](18, 2) NULL,
	[BetAmt6] [decimal](18, 2) NULL,
	[BetAmt7] [decimal](18, 2) NULL,
	[BetAmt8] [decimal](18, 2) NULL,
	[BetAmt9] [decimal](18, 2) NULL,
	[ReservedString36] [varchar](250) NULL,
	[ReservedString37] [varchar](250) NULL,
	[ReservedString38] [varchar](250) NULL,
	[ReservedString39] [varchar](250) NULL,
	[ReservedString40] [varchar](250) NULL,
	[ReservedString41] [varchar](250) NULL,
	[ReservedString42] [varchar](250) NULL,
	[ReservedString43] [varchar](250) NULL,
	[ReservedString44] [varchar](250) NULL,
	[ReservedString45] [varchar](250) NULL,
	[ReservedString46] [varchar](250) NULL,
	[ReservedString47] [varchar](250) NULL,
	[ReservedString48] [varchar](250) NULL,
	[ReservedString49] [varchar](250) NULL,
	[ReservedString50] [varchar](250) NULL,
	[ReservedString51] [varchar](250) NULL,
	[ReservedString52] [varchar](250) NULL,
	[ReservedString53] [varchar](250) NULL,
	[ReservedString54] [varchar](250) NULL,
	[ReservedString55] [varchar](250) NULL,
	[ReservedString56] [varchar](250) NULL,
	[ReservedString57] [varchar](250) NULL,
	[ReservedString58] [varchar](250) NULL,
	[ReservedString59] [varchar](250) NULL,
	[ReservedString60] [varchar](250) NULL,
	[ReservedString61] [varchar](250) NULL,
	[ReservedString62] [varchar](250) NULL,
	[ReservedString63] [varchar](250) NULL,
	[ReservedString64] [varchar](250) NULL,
	[ReservedString65] [varchar](250) NULL,
	[ReservedString66] [varchar](250) NULL,
	[ReservedString67] [varchar](250) NULL,
	[ReservedString68] [varchar](250) NULL,
	[ReservedString69] [varchar](250) NULL,
	[ReservedString70] [varchar](250) NULL,
	[ReservedString71] [varchar](250) NULL,
	[ReservedString72] [varchar](250) NULL,
	[ReservedString73] [varchar](250) NULL,
	[ReservedString74] [varchar](250) NULL,
	[ReservedString75] [varchar](250) NULL,
	[ReservedString76] [varchar](250) NULL,
	[ReservedString77] [varchar](250) NULL,
	[ReservedString78] [varchar](250) NULL,
	[ReservedString79] [varchar](250) NULL,
	[ReservedString80] [varchar](250) NULL,
	[ReservedString81] [varchar](250) NULL,
	[ReservedString82] [varchar](250) NULL,
	[ReservedString83] [varchar](250) NULL,
	[ReservedString84] [varchar](250) NULL,
	[ReservedString85] [varchar](250) NULL,
	[ReservedString86] [varchar](250) NULL,
	[ReservedString87] [varchar](250) NULL,
	[ReservedString88] [varchar](250) NULL,
	[ReservedString89] [varchar](250) NULL,
	[ReservedString90] [varchar](250) NULL,
	[ReservedString91] [varchar](250) NULL,
	[ReservedString92] [varchar](250) NULL,
	[ReservedString93] [varchar](250) NULL,
	[ReservedString94] [varchar](250) NULL,
	[ReservedString95] [varchar](250) NULL,
	[ReservedString96] [varchar](250) NULL,
	[ReservedString97] [varchar](250) NULL,
	[ReservedString98] [varchar](250) NULL,
	[ReservedString99] [varchar](250) NULL,
	[ReservedString100] [varchar](250) NULL,
	[ReservedString101] [varchar](250) NULL,
	[ReservedString102] [varchar](250) NULL,
	[ReservedString103] [varchar](250) NULL,
	[ReservedString104] [varchar](250) NULL,
	[ReservedString105] [varchar](250) NULL,
	[ReservedString106] [varchar](250) NULL,
	[ReservedString107] [varchar](250) NULL,
	[ReservedString108] [varchar](250) NULL,
	[ReservedString109] [varchar](250) NULL,
	[ReservedString110] [varchar](250) NULL,
	[ReservedString111] [varchar](250) NULL,
	[ReservedString112] [varchar](250) NULL,
	[ReservedString113] [varchar](250) NULL,
	[ReservedString114] [varchar](250) NULL,
	[ReservedString115] [varchar](250) NULL,
	[ReservedString116] [varchar](250) NULL,
	[ReservedString117] [varchar](250) NULL,
	[ReservedString118] [varchar](250) NULL,
	[ReservedString119] [varchar](250) NULL,
	[ReservedString120] [varchar](250) NULL,
	[ReservedString121] [varchar](250) NULL,
	[ReservedString122] [varchar](250) NULL,
	[ReservedString123] [varchar](250) NULL,
	[ReservedString124] [varchar](250) NULL,
	[ReservedString125] [varchar](250) NULL,
	[ReservedString126] [varchar](250) NULL,
	[ReservedString127] [varchar](250) NULL,
	[ReservedString128] [varchar](250) NULL,
	[ReservedString129] [varchar](250) NULL,
	[ReservedString130] [varchar](250) NULL,
	[ReservedString131] [varchar](250) NULL,
	[ReservedString132] [varchar](250) NULL,
	[ReservedString133] [varchar](250) NULL,
	[ReservedString134] [varchar](250) NULL,
	[ReservedString135] [varchar](250) NULL,
	[ReservedString136] [varchar](250) NULL,
	[ReservedString137] [varchar](250) NULL,
	[ReservedString138] [varchar](250) NULL,
	[ReservedString139] [varchar](250) NULL,
	[ReservedString140] [varchar](250) NULL,
	[ReservedString141] [varchar](250) NULL,
	[ReservedString142] [varchar](250) NULL,
	[ReservedString143] [varchar](250) NULL,
	[ReservedString144] [varchar](250) NULL,
	[ReservedString145] [varchar](250) NULL,
	[ReservedString146] [varchar](250) NULL,
	[ReservedString147] [varchar](250) NULL,
	[ReservedString148] [varchar](250) NULL,
	[ReservedString149] [varchar](250) NULL,
	[ReservedString150] [varchar](250) NULL,
	[ReservedString151] [varchar](250) NULL,
	[ReservedString152] [varchar](250) NULL,
	[ReservedString153] [varchar](250) NULL,
	[ReservedString154] [varchar](250) NULL,
	[ReservedString155] [varchar](250) NULL,
	[ReservedString156] [varchar](250) NULL,
	[ReservedString157] [varchar](250) NULL,
	[ReservedString158] [varchar](250) NULL,
	[ReservedString159] [varchar](250) NULL,
	[ReservedString160] [varchar](250) NULL,
	[ReservedString161] [varchar](250) NULL,
	[ReservedString162] [varchar](250) NULL,
	[ReservedString163] [varchar](250) NULL,
	[ReservedString164] [varchar](250) NULL,
	[ReservedString165] [varchar](250) NULL,
	[ReservedString166] [varchar](250) NULL,
	[ReservedString167] [varchar](250) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20220307-094000]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20220307-094000] ON [kelso].[brisnet_xrd]
(
	[RaceId] ASC,
	[TrackCd] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC,
	[Surface] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[brisnet_xrd_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[brisnet_xrd_staging](
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [varchar](10) NULL,
	[RaceNum] [int] NULL,
	[ReservedString1] [varchar](250) NULL,
	[Surface] [varchar](1) NULL,
	[ReservedString2] [varchar](250) NULL,
	[ReservedString3] [varchar](250) NULL,
	[ReservedString4] [varchar](250) NULL,
	[ReservedString5] [varchar](250) NULL,
	[ReservedString6] [varchar](250) NULL,
	[ReservedString7] [varchar](250) NULL,
	[ReservedString8] [varchar](250) NULL,
	[ReservedString9] [varchar](250) NULL,
	[ReservedString10] [varchar](250) NULL,
	[ReservedString11] [varchar](250) NULL,
	[FinalTime] [decimal](18, 2) NULL,
	[TrackCondition] [varchar](2) NULL,
	[PostPosition] [int] NULL,
	[EntryFlag] [varchar](250) NULL,
	[HorseName] [varchar](100) NULL,
	[ReservedString12] [varchar](250) NULL,
	[ReservedString13] [varchar](250) NULL,
	[ReservedString14] [varchar](250) NULL,
	[ReservedString15] [varchar](250) NULL,
	[ReservedString16] [varchar](250) NULL,
	[ReservedString17] [varchar](250) NULL,
	[ReservedString18] [varchar](250) NULL,
	[ReservedString19] [varchar](250) NULL,
	[ReservedString20] [varchar](250) NULL,
	[FinishPosition] [int] NULL,
	[ReservedString21] [varchar](250) NULL,
	[WagerType10] [varchar](50) NULL,
	[WagerType11] [varchar](50) NULL,
	[WagerType12] [varchar](50) NULL,
	[WagerType13] [varchar](50) NULL,
	[WagerType14] [varchar](50) NULL,
	[HorseOdd] [decimal](18, 2) NULL,
	[ReservedString22] [varchar](250) NULL,
	[ReservedString23] [varchar](250) NULL,
	[ReservedString24] [varchar](250) NULL,
	[ReservedString25] [varchar](250) NULL,
	[ReservedString26] [varchar](250) NULL,
	[ReservedString27] [varchar](250) NULL,
	[ReservedString28] [varchar](250) NULL,
	[ReservedString29] [varchar](250) NULL,
	[ReservedString30] [varchar](250) NULL,
	[ReservedString31] [varchar](250) NULL,
	[starter_field_size] [int] NULL,
	[official_finish_position] [int] NULL,
	[official_program_num] [varchar](3) NULL,
	[ReservedString32] [varchar](250) NULL,
	[ReservedString33] [varchar](250) NULL,
	[ReservedString34] [varchar](250) NULL,
	[ReservedString35] [varchar](250) NULL,
	[WinningNums10] [varchar](50) NULL,
	[WinningNums11] [varchar](50) NULL,
	[WinningNums12] [varchar](50) NULL,
	[WinningNums13] [varchar](50) NULL,
	[WinningNums14] [varchar](50) NULL,
	[TwoDollarsPayoff10] [varchar](50) NULL,
	[TwoDollarsPayoff11] [varchar](50) NULL,
	[TwoDollarsPayoff12] [varchar](50) NULL,
	[TwoDollarsPayoff13] [varchar](50) NULL,
	[TwoDollarsPayoff14] [varchar](50) NULL,
	[Pool10] [varchar](50) NULL,
	[Pool11] [varchar](50) NULL,
	[Pool12] [varchar](50) NULL,
	[Pool13] [varchar](50) NULL,
	[Pool14] [varchar](50) NULL,
	[BetAmt10] [varchar](50) NULL,
	[BetAmt11] [varchar](50) NULL,
	[BetAmt12] [varchar](50) NULL,
	[BetAmt13] [varchar](50) NULL,
	[BetAmt14] [varchar](50) NULL,
	[TwoDollarsWinPayOff] [varchar](50) NULL,
	[TwoDollarsPlacePayOff] [varchar](50) NULL,
	[TwoDollarsShowPayOff] [varchar](50) NULL,
	[WagerType1] [varchar](50) NULL,
	[WagerType2] [varchar](50) NULL,
	[WagerType3] [varchar](50) NULL,
	[WagerType4] [varchar](50) NULL,
	[WagerType5] [varchar](50) NULL,
	[WagerType6] [varchar](50) NULL,
	[WagerType7] [varchar](50) NULL,
	[WagerType8] [varchar](50) NULL,
	[WagerType9] [varchar](50) NULL,
	[WinningNums1] [varchar](50) NULL,
	[WinningNums2] [varchar](50) NULL,
	[WinningNums3] [varchar](50) NULL,
	[WinningNums4] [varchar](50) NULL,
	[WinningNums5] [varchar](50) NULL,
	[WinningNums6] [varchar](50) NULL,
	[WinningNums7] [varchar](50) NULL,
	[WinningNums8] [varchar](50) NULL,
	[WinningNums9] [varchar](50) NULL,
	[TwoDollarsPayoff1] [varchar](50) NULL,
	[TwoDollarsPayoff2] [varchar](50) NULL,
	[TwoDollarsPayoff3] [varchar](50) NULL,
	[TwoDollarsPayoff4] [varchar](50) NULL,
	[TwoDollarsPayoff5] [varchar](50) NULL,
	[TwoDollarsPayoff6] [varchar](50) NULL,
	[TwoDollarsPayoff7] [varchar](50) NULL,
	[TwoDollarsPayoff8] [varchar](50) NULL,
	[TwoDollarsPayoff9] [varchar](50) NULL,
	[Pool1] [varchar](50) NULL,
	[Pool2] [varchar](50) NULL,
	[Pool3] [varchar](50) NULL,
	[Pool4] [varchar](50) NULL,
	[Pool5] [varchar](50) NULL,
	[Pool6] [varchar](50) NULL,
	[Pool7] [varchar](50) NULL,
	[Pool8] [varchar](50) NULL,
	[Pool9] [varchar](50) NULL,
	[BetAmt1] [varchar](50) NULL,
	[BetAmt2] [varchar](50) NULL,
	[BetAmt3] [varchar](50) NULL,
	[BetAmt4] [varchar](50) NULL,
	[BetAmt5] [varchar](50) NULL,
	[BetAmt6] [varchar](50) NULL,
	[BetAmt7] [varchar](50) NULL,
	[BetAmt8] [varchar](50) NULL,
	[BetAmt9] [varchar](50) NULL,
	[ReservedString36] [varchar](250) NULL,
	[ReservedString37] [varchar](250) NULL,
	[ReservedString38] [varchar](250) NULL,
	[ReservedString39] [varchar](250) NULL,
	[ReservedString40] [varchar](250) NULL,
	[ReservedString41] [varchar](250) NULL,
	[ReservedString42] [varchar](250) NULL,
	[ReservedString43] [varchar](250) NULL,
	[ReservedString44] [varchar](250) NULL,
	[ReservedString45] [varchar](250) NULL,
	[ReservedString46] [varchar](250) NULL,
	[ReservedString47] [varchar](250) NULL,
	[ReservedString48] [varchar](250) NULL,
	[ReservedString49] [varchar](250) NULL,
	[ReservedString50] [varchar](250) NULL,
	[ReservedString51] [varchar](250) NULL,
	[ReservedString52] [varchar](250) NULL,
	[ReservedString53] [varchar](250) NULL,
	[ReservedString54] [varchar](250) NULL,
	[ReservedString55] [varchar](250) NULL,
	[ReservedString56] [varchar](250) NULL,
	[ReservedString57] [varchar](250) NULL,
	[ReservedString58] [varchar](250) NULL,
	[ReservedString59] [varchar](250) NULL,
	[ReservedString60] [varchar](250) NULL,
	[ReservedString61] [varchar](250) NULL,
	[ReservedString62] [varchar](250) NULL,
	[ReservedString63] [varchar](250) NULL,
	[ReservedString64] [varchar](250) NULL,
	[ReservedString65] [varchar](250) NULL,
	[ReservedString66] [varchar](250) NULL,
	[ReservedString67] [varchar](250) NULL,
	[ReservedString68] [varchar](250) NULL,
	[ReservedString69] [varchar](250) NULL,
	[ReservedString70] [varchar](250) NULL,
	[ReservedString71] [varchar](250) NULL,
	[ReservedString72] [varchar](250) NULL,
	[ReservedString73] [varchar](250) NULL,
	[ReservedString74] [varchar](250) NULL,
	[ReservedString75] [varchar](250) NULL,
	[ReservedString76] [varchar](250) NULL,
	[ReservedString77] [varchar](250) NULL,
	[ReservedString78] [varchar](250) NULL,
	[ReservedString79] [varchar](250) NULL,
	[ReservedString80] [varchar](250) NULL,
	[ReservedString81] [varchar](250) NULL,
	[ReservedString82] [varchar](250) NULL,
	[ReservedString83] [varchar](250) NULL,
	[ReservedString84] [varchar](250) NULL,
	[ReservedString85] [varchar](250) NULL,
	[ReservedString86] [varchar](250) NULL,
	[ReservedString87] [varchar](250) NULL,
	[ReservedString88] [varchar](250) NULL,
	[ReservedString89] [varchar](250) NULL,
	[ReservedString90] [varchar](250) NULL,
	[ReservedString91] [varchar](250) NULL,
	[ReservedString92] [varchar](250) NULL,
	[ReservedString93] [varchar](250) NULL,
	[ReservedString94] [varchar](250) NULL,
	[ReservedString95] [varchar](250) NULL,
	[ReservedString96] [varchar](250) NULL,
	[ReservedString97] [varchar](250) NULL,
	[ReservedString98] [varchar](250) NULL,
	[ReservedString99] [varchar](250) NULL,
	[ReservedString100] [varchar](250) NULL,
	[ReservedString101] [varchar](250) NULL,
	[ReservedString102] [varchar](250) NULL,
	[ReservedString103] [varchar](250) NULL,
	[ReservedString104] [varchar](250) NULL,
	[ReservedString105] [varchar](250) NULL,
	[ReservedString106] [varchar](250) NULL,
	[ReservedString107] [varchar](250) NULL,
	[ReservedString108] [varchar](250) NULL,
	[ReservedString109] [varchar](250) NULL,
	[ReservedString110] [varchar](250) NULL,
	[ReservedString111] [varchar](250) NULL,
	[ReservedString112] [varchar](250) NULL,
	[ReservedString113] [varchar](250) NULL,
	[ReservedString114] [varchar](250) NULL,
	[ReservedString115] [varchar](250) NULL,
	[ReservedString116] [varchar](250) NULL,
	[ReservedString117] [varchar](250) NULL,
	[ReservedString118] [varchar](250) NULL,
	[ReservedString119] [varchar](250) NULL,
	[ReservedString120] [varchar](250) NULL,
	[ReservedString121] [varchar](250) NULL,
	[ReservedString122] [varchar](250) NULL,
	[ReservedString123] [varchar](250) NULL,
	[ReservedString124] [varchar](250) NULL,
	[ReservedString125] [varchar](250) NULL,
	[ReservedString126] [varchar](250) NULL,
	[ReservedString127] [varchar](250) NULL,
	[ReservedString128] [varchar](250) NULL,
	[ReservedString129] [varchar](250) NULL,
	[ReservedString130] [varchar](250) NULL,
	[ReservedString131] [varchar](250) NULL,
	[ReservedString132] [varchar](250) NULL,
	[ReservedString133] [varchar](250) NULL,
	[ReservedString134] [varchar](250) NULL,
	[ReservedString135] [varchar](250) NULL,
	[ReservedString136] [varchar](250) NULL,
	[ReservedString137] [varchar](250) NULL,
	[ReservedString138] [varchar](250) NULL,
	[ReservedString139] [varchar](250) NULL,
	[ReservedString140] [varchar](250) NULL,
	[ReservedString141] [varchar](250) NULL,
	[ReservedString142] [varchar](250) NULL,
	[ReservedString143] [varchar](250) NULL,
	[ReservedString144] [varchar](250) NULL,
	[ReservedString145] [varchar](250) NULL,
	[ReservedString146] [varchar](250) NULL,
	[ReservedString147] [varchar](250) NULL,
	[ReservedString148] [varchar](250) NULL,
	[ReservedString149] [varchar](250) NULL,
	[ReservedString150] [varchar](250) NULL,
	[ReservedString151] [varchar](250) NULL,
	[ReservedString152] [varchar](250) NULL,
	[ReservedString153] [varchar](250) NULL,
	[ReservedString154] [varchar](250) NULL,
	[ReservedString155] [varchar](250) NULL,
	[ReservedString156] [varchar](250) NULL,
	[ReservedString157] [varchar](250) NULL,
	[ReservedString158] [varchar](250) NULL,
	[ReservedString159] [varchar](250) NULL,
	[ReservedString160] [varchar](250) NULL,
	[ReservedString161] [varchar](250) NULL,
	[ReservedString162] [varchar](250) NULL,
	[ReservedString163] [varchar](250) NULL,
	[ReservedString164] [varchar](250) NULL,
	[ReservedString165] [varchar](250) NULL,
	[ReservedString166] [varchar](250) NULL,
	[ReservedString167] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[ent]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[ent](
	[EntID] [int] IDENTITY(1,1) NOT NULL,
	[RacID] [int] NOT NULL,
	[RaceDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceNum] [int] NULL,
	[HorseName] [varchar](100) NULL,
	[HorseID] [int] NOT NULL,
	[PolePosition] [varchar](20) NULL,
	[MorningLine] [varchar](5) NULL,
	[PaceLines] [varchar](10) NULL,
	[EntryChar] [varchar](10) NULL,
	[ScratchFlagInd] [int] NULL,
	[CurrentYr] [int] NULL,
	[StartsThisYr] [int] NULL,
	[WinThisYr] [int] NULL,
	[PlacesThisYr] [int] NULL,
	[ShowsThisYr] [int] NULL,
	[EarningThisYr] [float] NULL,
	[PrevYearForEarning] [int] NULL,
	[StartsPrevYr] [int] NULL,
	[WinPrevYr] [int] NULL,
	[PlacesPrevYr] [int] NULL,
	[ShowsPrevYr] [int] NULL,
	[EarningPrevYr] [float] NULL,
	[OwnerName] [varchar](150) NULL,
	[Color] [nvarchar](10) NULL,
	[YearBorn] [int] NULL,
	[MonthBorn] [int] NULL,
	[StateBredInd] [varchar](5) NULL,
	[Age] [int] NULL,
	[Sex] [nvarchar](1) NULL,
	[SireName] [varchar](100) NULL,
	[SiresSire] [varchar](100) NULL,
	[Dam] [nvarchar](50) NULL,
	[DamsSire] [nvarchar](50) NULL,
	[TrainerName] [varchar](100) NULL,
	[BreederName] [varchar](100) NULL,
	[TrainerStarts] [int] NULL,
	[TrainerWins] [int] NULL,
	[TrainerPlaces] [int] NULL,
	[TrainerShows] [int] NULL,
	[TrainerPercentage] [float] NULL,
	[LasixInd] [int] NULL,
	[ButeInd] [int] NULL,
	[WeightAssigned] [float] NULL,
	[ApprenticeWtAllowance] [float] NULL,
	[JockeyName] [varchar](100) NULL,
	[JockeyID] [int] NULL,
	[JockeyStarts] [int] NULL,
	[JockeyWins] [int] NULL,
	[JockeyPlaces] [int] NULL,
	[JockeyShows] [int] NULL,
	[JockeyPercentage] [float] NULL,
	[ClaimingPrice] [float] NULL,
	[LifetimeStarts] [int] NULL,
	[LifetimeWins] [int] NULL,
	[LifetimePlaces] [int] NULL,
	[LifetimeShows] [int] NULL,
	[LifetimeEarnings] [float] NULL,
	[TrackStarts] [int] NULL,
	[TrackWins] [int] NULL,
	[TrackPlaces] [int] NULL,
	[TrackShows] [int] NULL,
	[TrackEarnings] [float] NULL,
	[TurfStarts] [int] NULL,
	[TurfWins] [int] NULL,
	[TurfPlaces] [int] NULL,
	[TurfShows] [int] NULL,
	[TurfEarnings] [float] NULL,
	[WetStarts] [int] NULL,
	[WetWins] [int] NULL,
	[WetPlaces] [int] NULL,
	[WetShows] [int] NULL,
	[WetEarnings] [float] NULL,
	[DistanceStarts] [int] NULL,
	[DistanceWins] [int] NULL,
	[DistancePlaces] [int] NULL,
	[DistanceShows] [int] NULL,
	[DistanceEarnings] [float] NULL,
	[AlsoEligibleInd] [int] NULL,
	[PartOfFieldInd] [int] NULL,
	[BlinkersToday] [int] NULL,
	[BandagesTodayInd] [int] NULL,
	[JockeyStatsYTD] [varchar](40) NULL,
	[TrainerStatsYTD] [varchar](40) NULL,
	[ReservedString3] [varchar](50) NULL,
	[ReservedString4] [varchar](50) NULL,
	[PostPosition] [int] NULL,
	[OffTrackRating] [int] NULL,
	[TurfRating] [int] NULL,
	[FirstTimeLasix] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190625-055522]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190625-055522] ON [kelso].[ent]
(
	[EntID] ASC,
	[RacID] ASC,
	[RaceDt] ASC,
	[TrackCd] ASC,
	[RaceNum] ASC,
	[HorseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[ent_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[ent_staging](
	[RaceDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceNum] [int] NULL,
	[HorseName] [varchar](100) NULL,
	[PolePosition] [varchar](20) NULL,
	[MorningLine] [varchar](5) NULL,
	[PaceLines] [varchar](10) NULL,
	[EntryChar] [varchar](10) NULL,
	[ScratchFlagInd] [int] NULL,
	[CurrentYr] [int] NULL,
	[StartsThisYr] [int] NULL,
	[WinThisYr] [int] NULL,
	[PlacesThisYr] [int] NULL,
	[ShowsThisYr] [int] NULL,
	[EarningThisYr] [float] NULL,
	[PrevYearForEarning] [int] NULL,
	[StartsPrevYr] [int] NULL,
	[WinPrevYr] [int] NULL,
	[PlacesPrevYr] [int] NULL,
	[ShowsPrevYr] [int] NULL,
	[EarningPrevYr] [float] NULL,
	[OwnerName] [varchar](150) NULL,
	[Color] [nvarchar](10) NULL,
	[YearBorn] [int] NULL,
	[MonthBorn] [int] NULL,
	[StateBredInd] [varchar](5) NULL,
	[Age] [int] NULL,
	[Sex] [nvarchar](1) NULL,
	[SireName] [varchar](100) NULL,
	[SiresSire] [varchar](100) NULL,
	[Dam] [nvarchar](50) NULL,
	[DamsSire] [nvarchar](50) NULL,
	[TrainerName] [varchar](100) NULL,
	[BreederName] [varchar](100) NULL,
	[TrainerStarts] [int] NULL,
	[TrainerWins] [int] NULL,
	[TrainerPlaces] [int] NULL,
	[TrainerShows] [int] NULL,
	[TrainerPercentage] [float] NULL,
	[LasixInd] [int] NULL,
	[ButeInd] [int] NULL,
	[WeightAssigned] [float] NULL,
	[ApprenticeWtAllowance] [float] NULL,
	[JockeyName] [varchar](100) NULL,
	[JockeyStarts] [int] NULL,
	[JockeyWins] [int] NULL,
	[JockeyPlaces] [int] NULL,
	[JockeyShows] [int] NULL,
	[JockeyPercentage] [float] NULL,
	[ClaimingPrice] [float] NULL,
	[LifetimeStarts] [int] NULL,
	[LifetimeWins] [int] NULL,
	[LifetimePlaces] [int] NULL,
	[LifetimeShows] [int] NULL,
	[LifetimeEarnings] [float] NULL,
	[TrackStarts] [int] NULL,
	[TrackWins] [int] NULL,
	[TrackPlaces] [int] NULL,
	[TrackShows] [int] NULL,
	[TrackEarnings] [float] NULL,
	[TurfStarts] [int] NULL,
	[TurfWins] [int] NULL,
	[TurfPlaces] [int] NULL,
	[TurfShows] [int] NULL,
	[TurfEarnings] [float] NULL,
	[WetStarts] [int] NULL,
	[WetWins] [int] NULL,
	[WetPlaces] [int] NULL,
	[WetShows] [int] NULL,
	[WetEarnings] [float] NULL,
	[DistanceStarts] [int] NULL,
	[DistanceWins] [int] NULL,
	[DistancePlaces] [int] NULL,
	[DistanceShows] [int] NULL,
	[DistanceEarnings] [float] NULL,
	[AlsoEligibleInd] [int] NULL,
	[PartOfFieldInd] [int] NULL,
	[BlinkersToday] [int] NULL,
	[BandagesTodayInd] [int] NULL,
	[JockeyStatsYTD] [varchar](40) NULL,
	[TrainerStatsYTD] [varchar](40) NULL,
	[ReservedString3] [varchar](50) NULL,
	[ReservedString4] [varchar](50) NULL,
	[PostPosition] [int] NULL,
	[OffTrackRating] [int] NULL,
	[TurfRating] [int] NULL,
	[FirstTimeLasix] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[hor_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[hor_staging](
	[RaceDt] [datetime] NULL,
	[TrackCd] [nvarchar](3) NULL,
	[RaceNum] [int] NULL,
	[HorseName] [varchar](100) NULL,
	[PaceLineDt] [datetime] NULL,
	[PaceLineTrackCd] [varchar](3) NULL,
	[PaceLineRaceNum] [varchar](10) NULL,
	[PaceLineDistance] [float] NULL,
	[InnerInd] [int] NULL,
	[TurfInd] [int] NULL,
	[AboutInd] [int] NULL,
	[OffTheTurfInd] [int] NULL,
	[TrackCondition] [varchar](3) NULL,
	[ThreeAndUpInd] [int] NULL,
	[FillieInd] [int] NULL,
	[StateBredInd] [int] NULL,
	[RestrictedInd] [int] NULL,
	[AgeRestriction] [varchar](3) NULL,
	[Sex] [int] NULL,
	[ClassString] [varchar](250) NULL,
	[ExtendedClassInfo] [varchar](250) NULL,
	[Purse] [float] NULL,
	[ClaimingPrice] [float] NULL,
	[RaceClass] [int] NULL,
	[StkHandicapGrade] [int] NULL,
	[ClaimedInd] [int] NULL,
	[FirstCallTime] [float] NULL,
	[SecondCallTime] [float] NULL,
	[FinalTime] [float] NULL,
	[AdditionalFractionalTime] [float] NULL,
	[PostPosition] [int] NULL,
	[StartCallPosition] [int] NULL,
	[FirstCallPosition] [int] NULL,
	[SecondCallPosition] [int] NULL,
	[StretchCallPosition] [int] NULL,
	[FinalCallPosition] [int] NULL,
	[FirstCallBeatenLengths] [float] NULL,
	[SecondCallBeatenLengths] [float] NULL,
	[StretchCallBeatenLengths] [float] NULL,
	[FinalBeatenLengths] [float] NULL,
	[JockeyName] [varchar](100) NULL,
	[LasixInd] [int] NULL,
	[ButeInd] [int] NULL,
	[Weight] [int] NULL,
	[BlinkersInd] [int] NULL,
	[FrontWrapsInd] [int] NULL,
	[FavoriteFlagInd] [int] NULL,
	[PostTimeOdds] [float] NULL,
	[FavortismOddRanking] [int] NULL,
	[CoupledInd] [int] NULL,
	[DeadHeatInd] [int] NULL,
	[DisqualifiedInd] [int] NULL,
	[DisqualifiedPlacement] [int] NULL,
	[SpeedRating] [float] NULL,
	[TrackVariant] [float] NULL,
	[AdvancedSpeedFigure] [float] NULL,
	[PTSEarlyPaceRating] [float] NULL,
	[PTSLatePaceRating] [float] NULL,
	[PTSTruePaceRating] [float] NULL,
	[PTSSpeedRating] [float] NULL,
	[PTSEarlyPaceVariant1] [float] NULL,
	[PTSEarlyPaceVariant2] [float] NULL,
	[PTSFinalPaceVariant] [float] NULL,
	[PTSAdditionalPointVariant] [float] NULL,
	[WinningHorse] [varchar](100) NULL,
	[WinningHorseWeight] [float] NULL,
	[WinningHorseMargin] [float] NULL,
	[SecondPlaceHorse] [varchar](100) NULL,
	[SecondPlaceHorseWeight] [float] NULL,
	[SecondPlaceHorseMargin] [float] NULL,
	[ThirdPlaceHorse] [varchar](100) NULL,
	[ThirdPlaceHorseWeight] [float] NULL,
	[ThirdPlaceHorseMargin] [float] NULL,
	[TroubleLine] [nvarchar](100) NULL,
	[NumberOfEntrants] [int] NULL,
	[OriginalTrainer] [nvarchar](100) NULL,
	[OriginalOwner] [nvarchar](100) NULL,
	[ExtendedTroubleLineInfo] [varchar](250) NULL,
	[DisqualificationComments] [nvarchar](150) NULL,
	[ReservedString1] [nvarchar](50) NULL,
	[ReservedString2] [nvarchar](50) NULL,
	[TrainerName] [nvarchar](100) NULL,
	[OwnerName] [nvarchar](100) NULL,
	[TypeOfPacelineRace] [int] NULL,
	[ApprenticeWeightAllowance] [float] NULL,
	[ReservedNumber1] [int] NULL,
	[ReservedNumber2] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Horses]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Horses](
	[HorseID] [int] IDENTITY(1,1) NOT NULL,
	[HorseName] [varchar](100) NOT NULL,
	[CurrentYear] [int] NULL,
	[StartsThisYr] [int] NULL,
	[WinThisYr] [int] NULL,
	[PlaceThisYr] [int] NULL,
	[ShowThisYr] [int] NULL,
	[EarningThisYr] [int] NULL,
	[LifetimeStarts] [int] NULL,
	[LifetimeWins] [int] NULL,
	[LifetimePlaces] [int] NULL,
	[LifetimeShows] [int] NULL,
	[LifetimeEarnings] [int] NULL,
	[TurfStarts] [int] NULL,
	[TurfWins] [int] NULL,
	[TurfPlaces] [int] NULL,
	[TurfShows] [int] NULL,
	[OffTrackRating] [int] NULL,
	[TurfRating] [int] NULL,
	[ChangeDt] [datetime] NULL,
	[RaceDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190625-055013]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190625-055013] ON [kelso].[Horses]
(
	[HorseID] ASC,
	[HorseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Jockeys]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Jockeys](
	[JockeyID] [int] IDENTITY(1,1) NOT NULL,
	[JockeyName] [nvarchar](50) NULL,
	[JockeyStarts] [int] NULL,
	[JockeyWins] [int] NULL,
	[JockeyPlaces] [int] NULL,
	[JockeyShows] [int] NULL,
	[JockeyPercentage] [float] NULL,
	[JockeyStatsYTD] [nvarchar](40) NULL,
	[JockeyLifetimeStats] [nvarchar](40) NULL,
	[JockeyLifetimeTotalRaces] [int] NULL,
	[JockeyLifetimeTotalWin] [int] NULL,
	[JockeyLifetimeWinPercentage] [float] NULL,
	[ChangeDate] [datetime] NOT NULL,
	[RaceDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190625-055605]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190625-055605] ON [kelso].[Jockeys]
(
	[JockeyID] ASC,
	[JockeyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Log]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Created] [datetime] NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Process]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Process](
	[ProcessID] [int] IDENTITY(1,1) NOT NULL,
	[RacID] [int] NULL,
	[EntID] [int] NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ChangeDt] [datetime] NOT NULL,
	[RaceDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[Distance] [float] NULL,
	[Furlong] [float] NULL,
	[RaceNum] [int] NULL,
	[TurfInd] [int] NULL,
	[HorseID] [int] NULL,
	[HorseName] [varchar](50) NULL,
	[PolePosition] [varchar](20) NULL,
	[LastRaceDt] [datetime] NULL,
	[NumOfDaysSinceLastRace] [int] NULL,
	[LastWorkoutDt] [datetime] NULL,
	[NumOfDaysSinceLastWorkout] [int] NULL,
	[BettingLine] [float] NULL,
	[StartsThisYr] [int] NULL,
	[WinThisYr] [int] NULL,
	[WinsPerc] [float] NULL,
	[Top3Finishes] [int] NULL,
	[Top3FinishesWinPerc] [float] NULL,
	[LifetimeStarts] [int] NULL,
	[LifetimeWins] [int] NULL,
	[LifetimeWinsPerc] [float] NULL,
	[LifetimeTop3Finish] [int] NULL,
	[Top3FinishesLifetimePerc] [float] NULL,
	[TurfStarts] [int] NULL,
	[TurfWins] [int] NULL,
	[TurfWinsPerc] [float] NULL,
	[TurfTop3Finishes] [int] NULL,
	[Top3FinishesTurfPerc] [float] NULL,
	[NonTurfStarts] [int] NULL,
	[NonTurfWins] [int] NULL,
	[NonTurfWinsPerc] [float] NULL,
	[NonTurfTop3Finishes] [int] NULL,
	[Top3FinishesNonTurfPerc] [float] NULL,
	[TrackStart] [int] NULL,
	[TrackEarnings] [float] NULL,
	[TrackWins] [int] NULL,
	[TrackTop3Finishes] [int] NULL,
	[DistanceStart] [int] NULL,
	[DistanceEarnings] [float] NULL,
	[DistanceWins] [int] NULL,
	[DistanceTop3Finishes] [int] NULL,
	[TurfRating] [int] NULL,
	[SpeedRating] [float] NULL,
	[TrackVariant] [float] NULL,
	[AdvancedSpeedFigure] [float] NULL,
	[PTSEarlyPaceRating] [float] NULL,
	[PTSLatePaceRating] [float] NULL,
	[PTSTruePaceRating] [float] NULL,
	[PTSSpeedRating] [float] NULL,
	[OffTrackRating] [int] NULL,
	[JockeyStarts] [int] NULL,
	[JockeyWins] [int] NULL,
	[JockeyTop3Finishes] [int] NULL,
	[JockeyWinningPerc] [float] NULL,
	[JockeyLifetimeWinningPerc] [float] NULL,
	[TrainerLifetimeWinningPerc] [float] NULL,
	[LastWorkoutRankingPercentage] [float] NULL,
	[LastWorkoutDistance] [float] NULL,
	[Workout4FurlongAvg] [float] NULL,
	[Workout5FurlongAvg] [float] NULL,
	[Workout6FurlongAvg] [float] NULL,
	[Workout7FurlongAvg] [float] NULL,
	[Workout8FurlongAvg] [float] NULL,
	[WorkoutTop3RankingAvg] [float] NULL,
	[Workout3MonthAvg] [float] NULL,
	[Workout6MonthAvg] [float] NULL,
	[Workout4FurlongBest] [float] NULL,
	[Workout5FurlongBest] [float] NULL,
	[Workout6FurlongBest] [float] NULL,
	[Workout7FurlongBest] [float] NULL,
	[Workout8FurlongBest] [float] NULL,
	[WorkoutAvgCurrentMonth] [float] NULL,
	[Workout4FurlongCurrentMonth] [float] NULL,
	[Workout5FurlongCurrentMonth] [float] NULL,
	[Workout6FurlongCurrentMonth] [float] NULL,
	[Workout7FurlongCurrentMonth] [float] NULL,
	[Workout8FurlongCurrentMonth] [float] NULL,
	[WorkoutAvgPreviousMonth] [float] NULL,
	[Workout4FurlongPreviousMonth] [float] NULL,
	[Workout5FurlongPreviousMonth] [float] NULL,
	[Workout6FurlongPreviousMonth] [float] NULL,
	[Workout7FurlongPreviousMonth] [float] NULL,
	[Workout8FurlongPreviousMonth] [float] NULL,
	[WorkoutAvgPrevious2Month] [float] NULL,
	[Workout4FurlongPrevious2Month] [float] NULL,
	[Workout5FurlongPrevious2Month] [float] NULL,
	[Workout6FurlongPrevious2Month] [float] NULL,
	[Workout7FurlongPrevious2Month] [float] NULL,
	[Workout8FurlongPrevious2Month] [float] NULL,
	[WorkoutAvgPrevious3Month] [float] NULL,
	[Workout4FurlongPrevious3Month] [float] NULL,
	[Workout5FurlongPrevious3Month] [float] NULL,
	[Workout6FurlongPrevious3Month] [float] NULL,
	[Workout7FurlongPrevious3Month] [float] NULL,
	[Workout8FurlongPrevious3Month] [float] NULL,
	[WorkoutSameTrackBest] [float] NULL,
	[WorkoutSameTrackBest3] [float] NULL,
	[WorkoutSameTrackAvg] [float] NULL,
	[CalculateTimeMethod] [varchar](3) NULL,
	[CalculateTime] [float] NULL,
	[CalculateTimePercentageAvg] [float] NULL,
	[CalculateTimeUsingPaceAvg] [float] NULL,
	[CalculateTimeUsingPaceOverallAvg] [float] NULL,
	[CalculateTimeTrendCorrelation] [float] NULL,
	[CalculateTimeTrendIntercept] [float] NULL,
	[CalculateTimeTrendR2] [float] NULL,
	[CalculateTimeTrendSlope] [float] NULL,
	[Furlong5Time] [float] NULL,
	[Furlong5TimeRankingPerc] [float] NULL,
	[Furlong6Time] [float] NULL,
	[Furlong6TimeRankingPerc] [float] NULL,
	[Furlong8Time] [float] NULL,
	[Furlong8TimeRankingPerc] [float] NULL,
	[FinishResult] [int] NULL,
	[CalculateTimeUsingPaceOverallRankingPerc] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190625-054811]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190625-054811] ON [kelso].[Process]
(
	[ProcessID] ASC,
	[RacID] ASC,
	[EntID] ASC,
	[TrackCd] ASC,
	[RaceNum] ASC,
	[TurfInd] ASC,
	[HorseID] ASC,
	[PolePosition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[rac]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[rac](
	[RacID] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](4) NULL,
	[RaceDt] [datetime] NULL,
	[TrackCd] [nvarchar](3) NULL,
	[RaceNum] [int] NULL,
	[SimulCastTrackCd] [nvarchar](3) NULL,
	[SimulCastRaceNum] [int] NULL,
	[Distance] [float] NULL,
	[InnerInd] [int] NULL,
	[TurfInd] [int] NULL,
	[AboutInd] [int] NULL,
	[RaceClass] [int] NULL,
	[TopClaimPrice] [float] NULL,
	[BottomClaimPrice] [float] NULL,
	[RacePurse] [float] NULL,
	[AgeRestriction] [nvarchar](3) NULL,
	[SexRestriction] [int] NULL,
	[StateBred] [int] NULL,
	[RestrictedStakes] [int] NULL,
	[StkHandicapGrade] [int] NULL,
	[AbbreviationClass] [nvarchar](21) NULL,
	[PostTime] [nvarchar](5) NULL,
	[TrackTimeZone] [nvarchar](1) NULL,
	[GmtAdjustmentFactor] [nvarchar](5) NULL,
	[TrackName] [nvarchar](25) NULL,
	[DistanceTrackRecord] [nvarchar](25) NULL,
	[ReservedString1] [nvarchar](50) NULL,
	[ReservedString2] [nvarchar](50) NULL,
	[ReservedNum1] [int] NULL,
	[ReservedNum2] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190625-055156]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190625-055156] ON [kelso].[rac]
(
	[RacID] ASC,
	[RaceDt] ASC,
	[TrackCd] ASC,
	[RaceNum] ASC,
	[TurfInd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[rac_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[rac_staging](
	[Version] [nvarchar](4) NULL,
	[RaceDt] [datetime] NULL,
	[TrackCd] [nvarchar](3) NULL,
	[RaceNum] [int] NULL,
	[SimulCastTrackCd] [nvarchar](3) NULL,
	[SimulCastRaceNum] [int] NULL,
	[Distance] [float] NULL,
	[InnerInd] [int] NULL,
	[TurfInd] [int] NULL,
	[AboutInd] [int] NULL,
	[RaceClass] [int] NULL,
	[TopClaimPrice] [float] NULL,
	[BottomClaimPrice] [float] NULL,
	[RacePurse] [float] NULL,
	[AgeRestriction] [nvarchar](3) NULL,
	[SexRestriction] [int] NULL,
	[StateBred] [int] NULL,
	[RestrictedStakes] [int] NULL,
	[StkHandicapGrade] [int] NULL,
	[AbbreviationClass] [nvarchar](21) NULL,
	[PostTime] [nvarchar](5) NULL,
	[TrackTimeZone] [nvarchar](1) NULL,
	[GmtAdjustmentFactor] [nvarchar](5) NULL,
	[TrackName] [nvarchar](25) NULL,
	[DistanceTrackRecord] [nvarchar](25) NULL,
	[ReservedString1] [nvarchar](50) NULL,
	[ReservedString2] [nvarchar](50) NULL,
	[ReservedNum1] [int] NULL,
	[ReservedNum2] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Results]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Results](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RacId] [int] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[ReservedString1] [varchar](250) NULL,
	[Surface] [varchar](1) NULL,
	[ReservedString2] [varchar](1) NULL,
	[ReservedString3] [varchar](1) NULL,
	[ReservedString4] [varchar](1) NULL,
	[ReservedString5] [varchar](1) NULL,
	[ReservedString6] [varchar](1) NULL,
	[ReservedString7] [varchar](1) NULL,
	[ReservedString8] [varchar](1) NULL,
	[ReservedString9] [varchar](1) NULL,
	[ReservedString10] [varchar](1) NULL,
	[ReservedString11] [varchar](1) NULL,
	[FinalTime] [float] NULL,
	[TrackCondition] [varchar](2) NULL,
	[PostPosition] [int] NULL,
	[EntryFlag] [varchar](1) NULL,
	[HorseName] [varchar](100) NULL,
	[ReservedString12] [varchar](1) NULL,
	[ReservedString13] [varchar](1) NULL,
	[ReservedString14] [varchar](1) NULL,
	[ReservedString15] [varchar](1) NULL,
	[ReservedString16] [varchar](1) NULL,
	[ReservedString17] [varchar](1) NULL,
	[ReservedString18] [varchar](1) NULL,
	[ReservedString19] [varchar](1) NULL,
	[ReservedString20] [varchar](1) NULL,
	[FinishPosition] [int] NULL,
	[ReservedString21] [varchar](1) NULL,
	[WagerType10] [varchar](50) NULL,
	[WagerType11] [varchar](50) NULL,
	[WagerType12] [varchar](50) NULL,
	[WagerType13] [varchar](50) NULL,
	[WagerType14] [varchar](50) NULL,
	[HorseOdd] [float] NULL,
	[ReservedString22] [varchar](1) NULL,
	[ReservedString23] [varchar](1) NULL,
	[ReservedString24] [varchar](1) NULL,
	[ReservedString25] [varchar](1) NULL,
	[ReservedString26] [varchar](1) NULL,
	[ReservedString27] [varchar](1) NULL,
	[ReservedString28] [varchar](1) NULL,
	[ReservedString29] [varchar](1) NULL,
	[ReservedString30] [varchar](1) NULL,
	[ReservedString31] [varchar](1) NULL,
	[starter_field_size] [int] NULL,
	[official_finish_position] [int] NULL,
	[official_program_num] [varchar](3) NULL,
	[ReservedString32] [varchar](1) NULL,
	[ReservedString33] [varchar](1) NULL,
	[ReservedString34] [varchar](1) NULL,
	[ReservedString35] [varchar](1) NULL,
	[WinningNums10] [varchar](50) NULL,
	[WinningNums11] [varchar](50) NULL,
	[WinningNums12] [varchar](50) NULL,
	[WinningNums13] [varchar](50) NULL,
	[WinningNums14] [varchar](50) NULL,
	[TwoDollarsPayoff10] [float] NULL,
	[TwoDollarsPayoff11] [float] NULL,
	[TwoDollarsPayoff12] [float] NULL,
	[TwoDollarsPayoff13] [float] NULL,
	[TwoDollarsPayoff14] [float] NULL,
	[Pool10] [float] NULL,
	[Pool11] [float] NULL,
	[Pool12] [float] NULL,
	[Pool13] [float] NULL,
	[Pool14] [float] NULL,
	[BetAmt10] [float] NULL,
	[BetAmt11] [float] NULL,
	[BetAmt12] [float] NULL,
	[BetAmt13] [float] NULL,
	[BetAmt14] [float] NULL,
	[TwoDollarsWinPayOff] [float] NULL,
	[TwoDollarsPlacePayOff] [float] NULL,
	[TwoDollarsShowPayOff] [float] NULL,
	[WagerType1] [varchar](50) NULL,
	[WagerType2] [varchar](50) NULL,
	[WagerType3] [varchar](50) NULL,
	[WagerType4] [varchar](50) NULL,
	[WagerType5] [varchar](50) NULL,
	[WagerType6] [varchar](50) NULL,
	[WagerType7] [varchar](50) NULL,
	[WagerType8] [varchar](50) NULL,
	[WagerType9] [varchar](50) NULL,
	[WinningNums1] [varchar](50) NULL,
	[WinningNums2] [varchar](50) NULL,
	[WinningNums3] [varchar](50) NULL,
	[WinningNums4] [varchar](50) NULL,
	[WinningNums5] [varchar](50) NULL,
	[WinningNums6] [varchar](50) NULL,
	[WinningNums7] [varchar](50) NULL,
	[WinningNums8] [varchar](50) NULL,
	[WinningNums9] [varchar](50) NULL,
	[TwoDollarsPayoff1] [float] NULL,
	[TwoDollarsPayoff2] [float] NULL,
	[TwoDollarsPayoff3] [float] NULL,
	[TwoDollarsPayoff4] [float] NULL,
	[TwoDollarsPayoff5] [float] NULL,
	[TwoDollarsPayoff6] [float] NULL,
	[TwoDollarsPayoff7] [float] NULL,
	[TwoDollarsPayoff8] [float] NULL,
	[TwoDollarsPayoff9] [float] NULL,
	[Pool1] [float] NULL,
	[Pool2] [float] NULL,
	[Pool3] [float] NULL,
	[Pool4] [float] NULL,
	[Pool5] [float] NULL,
	[Pool6] [float] NULL,
	[Pool7] [float] NULL,
	[Pool8] [float] NULL,
	[Pool9] [float] NULL,
	[BetAmt1] [float] NULL,
	[BetAmt2] [float] NULL,
	[BetAmt3] [float] NULL,
	[BetAmt4] [float] NULL,
	[BetAmt5] [float] NULL,
	[BetAmt6] [float] NULL,
	[BetAmt7] [float] NULL,
	[BetAmt8] [float] NULL,
	[BetAmt9] [float] NULL,
	[ReservedString36] [varchar](1) NULL,
	[ReservedString37] [varchar](1) NULL,
	[ReservedString38] [varchar](1) NULL,
	[ReservedString39] [varchar](1) NULL,
	[ReservedString40] [varchar](1) NULL,
	[ReservedString41] [varchar](1) NULL,
	[ReservedString42] [varchar](1) NULL,
	[ReservedString43] [varchar](1) NULL,
	[ReservedString44] [varchar](1) NULL,
	[ReservedString45] [varchar](1) NULL,
	[ReservedString46] [varchar](1) NULL,
	[ReservedString47] [varchar](1) NULL,
	[ReservedString48] [varchar](1) NULL,
	[ReservedString49] [varchar](1) NULL,
	[ReservedString50] [varchar](1) NULL,
	[ReservedString51] [varchar](1) NULL,
	[ReservedString52] [varchar](1) NULL,
	[ReservedString53] [varchar](1) NULL,
	[ReservedString54] [varchar](1) NULL,
	[ReservedString55] [varchar](1) NULL,
	[ReservedString56] [varchar](1) NULL,
	[ReservedString57] [varchar](1) NULL,
	[ReservedString58] [varchar](1) NULL,
	[ReservedString59] [varchar](1) NULL,
	[ReservedString60] [varchar](1) NULL,
	[ReservedString61] [varchar](1) NULL,
	[ReservedString62] [varchar](1) NULL,
	[ReservedString63] [varchar](1) NULL,
	[ReservedString64] [varchar](1) NULL,
	[ReservedString65] [varchar](1) NULL,
	[ReservedString66] [varchar](1) NULL,
	[ReservedString67] [varchar](1) NULL,
	[ReservedString68] [varchar](1) NULL,
	[ReservedString69] [varchar](1) NULL,
	[ReservedString70] [varchar](1) NULL,
	[ReservedString71] [varchar](1) NULL,
	[ReservedString72] [varchar](1) NULL,
	[ReservedString73] [varchar](1) NULL,
	[ReservedString74] [varchar](1) NULL,
	[ReservedString75] [varchar](1) NULL,
	[ReservedString76] [varchar](1) NULL,
	[ReservedString77] [varchar](1) NULL,
	[ReservedString78] [varchar](1) NULL,
	[ReservedString79] [varchar](1) NULL,
	[ReservedString80] [varchar](1) NULL,
	[ReservedString81] [varchar](1) NULL,
	[ReservedString82] [varchar](1) NULL,
	[ReservedString83] [varchar](1) NULL,
	[ReservedString84] [varchar](1) NULL,
	[ReservedString85] [varchar](1) NULL,
	[ReservedString86] [varchar](1) NULL,
	[ReservedString87] [varchar](1) NULL,
	[ReservedString88] [varchar](1) NULL,
	[ReservedString89] [varchar](1) NULL,
	[ReservedString90] [varchar](1) NULL,
	[ReservedString91] [varchar](1) NULL,
	[ReservedString92] [varchar](1) NULL,
	[ReservedString93] [varchar](1) NULL,
	[ReservedString94] [varchar](1) NULL,
	[ReservedString95] [varchar](1) NULL,
	[ReservedString96] [varchar](1) NULL,
	[ReservedString97] [varchar](1) NULL,
	[ReservedString98] [varchar](1) NULL,
	[ReservedString99] [varchar](1) NULL,
	[ReservedString100] [varchar](1) NULL,
	[ReservedString101] [varchar](1) NULL,
	[ReservedString102] [varchar](1) NULL,
	[ReservedString103] [varchar](1) NULL,
	[ReservedString104] [varchar](1) NULL,
	[ReservedString105] [varchar](1) NULL,
	[ReservedString106] [varchar](1) NULL,
	[ReservedString107] [varchar](1) NULL,
	[ReservedString108] [varchar](1) NULL,
	[ReservedString109] [varchar](1) NULL,
	[ReservedString110] [varchar](1) NULL,
	[ReservedString111] [varchar](1) NULL,
	[ReservedString112] [varchar](1) NULL,
	[ReservedString113] [varchar](1) NULL,
	[ReservedString114] [varchar](1) NULL,
	[ReservedString115] [varchar](1) NULL,
	[ReservedString116] [varchar](1) NULL,
	[ReservedString117] [varchar](1) NULL,
	[ReservedString118] [varchar](1) NULL,
	[ReservedString119] [varchar](1) NULL,
	[ReservedString120] [varchar](1) NULL,
	[ReservedString121] [varchar](1) NULL,
	[ReservedString122] [varchar](1) NULL,
	[ReservedString123] [varchar](1) NULL,
	[ReservedString124] [varchar](1) NULL,
	[ReservedString125] [varchar](1) NULL,
	[ReservedString126] [varchar](1) NULL,
	[ReservedString127] [varchar](1) NULL,
	[ReservedString128] [varchar](1) NULL,
	[ReservedString129] [varchar](1) NULL,
	[ReservedString130] [varchar](1) NULL,
	[ReservedString131] [varchar](1) NULL,
	[ReservedString132] [varchar](1) NULL,
	[ReservedString133] [varchar](1) NULL,
	[ReservedString134] [varchar](1) NULL,
	[ReservedString135] [varchar](1) NULL,
	[ReservedString136] [varchar](1) NULL,
	[ReservedString137] [varchar](1) NULL,
	[ReservedString138] [varchar](1) NULL,
	[ReservedString139] [varchar](1) NULL,
	[ReservedString140] [varchar](1) NULL,
	[ReservedString141] [varchar](1) NULL,
	[ReservedString142] [varchar](1) NULL,
	[ReservedString143] [varchar](1) NULL,
	[ReservedString144] [varchar](1) NULL,
	[ReservedString145] [varchar](1) NULL,
	[ReservedString146] [varchar](1) NULL,
	[ReservedString147] [varchar](1) NULL,
	[ReservedString148] [varchar](1) NULL,
	[ReservedString149] [varchar](1) NULL,
	[ReservedString150] [varchar](1) NULL,
	[ReservedString151] [varchar](1) NULL,
	[ReservedString152] [varchar](1) NULL,
	[ReservedString153] [varchar](1) NULL,
	[ReservedString154] [varchar](1) NULL,
	[ReservedString155] [varchar](1) NULL,
	[ReservedString156] [varchar](1) NULL,
	[ReservedString157] [varchar](1) NULL,
	[ReservedString158] [varchar](1) NULL,
	[ReservedString159] [varchar](1) NULL,
	[ReservedString160] [varchar](1) NULL,
	[ReservedString161] [varchar](1) NULL,
	[ReservedString162] [varchar](1) NULL,
	[ReservedString163] [varchar](1) NULL,
	[ReservedString164] [varchar](1) NULL,
	[ReservedString165] [varchar](1) NULL,
	[ReservedString166] [varchar](1) NULL,
	[ReservedString167] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20200322-210553]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20200322-210553] ON [kelso].[Results]
(
	[Id] ASC,
	[RacId] ASC,
	[TrackCd] ASC,
	[RaceDt] ASC,
	[RaceNum] ASC,
	[official_program_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Settings]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Settings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateID] [int] NOT NULL,
	[ColumnName] [varchar](25) NOT NULL,
	[DisplayName] [varchar](50) NOT NULL,
	[SetValue] [int] NULL,
	[SortID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Settings1]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Settings1](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NumberOfStart] [int] NULL,
	[FirstTimeJockeyScore] [decimal](12, 2) NULL,
	[FirstTimeTrainerScore] [decimal](12, 2) NULL,
	[FirstTimeWorkoutScore] [decimal](12, 2) NULL,
	[FirstTimeBettingLineScore] [decimal](12, 2) NULL,
	[JockeyScore] [decimal](12, 2) NULL,
	[TrainerScore] [decimal](12, 2) NULL,
	[WorkoutScore] [decimal](12, 2) NULL,
	[BettingLineScore] [decimal](12, 2) NULL,
	[ClaimScore] [decimal](12, 2) NULL,
	[CloserScore] [decimal](12, 2) NULL,
	[FastTrackScore] [decimal](12, 2) NULL,
	[TimePlacementScore] [decimal](12, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[Trainers]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[Trainers](
	[TrainerID] [int] IDENTITY(1,1) NOT NULL,
	[TrainerName] [nvarchar](50) NULL,
	[TrainerStarts] [int] NULL,
	[TrainerWins] [int] NULL,
	[TrainerPlaces] [int] NULL,
	[TrainerShows] [int] NULL,
	[TrainerPercentage] [float] NULL,
	[TrainerStatsYTD] [nvarchar](40) NULL,
	[TrainerLifetimeStats] [nvarchar](40) NULL,
	[TrainerLifetimeTotalRaces] [int] NULL,
	[TrainerLifetimeTotalWin] [int] NULL,
	[TrainerLifetimeWinPercentage] [float] NULL,
	[ChangeDate] [datetime] NULL,
	[RaceDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20190625-055629]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20190625-055629] ON [kelso].[Trainers]
(
	[TrainerID] ASC,
	[TrainerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[wor_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[wor_staging](
	[RaceDt] [datetime] NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceNum] [smallint] NULL,
	[HorseName] [varchar](100) NULL,
	[WorkOutDt] [datetime] NULL,
	[WorkOutTrack] [varchar](3) NULL,
	[WorkOutDistance] [float] NULL,
	[InnerInd] [smallint] NULL,
	[TurfInd] [smallint] NULL,
	[TrainingTrackInd] [smallint] NULL,
	[WorkOutTrackCond] [varchar](5) NULL,
	[WorkOutTime] [float] NULL,
	[BreezingInd] [smallint] NULL,
	[HandilyInd] [smallint] NULL,
	[BulletInd] [smallint] NULL,
	[DogsUpInd] [smallint] NULL,
	[GateWorkOutInd] [smallint] NULL,
	[WorkOutRank] [smallint] NULL,
	[WorkOutTotalNum] [smallint] NULL,
	[ReservedString1] [varchar](150) NULL,
	[ReservedString2] [varchar](150) NULL,
	[ReservedNum1] [smallint] NULL,
	[ReservedNum2] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[xdr]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[xdr](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[ReservedString1] [varchar](250) NULL,
	[Surface] [varchar](1) NULL,
	[ReservedString2] [varchar](1) NULL,
	[ReservedString3] [varchar](1) NULL,
	[ReservedString4] [varchar](1) NULL,
	[ReservedString5] [varchar](1) NULL,
	[ReservedString6] [varchar](1) NULL,
	[ReservedString7] [varchar](1) NULL,
	[ReservedString8] [varchar](1) NULL,
	[ReservedString9] [varchar](1) NULL,
	[ReservedString10] [varchar](1) NULL,
	[ReservedString11] [varchar](1) NULL,
	[FinalTime] [float] NULL,
	[TrackCondition] [varchar](2) NULL,
	[PostPosition] [int] NULL,
	[EntryFlag] [varchar](1) NULL,
	[HorseName] [varchar](100) NULL,
	[ReservedString12] [varchar](1) NULL,
	[ReservedString13] [varchar](1) NULL,
	[ReservedString14] [varchar](1) NULL,
	[ReservedString15] [varchar](1) NULL,
	[ReservedString16] [varchar](1) NULL,
	[ReservedString17] [varchar](1) NULL,
	[ReservedString18] [varchar](1) NULL,
	[ReservedString19] [varchar](1) NULL,
	[ReservedString20] [varchar](1) NULL,
	[FinishPosition] [int] NULL,
	[ReservedString21] [varchar](1) NULL,
	[WagerType10] [varchar](50) NULL,
	[WagerType11] [varchar](50) NULL,
	[WagerType12] [varchar](50) NULL,
	[WagerType13] [varchar](50) NULL,
	[WagerType14] [varchar](50) NULL,
	[HorseOdd] [float] NULL,
	[ReservedString22] [varchar](1) NULL,
	[ReservedString23] [varchar](1) NULL,
	[ReservedString24] [varchar](1) NULL,
	[ReservedString25] [varchar](1) NULL,
	[ReservedString26] [varchar](1) NULL,
	[ReservedString27] [varchar](1) NULL,
	[ReservedString28] [varchar](1) NULL,
	[ReservedString29] [varchar](1) NULL,
	[ReservedString30] [varchar](1) NULL,
	[ReservedString31] [varchar](1) NULL,
	[starter_field_size] [int] NULL,
	[official_finish_position] [int] NULL,
	[official_program_num] [varchar](3) NULL,
	[ReservedString32] [varchar](1) NULL,
	[ReservedString33] [varchar](1) NULL,
	[ReservedString34] [varchar](1) NULL,
	[ReservedString35] [varchar](1) NULL,
	[WinningNums10] [varchar](50) NULL,
	[WinningNums11] [varchar](50) NULL,
	[WinningNums12] [varchar](50) NULL,
	[WinningNums13] [varchar](50) NULL,
	[WinningNums14] [varchar](50) NULL,
	[TwoDollarsPayoff10] [float] NULL,
	[TwoDollarsPayoff11] [float] NULL,
	[TwoDollarsPayoff12] [float] NULL,
	[TwoDollarsPayoff13] [float] NULL,
	[TwoDollarsPayoff14] [float] NULL,
	[Pool10] [float] NULL,
	[Pool11] [float] NULL,
	[Pool12] [float] NULL,
	[Pool13] [float] NULL,
	[Pool14] [float] NULL,
	[BetAmt10] [float] NULL,
	[BetAmt11] [float] NULL,
	[BetAmt12] [float] NULL,
	[BetAmt13] [float] NULL,
	[BetAmt14] [float] NULL,
	[TwoDollarsWinPayOff] [float] NULL,
	[TwoDollarsPlacePayOff] [float] NULL,
	[TwoDollarsShowPayOff] [float] NULL,
	[WagerType1] [varchar](50) NULL,
	[WagerType2] [varchar](50) NULL,
	[WagerType3] [varchar](50) NULL,
	[WagerType4] [varchar](50) NULL,
	[WagerType5] [varchar](50) NULL,
	[WagerType6] [varchar](50) NULL,
	[WagerType7] [varchar](50) NULL,
	[WagerType8] [varchar](50) NULL,
	[WagerType9] [varchar](50) NULL,
	[WinningNums1] [varchar](50) NULL,
	[WinningNums2] [varchar](50) NULL,
	[WinningNums3] [varchar](50) NULL,
	[WinningNums4] [varchar](50) NULL,
	[WinningNums5] [varchar](50) NULL,
	[WinningNums6] [varchar](50) NULL,
	[WinningNums7] [varchar](50) NULL,
	[WinningNums8] [varchar](50) NULL,
	[WinningNums9] [varchar](50) NULL,
	[TwoDollarsPayoff1] [float] NULL,
	[TwoDollarsPayoff2] [float] NULL,
	[TwoDollarsPayoff3] [float] NULL,
	[TwoDollarsPayoff4] [float] NULL,
	[TwoDollarsPayoff5] [float] NULL,
	[TwoDollarsPayoff6] [float] NULL,
	[TwoDollarsPayoff7] [float] NULL,
	[TwoDollarsPayoff8] [float] NULL,
	[TwoDollarsPayoff9] [float] NULL,
	[Pool1] [float] NULL,
	[Pool2] [float] NULL,
	[Pool3] [float] NULL,
	[Pool4] [float] NULL,
	[Pool5] [float] NULL,
	[Pool6] [float] NULL,
	[Pool7] [float] NULL,
	[Pool8] [float] NULL,
	[Pool9] [float] NULL,
	[BetAmt1] [float] NULL,
	[BetAmt2] [float] NULL,
	[BetAmt3] [float] NULL,
	[BetAmt4] [float] NULL,
	[BetAmt5] [float] NULL,
	[BetAmt6] [float] NULL,
	[BetAmt7] [float] NULL,
	[BetAmt8] [float] NULL,
	[BetAmt9] [float] NULL,
	[ReservedString36] [varchar](1) NULL,
	[ReservedString37] [varchar](1) NULL,
	[ReservedString38] [varchar](1) NULL,
	[ReservedString39] [varchar](1) NULL,
	[ReservedString40] [varchar](1) NULL,
	[ReservedString41] [varchar](1) NULL,
	[ReservedString42] [varchar](1) NULL,
	[ReservedString43] [varchar](1) NULL,
	[ReservedString44] [varchar](1) NULL,
	[ReservedString45] [varchar](1) NULL,
	[ReservedString46] [varchar](1) NULL,
	[ReservedString47] [varchar](1) NULL,
	[ReservedString48] [varchar](1) NULL,
	[ReservedString49] [varchar](1) NULL,
	[ReservedString50] [varchar](1) NULL,
	[ReservedString51] [varchar](1) NULL,
	[ReservedString52] [varchar](1) NULL,
	[ReservedString53] [varchar](1) NULL,
	[ReservedString54] [varchar](1) NULL,
	[ReservedString55] [varchar](1) NULL,
	[ReservedString56] [varchar](1) NULL,
	[ReservedString57] [varchar](1) NULL,
	[ReservedString58] [varchar](1) NULL,
	[ReservedString59] [varchar](1) NULL,
	[ReservedString60] [varchar](1) NULL,
	[ReservedString61] [varchar](1) NULL,
	[ReservedString62] [varchar](1) NULL,
	[ReservedString63] [varchar](1) NULL,
	[ReservedString64] [varchar](1) NULL,
	[ReservedString65] [varchar](1) NULL,
	[ReservedString66] [varchar](1) NULL,
	[ReservedString67] [varchar](1) NULL,
	[ReservedString68] [varchar](1) NULL,
	[ReservedString69] [varchar](1) NULL,
	[ReservedString70] [varchar](1) NULL,
	[ReservedString71] [varchar](1) NULL,
	[ReservedString72] [varchar](1) NULL,
	[ReservedString73] [varchar](1) NULL,
	[ReservedString74] [varchar](1) NULL,
	[ReservedString75] [varchar](1) NULL,
	[ReservedString76] [varchar](1) NULL,
	[ReservedString77] [varchar](1) NULL,
	[ReservedString78] [varchar](1) NULL,
	[ReservedString79] [varchar](1) NULL,
	[ReservedString80] [varchar](1) NULL,
	[ReservedString81] [varchar](1) NULL,
	[ReservedString82] [varchar](1) NULL,
	[ReservedString83] [varchar](1) NULL,
	[ReservedString84] [varchar](1) NULL,
	[ReservedString85] [varchar](1) NULL,
	[ReservedString86] [varchar](1) NULL,
	[ReservedString87] [varchar](1) NULL,
	[ReservedString88] [varchar](1) NULL,
	[ReservedString89] [varchar](1) NULL,
	[ReservedString90] [varchar](1) NULL,
	[ReservedString91] [varchar](1) NULL,
	[ReservedString92] [varchar](1) NULL,
	[ReservedString93] [varchar](1) NULL,
	[ReservedString94] [varchar](1) NULL,
	[ReservedString95] [varchar](1) NULL,
	[ReservedString96] [varchar](1) NULL,
	[ReservedString97] [varchar](1) NULL,
	[ReservedString98] [varchar](1) NULL,
	[ReservedString99] [varchar](1) NULL,
	[ReservedString100] [varchar](1) NULL,
	[ReservedString101] [varchar](1) NULL,
	[ReservedString102] [varchar](1) NULL,
	[ReservedString103] [varchar](1) NULL,
	[ReservedString104] [varchar](1) NULL,
	[ReservedString105] [varchar](1) NULL,
	[ReservedString106] [varchar](1) NULL,
	[ReservedString107] [varchar](1) NULL,
	[ReservedString108] [varchar](1) NULL,
	[ReservedString109] [varchar](1) NULL,
	[ReservedString110] [varchar](1) NULL,
	[ReservedString111] [varchar](1) NULL,
	[ReservedString112] [varchar](1) NULL,
	[ReservedString113] [varchar](1) NULL,
	[ReservedString114] [varchar](1) NULL,
	[ReservedString115] [varchar](1) NULL,
	[ReservedString116] [varchar](1) NULL,
	[ReservedString117] [varchar](1) NULL,
	[ReservedString118] [varchar](1) NULL,
	[ReservedString119] [varchar](1) NULL,
	[ReservedString120] [varchar](1) NULL,
	[ReservedString121] [varchar](1) NULL,
	[ReservedString122] [varchar](1) NULL,
	[ReservedString123] [varchar](1) NULL,
	[ReservedString124] [varchar](1) NULL,
	[ReservedString125] [varchar](1) NULL,
	[ReservedString126] [varchar](1) NULL,
	[ReservedString127] [varchar](1) NULL,
	[ReservedString128] [varchar](1) NULL,
	[ReservedString129] [varchar](1) NULL,
	[ReservedString130] [varchar](1) NULL,
	[ReservedString131] [varchar](1) NULL,
	[ReservedString132] [varchar](1) NULL,
	[ReservedString133] [varchar](1) NULL,
	[ReservedString134] [varchar](1) NULL,
	[ReservedString135] [varchar](1) NULL,
	[ReservedString136] [varchar](1) NULL,
	[ReservedString137] [varchar](1) NULL,
	[ReservedString138] [varchar](1) NULL,
	[ReservedString139] [varchar](1) NULL,
	[ReservedString140] [varchar](1) NULL,
	[ReservedString141] [varchar](1) NULL,
	[ReservedString142] [varchar](1) NULL,
	[ReservedString143] [varchar](1) NULL,
	[ReservedString144] [varchar](1) NULL,
	[ReservedString145] [varchar](1) NULL,
	[ReservedString146] [varchar](1) NULL,
	[ReservedString147] [varchar](1) NULL,
	[ReservedString148] [varchar](1) NULL,
	[ReservedString149] [varchar](1) NULL,
	[ReservedString150] [varchar](1) NULL,
	[ReservedString151] [varchar](1) NULL,
	[ReservedString152] [varchar](1) NULL,
	[ReservedString153] [varchar](1) NULL,
	[ReservedString154] [varchar](1) NULL,
	[ReservedString155] [varchar](1) NULL,
	[ReservedString156] [varchar](1) NULL,
	[ReservedString157] [varchar](1) NULL,
	[ReservedString158] [varchar](1) NULL,
	[ReservedString159] [varchar](1) NULL,
	[ReservedString160] [varchar](1) NULL,
	[ReservedString161] [varchar](1) NULL,
	[ReservedString162] [varchar](1) NULL,
	[ReservedString163] [varchar](1) NULL,
	[ReservedString164] [varchar](1) NULL,
	[ReservedString165] [varchar](1) NULL,
	[ReservedString166] [varchar](1) NULL,
	[ReservedString167] [varchar](1) NULL,
	[RacId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kelso].[xdr_staging]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kelso].[xdr_staging](
	[TrackCd] [varchar](3) NULL,
	[RaceDt] [datetime] NULL,
	[RaceNum] [int] NULL,
	[ReservedString1] [varchar](250) NULL,
	[Surface] [varchar](1) NULL,
	[ReservedString2] [varchar](1) NULL,
	[ReservedString3] [varchar](1) NULL,
	[ReservedString4] [varchar](1) NULL,
	[ReservedString5] [varchar](1) NULL,
	[ReservedString6] [varchar](1) NULL,
	[ReservedString7] [varchar](1) NULL,
	[ReservedString8] [varchar](1) NULL,
	[ReservedString9] [varchar](1) NULL,
	[ReservedString10] [varchar](1) NULL,
	[ReservedString11] [varchar](1) NULL,
	[FinalTime] [float] NULL,
	[TrackCondition] [varchar](2) NULL,
	[PostPosition] [int] NULL,
	[EntryFlag] [varchar](1) NULL,
	[HorseName] [varchar](100) NULL,
	[ReservedString12] [varchar](1) NULL,
	[ReservedString13] [varchar](1) NULL,
	[ReservedString14] [varchar](1) NULL,
	[ReservedString15] [varchar](1) NULL,
	[ReservedString16] [varchar](1) NULL,
	[ReservedString17] [varchar](1) NULL,
	[ReservedString18] [varchar](1) NULL,
	[ReservedString19] [varchar](1) NULL,
	[ReservedString20] [varchar](1) NULL,
	[FinishPosition] [int] NULL,
	[ReservedString21] [varchar](1) NULL,
	[WagerType10] [varchar](50) NULL,
	[WagerType11] [varchar](50) NULL,
	[WagerType12] [varchar](50) NULL,
	[WagerType13] [varchar](50) NULL,
	[WagerType14] [varchar](50) NULL,
	[HorseOdd] [float] NULL,
	[ReservedString22] [varchar](1) NULL,
	[ReservedString23] [varchar](1) NULL,
	[ReservedString24] [varchar](1) NULL,
	[ReservedString25] [varchar](1) NULL,
	[ReservedString26] [varchar](1) NULL,
	[ReservedString27] [varchar](1) NULL,
	[ReservedString28] [varchar](1) NULL,
	[ReservedString29] [varchar](1) NULL,
	[ReservedString30] [varchar](1) NULL,
	[ReservedString31] [varchar](1) NULL,
	[starter_field_size] [int] NULL,
	[official_finish_position] [int] NULL,
	[official_program_num] [varchar](3) NULL,
	[ReservedString32] [varchar](1) NULL,
	[ReservedString33] [varchar](1) NULL,
	[ReservedString34] [varchar](1) NULL,
	[ReservedString35] [varchar](1) NULL,
	[WinningNums10] [varchar](50) NULL,
	[WinningNums11] [varchar](50) NULL,
	[WinningNums12] [varchar](50) NULL,
	[WinningNums13] [varchar](50) NULL,
	[WinningNums14] [varchar](50) NULL,
	[TwoDollarsPayoff10] [float] NULL,
	[TwoDollarsPayoff11] [float] NULL,
	[TwoDollarsPayoff12] [float] NULL,
	[TwoDollarsPayoff13] [float] NULL,
	[TwoDollarsPayoff14] [float] NULL,
	[Pool10] [float] NULL,
	[Pool11] [float] NULL,
	[Pool12] [float] NULL,
	[Pool13] [float] NULL,
	[Pool14] [float] NULL,
	[BetAmt10] [float] NULL,
	[BetAmt11] [float] NULL,
	[BetAmt12] [float] NULL,
	[BetAmt13] [float] NULL,
	[BetAmt14] [float] NULL,
	[TwoDollarsWinPayOff] [float] NULL,
	[TwoDollarsPlacePayOff] [float] NULL,
	[TwoDollarsShowPayOff] [float] NULL,
	[WagerType1] [varchar](50) NULL,
	[WagerType2] [varchar](50) NULL,
	[WagerType3] [varchar](50) NULL,
	[WagerType4] [varchar](50) NULL,
	[WagerType5] [varchar](50) NULL,
	[WagerType6] [varchar](50) NULL,
	[WagerType7] [varchar](50) NULL,
	[WagerType8] [varchar](50) NULL,
	[WagerType9] [varchar](50) NULL,
	[WinningNums1] [varchar](50) NULL,
	[WinningNums2] [varchar](50) NULL,
	[WinningNums3] [varchar](50) NULL,
	[WinningNums4] [varchar](50) NULL,
	[WinningNums5] [varchar](50) NULL,
	[WinningNums6] [varchar](50) NULL,
	[WinningNums7] [varchar](50) NULL,
	[WinningNums8] [varchar](50) NULL,
	[WinningNums9] [varchar](50) NULL,
	[TwoDollarsPayoff1] [float] NULL,
	[TwoDollarsPayoff2] [float] NULL,
	[TwoDollarsPayoff3] [float] NULL,
	[TwoDollarsPayoff4] [float] NULL,
	[TwoDollarsPayoff5] [float] NULL,
	[TwoDollarsPayoff6] [float] NULL,
	[TwoDollarsPayoff7] [float] NULL,
	[TwoDollarsPayoff8] [float] NULL,
	[TwoDollarsPayoff9] [float] NULL,
	[Pool1] [float] NULL,
	[Pool2] [float] NULL,
	[Pool3] [float] NULL,
	[Pool4] [float] NULL,
	[Pool5] [float] NULL,
	[Pool6] [float] NULL,
	[Pool7] [float] NULL,
	[Pool8] [float] NULL,
	[Pool9] [float] NULL,
	[BetAmt1] [float] NULL,
	[BetAmt2] [float] NULL,
	[BetAmt3] [float] NULL,
	[BetAmt4] [float] NULL,
	[BetAmt5] [float] NULL,
	[BetAmt6] [float] NULL,
	[BetAmt7] [float] NULL,
	[BetAmt8] [float] NULL,
	[BetAmt9] [float] NULL,
	[ReservedString36] [varchar](1) NULL,
	[ReservedString37] [varchar](1) NULL,
	[ReservedString38] [varchar](1) NULL,
	[ReservedString39] [varchar](1) NULL,
	[ReservedString40] [varchar](1) NULL,
	[ReservedString41] [varchar](1) NULL,
	[ReservedString42] [varchar](1) NULL,
	[ReservedString43] [varchar](1) NULL,
	[ReservedString44] [varchar](1) NULL,
	[ReservedString45] [varchar](1) NULL,
	[ReservedString46] [varchar](1) NULL,
	[ReservedString47] [varchar](1) NULL,
	[ReservedString48] [varchar](1) NULL,
	[ReservedString49] [varchar](1) NULL,
	[ReservedString50] [varchar](1) NULL,
	[ReservedString51] [varchar](1) NULL,
	[ReservedString52] [varchar](1) NULL,
	[ReservedString53] [varchar](1) NULL,
	[ReservedString54] [varchar](1) NULL,
	[ReservedString55] [varchar](1) NULL,
	[ReservedString56] [varchar](1) NULL,
	[ReservedString57] [varchar](1) NULL,
	[ReservedString58] [varchar](1) NULL,
	[ReservedString59] [varchar](1) NULL,
	[ReservedString60] [varchar](1) NULL,
	[ReservedString61] [varchar](1) NULL,
	[ReservedString62] [varchar](1) NULL,
	[ReservedString63] [varchar](1) NULL,
	[ReservedString64] [varchar](1) NULL,
	[ReservedString65] [varchar](1) NULL,
	[ReservedString66] [varchar](1) NULL,
	[ReservedString67] [varchar](1) NULL,
	[ReservedString68] [varchar](1) NULL,
	[ReservedString69] [varchar](1) NULL,
	[ReservedString70] [varchar](1) NULL,
	[ReservedString71] [varchar](1) NULL,
	[ReservedString72] [varchar](1) NULL,
	[ReservedString73] [varchar](1) NULL,
	[ReservedString74] [varchar](1) NULL,
	[ReservedString75] [varchar](1) NULL,
	[ReservedString76] [varchar](1) NULL,
	[ReservedString77] [varchar](1) NULL,
	[ReservedString78] [varchar](1) NULL,
	[ReservedString79] [varchar](1) NULL,
	[ReservedString80] [varchar](1) NULL,
	[ReservedString81] [varchar](1) NULL,
	[ReservedString82] [varchar](1) NULL,
	[ReservedString83] [varchar](1) NULL,
	[ReservedString84] [varchar](1) NULL,
	[ReservedString85] [varchar](1) NULL,
	[ReservedString86] [varchar](1) NULL,
	[ReservedString87] [varchar](1) NULL,
	[ReservedString88] [varchar](1) NULL,
	[ReservedString89] [varchar](1) NULL,
	[ReservedString90] [varchar](1) NULL,
	[ReservedString91] [varchar](1) NULL,
	[ReservedString92] [varchar](1) NULL,
	[ReservedString93] [varchar](1) NULL,
	[ReservedString94] [varchar](1) NULL,
	[ReservedString95] [varchar](1) NULL,
	[ReservedString96] [varchar](1) NULL,
	[ReservedString97] [varchar](1) NULL,
	[ReservedString98] [varchar](1) NULL,
	[ReservedString99] [varchar](1) NULL,
	[ReservedString100] [varchar](1) NULL,
	[ReservedString101] [varchar](1) NULL,
	[ReservedString102] [varchar](1) NULL,
	[ReservedString103] [varchar](1) NULL,
	[ReservedString104] [varchar](1) NULL,
	[ReservedString105] [varchar](1) NULL,
	[ReservedString106] [varchar](1) NULL,
	[ReservedString107] [varchar](1) NULL,
	[ReservedString108] [varchar](1) NULL,
	[ReservedString109] [varchar](1) NULL,
	[ReservedString110] [varchar](1) NULL,
	[ReservedString111] [varchar](1) NULL,
	[ReservedString112] [varchar](1) NULL,
	[ReservedString113] [varchar](1) NULL,
	[ReservedString114] [varchar](1) NULL,
	[ReservedString115] [varchar](1) NULL,
	[ReservedString116] [varchar](1) NULL,
	[ReservedString117] [varchar](1) NULL,
	[ReservedString118] [varchar](1) NULL,
	[ReservedString119] [varchar](1) NULL,
	[ReservedString120] [varchar](1) NULL,
	[ReservedString121] [varchar](1) NULL,
	[ReservedString122] [varchar](1) NULL,
	[ReservedString123] [varchar](1) NULL,
	[ReservedString124] [varchar](1) NULL,
	[ReservedString125] [varchar](1) NULL,
	[ReservedString126] [varchar](1) NULL,
	[ReservedString127] [varchar](1) NULL,
	[ReservedString128] [varchar](1) NULL,
	[ReservedString129] [varchar](1) NULL,
	[ReservedString130] [varchar](1) NULL,
	[ReservedString131] [varchar](1) NULL,
	[ReservedString132] [varchar](1) NULL,
	[ReservedString133] [varchar](1) NULL,
	[ReservedString134] [varchar](1) NULL,
	[ReservedString135] [varchar](1) NULL,
	[ReservedString136] [varchar](1) NULL,
	[ReservedString137] [varchar](1) NULL,
	[ReservedString138] [varchar](1) NULL,
	[ReservedString139] [varchar](1) NULL,
	[ReservedString140] [varchar](1) NULL,
	[ReservedString141] [varchar](1) NULL,
	[ReservedString142] [varchar](1) NULL,
	[ReservedString143] [varchar](1) NULL,
	[ReservedString144] [varchar](1) NULL,
	[ReservedString145] [varchar](1) NULL,
	[ReservedString146] [varchar](1) NULL,
	[ReservedString147] [varchar](1) NULL,
	[ReservedString148] [varchar](1) NULL,
	[ReservedString149] [varchar](1) NULL,
	[ReservedString150] [varchar](1) NULL,
	[ReservedString151] [varchar](1) NULL,
	[ReservedString152] [varchar](1) NULL,
	[ReservedString153] [varchar](1) NULL,
	[ReservedString154] [varchar](1) NULL,
	[ReservedString155] [varchar](1) NULL,
	[ReservedString156] [varchar](1) NULL,
	[ReservedString157] [varchar](1) NULL,
	[ReservedString158] [varchar](1) NULL,
	[ReservedString159] [varchar](1) NULL,
	[ReservedString160] [varchar](1) NULL,
	[ReservedString161] [varchar](1) NULL,
	[ReservedString162] [varchar](1) NULL,
	[ReservedString163] [varchar](1) NULL,
	[ReservedString164] [varchar](1) NULL,
	[ReservedString165] [varchar](1) NULL,
	[ReservedString166] [varchar](1) NULL,
	[ReservedString167] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-20180509-105248]    Script Date: 2/7/2023 2:13:21 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20180509-105248] ON [kelso].[WorkoutHistory]
(
	[HorseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_dr2Merge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_dr2Merge]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @brisnet_dr2 TABLE
	(
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[PostPosition] [varchar](5) NULL,
		[Entry] [varchar](5) NULL,
		[ClaimingPrice] [decimal](18, 0) NULL,
		[Trainer] [varchar](100) NULL,
		[TrainerStartsCurrentMeet] [int] NULL,
		[TrainerWinCurrentMeet] [int] NULL,
		[TrainerPlacesCurrentMeet] [int] NULL,
		[TrainerShowCurrentMeet] [int] NULL,
		[Jockey] [varchar](100) NULL,
		[ApprenticeWeight] [int] NULL,
		[JockeyStartsCurrentMeet] [varchar](100) NULL,
		[JockeyWinsCurrentMeet] [varchar](100) NULL,
		[JockeyPlacesCurrentMeet] [varchar](100) NULL,
		[JockeyShowsCurrentMeet] [varchar](100) NULL,
		[Owner] [varchar](100) NULL,
		[TrainerRecordCurrentYear] [varchar](30) NULL,
		[TrainerRecordPreviousYear] [varchar](30) NULL,
		[JockeyRecordCurrentYear] [varchar](30) NULL,
		[JockeyRecordPreviousYear] [varchar](30) NULL,
		[OwnersSilks] [varchar](100) NULL,
		[HorseName] [varchar](100) NULL,
		[YearOfBirth] [int] NULL,
		[HorseFoalingMonth] [int] NULL,
		[Reserved28] [varchar](50) NULL,
		[Sex] [char](1) NULL,
		[HorseColor] [varchar](50) NULL,
		[Weight] [int] NULL,
		[Sire] [varchar](50) NULL,
		[SireSire] [varchar](50) NULL,
		[Dam] [varchar](150) NULL,
		[DamSire] [varchar](150) NULL,
		[Breeder] [varchar](150) NULL,
		[StateCountry] [varchar](25) NULL,
		[AuctionPrice] [decimal](18, 0) NULL,
		[InfoSoldAtAuction] [varchar](25) NULL,
		[Reserved40] [varchar](150) NULL,
		[AEIndicator] [char](1) NULL,
		[Medication1stLasixInfo] [int] NULL,
		[Medication1stWithOutLasixInfo] [int] NULL,
		[EquipmentChange] [int] NULL,
		[LifeTimeRecordTodayDistanceStarts] [int] NULL,
		[LifeTimeRecordTodayDistanceWins] [int] NULL,
		[LifeTimeRecordTodayDistancePlaces] [int] NULL,
		[LifeTimeRecordTodayDistanceShows] [int] NULL,
		[LifeTimeRecordTodayDistanceEarning] [decimal](18, 0) NULL,
		[LifeTimeRecordTodayTrackStarts] [int] NULL,
		[LifeTimeRecordTodayTrackWins] [int] NULL,
		[LifeTimeRecordTodayTrackPlaces] [int] NULL,
		[LifeTimeRecordTodayTrackShows] [int] NULL,
		[LifeTimeRecordTodayTrackEarning] [decimal](18, 0) NULL,
		[LifeTimeTurfRecordStarts] [int] NULL,
		[LifeTimeTurfRecordWins] [int] NULL,
		[LifeTimeTurfRecordPlaces] [int] NULL,
		[LifeTimeTurfRecordShows] [int] NULL,
		[LifeTimeTurfRecordEarning] [decimal](18, 0) NULL,
		[LifeTimeWetRecordStarts] [int] NULL,
		[LifeTimeWetRecordWins] [int] NULL,
		[LifeTimeWetRecordPlaces] [int] NULL,
		[LifeTimeWetRecordShows] [int] NULL,
		[LifeTimeWetRecordEarning] [decimal](18, 0) NULL,
		[CurrentRecordYear] [int] NULL,
		[CurrentRecordStarts] [int] NULL,
		[CurrentRecordWins] [int] NULL,
		[CurrentRecordPlaces] [int] NULL,
		[CurrentRecordShows] [int] NULL,
		[CurrentRecordEarning] [decimal](18, 0) NULL,
		[PreviousRecordYear] [int] NULL,
		[PreviousRecordStarts] [int] NULL,
		[PreviousRecordWins] [int] NULL,
		[PreviousRecordPlaces] [int] NULL,
		[PreviousRecordShows] [int] NULL,
		[PreviousRecordEarning] [decimal](18, 0) NULL,
		[LifetimeRecordStarts] [int] NULL,
		[LifetimeRecordWins] [int] NULL,
		[LifetimeRecordPlaces] [int] NULL,
		[LifetimeRecordShows] [int] NULL,
		[LifetimeRecordEarning] [decimal](18, 0) NULL,
		[Workout1Date] [datetime] NULL,
		[Workout2Date] [datetime] NULL,
		[Workout3Date] [datetime] NULL,
		[Workout4Date] [datetime] NULL,
		[Workout5Date] [datetime] NULL,
		[Workout6Date] [datetime] NULL,
		[Workout7Date] [datetime] NULL,
		[Workout8Date] [datetime] NULL,
		[Workout9Date] [datetime] NULL,
		[Workout10Date] [datetime] NULL,
		[Workout11Date] [datetime] NULL,
		[Workout12Date] [datetime] NULL,
		[Workout1Time] [decimal](18, 2) NULL,
		[Workout2Time] [decimal](18, 2) NULL,
		[Workout3Time] [decimal](18, 2) NULL,
		[Workout4Time] [decimal](18, 2) NULL,
		[Workout5Time] [decimal](18, 2) NULL,
		[Workout6Time] [decimal](18, 2) NULL,
		[Workout7Time] [decimal](18, 2) NULL,
		[Workout8Time] [decimal](18, 2) NULL,
		[Workout9Time] [decimal](18, 2) NULL,
		[Workout10Time] [decimal](18, 2) NULL,
		[Workout11Time] [decimal](18, 2) NULL,
		[Workout12Time] [decimal](18, 2) NULL,
		[Workout1Track] [varchar](10) NULL,
		[Workout2Track] [varchar](10) NULL,
		[Workout3Track] [varchar](10) NULL,
		[Workout4Track] [varchar](10) NULL,
		[Workout5Track] [varchar](10) NULL,
		[Workout6Track] [varchar](10) NULL,
		[Workout7Track] [varchar](10) NULL,
		[Workout8Track] [varchar](10) NULL,
		[Workout9Track] [varchar](10) NULL,
		[Workout10Track] [varchar](10) NULL,
		[Workout11Track] [varchar](10) NULL,
		[Workout12Track] [varchar](10) NULL,
		[Workout1Distance] [decimal](18, 0) NULL,
		[Workout2Distance] [decimal](18, 0) NULL,
		[Workout3Distance] [decimal](18, 0) NULL,
		[Workout4Distance] [decimal](18, 0) NULL,
		[Workout5Distance] [decimal](18, 0) NULL,
		[Workout6Distance] [decimal](18, 0) NULL,
		[Workout7Distance] [decimal](18, 0) NULL,
		[Workout8Distance] [decimal](18, 0) NULL,
		[Workout9Distance] [decimal](18, 0) NULL,
		[Workout10Distance] [decimal](18, 0) NULL,
		[Workout11Distance] [decimal](18, 0) NULL,
		[Workout12Distance] [decimal](18, 0) NULL,
		[WorkoutTrackCondition1] [varchar](5) NULL,
		[WorkoutTrackCondition2] [varchar](5) NULL,
		[WorkoutTrackCondition3] [varchar](5) NULL,
		[WorkoutTrackCondition4] [varchar](5) NULL,
		[WorkoutTrackCondition5] [varchar](5) NULL,
		[WorkoutTrackCondition6] [varchar](5) NULL,
		[WorkoutTrackCondition7] [varchar](5) NULL,
		[WorkoutTrackCondition8] [varchar](5) NULL,
		[WorkoutTrackCondition9] [varchar](5) NULL,
		[WorkoutTrackCondition10] [varchar](5) NULL,
		[WorkoutTrackCondition11] [varchar](5) NULL,
		[WorkoutTrackCondition12] [varchar](5) NULL,
		[Workout1Description] [varchar](5) NULL,
		[Workout2Description] [varchar](5) NULL,
		[Workout3Description] [varchar](5) NULL,
		[Workout4Description] [varchar](5) NULL,
		[Workout5Description] [varchar](5) NULL,
		[Workout6Description] [varchar](5) NULL,
		[Workout7Description] [varchar](5) NULL,
		[Workout8Description] [varchar](5) NULL,
		[Workout9Description] [varchar](5) NULL,
		[Workout10Description] [varchar](5) NULL,
		[Workout11Description] [varchar](5) NULL,
		[Workout12Description] [varchar](5) NULL,
		[MainInnerTrackIndicator1] [varchar](5) NULL,
		[MainInnerTrackIndicator2] [varchar](5) NULL,
		[MainInnerTrackIndicator3] [varchar](5) NULL,
		[MainInnerTrackIndicator4] [varchar](5) NULL,
		[MainInnerTrackIndicator5] [varchar](5) NULL,
		[MainInnerTrackIndicator6] [varchar](5) NULL,
		[MainInnerTrackIndicator7] [varchar](5) NULL,
		[MainInnerTrackIndicator8] [varchar](5) NULL,
		[MainInnerTrackIndicator9] [varchar](5) NULL,
		[MainInnerTrackIndicator10] [varchar](5) NULL,
		[MainInnerTrackIndicator11] [varchar](5) NULL,
		[MainInnerTrackIndicator12] [varchar](5) NULL,
		[NumberOfWorkout1] [varchar](5) NULL,
		[NumberOfWorkout2] [varchar](5) NULL,
		[NumberOfWorkout3] [varchar](5) NULL,
		[NumberOfWorkout4] [varchar](5) NULL,
		[NumberOfWorkout5] [varchar](5) NULL,
		[NumberOfWorkout6] [varchar](5) NULL,
		[NumberOfWorkout7] [varchar](5) NULL,
		[NumberOfWorkout8] [varchar](5) NULL,
		[NumberOfWorkout9] [varchar](5) NULL,
		[NumberOfWorkout10] [varchar](5) NULL,
		[NumberOfWorkout11] [varchar](5) NULL,
		[NumberOfWorkout12] [varchar](5) NULL,
		[WorkoutRank1] [varchar](5) NULL,
		[WorkoutRank2] [varchar](5) NULL,
		[WorkoutRank3] [varchar](5) NULL,
		[WorkoutRank4] [varchar](5) NULL,
		[WorkoutRank5] [varchar](5) NULL,
		[WorkoutRank6] [varchar](5) NULL,
		[WorkoutRank7] [varchar](5) NULL,
		[WorkoutRank8] [varchar](5) NULL,
		[WorkoutRank9] [varchar](5) NULL,
		[WorkoutRank10] [varchar](5) NULL,
		[WorkoutRank11] [varchar](5) NULL,
		[WorkoutRank12] [varchar](5) NULL,
		[BrisRunStyle] [varchar](5) NULL,
		[QuirinSpeedPoints] [int] NULL,
		[Reserved191Reserved] [varchar](50) NULL,
		[Reserved192Reserved] [varchar](50) NULL,
		[Bris2fPaceFig] [int] NULL,
		[Bris4fPaceFig] [int] NULL,
		[Bris6fPaceFig] [int] NULL,
		[BrisSpeedFig] [int] NULL,
		[BrisLatePace] [int] NULL,
		[Reserved198] [varchar](50) NULL,
		[Reserved199] [varchar](50) NULL,
		[ProgramPostPosition] [int] NULL,
		[ProgramNumber] [varchar](5) NULL,
		[MorningLine] [decimal](18, 2) NULL,
		[NumOfDaySinceLastRace] [int] NULL,
		[RaceConditionLine1] [varchar](275) NULL,
		[RaceConditionLine2] [varchar](275) NULL,
		[RaceConditionLine3] [varchar](275) NULL,
		[RaceConditionLine4] [varchar](275) NULL,
		[RaceConditionLine5] [varchar](275) NULL,
		[RaceConditionLine6] [varchar](275) NULL,
		[LifetimeStartsAllWeather] [int] NULL,
		[LifetimeWinsAllWeather] [int] NULL,
		[LifetimePlacesAllWeather] [int] NULL,
		[LifetimeShowsAllWeather] [int] NULL,
		[LifetimeEarningsAllWeather] [decimal](18, 0) NULL,
		[BestBRISSpeedAllWeather] [int] NULL,
		[Reserved216] [varchar](50) NULL,
		[LowClaimingPrice] [decimal](18, 0) NULL,
		[StatebredFlag] [char](1) NULL,
		[WagerTypes219] [varchar](150) NULL,
		[WagerTypes220] [varchar](150) NULL,
		[WagerTypes221] [varchar](150) NULL,
		[WagerTypes222] [varchar](150) NULL,
		[WagerTypes223] [varchar](150) NULL,
		[WagerTypes224] [varchar](150) NULL,
		[WagerTypes225] [varchar](150) NULL,
		[WagerTypes226] [varchar](150) NULL,
		[WagerTypes227] [varchar](150) NULL,
		[SireStudFee] [decimal](18, 0) NULL,
		[BestBRISSpeedFastTrack] [int] NULL,
		[BestBRISSpeedTurf] [int] NULL,
		[BestBRISSpeedOffTrack] [int] NULL,
		[BestBRISSpeedDistance] [int] NULL,
		[Reserved233] [varchar](250) NULL,
		[Reserved234] [varchar](250) NULL
	)

	INSERT INTO @brisnet_dr2
	SELECT GETDATE()
			,GETDATE()
			,R.RaceId
			,[SOURCE].[TrackCd]
			,[SOURCE].[RaceDt]
			,[SOURCE].[RaceNum]
			,[SOURCE].[PostPosition]
			,[SOURCE].[Entry]
			,CASE WHEN ISNULL([SOURCE].[ClaimingPrice], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[ClaimingPrice] )) AS decimal(18, 2)) END
			,[SOURCE].[Trainer]
			,[SOURCE].[TrainerStartsCurrentMeet]
			,[SOURCE].[TrainerWinCurrentMeet]
			,[SOURCE].[TrainerPlacesCurrentMeet]
			,[SOURCE].[TrainerShowCurrentMeet]
			,[SOURCE].[Jockey]
			,[SOURCE].[ApprenticeWeight]
			,[SOURCE].[JockeyStartsCurrentMeet]
			,[SOURCE].[JockeyWinsCurrentMeet]
			,[SOURCE].[JockeyPlacesCurrentMeet]
			,[SOURCE].[JockeyShowsCurrentMeet]
			,[SOURCE].[Owner]
			,[SOURCE].[TrainerRecordCurrentYear]
			,[SOURCE].[TrainerRecordPreviousYear]
			,[SOURCE].[JockeyRecordCurrentYear]
			,[SOURCE].[JockeyRecordPreviousYear]
			,[SOURCE].[OwnersSilks]
			,[SOURCE].[HorseName]
			,[SOURCE].[YearOfBirth]
			,[SOURCE].[HorseFoalingMonth]
			,[SOURCE].[Reserved28]
			,[SOURCE].[Sex]
			,[SOURCE].[HorseColor]
			,[SOURCE].[Weight]
			,[SOURCE].[Sire]
			,[SOURCE].[SireSire]
			,[SOURCE].[Dam]
			,[SOURCE].[DamSire]
			,[SOURCE].[Breeder]
			,[SOURCE].[StateCountry]
			,CASE WHEN ISNULL([SOURCE].[AuctionPrice], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[AuctionPrice] )) AS decimal(18, 2)) END
			,[SOURCE].[InfoSoldAtAuction]
			,[SOURCE].[Reserved40]
			,[SOURCE].[AEIndicator]
			,[SOURCE].[Medication1stLasixInfo]
			,[SOURCE].[Medication1stWithOutLasixInfo]
			,[SOURCE].[EquipmentChange]
			,[SOURCE].[LifeTimeRecordTodayDistanceStarts]
			,[SOURCE].[LifeTimeRecordTodayDistanceWins]
			,[SOURCE].[LifeTimeRecordTodayDistancePlaces]
			,[SOURCE].[LifeTimeRecordTodayDistanceShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeRecordTodayDistanceEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeRecordTodayDistanceEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifeTimeRecordTodayTrackStarts]
			,[SOURCE].[LifeTimeRecordTodayTrackWins]
			,[SOURCE].[LifeTimeRecordTodayTrackPlaces]
			,[SOURCE].[LifeTimeRecordTodayTrackShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeRecordTodayTrackEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeRecordTodayTrackEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifeTimeTurfRecordStarts]
			,[SOURCE].[LifeTimeTurfRecordWins]
			,[SOURCE].[LifeTimeTurfRecordPlaces]
			,[SOURCE].[LifeTimeTurfRecordShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeTurfRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeTurfRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifeTimeWetRecordStarts]
			,[SOURCE].[LifeTimeWetRecordWins]
			,[SOURCE].[LifeTimeWetRecordPlaces]
			,[SOURCE].[LifeTimeWetRecordShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeWetRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeWetRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[CurrentRecordYear]
			,[SOURCE].[CurrentRecordStarts]
			,[SOURCE].[CurrentRecordWins]
			,[SOURCE].[CurrentRecordPlaces]
			,[SOURCE].[CurrentRecordShows]
			,CASE WHEN ISNULL([SOURCE].[CurrentRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[CurrentRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[PreviousRecordYear]
			,[SOURCE].[PreviousRecordStarts]
			,[SOURCE].[PreviousRecordWins]
			,[SOURCE].[PreviousRecordPlaces]
			,[SOURCE].[PreviousRecordShows]
			,CASE WHEN ISNULL([SOURCE].[PreviousRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[PreviousRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifetimeRecordStarts]
			,[SOURCE].[LifetimeRecordWins]
			,[SOURCE].[LifetimeRecordPlaces]
			,[SOURCE].[LifetimeRecordShows]
			,CASE WHEN ISNULL([SOURCE].[LifetimeRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifetimeRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[Workout1Date]
			,[SOURCE].[Workout2Date]
			,[SOURCE].[Workout3Date]
			,[SOURCE].[Workout4Date]
			,[SOURCE].[Workout5Date]
			,[SOURCE].[Workout6Date]
			,[SOURCE].[Workout7Date]
			,[SOURCE].[Workout8Date]
			,[SOURCE].[Workout9Date]
			,[SOURCE].[Workout10Date]
			,[SOURCE].[Workout11Date]
			,[SOURCE].[Workout12Date]
			,CASE WHEN ISNULL([SOURCE].[Workout1Time], '') = '' THEN 0 WHEN CHARINDEX('0', [SOURCE].[Workout1Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout1Time], CHARINDEX('-', [SOURCE].[Workout1Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout1Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout2Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout2Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout2Time], CHARINDEX('-', [SOURCE].[Workout2Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout2Time])END
			,CASE WHEN ISNULL([SOURCE].[Workout3Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout3Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout3Time], CHARINDEX('-', [SOURCE].[Workout3Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout3Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout4Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout4Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout4Time], CHARINDEX('-', [SOURCE].[Workout4Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout4Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout5Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout5Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout5Time], CHARINDEX('-', [SOURCE].[Workout5Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout5Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout6Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout6Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout6Time], CHARINDEX('-', [SOURCE].[Workout6Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout6Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout7Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout7Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout7Time], CHARINDEX('-', [SOURCE].[Workout7Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout7Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout8Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout8Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout8Time], CHARINDEX('-', [SOURCE].[Workout8Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout8Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout9Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout9Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout9Time], CHARINDEX('-', [SOURCE].[Workout9Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout9Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout10Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout10Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout10Time], CHARINDEX('-', [SOURCE].[Workout10Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout10Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout11Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout11Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout11Time], CHARINDEX('-', [SOURCE].[Workout11Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout11Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout12Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout12Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout12Time], CHARINDEX('-', [SOURCE].[Workout12Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout12Time]) END
			,[SOURCE].[Workout1Track]
			,[SOURCE].[Workout2Track]
			,[SOURCE].[Workout3Track]
			,[SOURCE].[Workout4Track]
			,[SOURCE].[Workout5Track]
			,[SOURCE].[Workout6Track]
			,[SOURCE].[Workout7Track]
			,[SOURCE].[Workout8Track]
			,[SOURCE].[Workout9Track]
			,[SOURCE].[Workout10Track]
			,[SOURCE].[Workout11Track]
			,[SOURCE].[Workout12Track]
			,CASE WHEN ISNULL([SOURCE].[Workout1Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout1Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout1Distance], CHARINDEX('-', [SOURCE].[Workout1Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout1Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout2Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout2Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout2Distance], CHARINDEX('-', [SOURCE].[Workout2Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout2Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout3Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout3Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout3Distance], CHARINDEX('-', [SOURCE].[Workout3Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout3Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout4Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout4Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout4Distance], CHARINDEX('-', [SOURCE].[Workout4Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout4Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout5Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout5Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout5Distance], CHARINDEX('-', [SOURCE].[Workout5Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout5Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout6Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout6Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout6Distance], CHARINDEX('-', [SOURCE].[Workout6Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout6Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout7Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout7Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout7Distance], CHARINDEX('-', [SOURCE].[Workout7Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout7Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout8Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout8Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout8Distance], CHARINDEX('-', [SOURCE].[Workout8Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout8Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout9Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout9Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout9Distance], CHARINDEX('-', [SOURCE].[Workout9Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout9Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout10Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout10Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout10Distance], CHARINDEX('-', [SOURCE].[Workout10Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout10Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout11Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout11Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout11Distance], CHARINDEX('-', [SOURCE].[Workout11Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout11Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout12Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout12Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout12Distance], CHARINDEX('-', [SOURCE].[Workout12Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout12Distance]) END
			,[SOURCE].[WorkoutTrackCondition1]
			,[SOURCE].[WorkoutTrackCondition2]
			,[SOURCE].[WorkoutTrackCondition3]
			,[SOURCE].[WorkoutTrackCondition4]
			,[SOURCE].[WorkoutTrackCondition5]
			,[SOURCE].[WorkoutTrackCondition6]
			,[SOURCE].[WorkoutTrackCondition7]
			,[SOURCE].[WorkoutTrackCondition8]
			,[SOURCE].[WorkoutTrackCondition9]
			,[SOURCE].[WorkoutTrackCondition10]
			,[SOURCE].[WorkoutTrackCondition11]
			,[SOURCE].[WorkoutTrackCondition12]
			,[SOURCE].[Workout1Description]
			,[SOURCE].[Workout2Description]
			,[SOURCE].[Workout3Description]
			,[SOURCE].[Workout4Description]
			,[SOURCE].[Workout5Description]
			,[SOURCE].[Workout6Description]
			,[SOURCE].[Workout7Description]
			,[SOURCE].[Workout8Description]
			,[SOURCE].[Workout9Description]
			,[SOURCE].[Workout10Description]
			,[SOURCE].[Workout11Description]
			,[SOURCE].[Workout12Description]
			,[SOURCE].[MainInnerTrackIndicator1]
			,[SOURCE].[MainInnerTrackIndicator2]
			,[SOURCE].[MainInnerTrackIndicator3]
			,[SOURCE].[MainInnerTrackIndicator4]
			,[SOURCE].[MainInnerTrackIndicator5]
			,[SOURCE].[MainInnerTrackIndicator6]
			,[SOURCE].[MainInnerTrackIndicator7]
			,[SOURCE].[MainInnerTrackIndicator8]
			,[SOURCE].[MainInnerTrackIndicator9]
			,[SOURCE].[MainInnerTrackIndicator10]
			,[SOURCE].[MainInnerTrackIndicator11]
			,[SOURCE].[MainInnerTrackIndicator12]
			,[SOURCE].[NumberOfWorkout1]
			,[SOURCE].[NumberOfWorkout2]
			,[SOURCE].[NumberOfWorkout3]
			,[SOURCE].[NumberOfWorkout4]
			,[SOURCE].[NumberOfWorkout5]
			,[SOURCE].[NumberOfWorkout6]
			,[SOURCE].[NumberOfWorkout7]
			,[SOURCE].[NumberOfWorkout8]
			,[SOURCE].[NumberOfWorkout9]
			,[SOURCE].[NumberOfWorkout10]
			,[SOURCE].[NumberOfWorkout11]
			,[SOURCE].[NumberOfWorkout12]
			,[SOURCE].[WorkoutRank1]
			,[SOURCE].[WorkoutRank2]
			,[SOURCE].[WorkoutRank3]
			,[SOURCE].[WorkoutRank4]
			,[SOURCE].[WorkoutRank5]
			,[SOURCE].[WorkoutRank6]
			,[SOURCE].[WorkoutRank7]
			,[SOURCE].[WorkoutRank8]
			,[SOURCE].[WorkoutRank9]
			,[SOURCE].[WorkoutRank10]
			,[SOURCE].[WorkoutRank11]
			,[SOURCE].[WorkoutRank12]
			,[SOURCE].[BrisRunStyle]
			,[SOURCE].[QuirinSpeedPoints]
			,[SOURCE].[Reserved191Reserved]
			,[SOURCE].[Reserved192Reserved]
			,[SOURCE].[Bris2fPaceFig]
			,[SOURCE].[Bris4fPaceFig]
			,[SOURCE].[Bris6fPaceFig]
			,[SOURCE].[BrisSpeedFig]
			,[SOURCE].[BrisLatePace]
			,[SOURCE].[Reserved198]
			,[SOURCE].[Reserved199]
			,[SOURCE].[ProgramPostPosition]
			,[SOURCE].[ProgramNumber]
			,CASE WHEN ISNULL([SOURCE].[MorningLine], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[MorningLine])) AS decimal(18, 2)) END
			,[SOURCE].[NumOfDaySinceLastRace]
			,[SOURCE].[RaceConditionLine1]
			,[SOURCE].[RaceConditionLine2]
			,[SOURCE].[RaceConditionLine3]
			,[SOURCE].[RaceConditionLine4]
			,[SOURCE].[RaceConditionLine5]
			,[SOURCE].[RaceConditionLine6]
			,[SOURCE].[LifetimeStartsAllWeather]
			,[SOURCE].[LifetimeWinsAllWeather]
			,[SOURCE].[LifetimePlacesAllWeather]
			,[SOURCE].[LifetimeShowsAllWeather]
			,CASE WHEN ISNULL([SOURCE].[LifetimeEarningsAllWeather], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifetimeEarningsAllWeather])) AS decimal(18, 2)) END
			,[SOURCE].[BestBRISSpeedAllWeather]
			,[SOURCE].[Reserved216]
			,CASE WHEN ISNULL([SOURCE].[LowClaimingPrice], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LowClaimingPrice])) AS decimal(18, 2)) END
			,[SOURCE].[StatebredFlag]
			,[SOURCE].[WagerTypes219]
			,[SOURCE].[WagerTypes220]
			,[SOURCE].[WagerTypes221]
			,[SOURCE].[WagerTypes222]
			,[SOURCE].[WagerTypes223]
			,[SOURCE].[WagerTypes224]
			,[SOURCE].[WagerTypes225]
			,[SOURCE].[WagerTypes226]
			,[SOURCE].[WagerTypes227]
			,CASE WHEN ISNULL([SOURCE].[SireStudFee], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[SireStudFee])) AS decimal(18, 2)) END
			,[SOURCE].[BestBRISSpeedFastTrack]
			,[SOURCE].[BestBRISSpeedTurf]
			,[SOURCE].[BestBRISSpeedOffTrack]
			,[SOURCE].[BestBRISSpeedDistance]
			,NULL
			,[SOURCE].[Reserved234]
	FROM kelso.brisnet_dr2_staging SOURCE
	LEFT JOIN kelso.brisnet_Races R ON( R.TrackCd = [SOURCE].[TrackCd]
									   AND R.RaceDt = CAST([SOURCE].[RaceDt] AS DATETIME)
									   AND R.RaceNum = CAST([SOURCE].[RaceNum] AS INT));

	MERGE kelso.brisnet_dr2 AS [TARGET]
	USING @brisnet_dr2 AS [SOURCE]
	ON ([SOURCE].[RaceId] = [TARGET].[RaceId] 
		AND [SOURCE].[PostPosition] = [TARGET].[PostPosition]) 
	WHEN MATCHED
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[Entry] = [SOURCE].[Entry] 
			,[TARGET].[ClaimingPrice] = [SOURCE].[ClaimingPrice]
			,[TARGET].[Trainer] = [SOURCE].[Trainer] 
			,[TARGET].[TrainerStartsCurrentMeet] = [SOURCE].[TrainerStartsCurrentMeet] 
			,[TARGET].[TrainerWinCurrentMeet] = [SOURCE].[TrainerWinCurrentMeet] 
			,[TARGET].[TrainerPlacesCurrentMeet] = [SOURCE].[TrainerPlacesCurrentMeet] 
			,[TARGET].[TrainerShowCurrentMeet] = [SOURCE].[TrainerShowCurrentMeet] 
			,[TARGET].[Jockey] = [SOURCE].[Jockey] 
			,[TARGET].[ApprenticeWeight] = [SOURCE].[ApprenticeWeight] 
			,[TARGET].[JockeyStartsCurrentMeet] = [SOURCE].[JockeyStartsCurrentMeet] 
			,[TARGET].[JockeyWinsCurrentMeet] = [SOURCE].[JockeyWinsCurrentMeet] 
			,[TARGET].[JockeyPlacesCurrentMeet] = [SOURCE].[JockeyPlacesCurrentMeet] 
			,[TARGET].[JockeyShowsCurrentMeet] = [SOURCE].[JockeyShowsCurrentMeet] 
			,[TARGET].[Owner] = [SOURCE].[Owner] 
			,[TARGET].[TrainerRecordCurrentYear] = [SOURCE].[TrainerRecordCurrentYear] 
			,[TARGET].[TrainerRecordPreviousYear] = [SOURCE].[TrainerRecordPreviousYear] 
			,[TARGET].[JockeyRecordCurrentYear] = [SOURCE].[JockeyRecordCurrentYear] 
			,[TARGET].[JockeyRecordPreviousYear] = [SOURCE].[JockeyRecordPreviousYear] 
			,[TARGET].[OwnersSilks] = [SOURCE].[OwnersSilks] 
			,[TARGET].[HorseName] = [SOURCE].[HorseName] 
			,[TARGET].[YearOfBirth] = [SOURCE].[YearOfBirth] 
			,[TARGET].[HorseFoalingMonth] = [SOURCE].[HorseFoalingMonth] 
			,[TARGET].[Reserved28] = [SOURCE].[Reserved28] 
			,[TARGET].[Sex] = [SOURCE].[Sex] 
			,[TARGET].[HorseColor] = [SOURCE].[HorseColor] 
			,[TARGET].[Weight] = [SOURCE].[Weight] 
			,[TARGET].[Sire] = [SOURCE].[Sire] 
			,[TARGET].[SireSire] = [SOURCE].[SireSire] 
			,[TARGET].[Dam] = [SOURCE].[Dam] 
			,[TARGET].[DamSire] = [SOURCE].[DamSire] 
			,[TARGET].[Breeder] = [SOURCE].[Breeder] 
			,[TARGET].[StateCountry] = [SOURCE].[StateCountry] 
			,[TARGET].[AuctionPrice] = [SOURCE].[AuctionPrice] 
			,[TARGET].[InfoSoldAtAuction] = [SOURCE].[InfoSoldAtAuction] 
			,[TARGET].[Reserved40] = [SOURCE].[Reserved40] 
			,[TARGET].[AEIndicator] = [SOURCE].[AEIndicator] 
			,[TARGET].[Medication1stLasixInfo] = [SOURCE].[Medication1stLasixInfo] 
			,[TARGET].[Medication1stWithOutLasixInfo] = [SOURCE].[Medication1stWithOutLasixInfo] 
			,[TARGET].[EquipmentChange] = [SOURCE].[EquipmentChange] 
			,[TARGET].[LifeTimeRecordTodayDistanceStarts] = [SOURCE].[LifeTimeRecordTodayDistanceStarts] 
			,[TARGET].[LifeTimeRecordTodayDistanceWins] = [SOURCE].[LifeTimeRecordTodayDistanceWins] 
			,[TARGET].[LifeTimeRecordTodayDistancePlaces] = [SOURCE].[LifeTimeRecordTodayDistancePlaces] 
			,[TARGET].[LifeTimeRecordTodayDistanceShows] = [SOURCE].[LifeTimeRecordTodayDistanceShows] 
			,[TARGET].[LifeTimeRecordTodayDistanceEarning] = [SOURCE].[LifeTimeRecordTodayDistanceEarning] 
			,[TARGET].[LifeTimeRecordTodayTrackStarts] = [SOURCE].[LifeTimeRecordTodayTrackStarts] 
			,[TARGET].[LifeTimeRecordTodayTrackWins] = [SOURCE].[LifeTimeRecordTodayTrackWins] 
			,[TARGET].[LifeTimeRecordTodayTrackPlaces] = [SOURCE].[LifeTimeRecordTodayTrackPlaces] 
			,[TARGET].[LifeTimeRecordTodayTrackShows] = [SOURCE].[LifeTimeRecordTodayTrackShows] 
			,[TARGET].[LifeTimeRecordTodayTrackEarning] = [SOURCE].[LifeTimeRecordTodayTrackEarning]
			,[TARGET].[LifeTimeTurfRecordStarts] = [SOURCE].[LifeTimeTurfRecordStarts] 
			,[TARGET].[LifeTimeTurfRecordWins] = [SOURCE].[LifeTimeTurfRecordWins] 
			,[TARGET].[LifeTimeTurfRecordPlaces] = [SOURCE].[LifeTimeTurfRecordPlaces] 
			,[TARGET].[LifeTimeTurfRecordShows] = [SOURCE].[LifeTimeTurfRecordShows] 
			,[TARGET].[LifeTimeTurfRecordEarning] = [SOURCE].[LifeTimeTurfRecordEarning]
			,[TARGET].[LifeTimeWetRecordStarts] = [SOURCE].[LifeTimeWetRecordStarts] 
			,[TARGET].[LifeTimeWetRecordWins] = [SOURCE].[LifeTimeWetRecordWins] 
			,[TARGET].[LifeTimeWetRecordPlaces] = [SOURCE].[LifeTimeWetRecordPlaces] 
			,[TARGET].[LifeTimeWetRecordShows] = [SOURCE].[LifeTimeWetRecordShows] 
			,[TARGET].[LifeTimeWetRecordEarning] = [SOURCE].[LifeTimeWetRecordEarning] 
			,[TARGET].[CurrentRecordYear] = [SOURCE].[CurrentRecordYear] 
			,[TARGET].[CurrentRecordStarts] = [SOURCE].[CurrentRecordStarts] 
			,[TARGET].[CurrentRecordWins] = [SOURCE].[CurrentRecordWins] 
			,[TARGET].[CurrentRecordPlaces] = [SOURCE].[CurrentRecordPlaces] 
			,[TARGET].[CurrentRecordShows] = [SOURCE].[CurrentRecordShows] 
			,[TARGET].[CurrentRecordEarning] = [SOURCE].[CurrentRecordEarning] 
			,[TARGET].[PreviousRecordYear] = [SOURCE].[PreviousRecordYear] 
			,[TARGET].[PreviousRecordStarts] = [SOURCE].[PreviousRecordStarts] 
			,[TARGET].[PreviousRecordWins] = [SOURCE].[PreviousRecordWins] 
			,[TARGET].[PreviousRecordPlaces] = [SOURCE].[PreviousRecordPlaces] 
			,[TARGET].[PreviousRecordShows] = [SOURCE].[PreviousRecordShows] 
			,[TARGET].[PreviousRecordEarning] = [SOURCE].[PreviousRecordEarning]
			,[TARGET].[LifetimeRecordStarts] = [SOURCE].[LifetimeRecordStarts] 
			,[TARGET].[LifetimeRecordWins] = [SOURCE].[LifetimeRecordWins] 
			,[TARGET].[LifetimeRecordPlaces] = [SOURCE].[LifetimeRecordPlaces] 
			,[TARGET].[LifetimeRecordShows] = [SOURCE].[LifetimeRecordShows] 
			,[TARGET].[LifetimeRecordEarning] = [SOURCE].[LifetimeRecordEarning]
			,[TARGET].[Workout1Date] = [SOURCE].[Workout1Date] 
			,[TARGET].[Workout2Date] = [SOURCE].[Workout2Date] 
			,[TARGET].[Workout3Date] = [SOURCE].[Workout3Date] 
			,[TARGET].[Workout4Date] = [SOURCE].[Workout4Date] 
			,[TARGET].[Workout5Date] = [SOURCE].[Workout5Date] 
			,[TARGET].[Workout6Date] = [SOURCE].[Workout6Date] 
			,[TARGET].[Workout7Date] = [SOURCE].[Workout7Date] 
			,[TARGET].[Workout8Date] = [SOURCE].[Workout8Date] 
			,[TARGET].[Workout9Date] = [SOURCE].[Workout9Date] 
			,[TARGET].[Workout10Date] = [SOURCE].[Workout10Date] 
			,[TARGET].[Workout11Date] = [SOURCE].[Workout11Date] 
			,[TARGET].[Workout12Date] = [SOURCE].[Workout12Date] 
			,[TARGET].[Workout1Time] = [SOURCE].[Workout1Time] 
			,[TARGET].[Workout2Time] = [SOURCE].[Workout2Time]
			,[TARGET].[Workout3Time] = [SOURCE].[Workout3Time]
			,[TARGET].[Workout4Time] = [SOURCE].[Workout4Time]
			,[TARGET].[Workout5Time] = [SOURCE].[Workout5Time]
			,[TARGET].[Workout6Time] = [SOURCE].[Workout6Time]
			,[TARGET].[Workout7Time] = [SOURCE].[Workout7Time]
			,[TARGET].[Workout8Time] = [SOURCE].[Workout8Time]
			,[TARGET].[Workout9Time] = [SOURCE].[Workout9Time]
			,[TARGET].[Workout10Time] = [SOURCE].[Workout10Time]
			,[TARGET].[Workout11Time] = [SOURCE].[Workout11Time]
			,[TARGET].[Workout12Time] = [SOURCE].[Workout12Time]
			,[TARGET].[Workout1Track] = [SOURCE].[Workout1Track]
			,[TARGET].[Workout2Track] = [SOURCE].[Workout2Track] 
			,[TARGET].[Workout3Track] = [SOURCE].[Workout3Track]
			,[TARGET].[Workout4Track] = [SOURCE].[Workout4Track]
			,[TARGET].[Workout5Track] = [SOURCE].[Workout5Track]
			,[TARGET].[Workout6Track] = [SOURCE].[Workout6Track] 
			,[TARGET].[Workout7Track] = [SOURCE].[Workout7Track]
			,[TARGET].[Workout8Track] = [SOURCE].[Workout8Track]
			,[TARGET].[Workout9Track] = [SOURCE].[Workout9Track]
			,[TARGET].[Workout10Track] = [SOURCE].[Workout10Track] 
			,[TARGET].[Workout11Track] = [SOURCE].[Workout11Track]
			,[TARGET].[Workout12Track] = [SOURCE].[Workout12Track] 
			,[TARGET].[Workout1Distance] = [SOURCE].[Workout1Distance]
			,[TARGET].[Workout2Distance] = [SOURCE].[Workout2Distance]
			,[TARGET].[Workout3Distance] = [SOURCE].[Workout3Distance]
			,[TARGET].[Workout4Distance] = [SOURCE].[Workout4Distance]
			,[TARGET].[Workout5Distance] = [SOURCE].[Workout5Distance]
			,[TARGET].[Workout6Distance] = [SOURCE].[Workout6Distance]
			,[TARGET].[Workout7Distance] = [SOURCE].[Workout7Distance]
			,[TARGET].[Workout8Distance] = [SOURCE].[Workout8Distance]
			,[TARGET].[Workout9Distance] = [SOURCE].[Workout9Distance]
			,[TARGET].[Workout10Distance] = [SOURCE].[Workout10Distance]
			,[TARGET].[Workout11Distance] = [SOURCE].[Workout11Distance]
			,[TARGET].[Workout12Distance] = [SOURCE].[Workout12Distance]
			,[TARGET].[WorkoutTrackCondition1] = [SOURCE].[WorkoutTrackCondition1] 
			,[TARGET].[WorkoutTrackCondition2] = [SOURCE].[WorkoutTrackCondition2] 
			,[TARGET].[WorkoutTrackCondition3] = [SOURCE].[WorkoutTrackCondition3] 
			,[TARGET].[WorkoutTrackCondition4] = [SOURCE].[WorkoutTrackCondition4] 
			,[TARGET].[WorkoutTrackCondition5] = [SOURCE].[WorkoutTrackCondition5] 
			,[TARGET].[WorkoutTrackCondition6] = [SOURCE].[WorkoutTrackCondition6] 
			,[TARGET].[WorkoutTrackCondition7] = [SOURCE].[WorkoutTrackCondition7] 
			,[TARGET].[WorkoutTrackCondition8] = [SOURCE].[WorkoutTrackCondition8] 
			,[TARGET].[WorkoutTrackCondition9] = [SOURCE].[WorkoutTrackCondition9] 
			,[TARGET].[WorkoutTrackCondition10] = [SOURCE].[WorkoutTrackCondition10] 
			,[TARGET].[WorkoutTrackCondition11] = [SOURCE].[WorkoutTrackCondition11] 
			,[TARGET].[WorkoutTrackCondition12] = [SOURCE].[WorkoutTrackCondition12] 
			,[TARGET].[Workout1Description] = [SOURCE].[Workout1Description] 
			,[TARGET].[Workout2Description] = [SOURCE].[Workout2Description] 
			,[TARGET].[Workout3Description] = [SOURCE].[Workout3Description] 
			,[TARGET].[Workout4Description] = [SOURCE].[Workout4Description] 
			,[TARGET].[Workout5Description] = [SOURCE].[Workout5Description] 
			,[TARGET].[Workout6Description] = [SOURCE].[Workout6Description] 
			,[TARGET].[Workout7Description] = [SOURCE].[Workout7Description] 
			,[TARGET].[Workout8Description] = [SOURCE].[Workout8Description] 
			,[TARGET].[Workout9Description] = [SOURCE].[Workout9Description] 
			,[TARGET].[Workout10Description] = [SOURCE].[Workout10Description] 
			,[TARGET].[Workout11Description] = [SOURCE].[Workout11Description] 
			,[TARGET].[Workout12Description] = [SOURCE].[Workout12Description] 
			,[TARGET].[MainInnerTrackIndicator1] = [SOURCE].[MainInnerTrackIndicator1] 
			,[TARGET].[MainInnerTrackIndicator2] = [SOURCE].[MainInnerTrackIndicator2] 
			,[TARGET].[MainInnerTrackIndicator3] = [SOURCE].[MainInnerTrackIndicator3] 
			,[TARGET].[MainInnerTrackIndicator4] = [SOURCE].[MainInnerTrackIndicator4] 
			,[TARGET].[MainInnerTrackIndicator5] = [SOURCE].[MainInnerTrackIndicator5] 
			,[TARGET].[MainInnerTrackIndicator6] = [SOURCE].[MainInnerTrackIndicator6] 
			,[TARGET].[MainInnerTrackIndicator7] = [SOURCE].[MainInnerTrackIndicator7] 
			,[TARGET].[MainInnerTrackIndicator8] = [SOURCE].[MainInnerTrackIndicator8] 
			,[TARGET].[MainInnerTrackIndicator9] = [SOURCE].[MainInnerTrackIndicator9] 
			,[TARGET].[MainInnerTrackIndicator10] = [SOURCE].[MainInnerTrackIndicator10] 
			,[TARGET].[MainInnerTrackIndicator11] = [SOURCE].[MainInnerTrackIndicator11] 
			,[TARGET].[MainInnerTrackIndicator12] = [SOURCE].[MainInnerTrackIndicator12] 
			,[TARGET].[NumberOfWorkout1] = [SOURCE].[NumberOfWorkout1] 
			,[TARGET].[NumberOfWorkout2] = [SOURCE].[NumberOfWorkout2] 
			,[TARGET].[NumberOfWorkout3] = [SOURCE].[NumberOfWorkout3] 
			,[TARGET].[NumberOfWorkout4] = [SOURCE].[NumberOfWorkout4] 
			,[TARGET].[NumberOfWorkout5] = [SOURCE].[NumberOfWorkout5] 
			,[TARGET].[NumberOfWorkout6] = [SOURCE].[NumberOfWorkout6] 
			,[TARGET].[NumberOfWorkout7] = [SOURCE].[NumberOfWorkout7] 
			,[TARGET].[NumberOfWorkout8] = [SOURCE].[NumberOfWorkout8] 
			,[TARGET].[NumberOfWorkout9] = [SOURCE].[NumberOfWorkout9] 
			,[TARGET].[NumberOfWorkout10] = [SOURCE].[NumberOfWorkout10] 
			,[TARGET].[NumberOfWorkout11] = [SOURCE].[NumberOfWorkout11] 
			,[TARGET].[NumberOfWorkout12] = [SOURCE].[NumberOfWorkout12] 
			,[TARGET].[WorkoutRank1] = [SOURCE].[WorkoutRank1] 
			,[TARGET].[WorkoutRank2] = [SOURCE].[WorkoutRank2] 
			,[TARGET].[WorkoutRank3] = [SOURCE].[WorkoutRank3] 
			,[TARGET].[WorkoutRank4] = [SOURCE].[WorkoutRank4] 
			,[TARGET].[WorkoutRank5] = [SOURCE].[WorkoutRank5] 
			,[TARGET].[WorkoutRank6] = [SOURCE].[WorkoutRank6] 
			,[TARGET].[WorkoutRank7] = [SOURCE].[WorkoutRank7] 
			,[TARGET].[WorkoutRank8] = [SOURCE].[WorkoutRank8] 
			,[TARGET].[WorkoutRank9] = [SOURCE].[WorkoutRank9] 
			,[TARGET].[WorkoutRank10] = [SOURCE].[WorkoutRank10] 
			,[TARGET].[WorkoutRank11] = [SOURCE].[WorkoutRank11] 
			,[TARGET].[WorkoutRank12] = [SOURCE].[WorkoutRank12] 
			,[TARGET].[BrisRunStyle] = [SOURCE].[BrisRunStyle] 
			,[TARGET].[QuirinSpeedPoints] = [SOURCE].[QuirinSpeedPoints] 
			,[TARGET].[Reserved191Reserved] = [SOURCE].[Reserved191Reserved] 
			,[TARGET].[Reserved192Reserved] = [SOURCE].[Reserved192Reserved] 
			,[TARGET].[Bris2fPaceFig] = [SOURCE].[Bris2fPaceFig] 
			,[TARGET].[Bris4fPaceFig] = [SOURCE].[Bris4fPaceFig] 
			,[TARGET].[Bris6fPaceFig] = [SOURCE].[Bris6fPaceFig] 
			,[TARGET].[BrisSpeedFig] = [SOURCE].[BrisSpeedFig] 
			,[TARGET].[BrisLatePace] = [SOURCE].[BrisLatePace] 
			,[TARGET].[Reserved198] = [SOURCE].[Reserved198] 
			,[TARGET].[Reserved199] = [SOURCE].[Reserved199] 
			,[TARGET].[ProgramPostPosition] = [SOURCE].[ProgramPostPosition] 
			,[TARGET].[ProgramNumber] = [SOURCE].[ProgramNumber] 
			,[TARGET].[MorningLine] = [SOURCE].[MorningLine] 
			,[TARGET].[NumOfDaySinceLastRace] = [SOURCE].[NumOfDaySinceLastRace] 
			,[TARGET].[RaceConditionLine1] = [SOURCE].[RaceConditionLine1] 
			,[TARGET].[RaceConditionLine2] = [SOURCE].[RaceConditionLine2] 
			,[TARGET].[RaceConditionLine3] = [SOURCE].[RaceConditionLine3] 
			,[TARGET].[RaceConditionLine4] = [SOURCE].[RaceConditionLine4] 
			,[TARGET].[RaceConditionLine5] = [SOURCE].[RaceConditionLine5] 
			,[TARGET].[RaceConditionLine6] = [SOURCE].[RaceConditionLine6] 
			,[TARGET].[LifetimeStartsAllWeather] = [SOURCE].[LifetimeStartsAllWeather] 
			,[TARGET].[LifetimeWinsAllWeather] = [SOURCE].[LifetimeWinsAllWeather] 
			,[TARGET].[LifetimePlacesAllWeather] = [SOURCE].[LifetimePlacesAllWeather] 
			,[TARGET].[LifetimeShowsAllWeather] = [SOURCE].[LifetimeShowsAllWeather] 
			,[TARGET].[LifetimeEarningsAllWeather] = [SOURCE].[LifetimeEarningsAllWeather] 
			,[TARGET].[BestBRISSpeedAllWeather] = [SOURCE].[BestBRISSpeedAllWeather] 
			,[TARGET].[Reserved216] = [SOURCE].[Reserved216] 
			,[TARGET].[LowClaimingPrice] = [SOURCE].[LowClaimingPrice] 
			,[TARGET].[StatebredFlag] = [SOURCE].[StatebredFlag] 
			,[TARGET].[WagerTypes219] = [SOURCE].[WagerTypes219] 
			,[TARGET].[WagerTypes220] = [SOURCE].[WagerTypes220] 
			,[TARGET].[WagerTypes221] = [SOURCE].[WagerTypes221] 
			,[TARGET].[WagerTypes222] = [SOURCE].[WagerTypes222] 
			,[TARGET].[WagerTypes223] = [SOURCE].[WagerTypes223] 
			,[TARGET].[WagerTypes224] = [SOURCE].[WagerTypes224] 
			,[TARGET].[WagerTypes225] = [SOURCE].[WagerTypes225] 
			,[TARGET].[WagerTypes226] = [SOURCE].[WagerTypes226] 
			,[TARGET].[WagerTypes227] = [SOURCE].[WagerTypes227] 
			,[TARGET].[SireStudFee] = [SOURCE].[SireStudFee]
			,[TARGET].[BestBRISSpeedFastTrack] = [SOURCE].[BestBRISSpeedFastTrack] 
			,[TARGET].[BestBRISSpeedTurf] = [SOURCE].[BestBRISSpeedTurf] 
			,[TARGET].[BestBRISSpeedOffTrack] = [SOURCE].[BestBRISSpeedOffTrack] 
			,[TARGET].[BestBRISSpeedDistance] = [SOURCE].[BestBRISSpeedDistance] 
			,[TARGET].[Reserved233] = NULL 
			,[TARGET].[Reserved234] = [SOURCE].[Reserved234] 
	WHEN NOT MATCHED 
	THEN INSERT ([RaceId]
				,[CreatedDt] 
				,[ModifiedDt]
				,[TrackCd]
				,[RaceDt] 
				,[RaceNum]
				,[PostPosition] 
				,[Entry] 
				,[ClaimingPrice] 
				,[Trainer] 
				,[TrainerStartsCurrentMeet] 
				,[TrainerWinCurrentMeet] 
				,[TrainerPlacesCurrentMeet] 
				,[TrainerShowCurrentMeet] 
				,[Jockey] 
				,[ApprenticeWeight] 
				,[JockeyStartsCurrentMeet] 
				,[JockeyWinsCurrentMeet] 
				,[JockeyPlacesCurrentMeet] 
				,[JockeyShowsCurrentMeet] 
				,[Owner] 
				,[TrainerRecordCurrentYear] 
				,[TrainerRecordPreviousYear] 
				,[JockeyRecordCurrentYear] 
				,[JockeyRecordPreviousYear] 
				,[OwnersSilks] 
				,[HorseName] 
				,[YearOfBirth] 
				,[HorseFoalingMonth] 
				,[Reserved28] 
				,[Sex] 
				,[HorseColor] 
				,[Weight] 
				,[Sire] 
				,[SireSire] 
				,[Dam] 
				,[DamSire] 
				,[Breeder] 
				,[StateCountry] 
				,[AuctionPrice] 
				,[InfoSoldAtAuction] 
				,[Reserved40] 
				,[AEIndicator] 
				,[Medication1stLasixInfo] 
				,[Medication1stWithOutLasixInfo] 
				,[EquipmentChange] 
				,[LifeTimeRecordTodayDistanceStarts] 
				,[LifeTimeRecordTodayDistanceWins] 
				,[LifeTimeRecordTodayDistancePlaces] 
				,[LifeTimeRecordTodayDistanceShows] 
				,[LifeTimeRecordTodayDistanceEarning] 
				,[LifeTimeRecordTodayTrackStarts] 
				,[LifeTimeRecordTodayTrackWins] 
				,[LifeTimeRecordTodayTrackPlaces] 
				,[LifeTimeRecordTodayTrackShows] 
				,[LifeTimeRecordTodayTrackEarning] 
				,[LifeTimeTurfRecordStarts] 
				,[LifeTimeTurfRecordWins] 
				,[LifeTimeTurfRecordPlaces] 
				,[LifeTimeTurfRecordShows] 
				,[LifeTimeTurfRecordEarning] 
				,[LifeTimeWetRecordStarts] 
				,[LifeTimeWetRecordWins] 
				,[LifeTimeWetRecordPlaces] 
				,[LifeTimeWetRecordShows] 
				,[LifeTimeWetRecordEarning] 
				,[CurrentRecordYear] 
				,[CurrentRecordStarts] 
				,[CurrentRecordWins] 
				,[CurrentRecordPlaces] 
				,[CurrentRecordShows] 
				,[CurrentRecordEarning] 
				,[PreviousRecordYear] 
				,[PreviousRecordStarts] 
				,[PreviousRecordWins] 
				,[PreviousRecordPlaces] 
				,[PreviousRecordShows] 
				,[PreviousRecordEarning] 
				,[LifetimeRecordStarts] 
				,[LifetimeRecordWins] 
				,[LifetimeRecordPlaces] 
				,[LifetimeRecordShows] 
				,[LifetimeRecordEarning] 
				,[Workout1Date] 
				,[Workout2Date] 
				,[Workout3Date] 
				,[Workout4Date] 
				,[Workout5Date] 
				,[Workout6Date] 
				,[Workout7Date] 
				,[Workout8Date] 
				,[Workout9Date] 
				,[Workout10Date] 
				,[Workout11Date] 
				,[Workout12Date] 
				,[Workout1Time] 
				,[Workout2Time] 
				,[Workout3Time] 
				,[Workout4Time] 
				,[Workout5Time] 
				,[Workout6Time] 
				,[Workout7Time] 
				,[Workout8Time] 
				,[Workout9Time] 
				,[Workout10Time] 
				,[Workout11Time] 
				,[Workout12Time]
				,[Workout1Track] 
				,[Workout2Track] 
				,[Workout3Track] 
				,[Workout4Track] 
				,[Workout5Track] 
				,[Workout6Track] 
				,[Workout7Track] 
				,[Workout8Track] 
				,[Workout9Track] 
				,[Workout10Track] 
				,[Workout11Track] 
				,[Workout12Track] 
				,[Workout1Distance] 
				,[Workout2Distance] 
				,[Workout3Distance] 
				,[Workout4Distance] 
				,[Workout5Distance] 
				,[Workout6Distance] 
				,[Workout7Distance] 
				,[Workout8Distance] 
				,[Workout9Distance] 
				,[Workout10Distance] 
				,[Workout11Distance] 
				,[Workout12Distance]
				,[WorkoutTrackCondition1] 
				,[WorkoutTrackCondition2] 
				,[WorkoutTrackCondition3] 
				,[WorkoutTrackCondition4] 
				,[WorkoutTrackCondition5] 
				,[WorkoutTrackCondition6] 
				,[WorkoutTrackCondition7] 
				,[WorkoutTrackCondition8] 
				,[WorkoutTrackCondition9] 
				,[WorkoutTrackCondition10] 
				,[WorkoutTrackCondition11] 
				,[WorkoutTrackCondition12] 
				,[Workout1Description] 
				,[Workout2Description] 
				,[Workout3Description] 
				,[Workout4Description] 
				,[Workout5Description] 
				,[Workout6Description] 
				,[Workout7Description] 
				,[Workout8Description] 
				,[Workout9Description] 
				,[Workout10Description] 
				,[Workout11Description] 
				,[Workout12Description] 
				,[MainInnerTrackIndicator1] 
				,[MainInnerTrackIndicator2] 
				,[MainInnerTrackIndicator3] 
				,[MainInnerTrackIndicator4] 
				,[MainInnerTrackIndicator5] 
				,[MainInnerTrackIndicator6] 
				,[MainInnerTrackIndicator7] 
				,[MainInnerTrackIndicator8] 
				,[MainInnerTrackIndicator9] 
				,[MainInnerTrackIndicator10] 
				,[MainInnerTrackIndicator11] 
				,[MainInnerTrackIndicator12] 
				,[NumberOfWorkout1] 
				,[NumberOfWorkout2] 
				,[NumberOfWorkout3] 
				,[NumberOfWorkout4] 
				,[NumberOfWorkout5] 
				,[NumberOfWorkout6] 
				,[NumberOfWorkout7] 
				,[NumberOfWorkout8] 
				,[NumberOfWorkout9] 
				,[NumberOfWorkout10] 
				,[NumberOfWorkout11] 
				,[NumberOfWorkout12] 
				,[WorkoutRank1] 
				,[WorkoutRank2] 
				,[WorkoutRank3] 
				,[WorkoutRank4] 
				,[WorkoutRank5] 
				,[WorkoutRank6] 
				,[WorkoutRank7] 
				,[WorkoutRank8] 
				,[WorkoutRank9] 
				,[WorkoutRank10] 
				,[WorkoutRank11] 
				,[WorkoutRank12] 
				,[BrisRunStyle] 
				,[QuirinSpeedPoints] 
				,[Reserved191Reserved] 
				,[Reserved192Reserved] 
				,[Bris2fPaceFig] 
				,[Bris4fPaceFig] 
				,[Bris6fPaceFig] 
				,[BrisSpeedFig] 
				,[BrisLatePace] 
				,[Reserved198] 
				,[Reserved199] 
				,[ProgramPostPosition] 
				,[ProgramNumber]
				,[MorningLine] 
				,[NumOfDaySinceLastRace] 
				,[RaceConditionLine1] 
				,[RaceConditionLine2] 
				,[RaceConditionLine3] 
				,[RaceConditionLine4] 
				,[RaceConditionLine5] 
				,[RaceConditionLine6] 
				,[LifetimeStartsAllWeather] 
				,[LifetimeWinsAllWeather] 
				,[LifetimePlacesAllWeather] 
				,[LifetimeShowsAllWeather] 
				,[LifetimeEarningsAllWeather] 
				,[BestBRISSpeedAllWeather] 
				,[Reserved216] 
				,[LowClaimingPrice] 
				,[StatebredFlag] 
				,[WagerTypes219] 
				,[WagerTypes220] 
				,[WagerTypes221] 
				,[WagerTypes222] 
				,[WagerTypes223] 
				,[WagerTypes224] 
				,[WagerTypes225] 
				,[WagerTypes226] 
				,[WagerTypes227] 
				,[SireStudFee] 
				,[BestBRISSpeedFastTrack] 
				,[BestBRISSpeedTurf] 
				,[BestBRISSpeedOffTrack] 
				,[BestBRISSpeedDistance] 
				,[Reserved233] 
				,[Reserved234] ) 
    VALUES ([SOURCE].[RaceId]
			 ,GETDATE()
			 ,GETDATE()
			 ,[SOURCE].[TrackCd]
			 ,[SOURCE].[RaceDt]
			 ,[SOURCE].[RaceNum]
			 ,[SOURCE].[PostPosition]
			 ,[SOURCE].[Entry]
			 ,[SOURCE].[ClaimingPrice]
			 ,[SOURCE].[Trainer]
			 ,[SOURCE].[TrainerStartsCurrentMeet]
			 ,[SOURCE].[TrainerWinCurrentMeet]
			 ,[SOURCE].[TrainerPlacesCurrentMeet]
			 ,[SOURCE].[TrainerShowCurrentMeet]
			 ,[SOURCE].[Jockey]
			 ,[SOURCE].[ApprenticeWeight]
			 ,[SOURCE].[JockeyStartsCurrentMeet]
			 ,[SOURCE].[JockeyWinsCurrentMeet]
			 ,[SOURCE].[JockeyPlacesCurrentMeet]
			 ,[SOURCE].[JockeyShowsCurrentMeet]
			 ,[SOURCE].[Owner]
			 ,[SOURCE].[TrainerRecordCurrentYear]
			 ,[SOURCE].[TrainerRecordPreviousYear]
			 ,[SOURCE].[JockeyRecordCurrentYear]
			 ,[SOURCE].[JockeyRecordPreviousYear]
			 ,[SOURCE].[OwnersSilks]
			 ,[SOURCE].[HorseName]
			 ,[SOURCE].[YearOfBirth]
			 ,[SOURCE].[HorseFoalingMonth]
			 ,[SOURCE].[Reserved28]
			 ,[SOURCE].[Sex]
			 ,[SOURCE].[HorseColor]
			 ,[SOURCE].[Weight]
			 ,[SOURCE].[Sire]
			 ,[SOURCE].[SireSire]
			 ,[SOURCE].[Dam]
			 ,[SOURCE].[DamSire]
			 ,[SOURCE].[Breeder]
			 ,[SOURCE].[StateCountry]
			 ,[SOURCE].[AuctionPrice]
			 ,[SOURCE].[InfoSoldAtAuction]
			 ,[SOURCE].[Reserved40]
			 ,[SOURCE].[AEIndicator]
			 ,[SOURCE].[Medication1stLasixInfo]
			 ,[SOURCE].[Medication1stWithOutLasixInfo]
			 ,[SOURCE].[EquipmentChange]
			 ,[SOURCE].[LifeTimeRecordTodayDistanceStarts]
			 ,[SOURCE].[LifeTimeRecordTodayDistanceWins]
			 ,[SOURCE].[LifeTimeRecordTodayDistancePlaces]
			 ,[SOURCE].[LifeTimeRecordTodayDistanceShows]
			 ,[SOURCE].[LifeTimeRecordTodayDistanceEarning]
			 ,[SOURCE].[LifeTimeRecordTodayTrackStarts]
			 ,[SOURCE].[LifeTimeRecordTodayTrackWins]
			 ,[SOURCE].[LifeTimeRecordTodayTrackPlaces]
			 ,[SOURCE].[LifeTimeRecordTodayTrackShows]
			 ,[SOURCE].[LifeTimeRecordTodayTrackEarning]
			 ,[SOURCE].[LifeTimeTurfRecordStarts]
			 ,[SOURCE].[LifeTimeTurfRecordWins]
			 ,[SOURCE].[LifeTimeTurfRecordPlaces]
			 ,[SOURCE].[LifeTimeTurfRecordShows]
			 ,[SOURCE].[LifeTimeTurfRecordEarning]
			 ,[SOURCE].[LifeTimeWetRecordStarts]
			 ,[SOURCE].[LifeTimeWetRecordWins]
			 ,[SOURCE].[LifeTimeWetRecordPlaces]
			 ,[SOURCE].[LifeTimeWetRecordShows]
			 ,[SOURCE].[LifeTimeWetRecordEarning]
			 ,[SOURCE].[CurrentRecordYear]
			 ,[SOURCE].[CurrentRecordStarts]
			 ,[SOURCE].[CurrentRecordWins]
			 ,[SOURCE].[CurrentRecordPlaces]
			 ,[SOURCE].[CurrentRecordShows]
			 ,[SOURCE].[CurrentRecordEarning]
			 ,[SOURCE].[PreviousRecordYear]
			 ,[SOURCE].[PreviousRecordStarts]
			 ,[SOURCE].[PreviousRecordWins]
			 ,[SOURCE].[PreviousRecordPlaces]
			 ,[SOURCE].[PreviousRecordShows]
			 ,[SOURCE].[PreviousRecordEarning]
			 ,[SOURCE].[LifetimeRecordStarts]
			 ,[SOURCE].[LifetimeRecordWins]
			 ,[SOURCE].[LifetimeRecordPlaces]
			 ,[SOURCE].[LifetimeRecordShows]
			 ,[SOURCE].[LifetimeRecordEarning]
			 ,[SOURCE].[Workout1Date]
			 ,[SOURCE].[Workout2Date]
			 ,[SOURCE].[Workout3Date]
			 ,[SOURCE].[Workout4Date]
			 ,[SOURCE].[Workout5Date]
			 ,[SOURCE].[Workout6Date]
			 ,[SOURCE].[Workout7Date]
			 ,[SOURCE].[Workout8Date]
			 ,[SOURCE].[Workout9Date]
			 ,[SOURCE].[Workout10Date]
			 ,[SOURCE].[Workout11Date]
			 ,[SOURCE].[Workout12Date]
			 ,[SOURCE].[Workout1Time]
			 ,[SOURCE].[Workout2Time]
			 ,[SOURCE].[Workout3Time]
			 ,[SOURCE].[Workout4Time]
			 ,[SOURCE].[Workout5Time]
			 ,[SOURCE].[Workout6Time]
			 ,[SOURCE].[Workout7Time]
			 ,[SOURCE].[Workout8Time]
			 ,[SOURCE].[Workout9Time]
			 ,[SOURCE].[Workout10Time]
			 ,[SOURCE].[Workout11Time]
			 ,[SOURCE].[Workout12Time]
			 ,[SOURCE].[Workout1Track]
			 ,[SOURCE].[Workout2Track]
			 ,[SOURCE].[Workout3Track]
			 ,[SOURCE].[Workout4Track]
			 ,[SOURCE].[Workout5Track]
			 ,[SOURCE].[Workout6Track]
			 ,[SOURCE].[Workout7Track]
			 ,[SOURCE].[Workout8Track]
			 ,[SOURCE].[Workout9Track]
			 ,[SOURCE].[Workout10Track]
			 ,[SOURCE].[Workout11Track]
			 ,[SOURCE].[Workout12Track]
			 ,[SOURCE].[Workout1Distance]
			 ,[SOURCE].[Workout2Distance]
			 ,[SOURCE].[Workout3Distance]
			 ,[SOURCE].[Workout4Distance]
			 ,[SOURCE].[Workout5Distance]
			 ,[SOURCE].[Workout6Distance]
			 ,[SOURCE].[Workout7Distance]
			 ,[SOURCE].[Workout8Distance]
			 ,[SOURCE].[Workout9Distance]
			 ,[SOURCE].[Workout10Distance]
			 ,[SOURCE].[Workout11Distance]
			 ,[SOURCE].[Workout12Distance]
			 ,[SOURCE].[WorkoutTrackCondition1]
			 ,[SOURCE].[WorkoutTrackCondition2]
			 ,[SOURCE].[WorkoutTrackCondition3]
			 ,[SOURCE].[WorkoutTrackCondition4]
			 ,[SOURCE].[WorkoutTrackCondition5]
			 ,[SOURCE].[WorkoutTrackCondition6]
			 ,[SOURCE].[WorkoutTrackCondition7]
			 ,[SOURCE].[WorkoutTrackCondition8]
			 ,[SOURCE].[WorkoutTrackCondition9]
			 ,[SOURCE].[WorkoutTrackCondition10]
			 ,[SOURCE].[WorkoutTrackCondition11]
			 ,[SOURCE].[WorkoutTrackCondition12]
			 ,[SOURCE].[Workout1Description]
			 ,[SOURCE].[Workout2Description]
			 ,[SOURCE].[Workout3Description]
			 ,[SOURCE].[Workout4Description]
			 ,[SOURCE].[Workout5Description]
			 ,[SOURCE].[Workout6Description]
			 ,[SOURCE].[Workout7Description]
			 ,[SOURCE].[Workout8Description]
			 ,[SOURCE].[Workout9Description]
			 ,[SOURCE].[Workout10Description]
			 ,[SOURCE].[Workout11Description]
			 ,[SOURCE].[Workout12Description]
			 ,[SOURCE].[MainInnerTrackIndicator1]
			 ,[SOURCE].[MainInnerTrackIndicator2]
			 ,[SOURCE].[MainInnerTrackIndicator3]
			 ,[SOURCE].[MainInnerTrackIndicator4]
			 ,[SOURCE].[MainInnerTrackIndicator5]
			 ,[SOURCE].[MainInnerTrackIndicator6]
			 ,[SOURCE].[MainInnerTrackIndicator7]
			 ,[SOURCE].[MainInnerTrackIndicator8]
			 ,[SOURCE].[MainInnerTrackIndicator9]
			 ,[SOURCE].[MainInnerTrackIndicator10]
			 ,[SOURCE].[MainInnerTrackIndicator11]
			 ,[SOURCE].[MainInnerTrackIndicator12]
			 ,[SOURCE].[NumberOfWorkout1]
			 ,[SOURCE].[NumberOfWorkout2]
			 ,[SOURCE].[NumberOfWorkout3]
			 ,[SOURCE].[NumberOfWorkout4]
			 ,[SOURCE].[NumberOfWorkout5]
			 ,[SOURCE].[NumberOfWorkout6]
			 ,[SOURCE].[NumberOfWorkout7]
			 ,[SOURCE].[NumberOfWorkout8]
			 ,[SOURCE].[NumberOfWorkout9]
			 ,[SOURCE].[NumberOfWorkout10]
			 ,[SOURCE].[NumberOfWorkout11]
			 ,[SOURCE].[NumberOfWorkout12]
			 ,[SOURCE].[WorkoutRank1]
			 ,[SOURCE].[WorkoutRank2]
			 ,[SOURCE].[WorkoutRank3]
			 ,[SOURCE].[WorkoutRank4]
			 ,[SOURCE].[WorkoutRank5]
			 ,[SOURCE].[WorkoutRank6]
			 ,[SOURCE].[WorkoutRank7]
			 ,[SOURCE].[WorkoutRank8]
			 ,[SOURCE].[WorkoutRank9]
			 ,[SOURCE].[WorkoutRank10]
			 ,[SOURCE].[WorkoutRank11]
			 ,[SOURCE].[WorkoutRank12]
			 ,[SOURCE].[BrisRunStyle]
			 ,[SOURCE].[QuirinSpeedPoints]
			 ,[SOURCE].[Reserved191Reserved]
			 ,[SOURCE].[Reserved192Reserved]
			 ,[SOURCE].[Bris2fPaceFig]
			 ,[SOURCE].[Bris4fPaceFig]
			 ,[SOURCE].[Bris6fPaceFig]
			 ,[SOURCE].[BrisSpeedFig]
			 ,[SOURCE].[BrisLatePace]
			 ,[SOURCE].[Reserved198]
			 ,[SOURCE].[Reserved199]
			 ,[SOURCE].[ProgramPostPosition]
			 ,[SOURCE].[ProgramNumber]
			 ,[SOURCE].[MorningLine]
			 ,[SOURCE].[NumOfDaySinceLastRace]
			 ,[SOURCE].[RaceConditionLine1]
			 ,[SOURCE].[RaceConditionLine2]
			 ,[SOURCE].[RaceConditionLine3]
			 ,[SOURCE].[RaceConditionLine4]
			 ,[SOURCE].[RaceConditionLine5]
			 ,[SOURCE].[RaceConditionLine6]
			 ,[SOURCE].[LifetimeStartsAllWeather]
			 ,[SOURCE].[LifetimeWinsAllWeather]
			 ,[SOURCE].[LifetimePlacesAllWeather]
			 ,[SOURCE].[LifetimeShowsAllWeather]
			 ,[SOURCE].[LifetimeEarningsAllWeather]
			 ,[SOURCE].[BestBRISSpeedAllWeather]
			 ,[SOURCE].[Reserved216]
			 ,[SOURCE].[LowClaimingPrice]
			 ,[SOURCE].[StatebredFlag]
			 ,[SOURCE].[WagerTypes219]
			 ,[SOURCE].[WagerTypes220]
			 ,[SOURCE].[WagerTypes221]
			 ,[SOURCE].[WagerTypes222]
			 ,[SOURCE].[WagerTypes223]
			 ,[SOURCE].[WagerTypes224]
			 ,[SOURCE].[WagerTypes225]
			 ,[SOURCE].[WagerTypes226]
			 ,[SOURCE].[WagerTypes227]
			 ,[SOURCE].[SireStudFee]
			 ,[SOURCE].[BestBRISSpeedFastTrack]
			 ,[SOURCE].[BestBRISSpeedTurf]
			 ,[SOURCE].[BestBRISSpeedOffTrack]
			 ,[SOURCE].[BestBRISSpeedDistance]
			 ,[SOURCE].[Reserved233]
			 ,[SOURCE].[Reserved234]);
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_dr3Merge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_dr3Merge]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @brisnet_dr3 TABLE
	(
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[HorseId] [uniqueidentifier] NULL,
		[HorseName] [varchar](100) NULL,
		[PostPosition] [int] NULL,
		[PreviousRaceDate] [datetime] NULL,
		[NumOfDaysSincePreviousRace] [int] NULL,
		[PreviousTrackName] [varchar](30) NULL,
		[PreviousTrackCd] [varchar](3) NULL,
		[PreviousRaceNum] [int] NULL,
		[TrackCondition] [varchar](2) NULL,
		[Distance] [decimal](18, 2) NULL,
		[Surface] [char](1) NULL,
		[SpecialChuteIndicator] [char](1) NULL,
		[NumOfEntrants] [int] NULL,
		[PreviousPostPosition] [int] NULL,
		[Equipment] [char](1) NULL,
		[Reserved18] [varchar](50) NULL,
		[Medication] [int] NULL,
		[TripComment] [varchar](100) NULL,
		[WinnerName] [varchar](50) NULL,
		[SecondPlaceFinisherName] [varchar](50) NULL,
		[ThirdPlaceFinisherName] [varchar](50) NULL,
		[WinnerWeight] [int] NULL,
		[SecondPlaceWeight] [int] NULL,
		[ThirdPlaceWeight] [int] NULL,
		[WinnerMargin] [decimal](18, 2) NULL,
		[SecondPlaceMargin] [decimal](18, 2) NULL,
		[ThirdPlaceMargin] [decimal](18, 2) NULL,
		[ExtraCommentLine] [varchar](200) NULL,
		[Weight] [int] NULL,
		[Odds] [decimal](18, 2) NULL,
		[Entry] [char](1) NULL,
		[RaceClassification] [varchar](25) NULL,
		[ClaimingPrice] [decimal](18, 2) NULL,
		[Purse] [decimal](18, 2) NULL,
		[StartCallPosition] [varchar](5) NULL,
		[FirstCallPosition] [varchar](5) NULL,
		[SecondCallPosition] [varchar](5) NULL,
		[GateCallPosition] [varchar](5) NULL,
		[StretchCallPosition] [varchar](5) NULL,
		[FinishPosition] [varchar](5) NULL,
		[MoneyPosition] [varchar](5) NULL,
		[StartCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StartCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[FirstCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FirstCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[SecondCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[SecondCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[Reserved50] [varchar](250) NULL,
		[Reserved51] [varchar](250) NULL,
		[StretchBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StretchBtnLngthsOnly] [decimal](18, 2) NULL,
		[FinishBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FinishCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[BrisRaceShapeSecondCall] [decimal](18, 2) NULL,
		[Bris2FPace] [int] NULL,
		[Bris4FPace] [int] NULL,
		[Bris6FPace] [int] NULL,
		[Bris8FPace] [int] NULL,
		[Bris10FPace] [int] NULL,
		[BrisLateFPace] [int] NULL,
		[BrisRaceShapeFirstCall] [int] NULL,
		[Reserved64] [int] NULL,
		[BrisSpeedRating] [int] NULL,
		[SpeedRating] [int] NULL,
		[TrackVariant] [int] NULL,
		[TwoFurlongFraction] [decimal](18, 2) NULL,
		[ThreeFurlongFraction] [decimal](18, 2) NULL,
		[FourFurlongFraction] [decimal](18, 2) NULL,
		[FiveFurlongFraction] [decimal](18, 2) NULL,
		[SixFurlongFraction] [decimal](18, 2) NULL,
		[SevenFurlongFraction] [decimal](18, 2) NULL,
		[EightFurlongFraction] [decimal](18, 2) NULL,
		[TenFurlongFraction] [decimal](18, 2) NULL,
		[TwelveFurlongFraction] [decimal](18, 2) NULL,
		[FourteenFurlongFraction] [decimal](18, 2) NULL,
		[SixteenFurlongFraction] [decimal](18, 2) NULL,
		[Fraction1] [decimal](18, 2) NULL,
		[Fraction2] [decimal](18, 2) NULL,
		[Fraction3] [decimal](18, 2) NULL,
		[Reserved82] [varchar](250) NULL,
		[Reserved83] [varchar](250) NULL,
		[FinalTime] [decimal](18, 2) NULL,
		[ClaimedCd] [char](10) NULL,
		[Trainer] [varchar](100) NULL,
		[Jockey] [varchar](100) NULL,
		[ApprenticeWtAllow] [int] NULL,
		[RaceType] [varchar](2) NULL,
		[AgeAndSexRestrictions] [varchar](3) NULL,
		[StatebredFlag] [char](1) NULL,
		[RestrictedQualifierFlag] [char](1) NULL,
		[FavoriteIndicator] [int] NULL,
		[FrontBandagesIndicator] [int] NULL,
		[BrisSpeedParPrior] [int] NULL,
		[BarShoe] [char](1) NULL,
		[CompanyLineCode] [varchar](5) NULL,
		[LowClaimingPriceOfRace] [decimal](18, 2) NULL,
		[HighClaimingPriceOfRace] [decimal](18, 2) NULL,
		[Reserved100] [varchar](250) NULL,
		[CodeForPriorStart] [char](1) NULL,
		[Reserved101] [varchar](250) NULL,
		[Reserved102] [varchar](250) NULL,
		[Reserved103] [varchar](250) NULL,
		[Reserved104] [varchar](250) NULL,
		[Reserved105] [varchar](250) NULL,
		[Reserved106] [varchar](250) NULL,
		[ExtendedStartComment] [varchar](250) NULL,
		[SealedTrackIndicator] [char](1) NULL,
		[PrevAllWeatherSurfaceFlag] [char](1) NULL,
		[Reserved110] [varchar](250) NULL,
		[Reserved111] [varchar](250) NULL,
		[Reserved112] [varchar](250) NULL,
		[Reserved113] [varchar](250) NULL,
		[Reserved114] [varchar](250) NULL,
		[Reserved115] [varchar](250) NULL,
		[Reserved116] [varchar](250) NULL,
		[Reserved117] [varchar](250) NULL,
		[Reserved118] [varchar](250) NULL,
		[Reserved119] [varchar](250) NULL,
		[Reserved120] [varchar](250) NULL,
		[Reserved121] [varchar](250) NULL,
		[Reserved122] [varchar](250) NULL
	);

	INSERT INTO @brisnet_dr3
	SELECT GETDATE()
		   ,GETDATE()
		   ,R.RaceId
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,R.HorseId
		   ,R.HorseName
		   ,[SOURCE].[PostPosition]
		   ,[SOURCE].[PreviousRaceDate]
		   ,[SOURCE].[NumOfDaysSincePreviousRace]
		   ,[SOURCE].[PreviousTrackName]
		   ,[SOURCE].[PreviousTrackCd]
		   ,[SOURCE].[PreviousRaceNum]
		   ,[SOURCE].[TrackCondition]
		   ,[SOURCE].[Distance]
		   ,[SOURCE].[Surface]
		   ,[SOURCE].[SpecialChuteIndicator]
		   ,[SOURCE].[NumOfEntrants]
		   ,[SOURCE].[PreviousPostPosition]
		   ,[SOURCE].[Equipment]
		   ,[SOURCE].[Reserved18]
		   ,[SOURCE].[Medication]
		   ,[SOURCE].[TripComment]
		   ,[SOURCE].[WinnerName]
		   ,[SOURCE].[SecondPlaceFinisherName]
		   ,[SOURCE].[ThirdPlaceFinisherName]
		   ,[SOURCE].[WinnerWeight]
		   ,[SOURCE].[SecondPlaceWeight]
		   ,[SOURCE].[ThirdPlaceWeight]
		   ,CASE WHEN ISNULL([SOURCE].[WinnerMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[WinnerMargin] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SecondPlaceMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondPlaceMargin] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[ThirdPlaceMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[ThirdPlaceMargin] AS DECIMAL(18,2)) END 
		   ,[SOURCE].[ExtraCommentLine]
		   ,[SOURCE].[Weight]
		   ,CASE WHEN ISNULL([SOURCE].[Odds], '') = '' THEN 0 ELSE CAST([SOURCE].[Odds] AS DECIMAL(18,2)) END
		   ,[SOURCE].[Entry]
		   ,[SOURCE].[RaceClassification]
		   ,CASE WHEN ISNULL([SOURCE].[ClaimingPrice], '') = '' THEN 0 ELSE CAST([SOURCE].[ClaimingPrice] AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[Purse], '') = '' THEN 0 ELSE CAST([SOURCE].[Purse] AS DECIMAL(18,2)) END 
		   ,[SOURCE].[StartCallPosition]
		   ,[SOURCE].[FirstCallPosition]
		   ,[SOURCE].[SecondCallPosition]
		   ,[SOURCE].[GateCallPosition]
		   ,[SOURCE].[StretchCallPosition]
		   ,[SOURCE].[FinishPosition]
		   ,[SOURCE].[MoneyPosition]
		   ,CASE WHEN ISNULL([SOURCE].[StartCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[StartCallBtnLngthLdrMargin]AS DECIMAL(18,2))END
		   ,CASE WHEN ISNULL([SOURCE].[StartCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[StartCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FirstCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[FirstCallBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FirstCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[FirstCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[SecondCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondCallBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[SecondCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,[SOURCE].[Reserved50]
		   ,[SOURCE].[Reserved51]
		   ,CASE WHEN ISNULL([SOURCE].[StretchBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[StretchBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[StretchBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[StretchBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FinishBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[FinishBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FinishCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[FinishCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[BrisRaceShapeSecondCall], '') = '' THEN 0 ELSE CAST([SOURCE].[BrisRaceShapeSecondCall]AS DECIMAL(18,2)) END
		   ,[SOURCE].[Bris2FPace]
		   ,[SOURCE].[Bris4FPace]
		   ,[SOURCE].[Bris6FPace]
		   ,[SOURCE].[Bris8FPace]
		   ,[SOURCE].[Bris10FPace]
		   ,[SOURCE].[BrisLateFPace]
		   ,[SOURCE].[BrisRaceShapeFirstCall]
		   ,[SOURCE].[Reserved64]
		   ,[SOURCE].[BrisSpeedRating]
		   ,[SOURCE].[SpeedRating]
		   ,[SOURCE].[TrackVariant]
		   ,CASE WHEN ISNULL([SOURCE].[TwoFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[TwoFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[ThreeFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[ThreeFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[FourFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[FourFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[FiveFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[FiveFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SixFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[SixFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SevenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[SevenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[EightFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[EightFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[TenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[TenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[TwelveFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[TwelveFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[FourteenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[FourteenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SixteenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[SixteenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[Fraction1], '') = '' THEN 0 ELSE CAST([SOURCE].[Fraction1] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[Fraction2], '') = '' THEN 0 ELSE CAST([SOURCE].[Fraction2] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[Fraction3], '') = '' THEN 0 ELSE CAST([SOURCE].[Fraction3] AS DECIMAL(18,2)) END 
		   ,[SOURCE].[Reserved82]
		   ,[SOURCE].[Reserved83]
		   ,CASE WHEN ISNULL([SOURCE].[FinalTime], '') = '' THEN 0 ELSE CAST([SOURCE].[FinalTime] AS DECIMAL(18,2)) END
		   ,[SOURCE].[ClaimedCd]
		   ,[SOURCE].[Trainer]
		   ,[SOURCE].[Jockey]
		   ,[SOURCE].[ApprenticeWtAllow]
		   ,[SOURCE].[RaceType]
		   ,[SOURCE].[AgeAndSexRestrictions]
		   ,[SOURCE].[StatebredFlag]
		   ,[SOURCE].[RestrictedQualifierFlag]
		   ,[SOURCE].[FavoriteIndicator]
		   ,[SOURCE].[FrontBandagesIndicator]
		   ,[SOURCE].[BrisSpeedParPrior]
		   ,[SOURCE].[BarShoe]
		   ,[SOURCE].[CompanyLineCode]
		   ,CASE WHEN ISNULL([SOURCE].[LowClaimingPriceOfRace], '') = '' THEN 0 ELSE CAST([SOURCE].[LowClaimingPriceOfRace]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[HighClaimingPriceOfRace], '') = '' THEN 0 ELSE CAST([SOURCE].[HighClaimingPriceOfRace]AS DECIMAL(18,2)) END
		   ,[SOURCE].[Reserved100]
		   ,[SOURCE].[CodeForPriorStart]
		   ,[SOURCE].[Reserved101]
		   ,[SOURCE].[Reserved102]
		   ,[SOURCE].[Reserved103]
		   ,[SOURCE].[Reserved104]
		   ,[SOURCE].[Reserved105]
		   ,[SOURCE].[Reserved106]
		   ,[SOURCE].[ExtendedStartComment]
		   ,[SOURCE].[SealedTrackIndicator]
		   ,[SOURCE].[PrevAllWeatherSurfaceFlag]
		   ,[SOURCE].[Reserved110]
		   ,[SOURCE].[Reserved111]
		   ,[SOURCE].[Reserved112]
		   ,[SOURCE].[Reserved113]
		   ,[SOURCE].[Reserved114]
		   ,[SOURCE].[Reserved115]
		   ,[SOURCE].[Reserved116]
		   ,[SOURCE].[Reserved117]
		   ,[SOURCE].[Reserved118]
		   ,[SOURCE].[Reserved119]
		   ,[SOURCE].[Reserved120]
		   ,[SOURCE].[Reserved121]
		   ,[SOURCE].[Reserved122]
	FROM kelso.brisnet_dr3_staging AS [SOURCE]
	JOIN kelso.brisnet_RaceParticipants R ON R.RaceDt = [SOURCE].RaceDt 
											 AND R.TrackCd = [SOURCE].TrackCd 
											 AND R.RaceNum = [SOURCE].RaceNum
											 AND R.PostPosition = [SOURCE].PostPosition;

	MERGE kelso.brisnet_dr3 AS [TARGET]
	USING @brisnet_dr3 AS [SOURCE]
	ON ([SOURCE].[RaceId] = [TARGET].[RaceId] 
		AND [SOURCE].[HorseId] = [TARGET].[HorseId]
		AND [SOURCE].[PreviousRaceDate] = [TARGET].[PreviousRaceDate]) 
	WHEN MATCHED
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[PreviousRaceDate] = [SOURCE].[PreviousRaceDate]
			,[TARGET].[NumOfDaysSincePreviousRace] = [SOURCE].[NumOfDaysSincePreviousRace]
			,[TARGET].[PreviousTrackName] = [SOURCE].[PreviousTrackName]
			,[TARGET].[PreviousTrackCd] = [SOURCE].[PreviousTrackCd]
			,[TARGET].[PreviousRaceNum] = [SOURCE].[PreviousRaceNum]
			,[TARGET].[TrackCondition] = [SOURCE].[TrackCondition]
			,[TARGET].[Distance] = [SOURCE].[Distance]
			,[TARGET].[Surface] = [SOURCE].[Surface]
			,[TARGET].[SpecialChuteIndicator] = [SOURCE].[SpecialChuteIndicator]
			,[TARGET].[NumOfEntrants] = [SOURCE].[NumOfEntrants]
			,[TARGET].[PreviousPostPosition] = [SOURCE].[PreviousPostPosition]
			,[TARGET].[Equipment] = [SOURCE].[Equipment]
			,[TARGET].[Reserved18] = [SOURCE].[Reserved18]
			,[TARGET].[Medication] = [SOURCE].[Medication]
			,[TARGET].[TripComment] = [SOURCE].[TripComment]
			,[TARGET].[WinnerName] = [SOURCE].[WinnerName]
			,[TARGET].[SecondPlaceFinisherName] = [SOURCE].[SecondPlaceFinisherName]
			,[TARGET].[ThirdPlaceFinisherName] = [SOURCE].[ThirdPlaceFinisherName]
			,[TARGET].[WinnerWeight] = [SOURCE].[WinnerWeight]
			,[TARGET].[SecondPlaceWeight] = [SOURCE].[SecondPlaceWeight]
			,[TARGET].[ThirdPlaceWeight] = [SOURCE].[ThirdPlaceWeight]
			,[TARGET].[WinnerMargin] = [SOURCE].[WinnerMargin]
			,[TARGET].[SecondPlaceMargin] = [SOURCE].[SecondPlaceMargin]
			,[TARGET].[ThirdPlaceMargin] = [SOURCE].[ThirdPlaceMargin]
			,[TARGET].[ExtraCommentLine] = [SOURCE].[ExtraCommentLine]
			,[TARGET].[Weight] = [SOURCE].[Weight]
			,[TARGET].[Odds] = [SOURCE].[Odds]
			,[TARGET].[Entry] = [SOURCE].[Entry]
			,[TARGET].[RaceClassification] = [SOURCE].[RaceClassification]
			,[TARGET].[ClaimingPrice] = [SOURCE].[ClaimingPrice]
			,[TARGET].[Purse] = [SOURCE].[Purse]
			,[TARGET].[StartCallPosition] = [SOURCE].[StartCallPosition]
			,[TARGET].[FirstCallPosition] = [SOURCE].[FirstCallPosition]
			,[TARGET].[SecondCallPosition] = [SOURCE].[SecondCallPosition]
			,[TARGET].[GateCallPosition] = [SOURCE].[GateCallPosition]
			,[TARGET].[StretchCallPosition] = [SOURCE].[StretchCallPosition]
			,[TARGET].[FinishPosition] = [SOURCE].[FinishPosition]
			,[TARGET].[MoneyPosition] = [SOURCE].[MoneyPosition]
			,[TARGET].[StartCallBtnLngthLdrMargin] = [SOURCE].[StartCallBtnLngthLdrMargin]
			,[TARGET].[StartCallBtnLngthsOnly] = [SOURCE].[StartCallBtnLngthsOnly]
			,[TARGET].[FirstCallBtnLngthLdrMargin] = [SOURCE].[FirstCallBtnLngthLdrMargin]
			,[TARGET].[FirstCallBtnLngthsOnly] = [SOURCE].[FirstCallBtnLngthsOnly]
			,[TARGET].[SecondCallBtnLngthLdrMargin] = [SOURCE].[SecondCallBtnLngthLdrMargin]
			,[TARGET].[SecondCallBtnLngthsOnly] = [SOURCE].[SecondCallBtnLngthsOnly]
			,[TARGET].[Reserved50] = [SOURCE].[Reserved50]
			,[TARGET].[Reserved51] = [SOURCE].[Reserved51]
			,[TARGET].[StretchBtnLngthLdrMargin] = [SOURCE].[StretchBtnLngthLdrMargin]
			,[TARGET].[StretchBtnLngthsOnly] = [SOURCE].[StretchBtnLngthsOnly]
			,[TARGET].[FinishBtnLngthLdrMargin] = [SOURCE].[FinishBtnLngthLdrMargin]
			,[TARGET].[FinishCallBtnLngthsOnly] = [SOURCE].[FinishCallBtnLngthsOnly]
			,[TARGET].[BrisRaceShapeSecondCall] = [SOURCE].[BrisRaceShapeSecondCall]
			,[TARGET].[Bris2FPace] = [SOURCE].[Bris2FPace]
			,[TARGET].[Bris4FPace] = [SOURCE].[Bris4FPace]
			,[TARGET].[Bris6FPace] = [SOURCE].[Bris6FPace]
			,[TARGET].[Bris8FPace] = [SOURCE].[Bris8FPace]
			,[TARGET].[Bris10FPace] = [SOURCE].[Bris10FPace]
			,[TARGET].[BrisLateFPace] = [SOURCE].[BrisLateFPace]
			,[TARGET].[BrisRaceShapeFirstCall] = [SOURCE].[BrisRaceShapeFirstCall]
			,[TARGET].[Reserved64] = [SOURCE].[Reserved64]
			,[TARGET].[BrisSpeedRating] = [SOURCE].[BrisSpeedRating]
			,[TARGET].[SpeedRating] = [SOURCE].[SpeedRating]
			,[TARGET].[TrackVariant] = [SOURCE].[TrackVariant]
			,[TARGET].[TwoFurlongFraction] = [SOURCE].[TwoFurlongFraction]
			,[TARGET].[ThreeFurlongFraction] = [SOURCE].[ThreeFurlongFraction]
			,[TARGET].[FourFurlongFraction] = [SOURCE].[FourFurlongFraction]
			,[TARGET].[FiveFurlongFraction] = [SOURCE].[FiveFurlongFraction]
			,[TARGET].[SixFurlongFraction] = [SOURCE].[SixFurlongFraction]
			,[TARGET].[SevenFurlongFraction] = [SOURCE].[SevenFurlongFraction]
			,[TARGET].[EightFurlongFraction] = [SOURCE].[EightFurlongFraction]
			,[TARGET].[TenFurlongFraction] = [SOURCE].[TenFurlongFraction]
			,[TARGET].[TwelveFurlongFraction] = [SOURCE].[TwelveFurlongFraction]
			,[TARGET].[FourteenFurlongFraction] = [SOURCE].[FourteenFurlongFraction]
			,[TARGET].[SixteenFurlongFraction] = [SOURCE].[SixteenFurlongFraction]
			,[TARGET].[Fraction1] = [SOURCE].[Fraction1]
			,[TARGET].[Fraction2] = [SOURCE].[Fraction2]
			,[TARGET].[Fraction3] = [SOURCE].[Fraction3]
			,[TARGET].[Reserved82] = [SOURCE].[Reserved82]
			,[TARGET].[Reserved83] = [SOURCE].[Reserved83]
			,[TARGET].[FinalTime] = [SOURCE].[FinalTime]
			,[TARGET].[ClaimedCd] = [SOURCE].[ClaimedCd]
			,[TARGET].[Trainer] = [SOURCE].[Trainer]
			,[TARGET].[Jockey] = [SOURCE].[Jockey]
			,[TARGET].[ApprenticeWtAllow] = [SOURCE].[ApprenticeWtAllow]
			,[TARGET].[RaceType] = [SOURCE].[RaceType]
			,[TARGET].[AgeAndSexRestrictions] = [SOURCE].[AgeAndSexRestrictions]
			,[TARGET].[StatebredFlag] = [SOURCE].[StatebredFlag]
			,[TARGET].[RestrictedQualifierFlag] = [SOURCE].[RestrictedQualifierFlag]
			,[TARGET].[FavoriteIndicator] = [SOURCE].[FavoriteIndicator]
			,[TARGET].[FrontBandagesIndicator] = [SOURCE].[FrontBandagesIndicator]
			,[TARGET].[BrisSpeedParPrior] = [SOURCE].[BrisSpeedParPrior]
			,[TARGET].[BarShoe] = [SOURCE].[BarShoe]
			,[TARGET].[CompanyLineCode] = [SOURCE].[CompanyLineCode]
			,[TARGET].[LowClaimingPriceOfRace] = [SOURCE].[LowClaimingPriceOfRace]
			,[TARGET].[HighClaimingPriceOfRace] = [SOURCE].[HighClaimingPriceOfRace]
			,[TARGET].[Reserved100] = [SOURCE].[Reserved100]
			,[TARGET].[CodeForPriorStart] = [SOURCE].[CodeForPriorStart]
			,[TARGET].[Reserved101] = [SOURCE].[Reserved101]
			,[TARGET].[Reserved102] = [SOURCE].[Reserved102]
			,[TARGET].[Reserved103] = [SOURCE].[Reserved103]
			,[TARGET].[Reserved104] = [SOURCE].[Reserved104]
			,[TARGET].[Reserved105] = [SOURCE].[Reserved105]
			,[TARGET].[Reserved106] = [SOURCE].[Reserved106]
			,[TARGET].[ExtendedStartComment] = [SOURCE].[ExtendedStartComment]
			,[TARGET].[SealedTrackIndicator] = [SOURCE].[SealedTrackIndicator]
			,[TARGET].[PrevAllWeatherSurfaceFlag] = [SOURCE].[PrevAllWeatherSurfaceFlag]
			,[TARGET].[Reserved110] = [SOURCE].[Reserved110]
			,[TARGET].[Reserved111] = [SOURCE].[Reserved111]
			,[TARGET].[Reserved112] = [SOURCE].[Reserved112]
			,[TARGET].[Reserved113] = [SOURCE].[Reserved113]
			,[TARGET].[Reserved114] = [SOURCE].[Reserved114]
			,[TARGET].[Reserved115] = [SOURCE].[Reserved115]
			,[TARGET].[Reserved116] = [SOURCE].[Reserved116]
			,[TARGET].[Reserved117] = [SOURCE].[Reserved117]
			,[TARGET].[Reserved118] = [SOURCE].[Reserved118]
			,[TARGET].[Reserved119] = [SOURCE].[Reserved119]
			,[TARGET].[Reserved120] = [SOURCE].[Reserved120]
			,[TARGET].[Reserved121]  = [SOURCE].[Reserved121] 
			,[TARGET].[Reserved122] = [SOURCE].[Reserved122]
	WHEN NOT MATCHED 
	THEN INSERT ([RaceId]
				,[CreatedDt]
				,[ModifiedDt]
				,[TrackCd]
				,[RaceDt]
				,[RaceNum]
				,[HorseId]
				,[HorseName]
				,[PostPosition]
				,[PreviousRaceDate]
				,[NumOfDaysSincePreviousRace]
				,[PreviousTrackName]
				,[PreviousTrackCd]
				,[PreviousRaceNum]
				,[TrackCondition]
				,[Distance]
				,[Surface]
				,[SpecialChuteIndicator]
				,[NumOfEntrants]
				,[PreviousPostPosition]
				,[Equipment]
				,[Reserved18]
				,[Medication]
				,[TripComment]
				,[WinnerName]
				,[SecondPlaceFinisherName]
				,[ThirdPlaceFinisherName]
				,[WinnerWeight]
				,[SecondPlaceWeight]
				,[ThirdPlaceWeight]
				,[WinnerMargin]
				,[SecondPlaceMargin]
				,[ThirdPlaceMargin]
				,[ExtraCommentLine]
				,[Weight]
				,[Odds]
				,[Entry]
				,[RaceClassification]
				,[ClaimingPrice]
				,[Purse]
				,[StartCallPosition]
				,[FirstCallPosition]
				,[SecondCallPosition]
				,[GateCallPosition]
				,[StretchCallPosition]
				,[FinishPosition]
				,[MoneyPosition]
				,[StartCallBtnLngthLdrMargin]
				,[StartCallBtnLngthsOnly]
				,[FirstCallBtnLngthLdrMargin]
				,[FirstCallBtnLngthsOnly]
				,[SecondCallBtnLngthLdrMargin]
				,[SecondCallBtnLngthsOnly]
				,[Reserved50]
				,[Reserved51]
				,[StretchBtnLngthLdrMargin]
				,[StretchBtnLngthsOnly]
				,[FinishBtnLngthLdrMargin]
				,[FinishCallBtnLngthsOnly]
				,[BrisRaceShapeSecondCall]
				,[Bris2FPace]
				,[Bris4FPace]
				,[Bris6FPace]
				,[Bris8FPace]
				,[Bris10FPace]
				,[BrisLateFPace]
				,[BrisRaceShapeFirstCall]
				,[Reserved64]
				,[BrisSpeedRating]
				,[SpeedRating]
				,[TrackVariant]
				,[TwoFurlongFraction]
				,[ThreeFurlongFraction]
				,[FourFurlongFraction]
				,[FiveFurlongFraction]
				,[SixFurlongFraction]
				,[SevenFurlongFraction]
				,[EightFurlongFraction]
				,[TenFurlongFraction]
				,[TwelveFurlongFraction]
				,[FourteenFurlongFraction]
				,[SixteenFurlongFraction]
				,[Fraction1]
				,[Fraction2]
				,[Fraction3]
				,[Reserved82]
				,[Reserved83]
				,[FinalTime]
				,[ClaimedCd]
				,[Trainer]
				,[Jockey]
				,[ApprenticeWtAllow]
				,[RaceType]
				,[AgeAndSexRestrictions]
				,[StatebredFlag]
				,[RestrictedQualifierFlag]
				,[FavoriteIndicator]
				,[FrontBandagesIndicator]
				,[BrisSpeedParPrior]
				,[BarShoe]
				,[CompanyLineCode]
				,[LowClaimingPriceOfRace]
				,[HighClaimingPriceOfRace]
				,[Reserved100]
				,[CodeForPriorStart]
				,[Reserved101]
				,[Reserved102]
				,[Reserved103]
				,[Reserved104]
				,[Reserved105]
				,[Reserved106]
				,[ExtendedStartComment]
				,[SealedTrackIndicator]
				,[PrevAllWeatherSurfaceFlag]
				,[Reserved110]
				,[Reserved111]
				,[Reserved112]
				,[Reserved113]
				,[Reserved114]
				,[Reserved115]
				,[Reserved116]
				,[Reserved117]
				,[Reserved118]
				,[Reserved119]
				,[Reserved120]
				,[Reserved121] 
				,[Reserved122]) 
    VALUES ([SOURCE].[RaceId]
				,GETDATE()
				,GETDATE()
				,[SOURCE].[TrackCd]
				,[SOURCE].[RaceDt]
				,[SOURCE].[RaceNum]
				,[SOURCE].[HorseId]
				,[SOURCE].[HorseName]
				,[SOURCE].[PostPosition]
				,[SOURCE].[PreviousRaceDate]
				,[SOURCE].[NumOfDaysSincePreviousRace]
				,[SOURCE].[PreviousTrackName]
				,[SOURCE].[PreviousTrackCd]
				,[SOURCE].[PreviousRaceNum]
				,[SOURCE].[TrackCondition]
				,[SOURCE].[Distance]
				,[SOURCE].[Surface]
				,[SOURCE].[SpecialChuteIndicator]
				,[SOURCE].[NumOfEntrants]
				,[SOURCE].[PreviousPostPosition]
				,[SOURCE].[Equipment]
				,[SOURCE].[Reserved18]
				,[SOURCE].[Medication]
				,[SOURCE].[TripComment]
				,[SOURCE].[WinnerName]
				,[SOURCE].[SecondPlaceFinisherName]
				,[SOURCE].[ThirdPlaceFinisherName]
				,[SOURCE].[WinnerWeight]
				,[SOURCE].[SecondPlaceWeight]
				,[SOURCE].[ThirdPlaceWeight]
				,[SOURCE].[WinnerMargin]
				,[SOURCE].[SecondPlaceMargin]
				,[SOURCE].[ThirdPlaceMargin]
				,[SOURCE].[ExtraCommentLine]
				,[SOURCE].[Weight]
				,[SOURCE].[Odds]
				,[SOURCE].[Entry]
				,[SOURCE].[RaceClassification]
				,[SOURCE].[ClaimingPrice]
				,[SOURCE].[Purse]
				,[SOURCE].[StartCallPosition]
				,[SOURCE].[FirstCallPosition]
				,[SOURCE].[SecondCallPosition]
				,[SOURCE].[GateCallPosition]
				,[SOURCE].[StretchCallPosition]
				,[SOURCE].[FinishPosition]
				,[SOURCE].[MoneyPosition]
				,[SOURCE].[StartCallBtnLngthLdrMargin]
				,[SOURCE].[StartCallBtnLngthsOnly]
				,[SOURCE].[FirstCallBtnLngthLdrMargin]
				,[SOURCE].[FirstCallBtnLngthsOnly]
				,[SOURCE].[SecondCallBtnLngthLdrMargin]
				,[SOURCE].[SecondCallBtnLngthsOnly]
				,[SOURCE].[Reserved50]
				,[SOURCE].[Reserved51]
				,[SOURCE].[StretchBtnLngthLdrMargin]
				,[SOURCE].[StretchBtnLngthsOnly]
				,[SOURCE].[FinishBtnLngthLdrMargin]
				,[SOURCE].[FinishCallBtnLngthsOnly]
				,[SOURCE].[BrisRaceShapeSecondCall]
				,[SOURCE].[Bris2FPace]
				,[SOURCE].[Bris4FPace]
				,[SOURCE].[Bris6FPace]
				,[SOURCE].[Bris8FPace]
				,[SOURCE].[Bris10FPace]
				,[SOURCE].[BrisLateFPace]
				,[SOURCE].[BrisRaceShapeFirstCall]
				,[SOURCE].[Reserved64]
				,[SOURCE].[BrisSpeedRating]
				,[SOURCE].[SpeedRating]
				,[SOURCE].[TrackVariant]
				,[SOURCE].[TwoFurlongFraction]
				,[SOURCE].[ThreeFurlongFraction]
				,[SOURCE].[FourFurlongFraction]
				,[SOURCE].[FiveFurlongFraction] 
				,[SOURCE].[SixFurlongFraction]
				,[SOURCE].[SevenFurlongFraction]
				,[SOURCE].[EightFurlongFraction]
				,[SOURCE].[TenFurlongFraction]
				,[SOURCE].[TwelveFurlongFraction]
				,[SOURCE].[FourteenFurlongFraction]
				,[SOURCE].[SixteenFurlongFraction]
				,[SOURCE].[Fraction1]
				,[SOURCE].[Fraction2]
				,[SOURCE].[Fraction3]
				,[SOURCE].[Reserved82]
				,[SOURCE].[Reserved83]
				,[SOURCE].[FinalTime]
				,[SOURCE].[ClaimedCd]
				,[SOURCE].[Trainer]
				,[SOURCE].[Jockey]
				,[SOURCE].[ApprenticeWtAllow]
				,[SOURCE].[RaceType]
				,[SOURCE].[AgeAndSexRestrictions]
				,[SOURCE].[StatebredFlag]
				,[SOURCE].[RestrictedQualifierFlag]
				,[SOURCE].[FavoriteIndicator]
				,[SOURCE].[FrontBandagesIndicator]
				,[SOURCE].[BrisSpeedParPrior]
				,[SOURCE].[BarShoe]
				,[SOURCE].[CompanyLineCode]
				,[SOURCE].[LowClaimingPriceOfRace]
				,[SOURCE].[HighClaimingPriceOfRace]
				,[SOURCE].[Reserved100]
				,[SOURCE].[CodeForPriorStart]
				,[SOURCE].[Reserved101]
				,[SOURCE].[Reserved102]
				,[SOURCE].[Reserved103]
				,[SOURCE].[Reserved104]
				,[SOURCE].[Reserved105]
				,[SOURCE].[Reserved106]
				,[SOURCE].[ExtendedStartComment]
				,[SOURCE].[SealedTrackIndicator]
				,[SOURCE].[PrevAllWeatherSurfaceFlag]
				,[SOURCE].[Reserved110]
				,[SOURCE].[Reserved111]
				,[SOURCE].[Reserved112]
				,[SOURCE].[Reserved113]
				,[SOURCE].[Reserved114]
				,[SOURCE].[Reserved115]
				,[SOURCE].[Reserved116]
				,[SOURCE].[Reserved117]
				,[SOURCE].[Reserved118]
				,[SOURCE].[Reserved119]
				,[SOURCE].[Reserved120]
				,[SOURCE].[Reserved121]
				,[SOURCE].[Reserved122]);

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_dr4Insert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_dr4Insert]
AS
BEGIN
INSERT INTO [kelso].[brisnet_dr4]
           ([RaceId]
           ,[CreatedDt]
           ,[ModifiedDt]
           ,[TrackCd]
           ,[RaceDt]
           ,[RaceNum]
		   ,[HorseId]
		   ,[HorseName]
           ,[PostPosition]
           ,[BRISPrimePowerRating]
           ,[BRISDirtPedigreeRating]
           ,[BRISMudPedigreeRating]
           ,[BRISTurfPedigreeRating]
           ,[BRISDistPedigreeRating]
           ,[BestBRISSpeedLife]
           ,[BestBRISSpeedMostRecentYr]
           ,[BestBRISSpeedSecondMostRecentYr]
           ,[BestBRISSpeedTrack]
           ,[NumOfStartsFASTDirt]
           ,[NumOfWinsFASTDirt]
           ,[NumOfPlacesFASTDirt]
           ,[NumOfShowsFASTDirt]
           ,[NumOfEarningsFASTDirt]
           ,[TrntStatCategory1]
           ,[NumOfStarts1]
           ,[WinPercentage1]
           ,[InTheMoneyPercentage1]
           ,[ReturnOfInvestment1]
           ,[TrntStatCategory2]
           ,[NumOfStarts2]
           ,[WinPercentage2]
           ,[InTheMoneyPercentage2]
           ,[ReturnOfInvestment2]
           ,[TrntStatCategory3]
           ,[NumOfStarts3]
           ,[WinPercentage3]
           ,[InTheMoneyPercentage3]
           ,[ReturnOfInvestment3]
           ,[TrntStatCategory4]
           ,[NumOfStarts4]
           ,[WinPercentage4]
           ,[InTheMoneyPercentage4]
           ,[ReturnOfInvestment4]
           ,[TrntStatCategory5]
           ,[NumOfStarts5]
           ,[WinPercentage5]
           ,[InTheMoneyPercentage5]
           ,[ReturnOfInvestment5]
           ,[TrntStatCategory6]
           ,[NumOfStarts6]
           ,[WinPercentage6]
           ,[InTheMoneyPercentage6]
           ,[ReturnOfInvestment6]
           ,[Reserved49]
           ,[JKYDistanceTurfLabel]
           ,[JKYDistanceTurfStarts]
           ,[JKYDistanceTurfWins]
           ,[JKYDistanceTurfPlaces]
           ,[JKYDistanceTurfShows]
           ,[JKYDistanceTurfROI]
           ,[JKYDistanceTurfEarnings]
           ,[Reserved57]
           ,[Reserved58]
           ,[Reserved59]
           ,[Reserved60]
           ,[Reserved61]
           ,[Reserved62]
           ,[Reserved63]
           ,[Reserved64]
           ,[Reserved65]
           ,[Reserved66]
           ,[Reserved67]
           ,[Reserved68]
           ,[Reserved69]
           ,[Reserved70]
           ,[Reserved71]
           ,[Reserved72]
           ,[Reserved73]
           ,[Reserved74]
           ,[Reserved75]
           ,[Reserved76]
           ,[Reserved77]
           ,[Reserved78]
           ,[Reserved79]
           ,[Reserved80]
           ,[Reserved81]
           ,[Reserved82]
           ,[Reserved83]
           ,[Reserved84]
           ,[Reserved85]
           ,[Reserved86]
           ,[Reserved87]
           ,[Reserved88]
           ,[Reserved89]
           ,[Reserved90]
           ,[Reserved91]
           ,[Reserved92]
           ,[Reserved93]
           ,[Reserved94]
           ,[Reserved95]
           ,[Reserved96]
           ,[Reserved97]
           ,[Reserved98]
           ,[Reserved99]
           ,[Reserved100]
           ,[Reserved101]
           ,[Reserved102]
           ,[Reserved103]
           ,[Reserved104]
           ,[Reserved105]
           ,[Reserved106]
           ,[Reserved107]
           ,[Reserved108]
           ,[Reserved109]
           ,[Reserved110]
           ,[Reserved111]
           ,[Reserved112]
           ,[Reserved113]
           ,[Reserved114]
           ,[Reserved115]
           ,[Reserved116]
           ,[Reserved117]
           ,[Reserved118]
           ,[Reserved119]
           ,[Reserved120]
           ,[Reserved121]
           ,[Reserved122]
           ,[Reserved123]
           ,[Reserved124]
           ,[Reserved125]
           ,[Reserved126]
           ,[Reserved127]
           ,[Reserved128]
           ,[Reserved129]
           ,[Reserved130]
           ,[Reserved131]
           ,[Reserved132]
           ,[Reserved133]
           ,[Reserved134]
           ,[Reserved135]
           ,[Reserved136]
           ,[Reserved137]
           ,[Reserved138]
           ,[Reserved139]
           ,[Reserved140]
           ,[Reserved141]
           ,[Reserved142]
           ,[Reserved143]
           ,[Reserved144]
           ,[Reserved145]
           ,[Reserved146]
           ,[Reserved147]
           ,[Reserved148]
           ,[Reserved149]
           ,[Reserved150]
           ,[Reserved151]
           ,[Reserved152]
           ,[Reserved153]
           ,[Reserved154]
           ,[Reserved155]
           ,[Reserved156]
           ,[Reserved157]
           ,[Reserved158]
           ,[Reserved159]
           ,[Reserved160]
           ,[Reserved161]
           ,[Reserved162]
           ,[Reserved163]
           ,[Reserved164]
           ,[Reserved165]
           ,[Reserved166]
           ,[Reserved167]
           ,[Reserved168]
           ,[Reserved169]
           ,[Reserved170]
           ,[Reserved171]
           ,[Reserved172]
           ,[Reserved173]
           ,[Reserved174]
           ,[Reserved175]
           ,[Reserved176]
           ,[Reserved177]
           ,[Reserved178]
           ,[Reserved179]
           ,[Reserved180]
           ,[Reserved181]
           ,[Reserved182]
           ,[Reserved183]
           ,[Reserved184]
           ,[Reserved185]
           ,[Reserved186]
           ,[Reserved187]
           ,[Reserved188]
           ,[Reserved189]
           ,[Reserved190]
           ,[Reserved191]
           ,[Reserved192]
           ,[Reserved193]
           ,[Reserved194]
           ,[Reserved195]
           ,[Reserved196]
           ,[Reserved197]
           ,[Reserved198]
           ,[Reserved199]
           ,[Reserved200]
           ,[Reserved201]
           ,[Reserved202]
           ,[Reserved203]
           ,[Reserved204]
           ,[Reserved205]
           ,[Reserved206]
           ,[Reserved207]
           ,[Reserved208]
           ,[Reserved209]
           ,[Reserved210]
           ,[Reserved211]
           ,[Reserved212]
           ,[Reserved213]
           ,[Reserved214]
           ,[Reserved215]
           ,[Reserved216]
           ,[Reserved217]
           ,[Reserved218]
           ,[Reserved219]
           ,[Reserved220]
           ,[Reserved221]
           ,[Reserved222]
           ,[Reserved223]
           ,[Reserved224]
           ,[Reserved225]
           ,[Reserved226]
           ,[Reserved227]
           ,[Reserved228]
           ,[Reserved229]
           ,[Reserved230]
           ,[Reserved231]
           ,[Reserved232]
           ,[Reserved233]
           ,[Reserved234]
           ,[Reserved235]
           ,[Reserved236]
           ,[Reserved237]
           ,[Reserved238]
           ,[Reserved239]
           ,[Reserved240]
           ,[Reserved241]
           ,[Reserved242]
           ,[Reserved243]
           ,[Reserved244]
           ,[Reserved245]
           ,[Reserved246]
           ,[Reserved247]
           ,[Reserved248]
           ,[Reserved249]
           ,[Reserved250]
           ,[Reserved251]
           ,[Reserved252]
           ,[Reserved253]
           ,[Reserved254])
     SELECT R.RaceId
	        ,GETDATE()
	        ,GETDATE()
		    ,[SOURCE].[TrackCd]
			,[SOURCE].[RaceDt]
			,[SOURCE].[RaceNum]
			,[H].[HorseId]
			,[H].[HorseName]
			,[SOURCE].[PostPosition]
			,[SOURCE].[BRISPrimePowerRating]
			,REPLACE(REPLACE(REPLACE([SOURCE].[BRISDirtPedigreeRating], '?', ''), '*', ''), 'X', '')
			,REPLACE(REPLACE(REPLACE([SOURCE].[BRISMudPedigreeRating], '?', ''), '*', ''), 'X', '')
			,REPLACE(REPLACE(REPLACE([SOURCE].[BRISTurfPedigreeRating], '?', ''), '*', ''), 'X', '')
			,REPLACE(REPLACE(REPLACE([SOURCE].[BRISDistPedigreeRating], '?', ''), '*', ''), 'X', '')
			,REPLACE(REPLACE(REPLACE([SOURCE].[BestBRISSpeedLife], '?', ''), '*', ''), 'X', '')
			,[SOURCE].[BestBRISSpeedMostRecentYr]
			,[SOURCE].[BestBRISSpeedSecondMostRecentYr]
			,[SOURCE].[BestBRISSpeedTrack]
			,[SOURCE].[NumOfStartsFASTDirt]
			,[SOURCE].[NumOfWinsFASTDirt]
			,[SOURCE].[NumOfPlacesFASTDirt]
			,[SOURCE].[NumOfShowsFASTDirt]
			,CASE WHEN ISNULL([SOURCE].[NumOfEarningsFASTDirt], '') = '' THEN 0 ELSE CAST([SOURCE].[NumOfEarningsFASTDirt] AS DECIMAL(18, 2)) END
			,[SOURCE].[TrntStatCategory1]
			,[SOURCE].[NumOfStarts1]
			,CASE WHEN ISNULL([SOURCE].[WinPercentage1], '') = '' THEN 0 ELSE CAST([SOURCE].[WinPercentage1] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[InTheMoneyPercentage1], 0) = '' THEN 0 ELSE CAST([SOURCE].[InTheMoneyPercentage1] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[ReturnOfInvestment1], 0) = '' THEN 0 ELSE CAST([SOURCE].[ReturnOfInvestment1] AS DECIMAL(18, 2)) END
			,[SOURCE].[TrntStatCategory2]
			,[SOURCE].[NumOfStarts2]
			,CASE WHEN ISNULL([SOURCE].[WinPercentage2], '') = '' THEN 0 ELSE CAST([SOURCE].[WinPercentage2] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[InTheMoneyPercentage2], 0) = '' THEN 0 ELSE CAST([SOURCE].[InTheMoneyPercentage2] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[ReturnOfInvestment2], 0) = '' THEN 0 ELSE CAST([SOURCE].[ReturnOfInvestment2] AS DECIMAL(18, 2)) END
			,[SOURCE].[TrntStatCategory3]
			,[SOURCE].[NumOfStarts3]
			,CASE WHEN ISNULL([SOURCE].[WinPercentage3], '') = '' THEN 0 ELSE CAST([SOURCE].[WinPercentage3] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[InTheMoneyPercentage3], 0) = '' THEN 0 ELSE CAST([SOURCE].[InTheMoneyPercentage3] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[ReturnOfInvestment3], 0) = '' THEN 0 ELSE CAST([SOURCE].[ReturnOfInvestment3] AS DECIMAL(18, 2)) END
			,[SOURCE].[TrntStatCategory4]
			,[SOURCE].[NumOfStarts4]
			,CASE WHEN ISNULL([SOURCE].[WinPercentage4], '') = '' THEN 0 ELSE CAST([SOURCE].[WinPercentage4] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[InTheMoneyPercentage4], 0) = '' THEN 0 ELSE CAST([SOURCE].[InTheMoneyPercentage4] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[ReturnOfInvestment4], 0) = '' THEN 0 ELSE CAST([SOURCE].[ReturnOfInvestment4] AS DECIMAL(18, 2)) END
			,[SOURCE].[TrntStatCategory5]
			,[SOURCE].[NumOfStarts5]
			,CASE WHEN ISNULL([SOURCE].[WinPercentage5], '') = '' THEN 0 ELSE CAST([SOURCE].[WinPercentage5] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[InTheMoneyPercentage5], 0) = '' THEN 0 ELSE CAST([SOURCE].[InTheMoneyPercentage5] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[ReturnOfInvestment5], 0) = '' THEN 0 ELSE CAST([SOURCE].[ReturnOfInvestment5] AS DECIMAL(18, 2)) END
			,[SOURCE].[TrntStatCategory6]
			,[SOURCE].[NumOfStarts6]
			,CASE WHEN ISNULL([SOURCE].[WinPercentage6], '') = '' THEN 0 ELSE CAST([SOURCE].[WinPercentage6] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[InTheMoneyPercentage6], 0) = '' THEN 0 ELSE CAST([SOURCE].[InTheMoneyPercentage6] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[ReturnOfInvestment6], 0) = '' THEN 0 ELSE CAST([SOURCE].[ReturnOfInvestment6] AS DECIMAL(18, 2)) END
			,[SOURCE].[Reserved49]
			,[SOURCE].[JKYDistanceTurfLabel]
			,[SOURCE].[JKYDistanceTurfStarts]
			,[SOURCE].[JKYDistanceTurfWins]
			,[SOURCE].[JKYDistanceTurfPlaces]
			,[SOURCE].[JKYDistanceTurfShows]
			,CASE WHEN ISNULL([SOURCE].[JKYDistanceTurfROI], '') = '' THEN 0 ELSE CAST([SOURCE].[JKYDistanceTurfROI] AS DECIMAL(18, 2)) END
			,CASE WHEN ISNULL([SOURCE].[JKYDistanceTurfEarnings], '') = '' THEN 0 ELSE CAST([SOURCE].[JKYDistanceTurfEarnings] AS DECIMAL(18,2)) END
			,[SOURCE].[Reserved57]
			,[SOURCE].[Reserved58]
			,[SOURCE].[Reserved59]
			,[SOURCE].[Reserved60]
			,[SOURCE].[Reserved61]
			,[SOURCE].[Reserved62]
			,[SOURCE].[Reserved63]
			,[SOURCE].[Reserved64]
			,[SOURCE].[Reserved65]
			,[SOURCE].[Reserved66]
			,[SOURCE].[Reserved67]
			,[SOURCE].[Reserved68]
			,[SOURCE].[Reserved69]
			,[SOURCE].[Reserved70]
			,[SOURCE].[Reserved71]
			,[SOURCE].[Reserved72]
			,[SOURCE].[Reserved73]
			,[SOURCE].[Reserved74]
			,[SOURCE].[Reserved75]
			,[SOURCE].[Reserved76]
			,[SOURCE].[Reserved77]
			,[SOURCE].[Reserved78]
			,[SOURCE].[Reserved79]
			,[SOURCE].[Reserved80]
			,[SOURCE].[Reserved81]
			,[SOURCE].[Reserved82]
			,[SOURCE].[Reserved83]
			,[SOURCE].[Reserved84]
			,[SOURCE].[Reserved85]
			,[SOURCE].[Reserved86]
			,[SOURCE].[Reserved87]
			,[SOURCE].[Reserved88]
			,[SOURCE].[Reserved89]
			,[SOURCE].[Reserved90]
			,[SOURCE].[Reserved91]
			,[SOURCE].[Reserved92]
			,[SOURCE].[Reserved93]
			,[SOURCE].[Reserved94]
			,[SOURCE].[Reserved95]
			,[SOURCE].[Reserved96]
			,[SOURCE].[Reserved97]
			,[SOURCE].[Reserved98]
			,[SOURCE].[Reserved99]
			,[SOURCE].[Reserved100]
			,[SOURCE].[Reserved101]
			,[SOURCE].[Reserved102]
			,[SOURCE].[Reserved103]
			,[SOURCE].[Reserved104]
			,[SOURCE].[Reserved105]
			,[SOURCE].[Reserved106]
			,[SOURCE].[Reserved107]
			,[SOURCE].[Reserved108]
			,[SOURCE].[Reserved109]
			,[SOURCE].[Reserved110]
			,[SOURCE].[Reserved111]
			,[SOURCE].[Reserved112]
			,[SOURCE].[Reserved113]
			,[SOURCE].[Reserved114]
			,[SOURCE].[Reserved115]
			,[SOURCE].[Reserved116]
			,[SOURCE].[Reserved117]
			,[SOURCE].[Reserved118]
			,[SOURCE].[Reserved119]
			,[SOURCE].[Reserved120]
			,[SOURCE].[Reserved121]
			,[SOURCE].[Reserved122]
			,[SOURCE].[Reserved123]
			,[SOURCE].[Reserved124]
			,[SOURCE].[Reserved125]
			,[SOURCE].[Reserved126]
			,[SOURCE].[Reserved127]
			,[SOURCE].[Reserved128]
			,[SOURCE].[Reserved129]
			,[SOURCE].[Reserved130]
			,[SOURCE].[Reserved131]
			,[SOURCE].[Reserved132]
			,[SOURCE].[Reserved133]
			,[SOURCE].[Reserved134]
			,[SOURCE].[Reserved135]
			,[SOURCE].[Reserved136]
			,[SOURCE].[Reserved137]
			,[SOURCE].[Reserved138]
			,[SOURCE].[Reserved139]
			,[SOURCE].[Reserved140]
			,[SOURCE].[Reserved141]
			,[SOURCE].[Reserved142]
			,[SOURCE].[Reserved143]
			,[SOURCE].[Reserved144]
			,[SOURCE].[Reserved145]
			,[SOURCE].[Reserved146]
			,[SOURCE].[Reserved147]
			,[SOURCE].[Reserved148]
			,[SOURCE].[Reserved149]
			,[SOURCE].[Reserved150]
			,[SOURCE].[Reserved151]
			,[SOURCE].[Reserved152]
			,[SOURCE].[Reserved153]
			,[SOURCE].[Reserved154]
			,[SOURCE].[Reserved155]
			,[SOURCE].[Reserved156]
			,[SOURCE].[Reserved157]
			,[SOURCE].[Reserved158]
			,[SOURCE].[Reserved159]
			,[SOURCE].[Reserved160]
			,[SOURCE].[Reserved161]
			,[SOURCE].[Reserved162]
			,[SOURCE].[Reserved163]
			,[SOURCE].[Reserved164]
			,[SOURCE].[Reserved165]
			,[SOURCE].[Reserved166]
			,[SOURCE].[Reserved167]
			,[SOURCE].[Reserved168]
			,[SOURCE].[Reserved169]
			,[SOURCE].[Reserved170]
			,[SOURCE].[Reserved171]
			,[SOURCE].[Reserved172]
			,[SOURCE].[Reserved173]
			,[SOURCE].[Reserved174]
			,[SOURCE].[Reserved175]
			,[SOURCE].[Reserved176]
			,[SOURCE].[Reserved177]
			,[SOURCE].[Reserved178]
			,[SOURCE].[Reserved179]
			,[SOURCE].[Reserved180]
			,[SOURCE].[Reserved181]
			,[SOURCE].[Reserved182]
			,[SOURCE].[Reserved183]
			,[SOURCE].[Reserved184]
			,[SOURCE].[Reserved185]
			,[SOURCE].[Reserved186]
			,[SOURCE].[Reserved187]
			,[SOURCE].[Reserved188]
			,[SOURCE].[Reserved189]
			,[SOURCE].[Reserved190]
			,[SOURCE].[Reserved191]
			,[SOURCE].[Reserved192]
			,[SOURCE].[Reserved193]
			,[SOURCE].[Reserved194]
			,[SOURCE].[Reserved195]
			,[SOURCE].[Reserved196]
			,[SOURCE].[Reserved197]
			,[SOURCE].[Reserved198]
			,[SOURCE].[Reserved199]
			,[SOURCE].[Reserved200]
			,[SOURCE].[Reserved201]
			,[SOURCE].[Reserved202]
			,[SOURCE].[Reserved203]
			,[SOURCE].[Reserved204]
			,[SOURCE].[Reserved205]
			,[SOURCE].[Reserved206]
			,[SOURCE].[Reserved207]
			,[SOURCE].[Reserved208]
			,[SOURCE].[Reserved209]
			,[SOURCE].[Reserved210]
			,[SOURCE].[Reserved211]
			,[SOURCE].[Reserved212]
			,[SOURCE].[Reserved213]
			,[SOURCE].[Reserved214]
			,[SOURCE].[Reserved215]
			,[SOURCE].[Reserved216]
			,[SOURCE].[Reserved217]
			,[SOURCE].[Reserved218]
			,[SOURCE].[Reserved219]
			,[SOURCE].[Reserved220]
			,[SOURCE].[Reserved221]
			,[SOURCE].[Reserved222]
			,[SOURCE].[Reserved223]
			,[SOURCE].[Reserved224]
			,[SOURCE].[Reserved225]
			,[SOURCE].[Reserved226]
			,[SOURCE].[Reserved227]
			,[SOURCE].[Reserved228]
			,[SOURCE].[Reserved229]
			,[SOURCE].[Reserved230]
			,[SOURCE].[Reserved231]
			,[SOURCE].[Reserved232]
			,[SOURCE].[Reserved233]
			,[SOURCE].[Reserved234]
			,[SOURCE].[Reserved235]
			,[SOURCE].[Reserved236]
			,[SOURCE].[Reserved237]
			,[SOURCE].[Reserved238]
			,[SOURCE].[Reserved239]
			,[SOURCE].[Reserved240]
			,[SOURCE].[Reserved241]
			,[SOURCE].[Reserved242]
			,[SOURCE].[Reserved243]
			,[SOURCE].[Reserved244]
			,[SOURCE].[Reserved245]
			,[SOURCE].[Reserved246]
			,[SOURCE].[Reserved247]
			,[SOURCE].[Reserved248]
			,[SOURCE].[Reserved249]
			,[SOURCE].[Reserved250]
			,[SOURCE].[Reserved251]
			,[SOURCE].[Reserved252]
			,[SOURCE].[Reserved253]
			,[SOURCE].[Reserved254]
  FROM [kelso].[brisnet_dr4_staging] [SOURCE]
  LEFT JOIN [kelso].[brisnet_dr4] [TARGET] ON [TARGET].[TrackCd] = [SOURCE].[TrackCd]
											  AND [TARGET].[RaceDt] = [SOURCE].[RaceDt]
											  AND [TARGET].[RaceNum] = [SOURCE].[RaceNum]
											  AND [TARGET].[PostPosition] = [SOURCE].[PostPosition]
  LEFT JOIN [kelso].[brisnet_dr2] [DR2] ON  [DR2].[TrackCd] = [SOURCE].[TrackCd]
											AND [DR2].[RaceDt] = [SOURCE].[RaceDt]
											AND [DR2].[RaceNum] = [SOURCE].[RaceNum]
											AND [DR2].[PostPosition] = [SOURCE].[PostPosition]
  JOIN [kelso].[brisnet_Horses] H ON H.HorseName = DR2.HorseName
  LEFT JOIN [kelso].[brisnet_Races] R ON R.RaceDt = SOURCE.RaceDt
									   AND R.TrackCd = SOURCE.TrackCd
									   AND R.RaceNum = SOURCE.RaceNum
  WHERE [TARGET].[TrackCd] IS NULL;
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_drfMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_drfMerge]
	@FileId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @TrackCd VARCHAR(75) = NULL;
	DECLARE @RaceDt DATE;
	DECLARE @RaceNum INT;

	IF NOT EXISTS (SELECT 0
				   FROM kelso.brisnet_Races
				   WHERE FileId = @FileId)
	BEGIN
		INSERT INTO kelso.brisnet_Races
		SELECT GETDATE()
			   ,GETDATE()
			   ,@FileId
			   ,NEWID()
			   ,D.TrackCd
			   ,ISNULL(T.TrackName, D.TrackCd)
			   ,CAST(D.[RaceDt] AS DATETIME)
			   ,CAST(D.[RaceNum] AS INT)
			   ,CAST(CAST(D.Distance AS DECIMAL(18,2)) / 220.00 AS DECIMAL(18,2))
			   ,D.Distance
			   ,CAST((CAST(D.Distance AS DECIMAL(18,2)) * 3.00) AS DECIMAL(18,2))
			   ,D.Surface 
			   ,D.RaceType 
			   ,D.Purse
			   ,D.ClaimingPrice
			   ,D.TrackRecord
		FROM kelso.brisnet_drf_staging D
		LEFT JOIN kelso.brisnet_Tracks T ON T.TrackCd = D.TrackCd;
	END

	DECLARE @brisnet_drf TABLE
	(
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[FileId] UNIQUEIDENTIFIER NOT NULL,
		[RaceId] UNIQUEIDENTIFIER NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NOT NULL,
		[RaceNum] [int] NULL,
		[Distance] [decimal](18, 2) NULL,
		[Surface] [char](1) NULL,
		[AllWeatherSurfaceFlag] [char](1) NULL,
		[RaceType] [varchar](5) NULL,
		[AgeSexRestrictions] [varchar](5) NULL,
		[Reserved9] [varchar](50) NULL,
		[Purse] [decimal](18, 0) NULL,
		[ClaimingPrice] [decimal](18, 0) NULL,
		[TrackRecord] [decimal](18, 2) NULL,
		[RaceConditions] [varchar](500) NULL,
		[LasixList] [varchar](500) NULL,
		[ButeList] [varchar](500) NULL,
		[CoupledList] [varchar](500) NULL,
		[MutuelList] [varchar](500) NULL,
		[SimulcastTrackCd] [varchar](3) NULL,
		[SimulcastTrackRaceNum] [varchar](50) NULL,
		[Reserved20] [varchar](500) NULL,
		[Reserved21] [varchar](500) NULL,
		[Reserved22] [varchar](500) NULL,
		[PostTimes] [varchar](50) NULL,
		[Reserved24] [varchar](500) NULL
	);

	INSERT INTO @brisnet_drf
	SELECT GETDATE()
		   ,GETDATE()
		   ,@FileId
	     ,[R].[RaceId]
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[Distance]
		   ,[SOURCE].[Surface]
		   ,[SOURCE].[AllWeatherSurfaceFlag]
		   ,[SOURCE].[RaceType]
		   ,[SOURCE].[AgeSexRestrictions]
		   ,[SOURCE].[Reserved9]
		   ,CASE WHEN ISNULL([SOURCE].[Purse], '') = '' THEN 0 ELSE [SOURCE].[Purse] END
		   ,CASE WHEN ISNULL([SOURCE].[ClaimingPrice], '') = '' THEN 0 ELSE [SOURCE].[ClaimingPrice] END
		   ,CASE WHEN ISNULL([SOURCE].[TrackRecord], '') = '' THEN 0 ELSE CAST([SOURCE].[TrackRecord] AS decimal(18,2)) END
		   ,[SOURCE].[RaceConditions]
		   ,[SOURCE].[LasixList]
		   ,[SOURCE].[ButeList]
		   ,[SOURCE].[CoupledList]
		   ,[SOURCE].[MutuelList]
		   ,[SOURCE].[SimulcastTrackCd]
		   ,[SOURCE].[SimulcastTrackRaceNum]
		   ,[SOURCE].[Reserved20]
		   ,[SOURCE].[Reserved21]
		   ,[SOURCE].[Reserved22]
		   ,[SOURCE].[PostTimes]
		   ,[SOURCE].[Reserved24]
	FROM kelso.brisnet_drf_staging SOURCE
	LEFT JOIN kelso.brisnet_Races R ON R.RaceDt = SOURCE.RaceDt
									   AND R.TrackCd = SOURCE.TrackCd
									   AND R.RaceNum = SOURCE.RaceNum
									   AND R.DistanceYard = SOURCE.Distance
	LEFT JOIN kelso.brisnet_drf DRF ON DRF.RaceDt = SOURCE.RaceDt
									   AND DRF.TrackCd = SOURCE.TrackCd
									   AND DRF.RaceNum = SOURCE.RaceNum
									   AND DRF.Distance = SOURCE.Distance;

	MERGE kelso.brisnet_drf AS [TARGET]
    USING @brisnet_drf [SOURCE]
    ON ([SOURCE].[RaceId] = [TARGET].[RaceId])
	WHEN MATCHED
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[Surface] = [SOURCE].[Surface]
			,[TARGET].[AllWeatherSurfaceFlag] = [SOURCE].[AllWeatherSurfaceFlag]
			,[TARGET].[RaceType] = [SOURCE].[RaceType]
			,[TARGET].[AgeSexRestrictions] = [SOURCE].[AgeSexRestrictions]
			,[TARGET].[Reserved9] = [SOURCE].[Reserved9]
			,[TARGET].[Purse] = [SOURCE].[Purse]
			,[TARGET].[ClaimingPrice] = [SOURCE].[ClaimingPrice] 
			,[TARGET].[TrackRecord] = [SOURCE].[TrackRecord]
			,[TARGET].[RaceConditions] = [SOURCE].[RaceConditions]
			,[TARGET].[LasixList] = [SOURCE].[LasixList]
			,[TARGET].[ButeList] = [SOURCE].[ButeList]
			,[TARGET].[CoupledList] = [SOURCE].[CoupledList]
			,[TARGET].[MutuelList] = [SOURCE].[MutuelList]
			,[TARGET].[SimulcastTrackCd] = [SOURCE].[SimulcastTrackCd]
			,[TARGET].[SimulcastTrackRaceNum] = [SOURCE].[SimulcastTrackRaceNum]
			,[TARGET].[Reserved20] = [SOURCE].[Reserved20]
			,[TARGET].[Reserved21] = [SOURCE].[Reserved21]
			,[TARGET].[Reserved22] = [SOURCE].[Reserved22]
			,[TARGET].[PostTimes] = [SOURCE].[PostTimes]
			,[TARGET].[Reserved24] = [SOURCE].[Reserved24]
	WHEN NOT MATCHED 
    THEN INSERT ([FileId]
	        ,[RaceId]
				  ,[CreatedDt]
			    ,[ModifiedDt]
			    ,[TrackCd]
			    ,[RaceDt]
			    ,[RaceNum]
			    ,[Distance]
			    ,[Surface]
			    ,[AllWeatherSurfaceFlag]
			    ,[RaceType]
			    ,[AgeSexRestrictions]
			    ,[Reserved9]
			    ,[Purse]
			    ,[ClaimingPrice]
			    ,[TrackRecord]
			    ,[RaceConditions]
			    ,[LasixList]
			    ,[ButeList]
			    ,[CoupledList]
			    ,[MutuelList]
			    ,[SimulcastTrackCd]
			    ,[SimulcastTrackRaceNum]
			    ,[Reserved20]
			    ,[Reserved21]
			    ,[Reserved22]
			    ,[PostTimes]
			    ,[Reserved24]) 
  VALUES ([SOURCE].[FileId]
				  ,[SOURCE].[RaceId]
				  ,GETDATE()
			    ,GETDATE()
			    ,[SOURCE].[TrackCd]
			    ,[SOURCE].[RaceDt]
			    ,[SOURCE].[RaceNum]
			    ,[SOURCE].[Distance]
			    ,[SOURCE].[Surface]
			    ,[SOURCE].[AllWeatherSurfaceFlag]
			    ,[SOURCE].[RaceType]
			    ,[SOURCE].[AgeSexRestrictions]
			    ,[SOURCE].[Reserved9]
			    ,[SOURCE].[Purse]
			    ,CASE WHEN [SOURCE].[ClaimingPrice] IS NULL THEN 0 ELSE [SOURCE].[ClaimingPrice] END
			    ,[SOURCE].[TrackRecord]
			    ,[SOURCE].[RaceConditions]
			    ,[SOURCE].[LasixList]
			    ,[SOURCE].[ButeList]
			    ,[SOURCE].[CoupledList]
			    ,[SOURCE].[MutuelList]
			    ,[SOURCE].[SimulcastTrackCd]
			    ,[SOURCE].[SimulcastTrackRaceNum]
			    ,[SOURCE].[Reserved20]
			    ,[SOURCE].[Reserved21]
			    ,[SOURCE].[Reserved22]
			    ,[SOURCE].[PostTimes]
			    ,[SOURCE].[Reserved24]);

	SELECT Id
		   ,FileId
		   ,RaceID 
		   ,RaceDt
		   ,TrackCd
		   ,TrackName
		   ,RaceNum
		   ,Furlong
		   ,DistanceFeet
		   ,Surface TurfInd
		   ,RaceType
	FROM kelso.brisnet_Races
	WHERE FileId = @FileId
	ORDER BY RaceNum;
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_FilesMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_HorseHistoryInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_HorseHistoryInsert]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @LengthTime DECIMAL(18, 2) = 0.18;

	DECLARE @HorseHistory AS TABLE
	(
		[HorseId] [uniqueidentifier] NULL,
		[HorseName] [varchar](75) NULL,
		[RaceDt] [date] NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceNum] [int] NULL,
		[TrackCondition] [varchar](2) NULL,
		[Distance] [decimal](18, 2) NULL,
		[Surface] [char](1) NULL,
		[NumOfEntrants] [int] NULL,
		[PostPosition] [int] NULL,
		[Equipment] [char](1) NULL,
		[Medication] [int] NULL,
		[TripComment] [varchar](100) NULL,
		[ExtraCommentLine] [varchar](200) NULL,
		[WinnerMargin] [decimal](18, 2) NULL,
		[SecondPlaceMargin] [decimal](18, 2) NULL,
		[ThirdPlaceMargin] [decimal](18, 2) NULL,
		[Odds] [decimal](18, 2) NULL,
		[RaceClassification] [varchar](25) NULL,
		[ClaimingPrice] [decimal](18, 2) NULL,
		[Purse] [decimal](18, 2) NULL,
		[StartCallPosition] [varchar](5) NULL,
		[FirstCallPosition] [varchar](5) NULL,
		[SecondCallPosition] [varchar](5) NULL,
		[GateCallPosition] [varchar](5) NULL,
		[StretchCallPosition] [varchar](5) NULL,
		[FinishPosition] [varchar](5) NULL,
		[MoneyPosition] [varchar](5) NULL,
		[StartCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StartCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[FirstCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FirstCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[SecondCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[SecondCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[StretchBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StretchBtnLngthsOnly] [decimal](18, 2) NULL,
		[FinishBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FinishCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[BrisRaceShapeSecondCall] [decimal](18, 2) NULL,
		[Bris2FPace] [int] NULL,
		[Bris4FPace] [int] NULL,
		[Bris6FPace] [int] NULL,
		[Bris8FPace] [int] NULL,
		[Bris10FPace] [int] NULL,
		[BrisLateFPace] [int] NULL,
		[BrisRaceShapeFirstCall] [int] NULL,
		[BrisSpeedRating] [int] NULL,
		[SpeedRating] [int] NULL,
		[TrackVariant] [int] NULL,
		[TwoFurlongFraction] [decimal](18, 2) NULL,
		[ThreeFurlongFraction] [decimal](18, 2) NULL,
		[FourFurlongFraction] [decimal](18, 2) NULL,
		[FiveFurlongFraction] [decimal](18, 2) NULL,
		[SixFurlongFraction] [decimal](18, 2) NULL,
		[SevenFurlongFraction] [decimal](18, 2) NULL,
		[EightFurlongFraction] [decimal](18, 2) NULL,
		[TenFurlongFraction] [decimal](18, 2) NULL,
		[TwelveFurlongFraction] [decimal](18, 2) NULL,
		[FourteenFurlongFraction] [decimal](18, 2) NULL,
		[SixteenFurlongFraction] [decimal](18, 2) NULL,
		[Fraction1] [decimal](18, 2) NULL,
		[Fraction2] [decimal](18, 2) NULL,
		[Fraction3] [decimal](18, 2) NULL,
		[FinalTime] [decimal](18, 2) NULL,
		[JockeyId] [int] NULL,
		[Jockey] [varchar](30) NULL,
		[RaceType] [varchar](2) NULL,
		[FavoriteIndicator] [int] NULL,
		[FrontBandagesIndicator] [int] NULL,
		[BrisSpeedParPrior] [int] NULL,
		[LowClaimingPriceOfRace] [decimal](18, 2) NULL,
		[HighClaimingPriceOfRace] [decimal](18, 2) NULL,
		[ExtendedStartComment] [varchar](100) NULL
	);

	INSERT INTO @HorseHistory
	SELECT DR3.HorseId
			,DR3.HorseName
			,DR3.PreviousRaceDate RaceDt
			,DR3.PreviousTrackCd TrackCd
			,DR3.PreviousRaceNum RaceNum
			,DR3.TrackCondition
			,ABS(DR3.Distance) 
			,DR3.Surface
			,DR3.NumOfEntrants
			,DR3.PreviousPostPosition PostPosition
			,DR3.Equipment
			,DR3.Medication
			,DR3.TripComment
			,DR3.ExtraCommentLine
			,DR3.WinnerMargin
			,DR3.SecondPlaceMargin
			,DR3.ThirdPlaceMargin
			,DR3.Odds
			,DR3.RaceClassification
			,DR3.ClaimingPrice
			,DR3.Purse
			,DR3.StartCallPosition
			,DR3.FirstCallPosition
			,DR3.SecondCallPosition
			,DR3.GateCallPosition
			,DR3.StretchCallPosition
			,DR3.FinishPosition
			,DR3.MoneyPosition
			,DR3.StartCallBtnLngthLdrMargin
			,DR3.StartCallBtnLngthsOnly
			,DR3.FirstCallBtnLngthLdrMargin
			,DR3.FirstCallBtnLngthsOnly
			,DR3.SecondCallBtnLngthLdrMargin
			,DR3.SecondCallBtnLngthsOnly
			,DR3.StretchBtnLngthLdrMargin
			,DR3.StretchBtnLngthsOnly
			,DR3.FinishBtnLngthLdrMargin
			,DR3.FinishCallBtnLngthsOnly
			,DR3.BrisRaceShapeSecondCall
			,DR3.Bris2FPace 
			,DR3.Bris4FPace
			,DR3.Bris6FPace
			,DR3.Bris8FPace
			,DR3.Bris10FPace
			,DR3.BrisLateFPace
			,DR3.BrisRaceShapeFirstCall
			,DR3.BrisSpeedRating
			,DR3.SpeedRating
			,DR3.TrackVariant
			,CASE WHEN DR3.TwoFurlongFraction = 0.00 THEN DR3.TwoFurlongFraction
				  WHEN DR3.Distance BETWEEN 870.00 AND 1750.00 THEN DR3.TwoFurlongFraction + (DR3.FirstCallBtnLngthsOnly * @LengthTime)
				  WHEN DR3.Distance BETWEEN 1751.00 AND 1860.00 THEN DR3.TwoFurlongFraction + (DR3.StartCallBtnLngthsOnly * @LengthTime)
			 END TwoFurlongFraction
			,DR3.ThreeFurlongFraction
			,CASE WHEN DR3.FourFurlongFraction = 0.00 THEN DR3.FourFurlongFraction
				  WHEN DR3.Distance BETWEEN 870.00 AND 1750.00 THEN DR3.FourFurlongFraction + (DR3.SecondCallBtnLngthsOnly * @LengthTime)
				  ELSE DR3.FourFurlongFraction + (DR3.FirstCallBtnLngthsOnly * @LengthTime)
			 END FourFurlongFraction
			,CASE WHEN DR3.FiveFurlongFraction = 0.00 THEN DR3.FiveFurlongFraction ELSE DR3.FiveFurlongFraction + (DR3.StretchBtnLngthsOnly * @LengthTime) END FiveFurlongFraction
			,CASE WHEN DR3.SixFurlongFraction = 0.00 THEN DR3.SixFurlongFraction
				  WHEN DR3.Distance BETWEEN 1430.00 AND 1760.00 THEN DR3.SixFurlongFraction + (DR3.StretchBtnLngthsOnly * @LengthTime)
				  ELSE DR3.SixFurlongFraction + (DR3.SecondCallBtnLngthsOnly * @LengthTime)
			 END SixFurlongFraction
			,DR3.SevenFurlongFraction
			,CASE WHEN DR3.EightFurlongFraction = 0.00 THEN DR3.EightFurlongFraction 
				  ELSE DR3.EightFurlongFraction + (DR3.StretchBtnLngthsOnly * @LengthTime)
			END EightFurlongFraction
			,DR3.TenFurlongFraction
			,DR3.TwelveFurlongFraction
			,DR3.FourteenFurlongFraction
			,DR3.SixteenFurlongFraction
			,CASE  WHEN DR3.Fraction1 = 0.00 THEN DR3.Fraction1 
				  WHEN DR3.Fraction1 > 0.00 THEN DR3.Fraction1 + (DR3.FirstCallBtnLngthsOnly * @LengthTime)
				  ELSE 0.00 
			 END Fraction1
			,CASE WHEN DR3.Fraction2 = 0.00 THEN DR3.Fraction2
				WHEN DR3.Fraction1 = 0.00 AND DR3.Fraction2 >= 250.00 THEN 0.00
				WHEN DR3.Fraction1> 0.00 AND DR3.Fraction3 = 0.00 THEN DR3.Fraction2 + (DR3.StretchBtnLngthsOnly * @LengthTime) 
				ELSE DR3.Fraction2 + (DR3.SecondCallBtnLngthsOnly * @LengthTime) 
			 END Fraction2
			,CASE WHEN DR3.Fraction3 = 0.00 THEN DR3.Fraction3
				  ELSE DR3.Fraction3 + (DR3.StretchBtnLngthsOnly * @LengthTime) 
			 END Fraction3
			,DR3.FinalTime + (DR3.FinishCallBtnLngthsOnly * @LengthTime) FinalTime
			,NULL JockeyId
			,DR3.Jockey
			,DR3.RaceType
			,DR3.FavoriteIndicator
			,DR3.FrontBandagesIndicator
			,DR3.BrisSpeedParPrior
			,DR3.LowClaimingPriceOfRace
			,DR3.HighClaimingPriceOfRace
			,DR3.ExtendedStartComment
	FROM kelso.brisnet_DR3 DR3
		LEFT JOIN kelso.brisnet_HorseHistory HH ON HH.RaceDt = DR3.PreviousRaceDate 
											   AND HH.TrackCd = DR3.PreviousTrackCd
											   AND HH.RaceNum = DR3.PreviousRaceNum
											   AND HH.HorseId = DR3.HorseId
	WHERE DR3.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
		  AND HH.HorseId IS NULL
	ORDER BY ABS(DR3.Distance);

	INSERT INTO kelso.brisnet_HorseHistory
	SELECT [HorseId]
          ,[HorseName]
          ,[RaceDt]
          ,[TrackCd]
          ,[RaceNum]
          ,[TrackCondition]
          ,[Distance]
          ,[Surface]
          ,[NumOfEntrants]
          ,[PostPosition]
          ,[Equipment]
          ,[Medication]
          ,[TripComment]
          ,[ExtraCommentLine]
          ,[WinnerMargin]
          ,[SecondPlaceMargin]
          ,[ThirdPlaceMargin]
          ,[Odds]
          ,[RaceClassification]
          ,[ClaimingPrice]
          ,[Purse]
          ,[StartCallPosition]
          ,[FirstCallPosition]
          ,[SecondCallPosition]
          ,[GateCallPosition]
          ,[StretchCallPosition]
          ,[FinishPosition]
          ,[MoneyPosition]
          ,[StartCallBtnLngthLdrMargin]
          ,[StartCallBtnLngthsOnly]
          ,[FirstCallBtnLngthLdrMargin]
          ,[FirstCallBtnLngthsOnly]
          ,[SecondCallBtnLngthLdrMargin]
          ,[SecondCallBtnLngthsOnly]
          ,[StretchBtnLngthLdrMargin]
          ,[StretchBtnLngthsOnly]
          ,[FinishBtnLngthLdrMargin]
          ,[FinishCallBtnLngthsOnly]
          ,[BrisRaceShapeSecondCall]
          ,[Bris2FPace]
          ,[Bris4FPace]
          ,[Bris6FPace]
          ,[Bris8FPace]
          ,[Bris10FPace]
          ,[BrisLateFPace]
          ,[BrisRaceShapeFirstCall]
          ,[BrisSpeedRating]
          ,[SpeedRating]
          ,[TrackVariant]
          ,[TwoFurlongFraction]
          ,[ThreeFurlongFraction]
          ,[FourFurlongFraction]
          ,[FiveFurlongFraction]
          ,[SixFurlongFraction]
          ,[SevenFurlongFraction]
          ,[EightFurlongFraction]
          ,[TenFurlongFraction]
          ,[TwelveFurlongFraction]
          ,[FourteenFurlongFraction]
          ,[SixteenFurlongFraction]
          ,[Fraction1]
          ,[Fraction2]
          ,[Fraction3]
          ,[FinalTime]
          ,[JockeyId]
          ,[Jockey]
          ,[RaceType]
          ,[FavoriteIndicator]
          ,[FrontBandagesIndicator]
          ,[BrisSpeedParPrior]
          ,[LowClaimingPriceOfRace]
          ,[HighClaimingPriceOfRace]
          ,[ExtendedStartComment]
	FROM @HorseHistory DR3;
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_HorseInformationMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_HorseInformationMerge]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DR2.RaceDt
		   ,H.HorseId
	       ,DR2.HorseName
	       ,DR2.Sex
	       ,DR2.YearOfBirth
	       ,DR2.HorseFoalingMonth
	       ,DR2.[Weight]
	       ,DR2.Sire
	       ,DR2.SireSire
	       ,DR2.Dam
	       ,DR2.DamSire
	       ,DR2.Breeder
	       ,DR2.StateCountry
	       ,DR2.LifeTimeRecordTodayDistanceStarts
	       ,DR2.LifeTimeRecordTodayDistanceWins
	       ,DR2.LifeTimeRecordTodayDistancePlaces
	       ,DR2.LifeTimeRecordTodayDistanceShows
	       ,DR2.LifeTimeRecordTodayDistanceEarning
	       ,DR2.LifeTimeRecordTodayTrackStarts
	       ,DR2.LifeTimeRecordTodayTrackWins
	       ,DR2.LifeTimeRecordTodayTrackPlaces
	       ,DR2.LifeTimeRecordTodayTrackShows
	       ,DR2.LifeTimeRecordTodayTrackEarning
	       ,DR2.LifeTimeTurfRecordStarts
	       ,DR2.LifeTimeTurfRecordWins
	       ,DR2.LifeTimeTurfRecordPlaces
	       ,DR2.LifeTimeTurfRecordShows
	       ,DR2.LifeTimeTurfRecordEarning
	       ,DR2.LifeTimeWetRecordStarts
	       ,DR2.LifeTimeWetRecordWins
	       ,DR2.LifeTimeWetRecordPlaces
	       ,DR2.LifeTimeWetRecordShows
	       ,DR2.LifeTimeWetRecordEarning
	       ,DR2.CurrentRecordYear
	       ,DR2.CurrentRecordStarts
	       ,DR2.CurrentRecordWins
	       ,DR2.CurrentRecordPlaces
	       ,DR2.CurrentRecordShows
	       ,DR2.CurrentRecordEarning
	       ,DR2.PreviousRecordYear
	       ,DR2.PreviousRecordStarts
	       ,DR2.PreviousRecordWins
	       ,DR2.PreviousRecordPlaces
	       ,DR2.PreviousRecordShows
	       ,DR2.PreviousRecordEarning
	       ,DR2.LifetimeRecordStarts
	       ,DR2.LifetimeRecordWins
	       ,DR2.LifetimeRecordPlaces
	       ,DR2.LifetimeRecordShows
	       ,DR2.LifetimeRecordEarning
	       ,DR2.LifetimeStartsAllWeather
	       ,DR2.LifetimeWinsAllWeather
	       ,DR2.LifetimePlacesAllWeather
	       ,DR2.LifetimeShowsAllWeather
	       ,DR2.LifetimeEarningsAllWeather
		   ,ROW_NUMBER() OVER(ORDER BY (SELECT 0)) RowNum
	INTO #brisnet_horses
	FROM kelso.brisnet_dr2 DR2
	LEFT JOIN kelso.brisnet_Horses H ON H.HorseName = DR2.HorseName
	WHERE DR2.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','));

	MERGE kelso.brisnet_Horses AS [TARGET]
    USING #brisnet_horses [SOURCE]
    ON ([SOURCE].[HorseId] = [TARGET].[HorseId])
	WHEN MATCHED AND [SOURCE].[RaceDt] < [TARGET].[RaceDt]
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[RaceDt] = [SOURCE].[RaceDt]
			,[TARGET].[Weight] = [SOURCE].[Weight]
			,[TARGET].[Breeder] = [SOURCE].[Breeder]
			,[TARGET].[StateCountry] = [SOURCE].[StateCountry]
			,[TARGET].[LifeTimeRecordTodayDistanceStarts] = [SOURCE].[LifeTimeRecordTodayDistanceStarts]
			,[TARGET].[LifeTimeRecordTodayDistanceWins] = [SOURCE].[LifeTimeRecordTodayDistanceWins]
			,[TARGET].[LifeTimeRecordTodayDistancePlaces] = [SOURCE].[LifeTimeRecordTodayDistancePlaces]
			,[TARGET].[LifeTimeRecordTodayDistanceShows] = [SOURCE].[LifeTimeRecordTodayDistanceShows]
			,[TARGET].[LifeTimeRecordTodayDistanceEarning] = [SOURCE].[LifeTimeRecordTodayDistanceEarning]
			,[TARGET].[LifeTimeRecordTodayTrackStarts] = [SOURCE].[LifeTimeRecordTodayTrackStarts]
			,[TARGET].[LifeTimeRecordTodayTrackWins] = [SOURCE].[LifeTimeRecordTodayTrackWins]
			,[TARGET].[LifeTimeRecordTodayTrackPlaces] = [SOURCE].[LifeTimeRecordTodayTrackPlaces]
			,[TARGET].[LifeTimeRecordTodayTrackShows] = [SOURCE].[LifeTimeRecordTodayTrackShows]
			,[TARGET].[LifeTimeRecordTodayTrackEarning] = [SOURCE].[LifeTimeRecordTodayTrackEarning]
			,[TARGET].[LifeTimeTurfRecordStarts] = [SOURCE].[LifeTimeTurfRecordStarts]
			,[TARGET].[LifeTimeTurfRecordWins] = [SOURCE].[LifeTimeTurfRecordWins]
			,[TARGET].[LifeTimeTurfRecordPlaces] = [SOURCE].[LifeTimeTurfRecordPlaces]
			,[TARGET].[LifeTimeTurfRecordShows] = [SOURCE].[LifeTimeTurfRecordShows]
			,[TARGET].[LifeTimeTurfRecordEarning] = [SOURCE].[LifeTimeTurfRecordEarning]
			,[TARGET].[LifeTimeWetRecordStarts] = [SOURCE].[LifeTimeWetRecordStarts]
			,[TARGET].[LifeTimeWetRecordWins] = [SOURCE].[LifeTimeWetRecordWins]
			,[TARGET].[LifeTimeWetRecordPlaces] = [SOURCE].[LifeTimeWetRecordPlaces]
			,[TARGET].[LifeTimeWetRecordShows] = [SOURCE].[LifeTimeWetRecordShows]
			,[TARGET].[LifeTimeWetRecordEarning] = [SOURCE].[LifeTimeWetRecordEarning]
			,[TARGET].[CurrentRecordYear] = [SOURCE].[CurrentRecordYear]
			,[TARGET].[CurrentRecordStarts] = [SOURCE].[CurrentRecordStarts]
			,[TARGET].[CurrentRecordWins] = [SOURCE].[CurrentRecordWins]
			,[TARGET].[CurrentRecordPlaces] = [SOURCE].[CurrentRecordPlaces]
			,[TARGET].[CurrentRecordShows] = [SOURCE].[CurrentRecordShows]
			,[TARGET].[CurrentRecordEarning] = [SOURCE].[CurrentRecordEarning]
			,[TARGET].[PreviousRecordYear] = [SOURCE].[PreviousRecordYear]
			,[TARGET].[PreviousRecordStarts] = [SOURCE].[PreviousRecordStarts]
			,[TARGET].[PreviousRecordWins] = [SOURCE].[PreviousRecordWins]
			,[TARGET].[PreviousRecordPlaces] = [SOURCE].[PreviousRecordPlaces]
			,[TARGET].[PreviousRecordShows] = [SOURCE].[PreviousRecordShows]
			,[TARGET].[PreviousRecordEarning] = [SOURCE].[PreviousRecordEarning]
			,[TARGET].[LifetimeRecordStarts] = [SOURCE].[LifetimeRecordStarts]
			,[TARGET].[LifetimeRecordWins] = [SOURCE].[LifetimeRecordWins]
			,[TARGET].[LifetimeRecordPlaces] = [SOURCE].[LifetimeRecordPlaces]
			,[TARGET].[LifetimeRecordShows] = [SOURCE].[LifetimeRecordShows]
			,[TARGET].[LifetimeRecordEarning] = [SOURCE].[LifetimeRecordEarning]
			,[TARGET].[LifetimeStartsAllWeather] = [SOURCE].[LifetimeStartsAllWeather]
			,[TARGET].[LifetimeWinsAllWeather] = [SOURCE].[LifetimeWinsAllWeather]
			,[TARGET].[LifetimePlacesAllWeather] = [SOURCE].[LifetimePlacesAllWeather]
			,[TARGET].[LifetimeShowsAllWeather] = [SOURCE].[LifetimeShowsAllWeather]
			,[TARGET].[LifetimeEarningsAllWeather] = [SOURCE].[LifetimeEarningsAllWeather]
	WHEN NOT MATCHED 
    THEN INSERT ([CreatedDt]
				 ,[ModifiedDt]
				 ,[RaceDt]
				 ,[HorseId]
				 ,[HorseName]
				 ,[Sex]
				 ,[YearOfBirth]
				 ,[HorseFoalingMonth]
				 ,[Weight]
				 ,[Sire]
				 ,[SireSire]
				 ,[Dam]
				 ,[DamSire]
				 ,[Breeder]
				 ,[StateCountry]
				 ,[LifeTimeRecordTodayDistanceStarts]
				 ,[LifeTimeRecordTodayDistanceWins]
				 ,[LifeTimeRecordTodayDistancePlaces]
				 ,[LifeTimeRecordTodayDistanceShows]
				 ,[LifeTimeRecordTodayDistanceEarning]
				 ,[LifeTimeRecordTodayTrackStarts]
				 ,[LifeTimeRecordTodayTrackWins]
				 ,[LifeTimeRecordTodayTrackPlaces]
				 ,[LifeTimeRecordTodayTrackShows]
				 ,[LifeTimeRecordTodayTrackEarning]
				 ,[LifeTimeTurfRecordStarts]
				 ,[LifeTimeTurfRecordWins]
				 ,[LifeTimeTurfRecordPlaces]
				 ,[LifeTimeTurfRecordShows]
				 ,[LifeTimeTurfRecordEarning]
				 ,[LifeTimeWetRecordStarts]
				 ,[LifeTimeWetRecordWins]
				 ,[LifeTimeWetRecordPlaces]
				 ,[LifeTimeWetRecordShows]
				 ,[LifeTimeWetRecordEarning]
				 ,[CurrentRecordYear]
				 ,[CurrentRecordStarts]
				 ,[CurrentRecordWins]
				 ,[CurrentRecordPlaces]
				 ,[CurrentRecordShows]
				 ,[CurrentRecordEarning]
				 ,[PreviousRecordYear]
				 ,[PreviousRecordStarts]
				 ,[PreviousRecordWins]
				 ,[PreviousRecordPlaces]
				 ,[PreviousRecordShows]
				 ,[PreviousRecordEarning]
				 ,[LifetimeRecordStarts]
				 ,[LifetimeRecordWins]
				 ,[LifetimeRecordPlaces]
				 ,[LifetimeRecordShows]
				 ,[LifetimeRecordEarning]
				 ,[LifetimeStartsAllWeather]
				 ,[LifetimeWinsAllWeather]
				 ,[LifetimePlacesAllWeather]
				 ,[LifetimeShowsAllWeather]
				 ,[LifetimeEarningsAllWeather])
	VALUES (GETDATE()
				 ,GETDATE()
				 ,[SOURCE].[RaceDt]
				 ,NEWID()
				 ,[SOURCE].[HorseName]
				 ,[SOURCE].[Sex]
				 ,[SOURCE].[YearOfBirth]
				 ,[SOURCE].[HorseFoalingMonth]
				 ,[SOURCE].[Weight]
				 ,[SOURCE].[Sire]
				 ,[SOURCE].[SireSire]
				 ,[SOURCE].[Dam]
				 ,[SOURCE].[DamSire]
				 ,[SOURCE].[Breeder]
				 ,[SOURCE].[StateCountry]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceStarts]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceWins]
				 ,[SOURCE].[LifeTimeRecordTodayDistancePlaces]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceShows]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceEarning]
				 ,[SOURCE].[LifeTimeRecordTodayTrackStarts]
				 ,[SOURCE].[LifeTimeRecordTodayTrackWins]
				 ,[SOURCE].[LifeTimeRecordTodayTrackPlaces]
				 ,[SOURCE].[LifeTimeRecordTodayTrackShows]
				 ,[SOURCE].[LifeTimeRecordTodayTrackEarning]
				 ,[SOURCE].[LifeTimeTurfRecordStarts]
				 ,[SOURCE].[LifeTimeTurfRecordWins]
				 ,[SOURCE].[LifeTimeTurfRecordPlaces]
				 ,[SOURCE].[LifeTimeTurfRecordShows]
				 ,[SOURCE].[LifeTimeTurfRecordEarning]
				 ,[SOURCE].[LifeTimeWetRecordStarts]
				 ,[SOURCE].[LifeTimeWetRecordWins]
				 ,[SOURCE].[LifeTimeWetRecordPlaces]
				 ,[SOURCE].[LifeTimeWetRecordShows]
				 ,[SOURCE].[LifeTimeWetRecordEarning]
				 ,[SOURCE].[CurrentRecordYear]
				 ,[SOURCE].[CurrentRecordStarts]
				 ,[SOURCE].[CurrentRecordWins]
				 ,[SOURCE].[CurrentRecordPlaces]
				 ,[SOURCE].[CurrentRecordShows]
				 ,[SOURCE].[CurrentRecordEarning]
				 ,[SOURCE].[PreviousRecordYear]
				 ,[SOURCE].[PreviousRecordStarts]
				 ,[SOURCE].[PreviousRecordWins]
				 ,[SOURCE].[PreviousRecordPlaces]
				 ,[SOURCE].[PreviousRecordShows]
				 ,[SOURCE].[PreviousRecordEarning]
				 ,[SOURCE].[LifetimeRecordStarts]
				 ,[SOURCE].[LifetimeRecordWins]
				 ,[SOURCE].[LifetimeRecordPlaces]
				 ,[SOURCE].[LifetimeRecordShows]
				 ,[SOURCE].[LifetimeRecordEarning]
				 ,[SOURCE].[LifetimeStartsAllWeather]
				 ,[SOURCE].[LifetimeWinsAllWeather]
				 ,[SOURCE].[LifetimePlacesAllWeather]
				 ,[SOURCE].[LifetimeShowsAllWeather]
				 ,[SOURCE].[LifetimeEarningsAllWeather]);

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_HorseStatisticalAnalysisHistory]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_HorseStatisticalAnalysisHistory]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.brisnet_HorseStatisticalAnalysisHistory( CreatedDt
																,ModifiedDt
																,RaceId
																,RaceDt
																,HorseId
																,HorseName
																,TrackCd
																,BrisRunStyle
																,QuirinSpeedPoints
																,Bris2fPaceFig
																,Bris4fPaceFig
																,Bris6fPaceFig
																,BrisLatePace
																,BestBRISSpeedAllWeather
																,BestBRISSpeedDistance
																,BestBRISSpeedFastTrack
																,BestBRISSpeedOffTrack
																,BestBRISSpeedTurf)
	SELECT GETDATE()
		   ,GETDATE()
		   ,DR.RaceId
		   ,DR.RaceDt
		   ,H.HorseId
		   ,DR.HorseName
		   ,DR.TrackCd
		   ,DR.BrisRunStyle
		   ,DR.QuirinSpeedPoints
		   ,DR.Bris2fPaceFig
		   ,DR.Bris4fPaceFig
		   ,DR.Bris6fPaceFig
		   ,DR.BrisLatePace
		   ,DR.BestBRISSpeedAllWeather
		   ,DR.BestBRISSpeedDistance
		   ,DR.BestBRISSpeedFastTrack
		   ,DR.BestBRISSpeedOffTrack
		   ,DR.BestBRISSpeedTurf
	FROM kelso.brisnet_dr2 DR
			LEFT JOIN kelso.brisnet_HorseStatisticalAnalysisHistory ST ON (ST.RaceId = DR.RaceId AND ST.HorseName = DR.HorseName)
			JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
		AND ST.RaceId IS NULL;

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_JockeysMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_Program]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_Program]
(
	@TrackName VARCHAR(100),
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @perLength DECIMAL (18,2) = 0.20;
	DECLARE @TrackCd VARCHAR(25) = (SELECT TrackCd FROM kelso.brisnet_Tracks WHERE TrackName = @TrackName);

	DECLARE @Races TABLE
	( 
		RaceDt VARCHAR(50),
		TrackCd VARCHAR(25),
		TrackName VARCHAR(50),
		RaceNum INT,
		Distance DECIMAL(18, 2),
		Furlong DECIMAL(10, 2),
		Surface VARCHAR(10),
		RaceType VARCHAR(100),
		RaceCondition VARCHAR(MAX)
	);

	DECLARE @Horses TABLE
	(
		Id INT,
		HorseName VARCHAR(100)
	);

	DECLARE @Program TABLE
	(
		RaceNum INT,
		Race NVARCHAR(MAX)
	);

	DECLARE @dr2 TABLE 
	(
		[Id] [int] NOT NULL,
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[PostPosition] [varchar](5) NULL,
		[Entry] [varchar](5) NULL,
		[ClaimingPrice] [decimal](18, 2) NULL,
		[Trainer] [varchar](100) NULL,
		[TrainerStartsCurrentMeet] [int] NULL,
		[TrainerWinCurrentMeet] [int] NULL,
		[TrainerPlacesCurrentMeet] [int] NULL,
		[TrainerShowCurrentMeet] [int] NULL,
		[Jockey] [varchar](100) NULL,
		[ApprenticeWeight] [int] NULL,
		[JockeyStartsCurrentMeet] [varchar](100) NULL,
		[JockeyWinsCurrentMeet] [varchar](100) NULL,
		[JockeyPlacesCurrentMeet] [varchar](100) NULL,
		[JockeyShowsCurrentMeet] [varchar](100) NULL,
		[Owner] [varchar](100) NULL,
		[TrainerRecordCurrentYear] [varchar](30) NULL,
		[TrainerRecordPreviousYear] [varchar](30) NULL,
		[JockeyRecordCurrentYear] [varchar](30) NULL,
		[JockeyRecordPreviousYear] [varchar](30) NULL,
		[OwnersSilks] [varchar](100) NULL,
		[HorseName] [varchar](100) NULL,
		[YearOfBirth] [int] NULL,
		[HorseFoalingMonth] [int] NULL,
		[Reserved28] [varchar](50) NULL,
		[Sex] [char](1) NULL,
		[HorseColor] [varchar](50) NULL,
		[Weight] [int] NULL,
		[Sire] [varchar](50) NULL,
		[SireSire] [varchar](50) NULL,
		[Dam] [varchar](150) NULL,
		[DamSire] [varchar](150) NULL,
		[Breeder] [varchar](150) NULL,
		[StateCountry] [varchar](25) NULL,
		[AuctionPrice] [decimal](18, 0) NULL,
		[InfoSoldAtAuction] [varchar](25) NULL,
		[Reserved40] [varchar](150) NULL,
		[AEIndicator] [char](1) NULL,
		[Medication1stLasixInfo] [int] NULL,
		[Medication1stWithOutLasixInfo] [int] NULL,
		[EquipmentChange] [int] NULL,
		[LifeTimeRecordTodayDistanceStarts] [int] NULL,
		[LifeTimeRecordTodayDistanceWins] [int] NULL,
		[LifeTimeRecordTodayDistancePlaces] [int] NULL,
		[LifeTimeRecordTodayDistanceShows] [int] NULL,
		[LifeTimeRecordTodayDistanceEarning] [decimal](18, 2) NULL,
		[LifeTimeRecordTodayTrackStarts] [int] NULL,
		[LifeTimeRecordTodayTrackWins] [int] NULL,
		[LifeTimeRecordTodayTrackPlaces] [int] NULL,
		[LifeTimeRecordTodayTrackShows] [int] NULL,
		[LifeTimeRecordTodayTrackEarning] [decimal](18, 2) NULL,
		[LifeTimeTurfRecordStarts] [int] NULL,
		[LifeTimeTurfRecordWins] [int] NULL,
		[LifeTimeTurfRecordPlaces] [int] NULL,
		[LifeTimeTurfRecordShows] [int] NULL,
		[LifeTimeTurfRecordEarning] [decimal](18, 2) NULL,
		[LifeTimeWetRecordStarts] [int] NULL,
		[LifeTimeWetRecordWins] [int] NULL,
		[LifeTimeWetRecordPlaces] [int] NULL,
		[LifeTimeWetRecordShows] [int] NULL,
		[LifeTimeWetRecordEarning] [decimal](18, 2) NULL,
		[CurrentRecordYear] [int] NULL,
		[CurrentRecordStarts] [int] NULL,
		[CurrentRecordWins] [int] NULL,
		[CurrentRecordPlaces] [int] NULL,
		[CurrentRecordShows] [int] NULL,
		[CurrentRecordEarning] [decimal](18, 2) NULL,
		[PreviousRecordYear] [int] NULL,
		[PreviousRecordStarts] [int] NULL,
		[PreviousRecordWins] [int] NULL,
		[PreviousRecordPlaces] [int] NULL,
		[PreviousRecordShows] [int] NULL,
		[PreviousRecordEarning] [decimal](18, 2) NULL,
		[LifetimeRecordStarts] [int] NULL,
		[LifetimeRecordWins] [int] NULL,
		[LifetimeRecordPlaces] [int] NULL,
		[LifetimeRecordShows] [int] NULL,
		[LifetimeRecordEarning] [decimal](18, 2) NULL,
		[Workout1Date] [datetime] NULL,
		[Workout2Date] [datetime] NULL,
		[Workout3Date] [datetime] NULL,
		[Workout4Date] [datetime] NULL,
		[Workout5Date] [datetime] NULL,
		[Workout6Date] [datetime] NULL,
		[Workout7Date] [datetime] NULL,
		[Workout8Date] [datetime] NULL,
		[Workout9Date] [datetime] NULL,
		[Workout10Date] [datetime] NULL,
		[Workout11Date] [datetime] NULL,
		[Workout12Date] [datetime] NULL,
		[Workout1Time] [decimal](18, 2) NULL,
		[Workout2Time] [decimal](18, 2) NULL,
		[Workout3Time] [decimal](18, 2) NULL,
		[Workout4Time] [decimal](18, 2) NULL,
		[Workout5Time] [decimal](18, 2) NULL,
		[Workout6Time] [decimal](18, 2) NULL,
		[Workout7Time] [decimal](18, 2) NULL,
		[Workout8Time] [decimal](18, 2) NULL,
		[Workout9Time] [decimal](18, 2) NULL,
		[Workout10Time] [decimal](18, 2) NULL,
		[Workout11Time] [decimal](18, 2) NULL,
		[Workout12Time] [decimal](18, 2) NULL,
		[Workout1Track] [varchar](10) NULL,
		[Workout2Track] [varchar](10) NULL,
		[Workout3Track] [varchar](10) NULL,
		[Workout4Track] [varchar](10) NULL,
		[Workout5Track] [varchar](10) NULL,
		[Workout6Track] [varchar](10) NULL,
		[Workout7Track] [varchar](10) NULL,
		[Workout8Track] [varchar](10) NULL,
		[Workout9Track] [varchar](10) NULL,
		[Workout10Track] [varchar](10) NULL,
		[Workout11Track] [varchar](10) NULL,
		[Workout12Track] [varchar](10) NULL,
		[Workout1Distance] [decimal](18, 2) NULL,
		[Workout2Distance] [decimal](18, 2) NULL,
		[Workout3Distance] [decimal](18, 2) NULL,
		[Workout4Distance] [decimal](18, 2) NULL,
		[Workout5Distance] [decimal](18, 2) NULL,
		[Workout6Distance] [decimal](18, 2) NULL,
		[Workout7Distance] [decimal](18, 2) NULL,
		[Workout8Distance] [decimal](18, 2) NULL,
		[Workout9Distance] [decimal](18, 2) NULL,
		[Workout10Distance] [decimal](18, 2) NULL,
		[Workout11Distance] [decimal](18, 2) NULL,
		[Workout12Distance] [decimal](18, 2) NULL,
		[WorkoutTrackCondition1] [varchar](5) NULL,
		[WorkoutTrackCondition2] [varchar](5) NULL,
		[WorkoutTrackCondition3] [varchar](5) NULL,
		[WorkoutTrackCondition4] [varchar](5) NULL,
		[WorkoutTrackCondition5] [varchar](5) NULL,
		[WorkoutTrackCondition6] [varchar](5) NULL,
		[WorkoutTrackCondition7] [varchar](5) NULL,
		[WorkoutTrackCondition8] [varchar](5) NULL,
		[WorkoutTrackCondition9] [varchar](5) NULL,
		[WorkoutTrackCondition10] [varchar](5) NULL,
		[WorkoutTrackCondition11] [varchar](5) NULL,
		[WorkoutTrackCondition12] [varchar](5) NULL,
		[Workout1Description] [varchar](5) NULL,
		[Workout2Description] [varchar](5) NULL,
		[Workout3Description] [varchar](5) NULL,
		[Workout4Description] [varchar](5) NULL,
		[Workout5Description] [varchar](5) NULL,
		[Workout6Description] [varchar](5) NULL,
		[Workout7Description] [varchar](5) NULL,
		[Workout8Description] [varchar](5) NULL,
		[Workout9Description] [varchar](5) NULL,
		[Workout10Description] [varchar](5) NULL,
		[Workout11Description] [varchar](5) NULL,
		[Workout12Description] [varchar](5) NULL,
		[MainInnerTrackIndicator1] [varchar](5) NULL,
		[MainInnerTrackIndicator2] [varchar](5) NULL,
		[MainInnerTrackIndicator3] [varchar](5) NULL,
		[MainInnerTrackIndicator4] [varchar](5) NULL,
		[MainInnerTrackIndicator5] [varchar](5) NULL,
		[MainInnerTrackIndicator6] [varchar](5) NULL,
		[MainInnerTrackIndicator7] [varchar](5) NULL,
		[MainInnerTrackIndicator8] [varchar](5) NULL,
		[MainInnerTrackIndicator9] [varchar](5) NULL,
		[MainInnerTrackIndicator10] [varchar](5) NULL,
		[MainInnerTrackIndicator11] [varchar](5) NULL,
		[MainInnerTrackIndicator12] [varchar](5) NULL,
		[NumberOfWorkout1] [varchar](5) NULL,
		[NumberOfWorkout2] [varchar](5) NULL,
		[NumberOfWorkout3] [varchar](5) NULL,
		[NumberOfWorkout4] [varchar](5) NULL,
		[NumberOfWorkout5] [varchar](5) NULL,
		[NumberOfWorkout6] [varchar](5) NULL,
		[NumberOfWorkout7] [varchar](5) NULL,
		[NumberOfWorkout8] [varchar](5) NULL,
		[NumberOfWorkout9] [varchar](5) NULL,
		[NumberOfWorkout10] [varchar](5) NULL,
		[NumberOfWorkout11] [varchar](5) NULL,
		[NumberOfWorkout12] [varchar](5) NULL,
		[WorkoutRank1] [varchar](5) NULL,
		[WorkoutRank2] [varchar](5) NULL,
		[WorkoutRank3] [varchar](5) NULL,
		[WorkoutRank4] [varchar](5) NULL,
		[WorkoutRank5] [varchar](5) NULL,
		[WorkoutRank6] [varchar](5) NULL,
		[WorkoutRank7] [varchar](5) NULL,
		[WorkoutRank8] [varchar](5) NULL,
		[WorkoutRank9] [varchar](5) NULL,
		[WorkoutRank10] [varchar](5) NULL,
		[WorkoutRank11] [varchar](5) NULL,
		[WorkoutRank12] [varchar](5) NULL,
		[BrisRunStyle] [varchar](5) NULL,
		[QuirinSpeedPoints] [int] NULL,
		[Reserved191Reserved] [varchar](50) NULL,
		[Reserved192Reserved] [varchar](50) NULL,
		[Bris2fPaceFig] [int] NULL,
		[Bris4fPaceFig] [int] NULL,
		[Bris6fPaceFig] [int] NULL,
		[BrisSpeedFig] [int] NULL,
		[BrisLatePace] [int] NULL,
		[Reserved198] [varchar](50) NULL,
		[Reserved199] [varchar](50) NULL,
		[ProgramPostPosition] [int] NULL,
		[ProgramNumber] [varchar](5) NULL,
		[MorningLine] [decimal](18, 2) NULL,
		[NumOfDaySinceLastRace] [int] NULL,
		[RaceConditionLine1] [varchar](275) NULL,
		[RaceConditionLine2] [varchar](275) NULL,
		[RaceConditionLine3] [varchar](275) NULL,
		[RaceConditionLine4] [varchar](275) NULL,
		[RaceConditionLine5] [varchar](275) NULL,
		[RaceConditionLine6] [varchar](275) NULL,
		[LifetimeStartsAllWeather] [int] NULL,
		[LifetimeWinsAllWeather] [int] NULL,
		[LifetimePlacesAllWeather] [int] NULL,
		[LifetimeShowsAllWeather] [int] NULL,
		[LifetimeEarningsAllWeather] [decimal](18, 2) NULL,
		[BestBRISSpeedAllWeather] [int] NULL,
		[Reserved216] [varchar](50) NULL,
		[LowClaimingPrice] [decimal](18, 2) NULL,
		[StatebredFlag] [char](1) NULL,
		[WagerTypes219] [varchar](150) NULL,
		[WagerTypes220] [varchar](150) NULL,
		[WagerTypes221] [varchar](150) NULL,
		[WagerTypes222] [varchar](150) NULL,
		[WagerTypes223] [varchar](150) NULL,
		[WagerTypes224] [varchar](150) NULL,
		[WagerTypes225] [varchar](150) NULL,
		[WagerTypes226] [varchar](150) NULL,
		[WagerTypes227] [varchar](150) NULL,
		[SireStudFee] [decimal](18, 2) NULL,
		[BestBRISSpeedFastTrack] [int] NULL,
		[BestBRISSpeedTurf] [int] NULL,
		[BestBRISSpeedOffTrack] [int] NULL,
		[BestBRISSpeedDistance] [int] NULL,
		[Reserved233] [varchar](250) NULL,
		[Reserved234] [varchar](250) NULL
	);

	DECLARE @dr3 TABLE
	(
		[Id] [int] NOT NULL,
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[HorseId] [uniqueidentifier] NULL,
		[HorseName] [varchar](75) NULL,
		[PostPosition] [int] NULL,
		[PreviousRaceDate] [datetime] NULL,
		[NumOfDaysSincePreviousRace] [int] NULL,
		[PreviousTrackName] [varchar](30) NULL,
		[PreviousTrackCd] [varchar](3) NULL,
		[PreviousRaceNum] [int] NULL,
		[TrackCondition] [varchar](2) NULL,
		[Distance] [decimal](18, 2) NULL,
		[Surface] [char](1) NULL,
		[SpecialChuteIndicator] [char](1) NULL,
		[NumOfEntrants] [int] NULL,
		[PreviousPostPosition] [int] NULL,
		[Equipment] [char](1) NULL,
		[Reserved18] [varchar](50) NULL,
		[Medication] [int] NULL,
		[TripComment] [varchar](100) NULL,
		[WinnerName] [varchar](50) NULL,
		[SecondPlaceFinisherName] [varchar](50) NULL,
		[ThirdPlaceFinisherName] [varchar](50) NULL,
		[WinnerWeight] [int] NULL,
		[SecondPlaceWeight] [int] NULL,
		[ThirdPlaceWeight] [int] NULL,
		[WinnerMargin] [decimal](18, 2) NULL,
		[SecondPlaceMargin] [decimal](18, 2) NULL,
		[ThirdPlaceMargin] [decimal](18, 2) NULL,
		[ExtraCommentLine] [varchar](200) NULL,
		[Weight] [int] NULL,
		[Odds] [decimal](18, 2) NULL,
		[Entry] [char](1) NULL,
		[RaceClassification] [varchar](25) NULL,
		[ClaimingPrice] [decimal](18, 2) NULL,
		[Purse] [decimal](18, 2) NULL,
		[StartCallPosition] [varchar](5) NULL,
		[FirstCallPosition] [varchar](5) NULL,
		[SecondCallPosition] [varchar](5) NULL,
		[GateCallPosition] [varchar](5) NULL,
		[StretchCallPosition] [varchar](5) NULL,
		[FinishPosition] [varchar](5) NULL,
		[MoneyPosition] [varchar](5) NULL,
		[StartCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StartCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[FirstCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FirstCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[SecondCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[SecondCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[Reserved50] [varchar](250) NULL,
		[Reserved51] [varchar](250) NULL,
		[StretchBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StretchBtnLngthsOnly] [decimal](18, 2) NULL,
		[FinishBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FinishCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[BrisRaceShapeSecondCall] [decimal](18, 2) NULL,
		[Bris2FPace] [int] NULL,
		[Bris4FPace] [int] NULL,
		[Bris6FPace] [int] NULL,
		[Bris8FPace] [int] NULL,
		[Bris10FPace] [int] NULL,
		[BrisLateFPace] [int] NULL,
		[BrisRaceShapeFirstCall] [int] NULL,
		[Reserved64] [int] NULL,
		[BrisSpeedRating] [int] NULL,
		[SpeedRating] [int] NULL,
		[TrackVariant] [int] NULL,
		[TwoFurlongFraction] [decimal](18, 2) NULL,
		[ThreeFurlongFraction] [decimal](18, 2) NULL,
		[FourFurlongFraction] [decimal](18, 2) NULL,
		[FiveFurlongFraction] [decimal](18, 2) NULL,
		[SixFurlongFraction] [decimal](18, 2) NULL,
		[SevenFurlongFraction] [decimal](18, 2) NULL,
		[EightFurlongFraction] [decimal](18, 2) NULL,
		[TenFurlongFraction] [decimal](18, 2) NULL,
		[TwelveFurlongFraction] [decimal](18, 2) NULL,
		[FourteenFurlongFraction] [decimal](18, 2) NULL,
		[SixteenFurlongFraction] [decimal](18, 2) NULL,
		[Fraction1] [decimal](18, 2) NULL,
		[Fraction2] [decimal](18, 2) NULL,
		[Fraction3] [decimal](18, 2) NULL,
		[Reserved82] [varchar](250) NULL,
		[Reserved83] [varchar](250) NULL,
		[FinalTime] [decimal](18, 2) NULL,
		[ClaimedCd] [varchar](10) NULL,
		[Trainer] [varchar](100) NULL,
		[Jockey] [varchar](100) NULL,
		[ApprenticeWtAllow] [int] NULL,
		[RaceType] [varchar](2) NULL,
		[AgeAndSexRestrictions] [varchar](3) NULL,
		[StatebredFlag] [char](1) NULL,
		[RestrictedQualifierFlag] [char](1) NULL,
		[FavoriteIndicator] [int] NULL,
		[FrontBandagesIndicator] [int] NULL,
		[BrisSpeedParPrior] [int] NULL,
		[BarShoe] [char](1) NULL,
		[CompanyLineCode] [varchar](5) NULL,
		[LowClaimingPriceOfRace] [decimal](18, 2) NULL,
		[HighClaimingPriceOfRace] [decimal](18, 2) NULL,
		[Reserved100] [varchar](250) NULL,
		[CodeForPriorStart] [char](1) NULL,
		[Reserved101] [varchar](250) NULL,
		[Reserved102] [varchar](250) NULL,
		[Reserved103] [varchar](250) NULL,
		[Reserved104] [varchar](250) NULL,
		[Reserved105] [varchar](250) NULL,
		[Reserved106] [varchar](250) NULL,
		[ExtendedStartComment] [varchar](250) NULL,
		[SealedTrackIndicator] [char](1) NULL,
		[PrevAllWeatherSurfaceFlag] [char](1) NULL,
		[Reserved110] [varchar](250) NULL,
		[Reserved111] [varchar](250) NULL,
		[Reserved112] [varchar](250) NULL,
		[Reserved113] [varchar](250) NULL,
		[Reserved114] [varchar](250) NULL,
		[Reserved115] [varchar](250) NULL,
		[Reserved116] [varchar](250) NULL,
		[Reserved117] [varchar](250) NULL,
		[Reserved118] [varchar](250) NULL,
		[Reserved119] [varchar](250) NULL,
		[Reserved120] [varchar](250) NULL,
		[Reserved121] [varchar](250) NULL,
		[Reserved122] [varchar](250) NULL
	);

	INSERT INTO @Races
	SELECT CAST(FORMAT(DRF.RaceDt, 'MMM dd, yyyy') AS VARCHAR) RaceDt,
			T.TrackCd,
			T.TrackName,
			DRF.RaceNum,
			DRF.Distance,
			CAST((DRF.Distance / 220.00) AS DECIMAL(10, 2)) Furlong,
			DRF.Surface,
			DRF.Reserved9 RaceType,
			DRF.RaceConditions
	FROM kelso.brisnet_drf DRF
	JOIN kelso.brisnet_Tracks T ON T.TrackCd = DRF.TrackCd
	WHERE DRF.TrackCd = @TrackCd
	AND DRF.RaceDt = @RaceDt
	ORDER BY DRF.RaceNum;

	INSERT INTO @dr2
	SELECT *
	FROM kelso.brisnet_dr2
	WHERE TrackCd = @TrackCd
		AND RaceDt = @RaceDt
	ORDER BY RaceNum, PostPosition;
	
	INSERT INTO @dr3
	SELECT *
	FROM kelso.brisnet_dr3
	WHERE TrackCd = @TrackCd
		AND RaceDt = @RaceDt;

	DECLARE @numOfRaces INT = 0;
	DECLARE @cnt INT = 1;

	SELECT @numOfRaces = COUNT(1)
	FROM @Races;

	WHILE @cnt <= @numOfRaces
	BEGIN
		DELETE FROM @Horses;
		DECLARE @xmlRace NVARCHAR(MAX) = '<Race>';

		DECLARE @xmlInfo NVARCHAR(MAX) =
		(
			SELECT *
			FROM @Races
			WHERE RaceNum = @cnt
			FOR XML PATH('Info')
		);

		SET @xmlRace = @xmlRace + @xmlInfo;

		INSERT INTO @Horses
		SELECT ROW_NUMBER() OVER(ORDER BY PostPosition) Id, HorseName
		FROM @dr2
		WHERE RaceNum = @cnt;
	
		DECLARE @numOfHorses INT = NULL;
		DECLARE @HorseId INT = 1;
		DECLARE @xmlHorses VARCHAR(MAX) = '<Horses>';

		SELECT @numOfHorses = COUNT(1)
		FROM @Horses;

		WHILE @HorseId <= @numOfHorses
		BEGIN
			DECLARE @HorseName VARCHAR(100) = (SELECT HorseName FROM @Horses WHERE Id = @HorseId);

			DECLARE @Info NVARCHAR(MAX) = 
			(
				SELECT PostPosition,
					   HorseName,
					   CurrentRecordYear,
					   CurrentRecordStarts,
					   CurrentRecordWins,
					   CurrentRecordPlaces,
					   CurrentRecordShows,
					   FORMAT(CurrentRecordEarning, 'C') CurrentRecordEarning,
					   PreviousRecordYear,
					   PreviousRecordStarts,
					   PreviousRecordWins,
					   PreviousRecordPlaces,
					   PreviousRecordShows,
					   PreviousRecordWins,
					   FORMAT(PreviousRecordEarning, 'C') PreviousRecordEarning,
					   LifeTimeRecordTodayTrackStarts,
					   LifeTimeRecordTodayTrackWins,
					   LifeTimeRecordTodayTrackPlaces,
					   LifeTimeRecordTodayTrackShows,
					   FORMAT(LifeTimeRecordTodayTrackEarning, 'C') LifeTimeRecordTodayTrackEarning,
					   LifeTimeWetRecordStarts,
					   LifeTimeWetRecordWins,
					   LifeTimeWetRecordPlaces,
					   LifeTimeWetRecordShows,
					   FORMAT(LifeTimeWetRecordEarning, 'C') LifeTimeWetRecordEarning,
					   LifeTimeTurfRecordStarts,
					   LifeTimeTurfRecordWins,
					   LifeTimeTurfRecordPlaces,
					   LifeTimeTurfRecordShows,
					   FORMAT(LifeTimeTurfRecordEarning, 'C') LifeTimeTurfRecordEarning,
					   LifeTimeRecordTodayDistanceStarts,
					   LifeTimeRecordTodayDistanceWins,
					   LifeTimeRecordTodayDistancePlaces,
					   LifeTimeRecordTodayDistanceShows,
					   FORMAT(LifeTimeRecordTodayDistanceEarning, 'C') LifeTimeRecordTodayDistanceEarning,
					   Jockey,
					   JockeyRecordCurrentYear,
					   JockeyRecordPreviousYear,
					   Trainer,
					   TrainerRecordCurrentYear,
					   TrainerRecordPreviousYear
				FROM @dr2
				WHERE HorseName = @HorseName
				ORDER BY RaceNum, PostPosition
				FOR XML PATH('Info')
			);

			DECLARE @PastPerformance NVARCHAR(MAX) =
			(
				SELECT CAST(FORMAT(PreviousRaceDate, 'ddMMMyy') AS VARCHAR) RaceDt,
					   PreviousTrackCd TrackCd,
					   TrackCondition,
					   CAST((Distance / 220.00) AS DECIMAL(10,2)) Furlong,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(Fraction1, 'K')) = 0 OR ISNUMERIC(ISNULL(FirstCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(FirstCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN FirstCallPosition = 1 THEN ROUND(Fraction1, 1)
						ELSE ROUND(Fraction1  + (FirstCallBtnLngthsOnly * @perLength), 1)
					   END AS DECIMAL(18, 1)) FirstCall,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(Fraction2, 'K')) = 0 OR ISNUMERIC(ISNULL(SecondCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(SecondCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN SecondCallPosition = 1 THEN ROUND(Fraction2, 1)
						ELSE ROUND((Fraction2 + (SecondCallBtnLngthsOnly * @perLength)) , 1)
					   END AS DECIMAL(18, 1)) SecondCall,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(Fraction3, 'K')) = 0 OR ISNUMERIC(ISNULL(StretchCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(StretchBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN StretchCallPosition = 1 AND Fraction3 < 60.00 THEN ROUND(Fraction3, 1)
						WHEN StretchCallPosition = 1 AND Fraction3 >= 60.00 THEN (ROUND(Fraction3 / 60, 0) * 100) + ROUND(Fraction3 % 60, 1) 
						WHEN Fraction3 < 60.00 THEN ROUND(Fraction3 + (StretchBtnLngthsOnly * @perLength), 1)
						ELSE (ROUND(ROUND(Fraction3 + (StretchBtnLngthsOnly * @perLength), 1) / 60, 0) * 100) + ROUND(ROUND(Fraction3 + (StretchBtnLngthsOnly * @perLength), 1) % 60, 1)
					   END AS DECIMAL(18, 1)) StretchCall,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(FinalTime, 'K')) = 0 OR ISNUMERIC(ISNULL(FinishPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(FinishCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN FinishPosition = 1 AND FinalTime < 60 THEN ROUND(FinalTime, 1)
						WHEN FinishPosition = 1 AND FinalTime >= 60 THEN (ROUND(FinalTime / 60, 0) * 100) + ROUND(FinalTime % 60, 1)
						WHEN FinalTime < 60 THEN ROUND(FinalTime + (FinishCallBtnLngthsOnly * @perLength), 1)
						ELSE (ROUND(ROUND(FinalTime + (FinishCallBtnLngthsOnly * @perLength), 1) / 60, 0) * 100) + ROUND(ROUND(FinalTime + (FinishCallBtnLngthsOnly * @perLength), 1) % 60, 1)
					   END AS DECIMAL(18, 1)) FinalCall,
					   RaceClassification,
					   Purse,
					   BrisSpeedRating,
					   PreviousPostPosition,
					   StartCallPosition,
					   CAST(FirstCallPosition AS VARCHAR) + '-' + CAST(FirstCallBtnLngthsOnly AS VARCHAR) FirstCallPosition,
					   CAST(SecondCallPosition AS VARCHAR) + '-' + CAST(SecondCallBtnLngthsOnly AS VARCHAR) SecondCallPosition,
					   CAST(StretchCallPosition AS VARCHAR) + '-' + CAST(StretchBtnLngthsOnly AS VARCHAR) StretchCallPosition,
					   CAST(FinishPosition AS VARCHAR) + '-' + CAST(FinishCallBtnLngthsOnly AS VARCHAR) FinishPosition,
					   SpeedRating + '-' + TrackVariant SpeedRating,
					   WinnerName,
					   CAST(WinnerWeight AS VARCHAR) + '-' + CAST(WinnerMargin AS VARCHAR) FirstPlace,
					   SecondPlaceFinisherName,
					   CAST(SecondPlaceWeight AS VARCHAR) + '-' + CAST(SecondPlaceMargin AS VARCHAR) SecondPlace,
					   ThirdPlaceFinisherName,
					   CAST(ThirdPlaceWeight AS VARCHAR) + '-' + CAST(ThirdPlaceMargin AS VARCHAR) ThirdPlace,
					   TripComment,
					   ExtendedStartComment
				FROM @dr3
				WHERE HorseName = @HorseName
				ORDER BY RaceNum, PostPosition, PreviousRaceDate DESC
				FOR XML PATH('PastPerformance'), ROOT('PastPerformances')
			);

			DECLARE @Workout NVARCHAR(MAX) = '';
			WITH WorkoutCTE AS
			(
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout1Date WorkoutDate,
					   Workout1Track WorkoutTrack,
					   Workout1Distance WorkoutDistance,
					   Workout1Time WorkoutTime,
					   WorkoutTrackCondition1 WorkoutTrackCondition,
					   Workout1Description WorkoutDescription,
					   WorkoutRank1 + '/' + NumberOfWorkout1 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName 
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout2Date WorkoutDate,
					   Workout2Track,
					   Workout2Distance,
					   Workout2Time,
					   WorkoutTrackCondition2,
					   Workout2Description,
					   WorkoutRank2 + '/' + NumberOfWorkout2 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout3Date WorkoutDate,
					   Workout3Track,
					   Workout3Distance,
					   Workout3Time,
					   WorkoutTrackCondition3,
					   Workout3Description,
					   WorkoutRank3 + '/' + NumberOfWorkout3 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout4Date,
					   Workout4Track,
					   Workout4Distance,
					   Workout4Time,
					   WorkoutTrackCondition4,
					   Workout4Description,
					   WorkoutRank4 + '/' + NumberOfWorkout4 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout5Date,
					   Workout5Track,
					   Workout5Distance,
					   Workout5Time,
					   WorkoutTrackCondition5,
					   Workout5Description,
					   WorkoutRank5 + '/' + NumberOfWorkout5 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout6Date,
					   Workout6Track,
					   Workout6Distance,
					   Workout6Time,
					   WorkoutTrackCondition6,
					   Workout6Description,
					   WorkoutRank6 + '/' + NumberOfWorkout6 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout7Date,
					   Workout7Track,
					   Workout7Distance,
					   Workout7Time,
					   WorkoutTrackCondition7,
					   Workout7Description,
					   WorkoutRank7 + '/' + NumberOfWorkout7 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout8Date,
					   Workout8Track,
					   Workout8Distance,
					   Workout8Time,
					   WorkoutTrackCondition8,
					   Workout8Description,
					   WorkoutRank8 + '/' + NumberOfWorkout8 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout9Date,
					   Workout9Track,
					   Workout9Distance,
					   Workout9Time,
					   WorkoutTrackCondition9,
					   Workout9Description,
					   WorkoutRank9 + '/' + NumberOfWorkout9 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout10Date,
					   Workout10Track,
					   Workout10Distance,
					   Workout10Time,
					   WorkoutTrackCondition10,
					   Workout10Description,
					   WorkoutRank10 + '/' + NumberOfWorkout10 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout11Date,
					   Workout11Track,
					   Workout11Distance,
					   Workout11Time,
					   WorkoutTrackCondition11,
					   Workout11Description,
					   WorkoutRank11 + '/' + NumberOfWorkout11 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout12Date,
					   Workout12Track,
					   Workout12Distance,
					   Workout12Time,
					   WorkoutTrackCondition12,
					   Workout12Description,
					   WorkoutRank12 + '/' + NumberOfWorkout12 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
			)
			SELECT @Workout =
			(
				SELECT CAST(FORMAT(WorkoutDate, 'MMMdd') AS VARCHAR) DisplayWorkoutDate ,
					   WorkoutDate,
					   WorkoutTrack,
					   CAST((WorkoutDistance / 220.00) AS DECIMAL(10,2)) Furlong,
					   CAST(CAST(CASE WHEN WorkoutTime < 60 THEN WorkoutTime ELSE (ROUND(WorkoutTime / 60, 0) * 100) + ROUND(WorkoutTime % 60, 1) END AS DECIMAL(18,1)) AS VARCHAR) WorkoutTime,
					   WorkoutTrackCondition,
					   WorkoutDescription,
					   WorkoutRanking
				FROM WorkoutCTE
				ORDER BY WorkoutDate DESC
				FOR XML PATH('Workout'), ROOT('Workouts')
			);

			SET @xmlHorses = @xmlHorses + '<Horse>' + @Info + ISNULL(@PastPerformance, '<PastPerformances />') + @Workout + '</Horse>';
			SET @HorseId = @HorseId + 1;
		END

		SET @xmlHorses = @xmlHorses + '</Horses>';
		SET @xmlRace = ISNULL(@xmlRace, '') + @xmlHorses + '</Race>';

		INSERT INTO @Program (RaceNum, Race)
		SELECT @cnt, @xmlRace;

		SET @cnt = @cnt + 1;
	END

	SELECT RaceNum, Race
	FROM @Program;

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_ProgramGet]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_RaceParticipantsInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_TrainersMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_TrntStatInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_TrntStatInsert]
AS
BEGIN
	INSERT INTO [kelso].[brisnet_TrntStat]([RaceId]
										   ,[CreateDt]
										   ,[TrackCd]
										   ,[RaceDt]
										   ,[RaceNum]
										   ,[HorseId]
										   ,[HorseName]
										   ,[TrntStatCategory]
										   ,[NumOfStarts]
										   ,[WinPercentage]
										   ,[InTheMoneyPercentage]
										   ,[ReturnOfInvestment])
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory1] 
		   ,[SOURCE].[NumOfStarts1]
		   ,[SOURCE].[WinPercentage1]
		   ,[SOURCE].[InTheMoneyPercentage1]
		   ,[SOURCE].[ReturnOfInvestment1]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											     AND [TARGET].[HorseName] = [SOURCE].[HorseName]
												 AND [TrntStatCategory] = [SOURCE].[TrntStatCategory1]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory1], '') != ''
	UNION 
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory2] 
		   ,[SOURCE].[NumOfStarts2]
		   ,[SOURCE].[WinPercentage2]
		   ,[SOURCE].[InTheMoneyPercentage2]
		   ,[SOURCE].[ReturnOfInvestment2]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory2], '') != ''
		AND [SOURCE].[TrntStatCategory2] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory3] 
		   ,[SOURCE].[NumOfStarts3]
		   ,[SOURCE].[WinPercentage3]
		   ,[SOURCE].[InTheMoneyPercentage3]
		   ,[SOURCE].[ReturnOfInvestment3]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory3], '') != ''
		AND [SOURCE].[TrntStatCategory3] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory4] 
		   ,[SOURCE].[NumOfStarts4]
		   ,[SOURCE].[WinPercentage4]
		   ,[SOURCE].[InTheMoneyPercentage4]
		   ,[SOURCE].[ReturnOfInvestment4]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory4], '') != ''
		AND [SOURCE].[TrntStatCategory4] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory5] 
		   ,[SOURCE].[NumOfStarts5]
		   ,[SOURCE].[WinPercentage5]
		   ,[SOURCE].[InTheMoneyPercentage5]
		   ,[SOURCE].[ReturnOfInvestment5]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory5], '') != ''
		AND [SOURCE].[TrntStatCategory5] NOT IN ([TARGET].[TrntStatCategory])
	UNION
	SELECT [SOURCE].[RaceId]
		   ,GETDATE()
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,[SOURCE].[HorseId]
		   ,[SOURCE].[HorseName]
		   ,[SOURCE].[TrntStatCategory6] 
		   ,[SOURCE].[NumOfStarts6]
		   ,[SOURCE].[WinPercentage6]
		   ,[SOURCE].[InTheMoneyPercentage6]
		   ,[SOURCE].[ReturnOfInvestment6]
	FROM kelso.brisnet_dr4 [SOURCE]
	LEFT JOIN kelso.brisnet_TrntStat [TARGET] ON [TARGET].[RaceId] = [SOURCE].[RaceId]
											AND [TARGET].[HorseName] = [SOURCE].[HorseName]
	WHERE [TARGET].[RaceId] IS NULL
		AND ISNULL([SOURCE].[TrntStatCategory6], '') != ''
		AND [SOURCE].[TrntStatCategory6] NOT IN ([TARGET].[TrntStatCategory]);
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_WorkoutHistoryInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_WorkoutHistoryInsert]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.brisnet_Workouts( HorseId
										,HorseName
										,WorkoutDate
										,WorkoutTrack
										,WorkoutDistance
										,WorkoutTime
										,WorkoutTrackCondition
										,WorkoutDescription
										,MainInnerTrackIndicator
										,NumberOfWorkouts
										,WorkoutRank
	)
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout1Date
		   ,DR.Workout1Track
		   ,DR.Workout1Distance
		   ,DR.Workout1Time
		   ,DR.WorkoutTrackCondition1
		   ,DR.Workout1Description
		   ,DR.MainInnerTrackIndicator1
		   ,DR.NumberOfWorkout1
		   ,DR.WorkoutRank1
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout1Date
									       AND W.WorkoutTrack = DR.Workout1Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout1Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout2Date
		   ,DR.Workout2Track
		   ,DR.Workout2Distance
		   ,DR.Workout2Time
		   ,DR.WorkoutTrackCondition2
		   ,DR.Workout2Description
		   ,DR.MainInnerTrackIndicator2
		   ,DR.NumberOfWorkout2
		   ,DR.WorkoutRank2
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout2Date
									       AND W.WorkoutTrack = DR.Workout2Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout2Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout3Date
		   ,DR.Workout3Track
		   ,DR.Workout3Distance
		   ,DR.Workout3Time
		   ,DR.WorkoutTrackCondition3
		   ,DR.Workout3Description
		   ,DR.MainInnerTrackIndicator3
		   ,DR.NumberOfWorkout3
		   ,DR.WorkoutRank3
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout3Date
									       AND W.WorkoutTrack = DR.Workout3Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout3Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout4Date
		   ,DR.Workout4Track
		   ,DR.Workout4Distance
		   ,DR.Workout4Time
		   ,DR.WorkoutTrackCondition4
		   ,DR.Workout4Description
		   ,DR.MainInnerTrackIndicator4
		   ,DR.NumberOfWorkout4
		   ,DR.WorkoutRank4
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout4Date
									       AND W.WorkoutTrack = DR.Workout4Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout4Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout5Date
		   ,DR.Workout5Track
		   ,DR.Workout5Distance
		   ,DR.Workout5Time
		   ,DR.WorkoutTrackCondition5
		   ,DR.Workout5Description
		   ,DR.MainInnerTrackIndicator5
		   ,DR.NumberOfWorkout5
		   ,DR.WorkoutRank5
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout5Date
									       AND W.WorkoutTrack = DR.Workout5Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout5Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout6Date
		   ,DR.Workout6Track
		   ,DR.Workout6Distance
		   ,DR.Workout6Time
		   ,DR.WorkoutTrackCondition6
		   ,DR.Workout6Description
		   ,DR.MainInnerTrackIndicator6
		   ,DR.NumberOfWorkout6
		   ,DR.WorkoutRank6
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout6Date
									       AND W.WorkoutTrack = DR.Workout6Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout6Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout7Date
		   ,DR.Workout7Track
		   ,DR.Workout7Distance
		   ,DR.Workout7Time
		   ,DR.WorkoutTrackCondition7
		   ,DR.Workout7Description
		   ,DR.MainInnerTrackIndicator7
		   ,DR.NumberOfWorkout7
		   ,DR.WorkoutRank7
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout7Date
									       AND W.WorkoutTrack = DR.Workout7Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout7Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout8Date
		   ,DR.Workout8Track
		   ,DR.Workout8Distance
		   ,DR.Workout8Time
		   ,DR.WorkoutTrackCondition8
		   ,DR.Workout8Description
		   ,DR.MainInnerTrackIndicator8
		   ,DR.NumberOfWorkout8
		   ,DR.WorkoutRank8
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout8Date
									       AND W.WorkoutTrack = DR.Workout8Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout8Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout9Date
		   ,DR.Workout9Track
		   ,DR.Workout9Distance
		   ,DR.Workout9Time
		   ,DR.WorkoutTrackCondition9
		   ,DR.Workout9Description
		   ,DR.MainInnerTrackIndicator9
		   ,DR.NumberOfWorkout9
		   ,DR.WorkoutRank9
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout9Date
									       AND W.WorkoutTrack = DR.Workout9Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout9Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout10Date
		   ,DR.Workout10Track
		   ,DR.Workout10Distance
		   ,DR.Workout10Time
		   ,DR.WorkoutTrackCondition10
		   ,DR.Workout10Description
		   ,DR.MainInnerTrackIndicator10
		   ,DR.NumberOfWorkout10
		   ,DR.WorkoutRank10
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout10Date
									       AND W.WorkoutTrack = DR.Workout10Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout10Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout11Date
		   ,DR.Workout11Track
		   ,DR.Workout11Distance
		   ,DR.Workout11Time
		   ,DR.WorkoutTrackCondition11
		   ,DR.Workout11Description
		   ,DR.MainInnerTrackIndicator11
		   ,DR.NumberOfWorkout11
		   ,DR.WorkoutRank11
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout11Date
									       AND W.WorkoutTrack = DR.Workout11Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout11Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout12Date
		   ,DR.Workout12Track
		   ,DR.Workout12Distance
		   ,DR.Workout12Time
		   ,DR.WorkoutTrackCondition12
		   ,DR.Workout12Description
		   ,DR.MainInnerTrackIndicator12
		   ,DR.NumberOfWorkout12
		   ,DR.WorkoutRank12
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout12Date
									       AND W.WorkoutTrack = DR.Workout12Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout12Distance > 0

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_brisnet_xrdInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [kelso].[vsp_brisnet_xrdInsert]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CountRecords INT = 0;

	SELECT @CountRecords = COUNT(1)
	FROM kelso.brisnet_xrd_staging S
	JOIN kelso.brisnet_xrd XRD ON XRD.RaceDt = S.RaceDt AND XRD.TrackCd = S.TrackCd AND XRD.HorseName = S.HorseName;

	IF @CountRecords = 0
	BEGIN
		INSERT INTO kelso.brisnet_xrd (
									RaceId,
									TrackCd,
									RaceDt,
									RaceNum,
									ReservedString1,
									Surface,
									ReservedString2,
									ReservedString3,
									ReservedString4,
									ReservedString5,
									ReservedString6,
									ReservedString7,
									ReservedString8,
									ReservedString9,
									ReservedString10,
									ReservedString11,
									FinalTime,
									TrackCondition,
									PostPosition,
									EntryFlag,
									HorseId,
									HorseName,
									ReservedString12,
									ReservedString13,
									ReservedString14,
									ReservedString15,
									ReservedString16,
									ReservedString17,
									ReservedString18,
									ReservedString19,
									ReservedString20,
									FinishPosition,
									ReservedString21,
									WagerType10,
									WagerType11,
									WagerType12,
									WagerType13,
									WagerType14,
									HorseOdd,
									ReservedString22,
									ReservedString23,
									ReservedString24,
									ReservedString25,
									ReservedString26,
									ReservedString27,
									ReservedString28,
									ReservedString29,
									ReservedString30,
									ReservedString31,
									starter_field_size,
									official_finish_position,
									official_program_num,
									ReservedString32,
									ReservedString33,
									ReservedString34,
									ReservedString35,
									WinningNums10,
									WinningNums11,
									WinningNums12,
									WinningNums13,
									WinningNums14,
									TwoDollarsPayoff10,
									TwoDollarsPayoff11,
									TwoDollarsPayoff12,
									TwoDollarsPayoff13,
									TwoDollarsPayoff14,
									Pool10,
									Pool11,
									Pool12,
									Pool13,
									Pool14,
									BetAmt10,
									BetAmt11,
									BetAmt12,
									BetAmt13,
									BetAmt14,
									TwoDollarsWinPayOff,
									TwoDollarsPlacePayOff,
									TwoDollarsShowPayOff,
									WagerType1,
									WagerType2,
									WagerType3,
									WagerType4,
									WagerType5,
									WagerType6,
									WagerType7,
									WagerType8,
									WagerType9,
									WinningNums1,
									WinningNums2,
									WinningNums3,
									WinningNums4,
									WinningNums5,
									WinningNums6,
									WinningNums7,
									WinningNums8,
									WinningNums9,
									TwoDollarsPayoff1,
									TwoDollarsPayoff2,
									TwoDollarsPayoff3,
									TwoDollarsPayoff4,
									TwoDollarsPayoff5,
									TwoDollarsPayoff6,
									TwoDollarsPayoff7,
									TwoDollarsPayoff8,
									TwoDollarsPayoff9,
									Pool1,
									Pool2,
									Pool3,
									Pool4,
									Pool5,
									Pool6,
									Pool7,
									Pool8,
									Pool9,
									BetAmt1,
									BetAmt2,
									BetAmt3,
									BetAmt4,
									BetAmt5,
									BetAmt6,
									BetAmt7,
									BetAmt8,
									BetAmt9,
									ReservedString36,
									ReservedString37,
									ReservedString38,
									ReservedString39,
									ReservedString40,
									ReservedString41,
									ReservedString42,
									ReservedString43,
									ReservedString44,
									ReservedString45,
									ReservedString46,
									ReservedString47,
									ReservedString48,
									ReservedString49,
									ReservedString50,
									ReservedString51,
									ReservedString52,
									ReservedString53,
									ReservedString54,
									ReservedString55,
									ReservedString56,
									ReservedString57,
									ReservedString58,
									ReservedString59,
									ReservedString60,
									ReservedString61,
									ReservedString62,
									ReservedString63,
									ReservedString64,
									ReservedString65,
									ReservedString66,
									ReservedString67,
									ReservedString68,
									ReservedString69,
									ReservedString70,
									ReservedString71,
									ReservedString72,
									ReservedString73,
									ReservedString74,
									ReservedString75,
									ReservedString76,
									ReservedString77,
									ReservedString78,
									ReservedString79,
									ReservedString80,
									ReservedString81,
									ReservedString82,
									ReservedString83,
									ReservedString84,
									ReservedString85,
									ReservedString86,
									ReservedString87,
									ReservedString88,
									ReservedString89,
									ReservedString90,
									ReservedString91,
									ReservedString92,
									ReservedString93,
									ReservedString94,
									ReservedString95,
									ReservedString96,
									ReservedString97,
									ReservedString98,
									ReservedString99,
									ReservedString100,
									ReservedString101,
									ReservedString102,
									ReservedString103,
									ReservedString104,
									ReservedString105,
									ReservedString106,
									ReservedString107,
									ReservedString108,
									ReservedString109,
									ReservedString110,
									ReservedString111,
									ReservedString112,
									ReservedString113,
									ReservedString114,
									ReservedString115,
									ReservedString116,
									ReservedString117,
									ReservedString118,
									ReservedString119,
									ReservedString120,
									ReservedString121,
									ReservedString122,
									ReservedString123,
									ReservedString124,
									ReservedString125,
									ReservedString126,
									ReservedString127,
									ReservedString128,
									ReservedString129,
									ReservedString130,
									ReservedString131,
									ReservedString132,
									ReservedString133,
									ReservedString134,
									ReservedString135,
									ReservedString136,
									ReservedString137,
									ReservedString138,
									ReservedString139,
									ReservedString140,
									ReservedString141,
									ReservedString142,
									ReservedString143,
									ReservedString144,
									ReservedString145,
									ReservedString146,
									ReservedString147,
									ReservedString148,
									ReservedString149,
									ReservedString150,
									ReservedString151,
									ReservedString152,
									ReservedString153,
									ReservedString154,
									ReservedString155,
									ReservedString156,
									ReservedString157,
									ReservedString158,
									ReservedString159,
									ReservedString160,
									ReservedString161,
									ReservedString162,
									ReservedString163,
									ReservedString164,
									ReservedString165,
									ReservedString166,
									ReservedString167
								  )
					SELECT RP.RaceId,
						   S.TrackCd,
						   S.RaceDt,
						   S.RaceNum,
						   S.ReservedString1,
						   S.Surface,
						   S.ReservedString2,
						   S.ReservedString3,
						   S.ReservedString4,
						   S.ReservedString5,
						   S.ReservedString6,
						   S.ReservedString7,
						   S.ReservedString8,
						   S.ReservedString9,
						   S.ReservedString10,
						   S.ReservedString11,
						   CASE WHEN (S.FinalTime IS NULL OR LEN(S.FinalTime) = 0) THEN 0 ELSE CAST(S.FinalTime AS DECIMAL(18,2)) END,
						   S.TrackCondition,
						   S.PostPosition,
						   S.EntryFlag,
						   RP.HorseId,
						   S.HorseName,
						   S.ReservedString12,
						   S.ReservedString13,
						   S.ReservedString14,
						   S.ReservedString15,
						   S.ReservedString16,
						   S.ReservedString17,
						   S.ReservedString18,
						   S.ReservedString19,
						   S.ReservedString20,
						   S.FinishPosition,
						   S.ReservedString21,
						   S.WagerType10,
						   S.WagerType11,
						   S.WagerType12,
						   S.WagerType13,
						   S.WagerType14,
						   CASE WHEN (S.HorseOdd IS NULL OR LEN(S.HorseOdd) = 0) THEN 0 ELSE CAST(S.HorseOdd AS DECIMAL(18,2)) END,
						   S.ReservedString22,
						   S.ReservedString23,
						   S.ReservedString24,
						   S.ReservedString25,
						   S.ReservedString26,
						   S.ReservedString27,
						   S.ReservedString28,
						   S.ReservedString29,
						   S.ReservedString30,
						   S.ReservedString31,
						   S.starter_field_size,
						   S.official_finish_position,
						   S.official_program_num,
						   S.ReservedString32,
						   S.ReservedString33,
						   S.ReservedString34,
						   S.ReservedString35,
						   S.WinningNums10,
						   S.WinningNums11,
						   S.WinningNums12,
						   S.WinningNums13,
						   S.WinningNums14,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff10, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff10 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff11, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff11 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff12, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff12 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff13, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff13 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff14, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff14 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool10, '') = '' THEN 0 ELSE CAST(S.Pool10 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool11, '') = '' THEN 0 ELSE CAST(S.Pool11 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool12, '') = '' THEN 0 ELSE CAST(S.Pool12 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool13, '') = '' THEN 0 ELSE CAST(S.Pool13 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool14, '') = '' THEN 0 ELSE CAST(S.Pool14 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt10, '') = '' THEN 0 ELSE CAST(S.BetAmt10 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt11, '') = '' THEN 0 ELSE CAST(S.BetAmt11 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt12, '') = '' THEN 0 ELSE CAST(S.BetAmt12 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt13, '') = '' THEN 0 ELSE CAST(S.BetAmt13 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt14, '') = '' THEN 0 ELSE CAST(S.BetAmt14 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsWinPayOff, '') = '' THEN 0 ELSE CAST(S.TwoDollarsWinPayOff AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPlacePayOff, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPlacePayOff AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsShowPayOff, '') = '' THEN 0 ELSE CAST(S.TwoDollarsShowPayOff AS DECIMAL(18,2)) END,
						   S.WagerType1,
						   S.WagerType2,
						   S.WagerType3,
						   S.WagerType4,
						   S.WagerType5,
						   S.WagerType6,
						   S.WagerType7,
						   S.WagerType8,
						   S.WagerType9,
						   S.WinningNums1,
						   S.WinningNums2,
						   S.WinningNums3,
						   S.WinningNums4,
						   S.WinningNums5,
						   S.WinningNums6,
						   S.WinningNums7,
						   S.WinningNums8,
						   S.WinningNums9,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff1, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff1 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff2, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff2 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff3, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff3 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff4, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff4 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff5, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff5 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff6, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff6 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff7, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff7 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff8, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff8 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.TwoDollarsPayoff9, '') = '' THEN 0 ELSE CAST(S.TwoDollarsPayoff9 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool1, '') = '' THEN 0 ELSE CAST(S.Pool1 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool2, '') = '' THEN 0 ELSE CAST(S.Pool2 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool3, '') = '' THEN 0 ELSE CAST(S.Pool3 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool4, '') = '' THEN 0 ELSE CAST(S.Pool4 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool5, '') = '' THEN 0 ELSE CAST(S.Pool5 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool6, '') = '' THEN 0 ELSE CAST(S.Pool6 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool7, '') = '' THEN 0 ELSE CAST(S.Pool7 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool8, '') = '' THEN 0 ELSE CAST(S.Pool8 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.Pool9, '') = '' THEN 0 ELSE CAST(S.Pool9 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt1, '') = '' THEN 0 ELSE CAST(S.BetAmt1 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt2, '') = '' THEN 0 ELSE CAST(S.BetAmt2 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt3, '') = '' THEN 0 ELSE CAST(S.BetAmt3 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt4, '') = '' THEN 0 ELSE CAST(S.BetAmt4 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt5, '') = '' THEN 0 ELSE CAST(S.BetAmt5 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt6, '') = '' THEN 0 ELSE CAST(S.BetAmt6 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt7, '') = '' THEN 0 ELSE CAST(S.BetAmt7 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt8, '') = '' THEN 0 ELSE CAST(S.BetAmt8 AS DECIMAL(18,2)) END,
						   CASE WHEN ISNULL(S.BetAmt9, '') = '' THEN 0 ELSE CAST(S.BetAmt9 AS DECIMAL(18,2)) END,
						   S.ReservedString36,
						   S.ReservedString37,
						   S.ReservedString38,
						   S.ReservedString39,
						   S.ReservedString40,
						   S.ReservedString41,
						   S.ReservedString42,
						   S.ReservedString43,
						   S.ReservedString44,
						   S.ReservedString45,
						   S.ReservedString46,
						   S.ReservedString47,
						   S.ReservedString48,
						   S.ReservedString49,
						   S.ReservedString50,
						   S.ReservedString51,
						   S.ReservedString52,
						   S.ReservedString53,
						   S.ReservedString54,
						   S.ReservedString55,
						   S.ReservedString56,
						   S.ReservedString57,
						   S.ReservedString58,
						   S.ReservedString59,
						   S.ReservedString60,
						   S.ReservedString61,
						   S.ReservedString62,
						   S.ReservedString63,
						   S.ReservedString64,
						   S.ReservedString65,
						   S.ReservedString66,
						   S.ReservedString67,
						   S.ReservedString68,
						   S.ReservedString69,
						   S.ReservedString70,
						   S.ReservedString71,
						   S.ReservedString72,
						   S.ReservedString73,
						   S.ReservedString74,
						   S.ReservedString75,
						   S.ReservedString76,
						   S.ReservedString77,
						   S.ReservedString78,
						   S.ReservedString79,
						   S.ReservedString80,
						   S.ReservedString81,
						   S.ReservedString82,
						   S.ReservedString83,
						   S.ReservedString84,
						   S.ReservedString85,
						   S.ReservedString86,
						   S.ReservedString87,
						   S.ReservedString88,
						   S.ReservedString89,
						   S.ReservedString90,
						   S.ReservedString91,
						   S.ReservedString92,
						   S.ReservedString93,
						   S.ReservedString94,
						   S.ReservedString95,
						   S.ReservedString96,
						   S.ReservedString97,
						   S.ReservedString98,
						   S.ReservedString99,
						   S.ReservedString100,
						   S.ReservedString101,
						   S.ReservedString102,
						   S.ReservedString103,
						   S.ReservedString104,
						   S.ReservedString105,
						   S.ReservedString106,
						   S.ReservedString107,
						   S.ReservedString108,
						   S.ReservedString109,
						   S.ReservedString110,
						   S.ReservedString111,
						   S.ReservedString112,
						   S.ReservedString113,
						   S.ReservedString114,
						   S.ReservedString115,
						   S.ReservedString116,
						   S.ReservedString117,
						   S.ReservedString118,
						   S.ReservedString119,
						   S.ReservedString120,
						   S.ReservedString121,
						   S.ReservedString122,
						   S.ReservedString123,
						   S.ReservedString124,
						   S.ReservedString125,
						   S.ReservedString126,
						   S.ReservedString127,
						   S.ReservedString128,
						   S.ReservedString129,
						   S.ReservedString130,
						   S.ReservedString131,
						   S.ReservedString132,
						   S.ReservedString133,
						   S.ReservedString134,
						   S.ReservedString135,
						   S.ReservedString136,
						   S.ReservedString137,
						   S.ReservedString138,
						   S.ReservedString139,
						   S.ReservedString140,
						   S.ReservedString141,
						   S.ReservedString142,
						   S.ReservedString143,
						   S.ReservedString144,
						   S.ReservedString145,
						   S.ReservedString146,
						   S.ReservedString147,
						   S.ReservedString148,
						   S.ReservedString149,
						   S.ReservedString150,
						   S.ReservedString151,
						   S.ReservedString152,
						   S.ReservedString153,
						   S.ReservedString154,
						   S.ReservedString155,
						   S.ReservedString156,
						   S.ReservedString157,
						   S.ReservedString158,
						   S.ReservedString159,
						   S.ReservedString160,
						   S.ReservedString161,
						   S.ReservedString162,
						   S.ReservedString163,
						   S.ReservedString164,
						   S.ReservedString165,
						   S.ReservedString166,
						   S.ReservedString167
					FROM kelso.brisnet_xrd_staging S
						LEFT JOIN kelso.brisnet_RaceParticipants rp ON rp.TrackCd = s.TrackCd AND rp.RaceDt = S.RaceDt AND rp.HorseName = S.HorseName 
					WHERE NOT EXISTS (
										SELECT *
										FROM kelso.brisnet_xrd
										WHERE RaceDt = S.RaceDt
											  AND TrackCd = S.TrackCd
											  AND RaceNum = S.RaceNum
									 );
	END;
END;
GO
/****** Object:  StoredProcedure [kelso].[vsp_EntMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_EntMerge]
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.ent E
	USING (
			SELECT *
			FROM kelso.ent_staging 
		  ) S
	ON S.RaceDt = E.RaceDt
	   AND S.TrackCd = E.TrackCd
	   AND S.RaceNum = E.RaceNum
	   AND S.HorseName = E.HorseName
	WHEN MATCHED THEN
		UPDATE
			SET E.PolePosition = S.PolePosition,
				E.MorningLine = S.MorningLine, 
				E.PaceLines = S.PaceLines, 
				E.EntryChar = S.EntryChar, 
				E.ScratchFlagInd = S.ScratchFlagInd, 
				E.CurrentYr = S.CurrentYr, 
				E.StartsThisYr = S.StartsThisYr, 
				E.WinThisYr = S.WinThisYr, 
				E.PlacesThisYr = S.PlacesThisYr, 
				E.ShowsThisYr = S.ShowsThisYr, 
				E.EarningThisYr = S.EarningThisYr, 
				E.PrevYearForEarning = S.PrevYearForEarning, 
				E.StartsPrevYr = S.StartsPrevYr, 
				E.WinPrevYr = S.WinPrevYr, 
				E.PlacesPrevYr = S.PlacesPrevYr, 
				E.ShowsPrevYr = S.ShowsPrevYr, 
				E.EarningPrevYr = S.EarningPrevYr, 
				E.OwnerName = S.OwnerName, 
				E.Color = S.Color,
				E.YearBorn = S.YearBorn, 
				E.MonthBorn = S.MonthBorn, 
				E.StateBredInd = S.StateBredInd, 
				E.Age = S.Age, 
				E.Sex = S.Sex, 
				E.SireName = S.SireName,
				E.SiresSire = S.SiresSire, 
				E.Dam = S.Dam, 
				E.DamsSire = S.DamsSire, 
				E.TrainerName = S.TrainerName, 
				E.BreederName = S.BreederName, 
				E.TrainerStarts = S.TrainerStarts, 
				E.TrainerWins = S.TrainerWins, 
				E.TrainerPlaces = S.TrainerPlaces, 
				E.TrainerShows = S.TrainerShows, 
				E.TrainerPercentage = S.TrainerPercentage, 
				E.LasixInd = S.LasixInd, 
				E.ButeInd = S.ButeInd, 
				E.WeightAssigned = S.WeightAssigned, 
				E.ApprenticeWtAllowance = S.ApprenticeWtAllowance, 
				E.JockeyName = S.JockeyName, 
				E.JockeyID = (SELECT JockeyID FROM Jockeys WHERE JockeyName = S.JockeyName),
				E.JockeyStarts = S.JockeyStarts, 
				E.JockeyWins = S.JockeyWins, 
				E.JockeyPlaces = S.JockeyPlaces, 
				E.JockeyShows = S.JockeyShows, 
				E.JockeyPercentage = S.JockeyPercentage, 
				E.ClaimingPrice = S.ClaimingPrice, 
				E.LifetimeStarts = S.LifetimeStarts, 
				E.LifetimeWins = S.LifetimeWins, 
				E.LifetimePlaces = S.LifetimePlaces, 
				E.LifetimeShows = S.LifetimeShows, 
				E.LifetimeEarnings = S.LifetimeEarnings, 
				E.TrackStarts = S.TrackStarts, 
				E.TrackWins = S.TrackWins, 
				E.TrackPlaces = S.TrackPlaces, 
				E.TrackShows = S.TrackShows, 
				E.TrackEarnings = S.TrackEarnings, 
				E.TurfStarts = S.TurfStarts, 
				E.TurfWins = S.TurfWins, 
				E.TurfPlaces = S.TurfPlaces, 
				E.TurfShows = S.TurfShows, 
				E.TurfEarnings = S.TurfEarnings, 
				E.WetStarts = S.WetStarts, 
				E.WetWins = S.WetWins, 
				E.WetPlaces = S.WetPlaces, 
				E.WetShows = S.WetShows, 
				E.WetEarnings = S.WetEarnings, 
				E.DistanceStarts = S.DistanceStarts, 
				E.DistanceWins = S.DistanceWins, 
				E.DistancePlaces = S.DistancePlaces, 
				E.DistanceShows = S.DistanceShows, 
				E.DistanceEarnings = S.DistanceEarnings, 
				E.AlsoEligibleInd = S.AlsoEligibleInd, 
				E.PartOfFieldInd = S.PartOfFieldInd, 
				E.BlinkersToday = S.BlinkersToday, 
				E.BandagesTodayInd = S.BandagesTodayInd, 
				E.JockeyStatsYTD = S.JockeyStatsYTD,
				E.TrainerStatsYTD = S.TrainerStatsYTD,
				E.ReservedString3 = S.ReservedString3,
				E.ReservedString4 = S.ReservedString4,
				E.PostPosition = S.PostPosition, 
				E.OffTrackRating = S.OffTrackRating, 
				E.TurfRating = S.TurfRating, 
				E.FirstTimeLasix = S.FirstTimeLasix
    WHEN NOT MATCHED THEN  
		INSERT (
					RacID,
					RaceDt,
					TrackCd,
					RaceNum,
					HorseName,
					HorseID,
					PolePosition,
					MorningLine,
					PaceLines,
					EntryChar,
					ScratchFlagInd,
					CurrentYr,
					StartsThisYr,
					WinThisYr,
					PlacesThisYr,
					ShowsThisYr,
					EarningThisYr,
					PrevYearForEarning,
					StartsPrevYr,
					WinPrevYr,
					PlacesPrevYr,
					ShowsPrevYr,
					EarningPrevYr,
					OwnerName,
					Color,
					YearBorn,
					MonthBorn,
					StateBredInd,
					Age,
					Sex,
					SireName,
					SiresSire,
					Dam,
					DamsSire,
					TrainerName,
					BreederName,
					TrainerStarts,
					TrainerWins,
					TrainerPlaces,
					TrainerShows,
					TrainerPercentage,
					LasixInd,
					ButeInd,
					WeightAssigned,
					ApprenticeWtAllowance,
					JockeyName,
					JockeyID,
					JockeyStarts,
					JockeyWins,
					JockeyPlaces,
					JockeyShows,
					JockeyPercentage,
					ClaimingPrice,
					LifetimeStarts,
					LifetimeWins,
					LifetimePlaces,
					LifetimeShows,
					LifetimeEarnings,
					TrackStarts,
					TrackWins,
					TrackPlaces,
					TrackShows,
					TrackEarnings,
					TurfStarts,
					TurfWins,
					TurfPlaces,
					TurfShows,
					TurfEarnings,
					WetStarts,
					WetWins,
					WetPlaces,
					WetShows,
					WetEarnings,
					DistanceStarts,
					DistanceWins,
					DistancePlaces,
					DistanceShows,
					DistanceEarnings,
					AlsoEligibleInd,
					PartOfFieldInd,
					BlinkersToday,
					BandagesTodayInd,
					JockeyStatsYTD,
					TrainerStatsYTD,
					ReservedString3,
					ReservedString4,
					PostPosition,
					OffTrackRating,
					TurfRating,
					FirstTimeLasix
			   )
			   VALUES
			   (
					(SELECT RacID FROM kelso.rac WHERE RaceDt = S.RaceDt AND TrackCd = S.TrackCd AND RaceNum = S.RaceNum),
					S.RaceDt,
					S.TrackCd, 
					S.RaceNum,
					S.HorseName,
					(SELECT HorseID FROM kelso.Horses WHERE HorseName = S.HorseName),
					S.PolePosition,
					S.MorningLine,
					S.PaceLines,
					S.EntryChar,
					S.ScratchFlagInd,
					S.CurrentYr,
					S.StartsThisYr,
					S.WinThisYr,
					S.PlacesThisYr,
					S.ShowsThisYr,
					S.EarningThisYr,
					S.PrevYearForEarning,
					S.StartsPrevYr,
					S.WinPrevYr,
					S.PlacesPrevYr,
					S.ShowsPrevYr,
					S.EarningPrevYr,
					S.OwnerName,
					S.Color,
					S.YearBorn,
					S.MonthBorn,
					S.StateBredInd,
					S.Age,
					S.Sex,
					S.SireName,
					S.SiresSire,
					S.Dam,
					S.DamsSire,
					S.TrainerName,
					S.BreederName,
					S.TrainerStarts,
					S.TrainerWins,
					S.TrainerPlaces,
					S.TrainerShows,
					S.TrainerPercentage,
					S.LasixInd,
					S.ButeInd,
					S.WeightAssigned,
					S.ApprenticeWtAllowance,
					S.JockeyName,
					(SELECT JockeyID FROM kelso.Jockeys WHERE JockeyName = S.JockeyName),
					S.JockeyStarts,
					S.JockeyWins,
					S.JockeyPlaces,
					S.JockeyShows,
					S.JockeyPercentage,
					S.ClaimingPrice,
					S.LifetimeStarts,
					S.LifetimeWins,
					S.LifetimePlaces,
					S.LifetimeShows,
					S.LifetimeEarnings,
					S.TrackStarts,
					S.TrackWins,
					S.TrackPlaces,
					S.TrackShows,
					S.TrackEarnings,
					S.TurfStarts,
					S.TurfWins,
					S.TurfPlaces,
					S.TurfShows,
					S.TurfEarnings,
					S.WetStarts,
					S.WetWins,
					S.WetPlaces,
					S.WetShows,
					S.WetEarnings,
					S.DistanceStarts,
					S.DistanceWins,
					S.DistancePlaces,
					S.DistanceShows,
					S.DistanceEarnings,
					S.AlsoEligibleInd,
					S.PartOfFieldInd,
					S.BlinkersToday,
					S.BandagesTodayInd,
					S.JockeyStatsYTD,
					S.TrainerStatsYTD,
					S.ReservedString3,
					S.ReservedString4,
					S.PostPosition,
					S.OffTrackRating,
					S.TurfRating,
					S.FirstTimeLasix
			   );
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_EntSelect]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_HorseHistoryInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_HorseHistoryInsert]
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.HorseHistory
	SELECT (SELECT HorseID FROM kelso.Horses WHERE HorseName = S.HorseName) HorseID,
		   S.HorseName,
		   S.PaceLineDt RaceDt,
		   S.PaceLineTrackCd TrackCd,
		   S.PaceLineRaceNum RaceNum,
		   S.PaceLineDistance Distance,
		   (ROUND(S.PaceLineDistance / 660.00, 2)) Furlong,
		   S.InnerInd,
		   S.TurfInd,
		   S.TrackCondition,
		   S.StateBredInd,
		   S.ClassString,
		   S.ExtendedClassInfo,
		   S.Purse,
		   S.ClaimingPrice,
		   S.RaceClass,
		   S.StkHandicapGrade,
		   S.FirstCallTime,
		   S.SecondCallTime,
		   S.FinalTime,
		   S.AdditionalFractionalTime,
		   S.PostPosition, 
		   S.StartCallPosition,
		   S.FirstCallPosition,
		   S.SecondCallPosition,
		   S.StretchCallPosition,
		   S.FinalCallPosition,
		   S.FirstCallBeatenLengths,
		   S.SecondCallBeatenLengths,
		   S.StretchCallBeatenLengths,
		   S.FinalBeatenLengths,
		   CASE
			WHEN S.PaceLineDistance < (660.0 * 8.0) THEN S.FirstCallTime
			WHEN S.PaceLineDistance BETWEEN (660.0 * 8.0) AND (660.0 * 8.5) THEN S.AdditionalFractionalTime
		   END Furlong2,
		   CASE
			WHEN S.PaceLineDistance > 0 THEN 0
		   END Furlong3,
		   CASE
			WHEN S.PaceLineDistance < (660.0 * 8.0) THEN S.SecondCallTime
			WHEN S.PaceLineDistance >= (660.0 * 8.0) THEN S.FirstCallTime
		   END Furlong4,
		   CASE
			WHEN S.PaceLineDistance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) THEN S.AdditionalFractionalTime
		   END Furlong5,
		   CASE
			WHEN S.PaceLineDistance BETWEEN (660.0 * 6.5) AND (660.0 * 7.5) THEN S.AdditionalFractionalTime
			WHEN S.PaceLineDistance >= (660.0 * 8.0) THEN S.SecondCallTime
		   END Furlong6,
		   CASE
			WHEN S.PaceLineDistance > (660.0 * 8.5) THEN S.AdditionalFractionalTime
		   END Furlong8,
		   S.FinalTime FinnishTime,
		   NULL RankingPercentage,
		   S.JockeyName,
		   S.LasixInd,
		   S.FavoriteFlagInd,
		   S.PostTimeOdds,
		   S.FavortismOddRanking,
		   S.SpeedRating,
		   S.TrackVariant,
		   S.AdvancedSpeedFigure,
		   S.PTSEarlyPaceRating,
		   S.PTSLatePaceRating,
		   S.PTSTruePaceRating,
		   S.TroubleLine,
		   S.ExtendedTroubleLineInfo,
		   S.NumberOfEntrants
	FROM kelso.hor_staging S
	WHERE NOT EXISTS (SELECT *
					  FROM kelso.HorseHistory HH
					  WHERE HH.HorseName = S.HorseName
							AND HH.TrackCd = S.PaceLineTrackCd
							AND HH.RaceDt = S.PaceLineDt);
END
  
GO
/****** Object:  StoredProcedure [kelso].[vsp_HorseHistorySelect]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_HorseHistorySelect]
(
	@HorseId INT,
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT HH.HorseHistoryID,
		   HH.HorseID,
		   HH.RaceDt,
		   HH.TrackCd,
		   HH.RaceNum,
		   HH.Distance,
		   HH.Furlong,
		   HH.InnerInd,
		   HH.TurfInd,
		   HH.TrackCondition,
		   HH.StateBredInd,
		   HH.Purse,
		   HH.ClaimingPrice,
		   HH.RaceClass,
		   HH.StkHandicapGrade,
		   HH.FirstCallTime,
		   HH.SecondCallTime,
		   HH.FinalTime,
		   HH.AdditionalFractionalTime,
		   HH.PostPosition,
		   HH.StartCallPosition,
		   HH.FirstCallPosition,
		   HH.SecondCallPosition,
		   HH.StretchCallPosition,
		   HH.FinalCallPosition,
		   HH.FirstCallBeatenLengths,
		   HH.SecondCallBeatenLengths,
	 	   HH.StretchCallBeatenLengths,
		   HH.FinalBeatenLengths,
		   HH.JockeyName,
		   HH.LasixInd,
		   HH.FavoriteFlagInd,
		   HH.PostTimeOdds,
		   HH.FavortismOddRanking,
		   HH.SpeedRating,
		   HH.TrackVariant,
		   HH.AdvancedSpeedFigure,
		   HH.PTSEarlyPaceRating,
		   HH.PTSLatePaceRating,
		   PTSTruePaceRating,
		   HH.TroubleLine,
		   HH.ExtendedTroubleLineInfo,
		   HH.NumberOfEntrants,
		   HS.Furlong_1,
		   HS.Furlong_2,
		   HS.Furlong_3,
		   HS.Furlong_4,
		   CASE
			WHEN HS.Furlong_5 IS NOT NULL THEN HS.Furlong_5
			WHEN HS.Distance = (660.0 * 5.0) THEN HS.FinishTime
		   END Furlong_5,
		   CASE
			WHEN ISNULL(STATS5.StdevFurlongTime, 0.0) = 0.0 THEN 0.0
			WHEN HS.Furlong_5 IS NOT NULL THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.Furlong_5 - STATS5.AvgFurlongTime) / STATS5.StdevFurlongTime)) * 100.0, 2)
			WHEN HS.Distance = (660.0 * 5.0) AND ISNULL(HS.FinishTime, 0.0) > 0.0 THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS5.AvgFurlongTime) / STATS5.StdevFurlongTime)) * 100.0, 2)
		   END Furlong5RankingPerc,
		   CASE
			WHEN HS.Furlong_6 IS NOT NULL THEN HS.Furlong_6
			WHEN HS.Furlong = 6.0 THEN HS.FinishTime
		   END Furlong_6,
		   CASE
			WHEN ISNULL(STATS6.StdevFurlongTime, 0.0) = 0.0 THEN 0.0
			WHEN HS.Furlong_6 IS NOT NULL THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.Furlong_6 - STATS6.AvgFurlongTime) / STATS6.StdevFurlongTime)) * 100.0, 2)
			WHEN HS.Distance = (660.0 * 6.0) AND ISNULL(HS.FinishTime, 0.0) > 0.0 THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS6.AvgFurlongTime) / STATS6.StdevFurlongTime)) * 100.0, 2)
		   END Furlong6RankingPerc,
		   CASE
			WHEN HS.Furlong_8 IS NOT NULL THEN HS.Furlong_8
			WHEN HS.Furlong = 8.0 THEN HS.FinishTime
		   END Furlong_8,
		   CASE
		    WHEN ISNULL(STATS8.StdevFurlongTime, 0.0) = 0.0 THEN 0.0
			WHEN HS.Furlong_8 IS NOT NULL THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.Furlong_8 - STATS8.AvgFurlongTime) / STATS8.StdevFurlongTime)) * 100.0, 2)
			WHEN HS.Distance = (660.0 * 8.0) AND ISNULL(HS.FinishTime, 0.0) > 0.0 THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS8.AvgFurlongTime) / STATS8.StdevFurlongTime)) * 100.0, 2)
		   END Furlong8RankingPerc,
		   HS.FinishTime,
		   STATS.AvgFinishTime,
		   STATS.MinFinishTime,
		   STATS.MaxFinishTime,
		   STATS.StdevFinishTime,
		   CASE
			WHEN ISNULL(STATS.StdevFinishTime, 0.0) = 0.0 THEN NULL
			ELSE ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS.AvgFinishTime) / STATS.StdevFinishTime)) * 100, 2)
		   END FinishTimeRankingPerc,
		   HS.FirstCallPace,
		   HS.SecondCallPace,
		   HS.StretchCallPace,
		   HS.FinishCallPace,
		   HS.OverallPace
	FROM kelso.HorseHistory HH
		 JOIN kelso.HorseHistoryStats HS ON HS.HorseHistoryID = HH.HorseHistoryID
		 JOIN kelso.vw_HorseHistoryStatsTrackCondition STATS ON STATS.TrackCd = HH.TrackCd 
																AND STATS.Distance = HH.Distance 
																AND STATS.TurfInd = HH.TurfInd
																AND STATS.TrackCondition = HH.TrackCondition
		LEFT JOIN kelso.vw_5FurlongStats STATS5 ON STATS5.TrackCd = HH.TrackCd 
																AND STATS5.TurfInd = HH.TurfInd
																AND STATS5.TrackCondition = HH.TrackCondition
																AND (HH.Distance = (660.0 * 5.0) OR HH.Furlong5 IS NOT NULL)
		LEFT JOIN kelso.vw_6FurlongStats STATS6 ON STATS6.TrackCd = HH.TrackCd 
																AND STATS6.TurfInd = HH.TurfInd
																AND STATS6.TrackCondition = HH.TrackCondition
																AND (HH.Distance = (660.0 * 6.0) OR HH.Furlong6 IS NOT NULL)
		LEFT JOIN kelso.vw_8FurlongStats STATS8 ON STATS8.TrackCd = HH.TrackCd 
																AND STATS8.TurfInd = HH.TurfInd
																AND STATS8.TrackCondition = HH.TrackCondition
																AND (HH.Distance = (660.0 * 8.0) OR HH.Furlong8 IS NOT NULL)
	WHERE HH.HorseID = @HorseId
		  AND HH.RaceDt < @RaceDt
	ORDER BY HH.RaceDt;

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_HorseHistoryStatsInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_HorseHistoryStatsSelect]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_HorseHistoryStatsSelect]
(
	@HorseID INT
)
AS
BEGIN
	SET NOCOUNT ON;

	WITH CTE AS
	(
		SELECT *
		FROM kelso.HorseHistoryStats
		WHERE HorseID = @HorseID
	)
	SELECT HS.*,
		   C.AvgFinishTime,
		   C.MinFinishTime,
		   C.MaxFinishTime,
		   C.StdevFinishTime,
		   CASE
			WHEN ISNULL(StdevFinishTime, 0.0) = 0.0 THEN NULL
			ELSE ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - C.AvgFinishTime) / C.StdevFinishTime)) * 100.00, 2)
		   END PercentRanking
	FROM CTE HS
		 JOIN kelso.vw_HorseHistoryStatsTrackCondition C ON C.TrackCd = HS.TrackCd
															AND C.Distance = HS.Distance
															AND C.TurfInd = HS.TurfInd
															AND C.TrackCondition = HS.TrackCondition
	ORDER BY HS.RaceDt;

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_HorseInformation]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_HorseInformation]
(
	@HorseId INT,
	@RacId INT,
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	WITH historyCTE AS
	(
		SELECT *
		FROM kelso.HorseHistory
		WHERE HorseID = @HorseId
			  AND RaceDt < @RaceDt
	)
	SELECT H.HorseID,
		   H.HorseName,
		   (
			SELECT MAX (RaceDt) 
			FROM historyCTE
		   ) LastRaceDt, 
		   DATEDIFF(DAY,
					(
						SELECT MAX (RaceDt) 
						FROM historyCTE
					),
					@RaceDt 
		   ) NumOfDaysSinceLastRace,
		   (
			SELECT MAX (WorkOutDt) 
			FROM kelso.WorkoutHistory
			WHERE HorseID = H.HorseID 
				  AND WorkOutDt <= @RaceDt
		   ) LastWorkoutDt,
		   DATEDIFF(DAY,
					(
						SELECT MAX (WorkOutDt) 
						FROM kelso.WorkoutHistory
						WHERE HorseID = H.HorseID 
							  AND WorkOutDt <= @RaceDt
					),
					@RaceDt
		   ) NumOfDaysSinceLastWorkout,
		   (
				SELECT CONVERT
					   (
						FLOAT,
						CASE
							WHEN CHARINDEX('-', MorningLine) > 0 THEN SUBSTRING(MorningLine, 1, CHARINDEX('-', MorningLine) - 1)
							WHEN CHARINDEX('/', MorningLine) > 0 THEN SUBSTRING(MorningLine, 1, CHARINDEX('/', MorningLine) - 1)
							ELSE 1
						 END 
						) /
						CONVERT
						(
						 FLOAT,
						 CASE
							WHEN CHARINDEX('-', MorningLine) > 0 THEN SUBSTRING(MorningLine, CHARINDEX('-', MorningLine) + 1, 10)
							WHEN CHARINDEX('/', MorningLine) > 0 THEN SUBSTRING(MorningLine, CHARINDEX('/', MorningLine) + 1, 10)
							ELSE 1
						 END)  
				FROM kelso.ent
				WHERE RacID = @RacId AND HorseID = H.HorseID 
		   ) BettingLine,
		   H.StartsThisYr,
		   H.WinThisYr, 
		   CASE
			WHEN ISNULL(H.StartsThisYr, 0) = 0 THEN NULL
			ELSE ROUND((CAST(H.WinThisYr AS FLOAT) / CAST(H.StartsThisYr AS FLOAT)), 2) 
		   END WinsPerc,
		   (H.WinThisYr + H.PlaceThisYr + H.ShowThisYr) Top3Finishes,
		   CASE 
			WHEN ISNULL(H.StartsThisYr, 0) = 0 THEN NULL
			ELSE ROUND(CAST((H.WinThisYr + H.PlaceThisYr  + H.ShowThisYr) AS FLOAT) / CAST(H.StartsThisYr AS FLOAT), 2)
		   END Top3FinishesWinPerc,
		   H.LifetimeStarts,
		   H.LifetimeWins,
		   CASE
			WHEN ISNULL(H.LifetimeStarts, 0) = 0 THEN NULL
			ELSE ROUND((CAST(H.LifetimeWins AS FLOAT) / CAST(H.LifetimeStarts AS FLOAT)), 2) 
		   END LifetimeWinsPerc,
		   (H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) LifetimeTop3Finish,
		   CASE 
			WHEN ISNULL(H.LifetimeStarts, 0) = 0 THEN NULL
			ELSE ROUND(CAST((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) AS FLOAT) / CAST(H.LifetimeStarts AS FLOAT), 2)
		   END Top3FinishesLifetimePerc,
		   H.TurfStarts,
		   H.TurfWins,
		   CASE
			WHEN ISNULL(H.TurfStarts, 0) = 0 THEN NULL
			ELSE ROUND((CAST(H.TurfWins AS FLOAT) / CAST(H.TurfStarts AS FLOAT)), 2) 
		   END TurfWinsPerc,
		   (H.TurfWins + H.TurfPlaces + H.TurfShows) TurfTop3Finishes,
		   CASE 
			WHEN ISNULL(H.TurfStarts, 0) = 0 THEN NULL
			ELSE ROUND(CAST(((H.TurfWins + H.TurfPlaces + H.TurfShows)) AS FLOAT) / CAST(H.TurfStarts AS FLOAT), 2)
		   END Top3FinishesTurfPerc,
		   (H.LifetimeStarts - H.TurfStarts) NonTurfStarts,
		   CASE 
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND (H.LifetimeWins - H.TurfWins) > 0 THEN H.LifetimeWins - H.TurfWins 
		   END NonTurfWins,
		   CASE
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND (H.LifetimeWins - H.TurfWins) > 0 THEN ROUND(CAST((H.LifetimeWins - H.TurfWins) AS FLOAT) / CAST((H.LifetimeStarts - H.TurfStarts) AS FLOAT), 2)
		   END NonTurfWinsPerc,
		   CASE 
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND ((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows)) > 0 THEN ((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows)) 
		   END NonTurfTop3Finishes,
		   CASE
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND ((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows)) > 0 THEN ROUND(CAST((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows) AS FLOAT) / CAST((H.LifetimeStarts - H.TurfStarts) AS FLOAT), 2)
		   END Top3FinishesNonTurfPerc,
		   H.TurfRating,
		   H.OffTrackRating
	FROM kelso.Horses H
	WHERE H.HorseID = @HorseId;

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_HorsePredictedTimeUsingWorkout]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_HorsePredictedTimeUsingWorkout]
	@HorseID INT,
	@TrackCd VARCHAR(25),
	@RaceDt DATETIME,
	@TurfInd INT,
	@Distance FLOAT,
	@PredictedTime FLOAT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @MinDistance FLOAT = 0.0;
	DECLARE @MaxDistance FLOAT = 0.0;
	DECLARE @MinTime FLOAT = 0.0;
	DECLARE @MaxTime FLOAT = 0.0;
	DECLARE @Slope FLOAT = 0.0;

	SET @PredictedTime = 0.0;
	
	WITH CTE AS
	(
		SELECT TrackCd,
			   Distance,
			   AVG(WorkOutTime) WorkoutTime
		FROM kelso.WorkoutHistory
		WHERE HorseID = @HorseID
			AND TrackCd = @TrackCd
		GROUP BY TrackCd, Distance
	)
	SELECT @MaxDistance = MAX(Distance / 660.0),
		   @MinDistance = MIN(Distance / 660.0),
		   @MinTime = MIN(WorkoutTime),
		   @MaxTime = MAX(WorkoutTime)
	FROM CTE;

	IF @MaxDistance IS NULL AND @MinDistance IS NULL
	BEGIN
		WITH CTE AS
		(
			SELECT TrackCd,
					Distance,
					AVG(WorkOutTime) WorkoutTime
			FROM kelso.WorkoutHistory
			WHERE HorseID = @HorseID
			GROUP BY TrackCd, Distance
		)
		SELECT @MaxDistance = MAX(Distance / 660.0),
			   @MinDistance = MIN(Distance / 660.0),
			   @MinTime = MIN(WorkoutTime),
			   @MaxTime = MAX(WorkoutTime)
		FROM CTE;
	END 

	IF @MaxDistance = @MinDistance
	BEGIN
		SELECT @PredictedTime = @MaxTime;		
	END
	ELSE
	BEGIN
		SET @Slope = (LOG10(@MaxTime) - LOG10(@MinTime)) / (LOG10(@MaxDistance) - LOG10(@MinDistance));
		SELECT @PredictedTime = POWER(10.00000, (@Slope * (LOG10(@Distance / 660.0) - LOG10(@MinDistance))) + LOG10(@MinTime));
	END

	DECLARE @AdjustedPredictedTime FLOAT = 0.0;
	SELECT @AdjustedPredictedTime = (@PredictedTime * PercentageDiff)
	FROM [kelso].[vw_PercentageDiffWorkoutRacesTrack]
	WHERE TrackCd = @TrackCd
		AND Distance = @Distance;

	IF @AdjustedPredictedTime = 0.0 OR @AdjustedPredictedTime IS NULL
	BEGIN
		SELECT @AdjustedPredictedTime = @PredictedTime * PercDiff
		FROM [kelso].[vw_PercentageDiffWorkoutRaces]
		WHERE Distance = @Distance;
	END
	
	IF @AdjustedPredictedTime != 0.0
	BEGIN
		SET @PredictedTime = @AdjustedPredictedTime;
	END

	RETURN @PredictedTime;
END
  
GO
/****** Object:  StoredProcedure [kelso].[vsp_HorsesMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_HorsesMerge]
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Horses H
	USING (
			SELECT DISTINCT HorseName,
							CurrentYr,
						    StartsThisYr,
							WinThisYr,
							PlacesThisYr,
							ShowsThisYr,
							EarningThisYr,
							LifetimeStarts,
							LifetimeWins,
							LifetimePlaces,
							LifetimeShows,
							LifetimeEarnings,
							TurfStarts,
							TurfWins,
							TurfPlaces,
							TurfShows,
							OffTrackRating,
							TurfRating,
							RaceDt
			FROM kelso.ent_staging 
		  ) S
	ON S.HorseName = H.HorseName
	WHEN MATCHED THEN
		UPDATE 
			SET H.CurrentYear = NULL,
			    H.StartsThisYr = S.StartsThisYr,
			    H.WinThisYr = S.WinThisYr,
			    H.PlaceThisYr = S.PlacesThisYr,
			    H.ShowThisYr = S.ShowsThisYr,
			    H.EarningThisYr = S.EarningThisYr,
			    H.LifetimeStarts = S.LifetimeStarts,
			    H.LifetimeWins = S.LifetimeWins,
			    H.LifetimePlaces = S.LifetimePlaces,
			    H.LifetimeShows = S.LifetimeShows,
			    H.LifetimeEarnings = S.LifetimeEarnings,
			    H.TurfStarts = S.TurfStarts,
			    H.TurfWins = S.TurfWins,
			    H.TurfPlaces = S.TurfPlaces,
			    H.TurfShows = S.TurfShows,
			    H.OffTrackRating = S.OffTrackRating,
			    H.TurfRating = S.TurfRating,
			    H.ChangeDt = GETDATE(),
				H.RaceDt = S.RaceDt
    WHEN NOT MATCHED THEN  
		INSERT (
					HorseName,
					StartsThisYr,
					WinThisYr,
					PlaceThisYr,
					ShowThisYr,
					EarningThisYr,
					LifetimeStarts,
					LifetimeWins,
					LifetimePlaces,
					LifetimeShows,
					LifetimeEarnings,
					TurfStarts,
					TurfWins,
					TurfPlaces,
					TurfShows,
					OffTrackRating,
					TurfRating,
					ChangeDt,
					RaceDt
			   )
			   VALUES
			   (
					S.HorseName,
					S.StartsThisYr,
					S.WinThisYr,
					S.PlacesThisYr,
					S.ShowsThisYr,
					S.EarningThisYr,
				    S.LifetimeStarts,
				    S.LifetimeWins,
				    S.LifetimePlaces,
				    S.LifetimeShows,
				    S.LifetimeEarnings,
				    S.TurfStarts,
				    S.TurfWins,
					S.TurfPlaces,
				    S.TurfShows,
				    S.OffTrackRating,
				    S.TurfRating,
					GETDATE(),
					S.RaceDt
			   );
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_HorseTimeTrackRanking]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_HorseTimeTrackRanking]
	@CalculateTime FLOAT,
	@TrackCd VARCHAR(25),
	@Distance FLOAT
AS
	SET NOCOUNT ON;

	SELECT ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((@CalculateTime - HS.AvgFinishTime) / HS.StdevFinishTime)) * 100.00, 2.0) PercentRanking
	FROM kelso.vw_HorseHistoryStats HS
	WHERE HS.TrackCd = @TrackCd
		  AND HS.Distance = @Distance;
GO
/****** Object:  StoredProcedure [kelso].[vsp_JockeysMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_JockeysMerge]
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Jockeys J
	USING (
			SELECT DISTINCT JockeyName,
							JockeyStarts,
							JockeyWins,
							JockeyPlaces,
							JockeyShows,
							JockeyPercentage,
							JockeyStatsYTD,
							RaceDt
			FROM kelso.ent_staging 
		  ) S
	ON S.JockeyName = J.JockeyName
	WHEN MATCHED THEN
		UPDATE 
			SET J.JockeyStarts = S.JockeyStarts, 
				J.JockeyWins = S.JockeyWins, 
				J.JockeyPlaces = S.JockeyPlaces, 
				J.JockeyShows = S.JockeyShows, 
				J.JockeyPercentage = S.JockeyPercentage, 
				J.JockeyStatsYTD = S.JockeyStatsYTD, 
				J.JockeyLifetimeStats = SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, LEN(S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD) - 1),
				J.JockeyLifetimeTotalRaces = SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD)),
				J.JockeyLifetimeTotalWin = SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2) - CHARINDEX(' ', S.JockeyStatsYTD)),
				J.JockeyLifetimeWinPercentage = SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2), CHARINDEX(')', S.JockeyStatsYTD) - CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2)),
			    J.ChangeDate = GETDATE(),
				J.RaceDt = S.RaceDt
    WHEN NOT MATCHED THEN  
		INSERT (
					JockeyName, 
					JockeyStarts, 
					JockeyWins, 
					JockeyPlaces, 
					JockeyShows, 
					JockeyPercentage, 
					JockeyStatsYTD, 
					JockeyLifetimeStats,
					JockeyLifetimeTotalRaces,
					JockeyLifetimeTotalWin,
					JockeyLifetimeWinPercentage,
					ChangeDate,
					RaceDt
			   )
			   VALUES
			   (
					S.JockeyName, 
					S.JockeyStarts, 
					S.JockeyWins, 
					S.JockeyPlaces, 
					S.JockeyShows, 
					S.JockeyPercentage, 
					S.JockeyStatsYTD, 
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, LEN(S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD) - 1),
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD)),
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2) - CHARINDEX(' ', S.JockeyStatsYTD)),
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2), CHARINDEX(')', S.JockeyStatsYTD) - CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2)),
					GETDATE(),
					S.RaceDt
			   );
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_PredictedTimeFirstTime]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_PredictedTimeFirstTime]
(
	@HorseID INT,
	@RaceDt DATETIME,
	@RaceNum INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Pace DECIMAL = NULL;
	DECLARE @Distance FLOAT = NULL;
	DECLARE @TurfInd INT = NULL;
	DECLARE @RaceClass INT = NULL;
	DECLARE @RaceID INT = NULL;
	DECLARE @TrackCd NVARCHAR(3) = NULL;
	DECLARE @PolePosition VARCHAR(20) = NULL;
	DECLARE @PredictedTime FLOAT = 0.0;

	SELECT @RaceID = RacID,
		   @Distance = Distance,
		   @TurfInd = TurfInd,
		   @RaceClass = RaceClass,
		   @TrackCd = TrackCd
	FROM kelso.rac
	WHERE RaceDt = @RaceDt
		AND RaceNum = @RaceNum; 

	SELECT @PolePosition = PolePosition
	FROM kelso.ent
	WHERE RacID = @RaceID
		AND HorseID = @HorseID;

	SELECT @Pace = ROUND(AVG(Distance / WorkOutTime), 3)
	FROM kelso.WorkoutHistory
	WHERE HorseID = @HorseID
		AND TrackCd = @TrackCd;

	IF @Pace IS NULL
	BEGIN
		SELECT TOP 1 @Pace = ROUND(AVG(Distance / WorkOutTime), 3)
		FROM kelso.WorkoutHistory
		WHERE TrackCd IN (
							SELECT TrackCd
							FROM kelso.WorkoutHistory
							WHERE HorseID = @HorseID
						 );
	END

	IF @Pace IS NOT NULL
	BEGIN
		WITH CTE AS
		(
			SELECT *
			FROM kelso.WorkoutHistory
			WHERE ISNULL(WorkOutTime, 0) != 0
				AND TrackCd = @TrackCd 
		)
		SELECT @PredictedTime = AVG(FinnishTime)
		FROM kelso.HorseHistory
		WHERE HorseID IN
			(
				SELECT HorseID
				FROM CTE C
				WHERE ROUND((Distance / WorkOutTime), 3) BETWEEN (@Pace - 0.1) AND (@Pace + 0.1)
			)
			AND TrackCd = @TrackCd
			AND Distance = @Distance
			AND TurfInd = @TurfInd
			AND PostPosition = @PolePosition
			AND RaceClass = @RaceClass;
	END
	
	SELECT @PredictedTime;
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_PredictedTimeHorseHistorySelect]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_PredictedTimeHorseHistorySelect]
(
	@HorseID INT,
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM [kelso].[vw_HorseHistoryPercentageRanking]
	WHERE HorseID = @HorseID
		  AND RaceDt < @RaceDt
	ORDER BY RaceDt;

END

GO
/****** Object:  StoredProcedure [kelso].[vsp_ProcessMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_ProcessMerge]
(
	@datatable ProcessTableType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Process P
	USING (
			SELECT *
			FROM @datatable 
		  ) DT
	ON DT.RacID = P.RacID AND DT.EntID = P.EntID
	WHEN MATCHED THEN
		UPDATE 
			SET P.ChangeDt = GETDATE(),
				P.Distance = DT.Distance,
				P.Furlong = DT.Furlong,
				P.LastRaceDt = DT.LastRaceDt,
				P.NumOfDaysSinceLastRace = DT.NumOfDaysSinceLastRace,
				P.LastWorkoutDt = DT.LastWorkoutDt,
				P.NumOfDaysSinceLastWorkout = DT.NumOfDaysSinceLastWorkout,
				P.BettingLine = DT.BettingLine,
				P.StartsThisYr = DT.StartsThisYr,
				P.WinThisYr = DT.WinThisYr,
				P.WinsPerc = DT.WinsPerc,
				P.Top3Finishes = DT.Top3Finishes,
				P.Top3FinishesWinPerc = DT.Top3FinishesWinPerc,
				P.LifetimeStarts = DT.LifetimeStarts,
				P.LifetimeWins = DT.LifetimeWins,
				P.LifetimeWinsPerc = DT.LifetimeWinsPerc,
				P.LifetimeTop3Finish = DT.LifetimeTop3Finish,
				P.Top3FinishesLifetimePerc = DT.Top3FinishesLifetimePerc,
				P.TurfStarts = DT.TurfStarts,
				P.TurfWins = DT.TurfWins,
				P.TurfWinsPerc = DT.TurfWinsPerc,
				P.TurfTop3Finishes = DT.TurfTop3Finishes,
				P.Top3FinishesTurfPerc = DT.Top3FinishesTurfPerc,
				P.NonTurfStarts = DT.NonTurfStarts,
				P.NonTurfWins = DT.NonTurfWins,
				P.NonTurfWinsPerc = DT.NonTurfWinsPerc,
				P.NonTurfTop3Finishes = DT.NonTurfTop3Finishes,
				P.Top3FinishesNonTurfPerc = DT.Top3FinishesNonTurfPerc,
				P.TrackStart = DT.TrackStart,
				P.TrackEarnings = DT.TrackEarnings,
				P.TrackWins = DT.TrackWins,
				P.TrackTop3Finishes = DT.TrackTop3Finishes,
				P.DistanceStart = DT.DistanceStart,
				P.DistanceEarnings = DT.DistanceEarnings,
				P.DistanceWins = DT.DistanceWins,
				P.DistanceTop3Finishes = DT.DistanceTop3Finishes,
				P.TurfRating = DT.TurfRating,
				P.SpeedRating = DT.SpeedRating,
				P.TrackVariant = DT.TrackVariant,
				P.AdvancedSpeedFigure = DT.AdvancedSpeedFigure,
				P.PTSEarlyPaceRating = DT.PTSEarlyPaceRating,
				P.PTSLatePaceRating = DT.PTSLatePaceRating,
				P.PTSTruePaceRating = DT.PTSTruePaceRating,
				P.PTSSpeedRating = DT.PTSSpeedRating,
				P.OffTrackRating = DT.OffTrackRating,
				P.JockeyStarts = DT.JockeyStarts,
				P.JockeyWins = DT.JockeyWins,
				P.JockeyTop3Finishes = DT.JockeyTop3Finishes,
				P.JockeyWinningPerc = DT.JockeyWinningPerc,
				P.JockeyLifetimeWinningPerc = DT.JockeyLifetimeWinningPerc,
				P.TrainerLifetimeWinningPerc = DT.TrainerLifetimeWinningPerc,
				P.LastWorkoutRankingPercentage = DT.LastWorkoutRankingPercentage,
				P.LastWorkoutDistance = DT.LastWorkoutDistance,
				P.Workout4FurlongAvg = DT.Workout4FurlongAvg,
				P.Workout5FurlongAvg = DT.Workout5FurlongAvg,
				P.Workout6FurlongAvg = DT.Workout6FurlongAvg,
				P.Workout7FurlongAvg = DT.Workout7FurlongAvg,
				P.Workout8FurlongAvg = DT.Workout8FurlongAvg,
				P.WorkoutTop3RankingAvg = DT.WorkoutTop3RankingAvg,
				P.Workout3MonthAvg = DT.Workout3MonthAvg,
				P.Workout6MonthAvg = DT.Workout6MonthAvg,
				P.Workout4FurlongBest = DT.Workout4FurlongBest,
				P.Workout5FurlongBest = DT.Workout5FurlongBest,
				P.Workout6FurlongBest = DT.Workout6FurlongBest,
				P.Workout7FurlongBest = DT.Workout7FurlongBest,
				P.Workout8FurlongBest = DT.Workout8FurlongBest,
				P.WorkoutAvgCurrentMonth = DT.WorkoutAvgCurrentMonth,
				P.Workout4FurlongCurrentMonth = DT.Workout4FurlongCurrentMonth,
				P.Workout5FurlongCurrentMonth = DT.Workout5FurlongCurrentMonth,
				P.Workout6FurlongCurrentMonth = DT.Workout6FurlongCurrentMonth,
				P.Workout7FurlongCurrentMonth = DT.Workout7FurlongCurrentMonth,
				P.Workout8FurlongCurrentMonth = DT.Workout8FurlongCurrentMonth,
				P.WorkoutAvgPreviousMonth = DT.WorkoutAvgPreviousMonth,
				P.Workout4FurlongPreviousMonth = DT.Workout4FurlongPreviousMonth,
				P.Workout5FurlongPreviousMonth = DT.Workout5FurlongPreviousMonth,
				P.Workout6FurlongPreviousMonth = DT.Workout6FurlongPreviousMonth,
				P.Workout7FurlongPreviousMonth = DT.Workout7FurlongPreviousMonth,
				P.Workout8FurlongPreviousMonth = DT.Workout8FurlongPreviousMonth,
				P.WorkoutAvgPrevious2Month = DT.WorkoutAvgPrevious2Month,
				P.Workout4FurlongPrevious2Month = DT.Workout4FurlongPrevious2Month,
				P.Workout5FurlongPrevious2Month = DT.Workout5FurlongPrevious2Month,
				P.Workout6FurlongPrevious2Month = DT.Workout6FurlongPrevious2Month,
				P.Workout7FurlongPrevious2Month = DT.Workout7FurlongPrevious2Month,
				P.Workout8FurlongPrevious2Month = DT.Workout8FurlongPrevious2Month,
				P.WorkoutAvgPrevious3Month = DT.WorkoutAvgPrevious3Month,
				P.Workout4FurlongPrevious3Month = DT.Workout4FurlongPrevious3Month,
				P.Workout5FurlongPrevious3Month = DT.Workout5FurlongPrevious3Month,
				P.Workout6FurlongPrevious3Month = DT.Workout6FurlongPrevious3Month,
				P.Workout7FurlongPrevious3Month = DT.Workout7FurlongPrevious3Month,
				P.Workout8FurlongPrevious3Month = DT.Workout8FurlongPrevious3Month,
				P.WorkoutSameTrackBest = DT.WorkoutSameTrackBest,
				P.WorkoutSameTrackBest3 = DT.WorkoutSameTrackBest3,
				P.WorkoutSameTrackAvg = DT.WorkoutSameTrackAvg,
				P.CalculateTimeMethod = DT.CalculateTimeMethod,
				P.CalculateTime = DT.CalculateTime,
				P.CalculateTimePercentageAvg = DT.CalculateTimePercentageAvg,
				P.CalculateTimeUsingPaceAvg = DT.CalculateTimeUsingPaceAvg,
				P.CalculateTimeUsingPaceOverallAvg = DT.CalculateTimeUsingPaceOverallAvg,
				P.CalculateTimeTrendCorrelation = DT.CalculateTimeTrendCorrelation,
				P.CalculateTimeTrendIntercept = DT.CalculateTimeTrendIntercept,
				P.CalculateTimeTrendR2 = DT.CalculateTimeTrendR2,
				P.CalculateTimeTrendSlope = DT.CalculateTimeTrendSlope,
				P.Furlong5Time = DT.Furlong5Time,
				P.Furlong5TimeRankingPerc = DT.Furlong5TimeRankingPerc,
				P.Furlong6Time = DT.Furlong6Time,
				P.Furlong6TimeRankingPerc = DT.Furlong6TimeRankingPerc,
				P.Furlong8Time = DT.Furlong8Time,
				P.Furlong8TimeRankingPerc = DT.Furlong8TimeRankingPerc,
				P.CalculateTimeUsingPaceOverallRankingPerc = DT.CalculateTimeUsingPaceOverallRankingPerc
    WHEN NOT MATCHED THEN  
		INSERT (
				RacID,
				EntID,
				CreatedDt,
				ChangeDt,
				RaceDt,
				TrackCd,
				Distance,
				Furlong,
				RaceNum,
				TurfInd,
				HorseID,
				HorseName,
				PolePosition,
				LastRaceDt,
				NumOfDaysSinceLastRace,
				LastWorkoutDt,
				NumOfDaysSinceLastWorkout,
				BettingLine,
				StartsThisYr,
				WinThisYr,
				WinsPerc,
				Top3Finishes,
				Top3FinishesWinPerc,
				LifetimeStarts,
				LifetimeWins,
				LifetimeWinsPerc,
				LifetimeTop3Finish,
				Top3FinishesLifetimePerc,
				TurfStarts,
				TurfWins,
				TurfWinsPerc,
				TurfTop3Finishes,
				Top3FinishesTurfPerc,
				NonTurfStarts,
				NonTurfWins,
				NonTurfWinsPerc,
				NonTurfTop3Finishes,
				Top3FinishesNonTurfPerc,
				TrackStart,
				TrackEarnings,
				TrackWins,
				TrackTop3Finishes,
				DistanceStart,
				DistanceEarnings,
				DistanceWins,
				DistanceTop3Finishes,
				TurfRating,
				SpeedRating,
				TrackVariant,
				AdvancedSpeedFigure,
				PTSEarlyPaceRating,
				PTSLatePaceRating,
				PTSTruePaceRating,
				PTSSpeedRating,
				OffTrackRating,
				JockeyStarts,
				JockeyWins,
				JockeyTop3Finishes,
				JockeyWinningPerc,
				JockeyLifetimeWinningPerc,
				TrainerLifetimeWinningPerc,
				LastWorkoutRankingPercentage,
				LastWorkoutDistance,
				Workout4FurlongAvg,
				Workout5FurlongAvg,
				Workout6FurlongAvg,
				Workout7FurlongAvg,
				Workout8FurlongAvg,
				WorkoutTop3RankingAvg,
				Workout3MonthAvg,
				Workout6MonthAvg,
				Workout4FurlongBest,
				Workout5FurlongBest,
				Workout6FurlongBest,
				Workout7FurlongBest,
				Workout8FurlongBest,
				WorkoutAvgCurrentMonth,
				Workout4FurlongCurrentMonth,
				Workout5FurlongCurrentMonth,
				Workout6FurlongCurrentMonth,
				Workout7FurlongCurrentMonth,
				Workout8FurlongCurrentMonth,
				WorkoutAvgPreviousMonth,
				Workout4FurlongPreviousMonth,
				Workout5FurlongPreviousMonth,
				Workout6FurlongPreviousMonth,
				Workout7FurlongPreviousMonth,
				Workout8FurlongPreviousMonth,
				WorkoutAvgPrevious2Month,
				Workout4FurlongPrevious2Month,
				Workout5FurlongPrevious2Month,
				Workout6FurlongPrevious2Month,
				Workout7FurlongPrevious2Month,
				Workout8FurlongPrevious2Month,
				WorkoutAvgPrevious3Month,
				Workout4FurlongPrevious3Month,
				Workout5FurlongPrevious3Month,
				Workout6FurlongPrevious3Month,
				Workout7FurlongPrevious3Month,
				Workout8FurlongPrevious3Month,
				WorkoutSameTrackBest,
				WorkoutSameTrackBest3,
				WorkoutSameTrackAvg,
				CalculateTimeMethod,
				CalculateTime,
				CalculateTimePercentageAvg,
				CalculateTimeUsingPaceAvg,
				CalculateTimeUsingPaceOverallAvg,
				CalculateTimeTrendCorrelation,
				CalculateTimeTrendIntercept,
				CalculateTimeTrendR2,
				CalculateTimeTrendSlope,
				Furlong5Time,
				Furlong5TimeRankingPerc,
				Furlong6Time,
				Furlong6TimeRankingPerc,
				Furlong8Time,
				Furlong8TimeRankingPerc,
				CalculateTimeUsingPaceOverallRankingPerc
			   )
			   VALUES
			   (
				DT.RacID,
				DT.EntID,
				GETDATE(),
				GETDATE(),
				DT.RaceDt,
				DT.TrackCd,
				DT.Distance,
				DT.Furlong,
				DT.RaceNum,
				DT.TurfInd,
				DT.HorseID,
				DT.HorseName,
				DT.PolePosition,
				DT.LastRaceDt,
				DT.NumOfDaysSinceLastRace,
				DT.LastWorkoutDt,
				DT.NumOfDaysSinceLastWorkout,
				DT.BettingLine,
				DT.StartsThisYr,
				DT.WinThisYr,
				DT.WinsPerc,
				DT.Top3Finishes,
				DT.Top3FinishesWinPerc,
				DT.LifetimeStarts,
				DT.LifetimeWins,
				DT.LifetimeWinsPerc,
				DT.LifetimeTop3Finish,
				DT.Top3FinishesLifetimePerc,
				DT.TurfStarts,
				DT.TurfWins,
				DT.TurfWinsPerc,
				DT.TurfTop3Finishes,
				DT.Top3FinishesTurfPerc,
				DT.NonTurfStarts,
				DT.NonTurfWins,
				DT.NonTurfWinsPerc,
				DT.NonTurfTop3Finishes,
				DT.Top3FinishesNonTurfPerc,
				DT.TrackStart,
				DT.TrackEarnings,
				DT.TrackWins,
				DT.TrackTop3Finishes,
				DT.DistanceStart,
				DT.DistanceEarnings,
				DT.DistanceWins,
				DT.DistanceTop3Finishes,
				DT.TurfRating,
				DT.SpeedRating,
				DT.TrackVariant,
				DT.AdvancedSpeedFigure,
				DT.PTSEarlyPaceRating,
				DT.PTSLatePaceRating,
				DT.PTSTruePaceRating,
				DT.PTSSpeedRating,
				DT.OffTrackRating,
				DT.JockeyStarts,
				DT.JockeyWins,
				DT.JockeyTop3Finishes,
				DT.JockeyWinningPerc,
				DT.JockeyLifetimeWinningPerc,
				DT.TrainerLifetimeWinningPerc,
				DT.LastWorkoutRankingPercentage,
				DT.LastWorkoutDistance,
				DT.Workout4FurlongAvg,
				DT.Workout5FurlongAvg,
				DT.Workout6FurlongAvg,
				DT.Workout7FurlongAvg,
				DT.Workout8FurlongAvg,
				DT.WorkoutTop3RankingAvg,
				DT.Workout3MonthAvg,
				DT.Workout6MonthAvg,
				DT.Workout4FurlongBest,
				DT.Workout5FurlongBest,
				DT.Workout6FurlongBest,
				DT.Workout7FurlongBest,
				DT.Workout8FurlongBest,
				DT.WorkoutAvgCurrentMonth,
				DT.Workout4FurlongCurrentMonth,
				DT.Workout5FurlongCurrentMonth,
				DT.Workout6FurlongCurrentMonth,
				DT.Workout7FurlongCurrentMonth,
				DT.Workout8FurlongCurrentMonth,
				DT.WorkoutAvgPreviousMonth,
				DT.Workout4FurlongPreviousMonth,
				DT.Workout5FurlongPreviousMonth,
				DT.Workout6FurlongPreviousMonth,
				DT.Workout7FurlongPreviousMonth,
				DT.Workout8FurlongPreviousMonth,
				DT.WorkoutAvgPrevious2Month,
				DT.Workout4FurlongPrevious2Month,
				DT.Workout5FurlongPrevious2Month,
				DT.Workout6FurlongPrevious2Month,
				DT.Workout7FurlongPrevious2Month,
				DT.Workout8FurlongPrevious2Month,
				DT.WorkoutAvgPrevious3Month,
				DT.Workout4FurlongPrevious3Month,
				DT.Workout5FurlongPrevious3Month,
				DT.Workout6FurlongPrevious3Month,
				DT.Workout7FurlongPrevious3Month,
				DT.Workout8FurlongPrevious3Month,
				DT.WorkoutSameTrackBest,
				DT.WorkoutSameTrackBest3,
				DT.WorkoutSameTrackAvg,
				DT.CalculateTimeMethod,
				DT.CalculateTime,
				DT.CalculateTimePercentageAvg,
				DT.CalculateTimeUsingPaceAvg,
				DT.CalculateTimeUsingPaceOverallAvg,
				DT.CalculateTimeTrendCorrelation,
				DT.CalculateTimeTrendIntercept,
				DT.CalculateTimeTrendR2,
				DT.CalculateTimeTrendSlope,
				DT.Furlong5Time,
				DT.Furlong5TimeRankingPerc,
				DT.Furlong6Time,
				DT.Furlong6TimeRankingPerc,
				DT.Furlong8Time,
				DT.Furlong8TimeRankingPerc,
				DT.CalculateTimeUsingPaceOverallRankingPerc
			   );
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_RacInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_RacSelect]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [kelso].[vsp_ResultInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_ResultInsert]
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.Results (
								RacId,
								TrackCd,
								RaceDt,
								RaceNum,
								ReservedString1,
								Surface,
								ReservedString2,
								ReservedString3,
								ReservedString4,
								ReservedString5,
								ReservedString6,
								ReservedString7,
								ReservedString8,
								ReservedString9,
								ReservedString10,
								ReservedString11,
								FinalTime,
								TrackCondition,
								PostPosition,
								EntryFlag,
								HorseName,
								ReservedString12,
								ReservedString13,
								ReservedString14,
								ReservedString15,
								ReservedString16,
								ReservedString17,
								ReservedString18,
								ReservedString19,
								ReservedString20,
								FinishPosition,
								ReservedString21,
								WagerType10,
								WagerType11,
								WagerType12,
								WagerType13,
								WagerType14,
								HorseOdd,
								ReservedString22,
								ReservedString23,
								ReservedString24,
								ReservedString25,
								ReservedString26,
								ReservedString27,
								ReservedString28,
								ReservedString29,
								ReservedString30,
								ReservedString31,
								starter_field_size,
								official_finish_position,
								official_program_num,
								ReservedString32,
								ReservedString33,
								ReservedString34,
								ReservedString35,
								WinningNums10,
								WinningNums11,
								WinningNums12,
								WinningNums13,
								WinningNums14,
								TwoDollarsPayoff10,
								TwoDollarsPayoff11,
								TwoDollarsPayoff12,
								TwoDollarsPayoff13,
								TwoDollarsPayoff14,
								Pool10,
								Pool11,
								Pool12,
								Pool13,
								Pool14,
								BetAmt10,
								BetAmt11,
								BetAmt12,
								BetAmt13,
								BetAmt14,
								TwoDollarsWinPayOff,
								TwoDollarsPlacePayOff,
								TwoDollarsShowPayOff,
								WagerType1,
								WagerType2,
								WagerType3,
								WagerType4,
								WagerType5,
								WagerType6,
								WagerType7,
								WagerType8,
								WagerType9,
								WinningNums1,
								WinningNums2,
								WinningNums3,
								WinningNums4,
								WinningNums5,
								WinningNums6,
								WinningNums7,
								WinningNums8,
								WinningNums9,
								TwoDollarsPayoff1,
								TwoDollarsPayoff2,
								TwoDollarsPayoff3,
								TwoDollarsPayoff4,
								TwoDollarsPayoff5,
								TwoDollarsPayoff6,
								TwoDollarsPayoff7,
								TwoDollarsPayoff8,
								TwoDollarsPayoff9,
								Pool1,
								Pool2,
								Pool3,
								Pool4,
								Pool5,
								Pool6,
								Pool7,
								Pool8,
								Pool9,
								BetAmt1,
								BetAmt2,
								BetAmt3,
								BetAmt4,
								BetAmt5,
								BetAmt6,
								BetAmt7,
								BetAmt8,
								BetAmt9,
								ReservedString36,
								ReservedString37,
								ReservedString38,
								ReservedString39,
								ReservedString40,
								ReservedString41,
								ReservedString42,
								ReservedString43,
								ReservedString44,
								ReservedString45,
								ReservedString46,
								ReservedString47,
								ReservedString48,
								ReservedString49,
								ReservedString50,
								ReservedString51,
								ReservedString52,
								ReservedString53,
								ReservedString54,
								ReservedString55,
								ReservedString56,
								ReservedString57,
								ReservedString58,
								ReservedString59,
								ReservedString60,
								ReservedString61,
								ReservedString62,
								ReservedString63,
								ReservedString64,
								ReservedString65,
								ReservedString66,
								ReservedString67,
								ReservedString68,
								ReservedString69,
								ReservedString70,
								ReservedString71,
								ReservedString72,
								ReservedString73,
								ReservedString74,
								ReservedString75,
								ReservedString76,
								ReservedString77,
								ReservedString78,
								ReservedString79,
								ReservedString80,
								ReservedString81,
								ReservedString82,
								ReservedString83,
								ReservedString84,
								ReservedString85,
								ReservedString86,
								ReservedString87,
								ReservedString88,
								ReservedString89,
								ReservedString90,
								ReservedString91,
								ReservedString92,
								ReservedString93,
								ReservedString94,
								ReservedString95,
								ReservedString96,
								ReservedString97,
								ReservedString98,
								ReservedString99,
								ReservedString100,
								ReservedString101,
								ReservedString102,
								ReservedString103,
								ReservedString104,
								ReservedString105,
								ReservedString106,
								ReservedString107,
								ReservedString108,
								ReservedString109,
								ReservedString110,
								ReservedString111,
								ReservedString112,
								ReservedString113,
								ReservedString114,
								ReservedString115,
								ReservedString116,
								ReservedString117,
								ReservedString118,
								ReservedString119,
								ReservedString120,
								ReservedString121,
								ReservedString122,
								ReservedString123,
								ReservedString124,
								ReservedString125,
								ReservedString126,
								ReservedString127,
								ReservedString128,
								ReservedString129,
								ReservedString130,
								ReservedString131,
								ReservedString132,
								ReservedString133,
								ReservedString134,
								ReservedString135,
								ReservedString136,
								ReservedString137,
								ReservedString138,
								ReservedString139,
								ReservedString140,
								ReservedString141,
								ReservedString142,
								ReservedString143,
								ReservedString144,
								ReservedString145,
								ReservedString146,
								ReservedString147,
								ReservedString148,
								ReservedString149,
								ReservedString150,
								ReservedString151,
								ReservedString152,
								ReservedString153,
								ReservedString154,
								ReservedString155,
								ReservedString156,
								ReservedString157,
								ReservedString158,
								ReservedString159,
								ReservedString160,
								ReservedString161,
								ReservedString162,
								ReservedString163,
								ReservedString164,
								ReservedString165,
								ReservedString166,
								ReservedString167
							  )
				SELECT (SELECT RacID FROM kelso.rac WHERE TrackCd = S.TrackCd AND RaceDt = S.RaceDt AND RaceNum = S.RaceNum),
					   S.TrackCd,
					   S.RaceDt,
					   S.RaceNum,
					   S.ReservedString1,
					   S.Surface,
					   S.ReservedString2,
					   S.ReservedString3,
					   S.ReservedString4,
					   S.ReservedString5,
					   S.ReservedString6,
					   S.ReservedString7,
					   S.ReservedString8,
					   S.ReservedString9,
					   S.ReservedString10,
					   S.ReservedString11,
					   S.FinalTime,
					   S.TrackCondition,
					   S.PostPosition,
					   S.EntryFlag,
					   S.HorseName,
					   S.ReservedString12,
					   S.ReservedString13,
					   S.ReservedString14,
					   S.ReservedString15,
					   S.ReservedString16,
					   S.ReservedString17,
					   S.ReservedString18,
					   S.ReservedString19,
					   S.ReservedString20,
					   S.FinishPosition,
					   S.ReservedString21,
					   S.WagerType10,
					   S.WagerType11,
					   S.WagerType12,
					   S.WagerType13,
					   S.WagerType14,
					   S.HorseOdd,
					   S.ReservedString22,
					   S.ReservedString23,
					   S.ReservedString24,
					   S.ReservedString25,
					   S.ReservedString26,
					   S.ReservedString27,
					   S.ReservedString28,
					   S.ReservedString29,
					   S.ReservedString30,
					   S.ReservedString31,
					   S.starter_field_size,
					   S.official_finish_position,
					   S.official_program_num,
					   S.ReservedString32,
					   S.ReservedString33,
					   S.ReservedString34,
					   S.ReservedString35,
					   S.WinningNums10,
					   S.WinningNums11,
					   S.WinningNums12,
					   S.WinningNums13,
					   S.WinningNums14,
					   S.TwoDollarsPayoff10,
					   S.TwoDollarsPayoff11,
					   S.TwoDollarsPayoff12,
					   S.TwoDollarsPayoff13,
					   S.TwoDollarsPayoff14,
					   S.Pool10,
					   S.Pool11,
					   S.Pool12,
					   S.Pool13,
					   S.Pool14,
					   S.BetAmt10,
					   S.BetAmt11,
					   S.BetAmt12,
					   S.BetAmt13,
					   S.BetAmt14,
					   S.TwoDollarsWinPayOff,
					   S.TwoDollarsPlacePayOff,
					   S.TwoDollarsShowPayOff,
					   S.WagerType1,
					   S.WagerType2,
					   S.WagerType3,
					   S.WagerType4,
					   S.WagerType5,
					   S.WagerType6,
					   S.WagerType7,
					   S.WagerType8,
					   S.WagerType9,
					   S.WinningNums1,
					   S.WinningNums2,
					   S.WinningNums3,
					   S.WinningNums4,
					   S.WinningNums5,
					   S.WinningNums6,
					   S.WinningNums7,
					   S.WinningNums8,
					   S.WinningNums9,
					   S.TwoDollarsPayoff1,
					   S.TwoDollarsPayoff2,
					   S.TwoDollarsPayoff3,
					   S.TwoDollarsPayoff4,
					   S.TwoDollarsPayoff5,
					   S.TwoDollarsPayoff6,
					   S.TwoDollarsPayoff7,
					   S.TwoDollarsPayoff8,
					   S.TwoDollarsPayoff9,
					   S.Pool1,
					   S.Pool2,
					   S.Pool3,
					   S.Pool4,
					   S.Pool5,
					   S.Pool6,
					   S.Pool7,
					   S.Pool8,
					   S.Pool9,
					   S.BetAmt1,
					   S.BetAmt2,
					   S.BetAmt3,
					   S.BetAmt4,
					   S.BetAmt5,
					   S.BetAmt6,
					   S.BetAmt7,
					   S.BetAmt8,
					   S.BetAmt9,
					   S.ReservedString36,
					   S.ReservedString37,
					   S.ReservedString38,
					   S.ReservedString39,
					   S.ReservedString40,
					   S.ReservedString41,
					   S.ReservedString42,
					   S.ReservedString43,
					   S.ReservedString44,
					   S.ReservedString45,
					   S.ReservedString46,
					   S.ReservedString47,
					   S.ReservedString48,
					   S.ReservedString49,
					   S.ReservedString50,
					   S.ReservedString51,
					   S.ReservedString52,
					   S.ReservedString53,
					   S.ReservedString54,
					   S.ReservedString55,
					   S.ReservedString56,
					   S.ReservedString57,
					   S.ReservedString58,
					   S.ReservedString59,
					   S.ReservedString60,
					   S.ReservedString61,
					   S.ReservedString62,
					   S.ReservedString63,
					   S.ReservedString64,
					   S.ReservedString65,
					   S.ReservedString66,
					   S.ReservedString67,
					   S.ReservedString68,
					   S.ReservedString69,
					   S.ReservedString70,
					   S.ReservedString71,
					   S.ReservedString72,
					   S.ReservedString73,
					   S.ReservedString74,
					   S.ReservedString75,
					   S.ReservedString76,
					   S.ReservedString77,
					   S.ReservedString78,
					   S.ReservedString79,
					   S.ReservedString80,
					   S.ReservedString81,
					   S.ReservedString82,
					   S.ReservedString83,
					   S.ReservedString84,
					   S.ReservedString85,
					   S.ReservedString86,
					   S.ReservedString87,
					   S.ReservedString88,
					   S.ReservedString89,
					   S.ReservedString90,
					   S.ReservedString91,
					   S.ReservedString92,
					   S.ReservedString93,
					   S.ReservedString94,
					   S.ReservedString95,
					   S.ReservedString96,
					   S.ReservedString97,
					   S.ReservedString98,
					   S.ReservedString99,
					   S.ReservedString100,
					   S.ReservedString101,
					   S.ReservedString102,
					   S.ReservedString103,
					   S.ReservedString104,
					   S.ReservedString105,
					   S.ReservedString106,
					   S.ReservedString107,
					   S.ReservedString108,
					   S.ReservedString109,
					   S.ReservedString110,
					   S.ReservedString111,
					   S.ReservedString112,
					   S.ReservedString113,
					   S.ReservedString114,
					   S.ReservedString115,
					   S.ReservedString116,
					   S.ReservedString117,
					   S.ReservedString118,
					   S.ReservedString119,
					   S.ReservedString120,
					   S.ReservedString121,
					   S.ReservedString122,
					   S.ReservedString123,
					   S.ReservedString124,
					   S.ReservedString125,
					   S.ReservedString126,
					   S.ReservedString127,
					   S.ReservedString128,
					   S.ReservedString129,
					   S.ReservedString130,
					   S.ReservedString131,
					   S.ReservedString132,
					   S.ReservedString133,
					   S.ReservedString134,
					   S.ReservedString135,
					   S.ReservedString136,
					   S.ReservedString137,
					   S.ReservedString138,
					   S.ReservedString139,
					   S.ReservedString140,
					   S.ReservedString141,
					   S.ReservedString142,
					   S.ReservedString143,
					   S.ReservedString144,
					   S.ReservedString145,
					   S.ReservedString146,
					   S.ReservedString147,
					   S.ReservedString148,
					   S.ReservedString149,
					   S.ReservedString150,
					   S.ReservedString151,
					   S.ReservedString152,
					   S.ReservedString153,
					   S.ReservedString154,
					   S.ReservedString155,
					   S.ReservedString156,
					   S.ReservedString157,
					   S.ReservedString158,
					   S.ReservedString159,
					   S.ReservedString160,
					   S.ReservedString161,
					   S.ReservedString162,
					   S.ReservedString163,
					   S.ReservedString164,
					   S.ReservedString165,
					   S.ReservedString166,
					   S.ReservedString167
				FROM kelso.xdr_staging S
				WHERE NOT EXISTS (
									SELECT *
									FROM kelso.Results
									WHERE RaceDt = S.RaceDt
										  AND TrackCd = S.TrackCd
										  AND RaceNum = S.RaceNum
										  AND official_program_num = S.official_program_num
								 );
END;

GO
/****** Object:  StoredProcedure [kelso].[vsp_TrainersMerge]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_TrainersMerge]
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Trainers T
	USING (
			SELECT DISTINCT TrainerName,
						    TrainerStarts,
							TrainerWins,
							TrainerPlaces,
							TrainerShows,
							TrainerPercentage,
							TrainerStatsYTD
			FROM kelso.ent_staging 
		  ) S
	ON S.TrainerName = T.TrainerName
	WHEN MATCHED THEN
		UPDATE 
			SET T.TrainerStarts = S.TrainerStarts, 
				T.TrainerWins = S.TrainerWins, 
				T.TrainerPlaces = S.TrainerPlaces, 
				T.TrainerShows = S.TrainerShows, 
				T.TrainerPercentage = S.TrainerPercentage, 
				T.TrainerStatsYTD = S.TrainerStatsYTD, 
				T.TrainerLifetimeStats = SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, LEN(S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD) - 1),
				T.TrainerLifetimeTotalRaces = SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD)),
				T.TrainerLifetimeTotalWin = SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2) - CHARINDEX(' ', S.TrainerStatsYTD)),
				T.TrainerLifetimeWinPercentage = SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2), CHARINDEX(')', S.TrainerStatsYTD) - CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2)),
			    T.ChangeDate = GETDATE()
    WHEN NOT MATCHED THEN  
		INSERT (
					TrainerName, 
					TrainerStarts, 
					TrainerWins, 
					TrainerPlaces, 
					TrainerShows, 
					TrainerPercentage, 
					TrainerStatsYTD, 
					TrainerLifetimeStats,
					TrainerLifetimeTotalRaces,
					TrainerLifetimeTotalWin,
					TrainerLifetimeWinPercentage,
					ChangeDate
			   )
			   VALUES
			   (
					S.TrainerName, 
					S.TrainerStarts, 
					S.TrainerWins, 
					S.TrainerPlaces, 
					S.TrainerShows, 
					S.TrainerPercentage, 
					S.TrainerStatsYTD, 
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, LEN(S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD) - 1),
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD)),
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2) - CHARINDEX(' ', S.TrainerStatsYTD)),
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2), CHARINDEX(')', S.TrainerStatsYTD) - CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2)),
					GETDATE()
			   );
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_WorkoutHistoryInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_WorkoutHistoryInsert]
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.WorkoutHistory
	SELECT (SELECT HorseID FROM kelso.Horses WHERE HorseName = W.HorseName),
		   W.HorseName,
		   W.WorkOutDt,
		   W.WorkOutTrack,
		   W.WorkOutDistance,
		   ROUND(W.WorkOutDistance / 660.0, 2),
		   W.TurfInd,
		   W.TrainingTrackInd,
		   W.WorkOutTrackCond,
		   W.WorkOutTime,
		   W.BulletInd,
		   W.BreezingInd,
		   W.WorkOutRank,
		   W.WorkOutTotalNum
	FROM kelso.wor_staging W
	WHERE NOT EXISTS (
						SELECT *
						FROM kelso.WorkoutHistory 
						WHERE HorseName = W.HorseName
							  AND TrackCd = W.WorkOutTrack
							  AND WorkOutDt = W.WorkOutDt
					 );

END
  
GO
/****** Object:  StoredProcedure [kelso].[vsp_WorkoutHistoryStatsSelect]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_WorkoutHistoryStatsSelect]
(
	@HorseID INT,
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	WITH CTE AS
	(
		SELECT *
		FROM kelso.WorkoutHistory 
		WHERE HorseID = @HorseID
			  AND WorkOutDt <= @RaceDt
	)
	SELECT C.WorkoutHistoryID,
			C.HorseID,
			C.WorkOutDt,
			C.TrackCd,
			C.Distance,
			C.Furlong,
			C.TurfInd,
			C.TrackCond,
			C.WorkOutTime,
			CASE 
				WHEN ISNULL(S.WorkoutTimeStdv, 0) = 0 THEN 0.0
				ELSE ROUND(1.0 - kelso.fn_GetNormalDistributionCalc((C.WorkOutTime - S.WorkoutTimeAvg) / S.WorkoutTimeStdv), 2)
			END WorkoutRankingPerc,
			S.WorkoutTimeAvg,
			S.WorkoutTimeMin,
			S.WorkoutTimeMax,
			S.WorkoutTimeStdv,
			C.BreezingInd,
			C.BulletInd
	FROM CTE C
			JOIN kelso.vw_WorkoutStats S ON S.TrackCd = C.TrackCd 
										    AND S.Distance = C.Distance 
											AND S.TrackCond = C.TrackCond 
											AND S.TurfInd = C.TurfInd
	ORDER BY C.WorkOutDt DESC;
END

GO
/****** Object:  StoredProcedure [kelso].[vsp_XdrInsert]    Script Date: 2/7/2023 2:13:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [kelso].[vsp_XdrInsert]
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.xdr 
	SELECT S.*,
		   E.RacID
	FROM kelso.xdr_staging S
		 JOIN kelso.ent E ON E.RaceDt = S.RaceDt AND E.TrackCd = S.TrackCd AND E.PolePosition = S.official_program_num
	WHERE NOT EXISTS (
						SELECT *
						FROM kelso.xdr
						WHERE RaceDt = S.RaceDt
							  AND TrackCd = S.TrackCd
							  AND RaceNum = S.RaceNum
							  AND official_program_num = S.official_program_num
					 );

	
END;

GO
USE [master]
GO
ALTER DATABASE [FastTrackDev3] SET  READ_WRITE 
GO
