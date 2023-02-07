using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Data
{
    public static class TableName
    {
        public const string HOR = "kelso.hor";
        public const string ENT = "kelso.ent";
        public const string WOR = "kelso.wor";
        public const string RAC = "kelso.rac";
        public const string XDR = "kelso.Results";
        public const string CLS = "kelso.cls";
        public const string PROCESS = "kelso.Process";
        public const string HOR_STAGING = "kelso.hor_staging";
        public const string ENT_STAGING = "kelso.ent_staging";
        public const string WOR_STAGING = "kelso.wor_staging";
        public const string RAC_STAGING = "kelso.rac_staging";
        public const string XDR_STAGING = "kelso.xdr_staging";
        public const string CLS_STAGING = "kelso.cls_staging";
        public const string DRF_STAGING = "kelso.brisnet_drf_staging";
        public const string DR2_STAGING = "kelso.brisnet_dr2_staging";
        public const string DR3_STAGING = "kelso.brisnet_dr3_staging";
        public const string DR4_STAGING = "kelso.brisnet_dr4_staging";
        public const string XRD_STAGING = "kelso.brisnet_xrd_staging";
    }

    public static class FileType
    {
        public const string HOR = ".H";
        public const string ENT = ".E";
        public const string WOR = ".W";
        public const string RAC = ".R";
        public const string XDR = ".X";
        public const string CLS = ".C";
        public const string ZIP = ".zip";
        public const string DRF = ".DRF";
        public const string DR2 = ".DR2";
        public const string DR3 = ".DR3";
        public const string DR4 = ".DR4";
    }

    public static class StoreProcedures
    {
        public const string vsp_HorsesMerge = "kelso.vsp_HorsesMerge";
        public const string vsp_JockeysMerge = "kelso.vsp_JockeysMerge";
        public const string vsp_TrainersMerge = "kelso.vsp_TrainersMerge";
        public const string vsp_EntMerge = "kelso.vsp_EntMerge";
        public const string vsp_HorseHistoryInsert = "kelso.vsp_HorseHistoryInsert";
        public const string vsp_HorseHistoryStatsInsert = "kelso.vsp_HorseHistoryStatsInsert";
        public const string vsp_RacInsert = "kelso.vsp_RacInsert";
        public const string vsp_WorkoutHistoryInsert = "kelso.vsp_WorkoutHistoryInsert";
        public const string vsp_RacSelect = "kelso.vsp_RacSelect";
        public const string vsp_EntSelect = "kelso.vsp_EntSelect";
        public const string vsp_HorseHistorySelect = "kelso.vsp_HorseHistorySelect";
        public const string vsp_HorseInformation = "kelso.vsp_HorseInformation";
        public const string vsp_WorkoutHistoryStatsSelect = "kelso.vsp_WorkoutHistoryStatsSelect";
        public const string vsp_PredictedTimeHorseHistorySelect = "kelso.vsp_PredictedTimeHorseHistorySelect";
        public const string vsp_ResultInsert = "kelso.vsp_ResultInsert";
        public const string vsp_ProcessMerge = "kelso.vsp_ProcessMerge";
        public const string vsp_HorseTimeTrackRanking = "kelso.vsp_HorseTimeTrackRanking";
        public const string vsp_PredictedTimeFirstTime = "kelso.vsp_PredictedTimeFirstTime";
        public const string vsp_brisnet_drfMerge = "kelso.vsp_brisnet_drfMerge";
        public const string vsp_brisnet_dr2Merge = "kelso.vsp_brisnet_dr2Merge";
        public const string vsp_brisnet_dr3Merge = "kelso.vsp_brisnet_dr3Merge";
        public const string vsp_brisnet_dr4Insert = "kelso.vsp_brisnet_dr4Insert";
        public const string vsp_brisnet_drfSelect = "kelso.vsp_brisnet_drfSelect";
        public const string vsp_brisnet_HorseInformationMerge = "kelso.vsp_brisnet_HorseInformationMerge";
        public const string vsp_brisnet_HorseStatisticalAnalysisHistory = "kelso.vsp_brisnet_HorseStatisticalAnalysisHistory";
        public const string vsp_brisnet_JockeysMerge = "kelso.vsp_brisnet_JockeysMerge";
        public const string vsp_brisnet_TrainersMerge = "kelso.vsp_brisnet_TrainersMerge";
        public const string vsp_brisnet_WorkoutHistoryInsert = "kelso.vsp_brisnet_WorkoutHistoryInsert";
        public const string vsp_brisnet_HorseHistoryInsert = "kelso.vsp_brisnet_HorseHistoryInsert";
        public const string vsp_brisnet_TrntStatInsert = "kelso.vsp_brisnet_TrntStatInsert";
        public const string vsp_brisnet_xrdInsert = "kelso.vsp_brisnet_xrdInsert";
        public const string vsp_brisnet_ProgramFilesMerge = "kelso.vsp_brisnet_ProgramFilesMerge";
        public const string vsp_brisnet_FilesMerge = "kelso.vsp_brisnet_FilesMerge";
        public const string vsp_brisnet_RaceParticipantsInsert = "kelso.vsp_brisnet_RaceParticipantsInsert";
        public const string vsp_brisnet_Program = "kelso.vsp_brisnet_Program";
        public const string vsp_brisnet_ProgramGet = "kelso.vsp_brisnet_ProgramGet";
    }

    public static class PredictiveMethod
    {
        public const int SameTrackDistanceSurface = 1;
        public const int CalculateTime = 2;
    }
}


