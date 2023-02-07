using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using DataStreams.Common;
using DataStreams.Csv;
using Extreme.Statistics.Distributions;
using Many2PDFX;

namespace FastTrack;

public class frmMain : Form
{
	public enum KEY
	{
		KEY,
		KEY3,
		KEY8,
		KEY9
	}

	private OleDbConnection _conn = new OleDbConnection(ConfigurationManager.ConnectionStrings["Kelso"].ConnectionString);

	private DataSet _dataSet = new DataSet();

	private Default _def = new Default();

	private TrackInformation _trackInfo = new TrackInformation();

	private RaceInformation[] _raceInfo = null;

	private string[] _strTroubleLine = null;

	private int _Idx = 0;

	private bool _bPolling = false;

	private IContainer components = null;

	private Button bttnImport;

	private FolderBrowserDialog folderBrowserDialog1;

	private Label lblCondition;

	private TextBox txtBoxMaxDatePerformance;

	private Label lblMaxDateConsiderPerf;

	private TextBox txtBoxHandimanPerformance;

	private TextBox txtBoxModifiedBeyerSpeed;

	private Label lblHandimansPerformance;

	private Label lblModifiedBeyerSpeed;

	private TextBox txtBoxBeyerDistance;

	private TextBox txtBoxBeyerPerformance;

	private Label lblBeyerDistance;

	private Label lblBeyerPerformance;

	private ListBox lBoxEvent;

	private Button bttnStandardized;

	private Button bttnProcess;

	private Button bttnNext;

	private ListBox lBoxFiles;

	private BindingSource bindingSource1;

	private DataGridView dataGridView1;

	private Label lblTRaceTrack;

	private Label lblRaceTrack;

	private Label lblDate;

	private Label lblTDate;

	private Label lblRaceNum;

	private Label lblTRaceNum;

	private Label lblCalcType;

	private TextBox txtBoxWorkout;

	private TextBox txtBoxHandimanPercent;

	private Label lblGreater0Workout;

	private Label lblGreater0Handiman;

	private TextBox txtBoxJockey;

	private Label lblGreater0Jockey;

	private TextBox txtBoxTrainer;

	private Label lblGreater0Trainer;

	private Label lblTitleAdjustmentGreater0;

	private Label lblTitleAdjustmentEqual0;

	private TextBox txtBoxEq0Trainer;

	private TextBox txtBoxEq0Jockey;

	private TextBox txtBoxEq0Workout;

	private Label lblMaxDaysWorkout;

	private TextBox txtBoxMaxWorkoutDays;

	private Button bttnSaveAdjustment;

	private TextBox txtBoxClaimPrice;

	private Label lblClaimPriceTrend;

	private TextBox txtBoxBettingLine;

	private Label lblBettingLine;

	private TextBox txtBoxEq0BettingLine;

	private TextBox txtBoxEq0ClaimPrice;

	private DataGridView dataGridView2;

	private TextBox txtBoxClosingTrend;

	private Label lblClosingTrend;

	private Label lblJockeyNumOfRaces;

	private TextBox txtBoxMinNumOfRaces;

	private TextBox txtBoxStretchCall;

	private Label lblStretchCall;

	private TextBox txtBoxFavorite;

	private Label lblFavorite;

	private TextBox txtBoxDefineFavorite;

	private Label label1;

	private Button bttnReport;

	private ComboBox cbTrack;

	private ComboBox cbRacingDate;

	private Button bttnAllRace;

	private ComboBox cbModRacingDt;

	private ComboBox cbModTrack;

	private Button bttnSave;

	private ComboBox cbModHorseName;

	private ComboBox cbModRaceNum;

	private TextBox txtBoxFrankPoint;

	private TextBox txtBoxSpeedRating;

	private Label lblGreater0SpeedRating;

	private FileSystemWatcher fileSystemWatcher1;

	private Button bttnBeginPolling;

	private Button button4;

	private CheckBox ckBoxCloud;

	private ComboBox cbBoxProfile;

	private Button bttnLoadAdjustment;

	private ComboBox cbBoxNewRaceNum;

	private Button bttnProcessNew;

	private Button bttnResult;

	private Button bttnProcessResult;

	private Button button1;

	public frmMain()
	{
		InitializeComponent();
		try
		{
			_conn.Open();
			using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT * FROM kelso.adjustment WHERE id = 1", _conn))
			{
				using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
				object[] array = new object[oleDbDataReader.FieldCount];
				oleDbDataReader.Read();
				oleDbDataReader.GetValues(array);
				txtBoxBeyerPerformance.Text = array[1].ToString();
				txtBoxBeyerDistance.Text = array[2].ToString();
				txtBoxModifiedBeyerSpeed.Text = array[3].ToString();
				txtBoxHandimanPerformance.Text = array[4].ToString();
				txtBoxMaxDatePerformance.Text = array[5].ToString();
				txtBoxHandimanPercent.Text = array[6].ToString();
				txtBoxWorkout.Text = array[7].ToString();
				txtBoxJockey.Text = array[8].ToString();
				txtBoxTrainer.Text = array[9].ToString();
				txtBoxEq0Workout.Text = array[10].ToString();
				txtBoxEq0Jockey.Text = array[11].ToString();
				txtBoxEq0Trainer.Text = array[12].ToString();
				txtBoxMaxWorkoutDays.Text = array[13].ToString();
				txtBoxBettingLine.Text = array[14].ToString();
				txtBoxClaimPrice.Text = array[15].ToString();
				txtBoxEq0BettingLine.Text = array[16].ToString();
				txtBoxEq0ClaimPrice.Text = array[17].ToString();
				txtBoxClosingTrend.Text = array[18].ToString();
				txtBoxMinNumOfRaces.Text = array[19].ToString();
				txtBoxStretchCall.Text = array[20].ToString();
				txtBoxFavorite.Text = array[21].ToString();
				txtBoxDefineFavorite.Text = array[22].ToString();
				txtBoxSpeedRating.Text = array[23].ToString();
			}
			using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT DISTINCT track FROM kelso.process", _conn))
			{
				using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
				while (oleDbDataReader.Read())
				{
					cbTrack.Items.Add(oleDbDataReader.GetValue(0));
					cbModTrack.Items.Add(oleDbDataReader.GetValue(0));
				}
			}
			_conn.Close();
			_def.BeyerPerformance = double.Parse(txtBoxBeyerPerformance.Text) / 100.0;
			_def.BeyerDistance = double.Parse(txtBoxBeyerDistance.Text) / 100.0;
			_def.ModifiedBeyerSpeed = double.Parse(txtBoxModifiedBeyerSpeed.Text) / 100.0;
			_def.HandimanPerformance = double.Parse(txtBoxHandimanPerformance.Text) / 100.0;
			_def.MaxDate = double.Parse(txtBoxMaxDatePerformance.Text);
			_def.MaxDate2 = double.Parse(ConfigurationManager.AppSettings["MaxDate2"]);
			string[] files = Directory.GetFiles(ConfigurationManager.AppSettings["Files"], "*.c*");
			for (int i = 0; i < files.Count(); i++)
			{
				FileInfo fileInfo = new FileInfo(files[i]);
				lBoxFiles.Items.Add(fileInfo.Name.Replace(fileInfo.Extension, string.Empty));
			}
			_strTroubleLine = (from para in XDocument.Load(Application.StartupPath + "\\Parameters.xml").Root.Element("TroubleLine").Elements("Phrase")
				select para.Value).ToArray();
			fileSystemWatcher1.EnableRaisingEvents = false;
		}
		catch (Exception ex)
		{
			MessageBox.Show(ex.Message + "\n" + ex.StackTrace);
		}
	}

	private void bttnImport_Click(object sender, EventArgs e)
	{
		bttnImport.Enabled = false;
		_dataSet.Clear();
		if (_trackInfo != null)
		{
			_trackInfo = null;
		}
		_trackInfo = new TrackInformation();
		_Idx = 0;
		lBoxEvent.Items.Clear();
		_conn.Open();
		string fileName = (string)lBoxFiles.SelectedItem;
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Files located at " + ConfigurationManager.AppSettings["Files"]);
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Deleting data from rac, ent, and hor tables");
		truncateTable(_conn, new string[5] { "rac", "ent", "hor", "wor", "comp" });
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Deletion completed.");
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to rac.");
		loadToTable(_conn, "rac", fileName, "r", new string[1] { "RaceDt" });
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of rac completed.");
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to ent.");
		loadToTable(_conn, "ent", fileName, "e", new string[1] { "RaceDt" });
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of ent completed.");
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to hor.");
		loadToTable(_conn, "hor", fileName, "h", new string[2] { "RaceDt", "PaceLineDt" });
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of hor completed.");
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to wor.");
		loadToTable(_conn, "wor", fileName, "w", new string[2] { "RaceDt", "WorkOutDt" });
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of wor completed.");
		lBoxEvent.Items.Add("Click Standardizes to continue.");
		loadRaceNum();
		_conn.Close();
		bttnImport.Enabled = true;
	}

	private void loadRaceNum()
	{
		cbBoxNewRaceNum.Items.Clear();
		using OleDbCommand oleDbCommand = new OleDbCommand("SELECT DISTINCT racenum FROM kelso.rac", _conn);
		using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
		while (oleDbDataReader.Read())
		{
			cbBoxNewRaceNum.Items.Add(oleDbDataReader.GetValue(0));
		}
	}

	private void truncateTable(OleDbConnection conn, string[] tableName)
	{
		for (int i = 0; i < tableName.Count(); i++)
		{
			using OleDbCommand oleDbCommand = new OleDbCommand("DELETE FROM kelso." + tableName[i], conn);
			oleDbCommand.ExecuteNonQuery();
		}
	}

	private void loadToTable(OleDbConnection conn, string tableName, string fileName, string extension, string[] date)
	{
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Expected O, but got Unknown
		using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso." + tableName, conn);
		OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
		DataSet dataSet = new DataSet();
		oleDbDataAdapter.Fill(dataSet, tableName);
		dataSet.Tables[tableName].Rows.Clear();
		DirectoryInfo directoryInfo = new DirectoryInfo(ConfigurationManager.AppSettings["Files"]);
		FileInfo[] files = directoryInfo.GetFiles(fileName + "." + extension + "*");
		for (int i = 0; i < files.Count(); i++)
		{
			CsvReader val = new CsvReader(files[i].FullName);
			try
			{
				val.get_Settings().set_UseTextQualifier(true);
				while (((ReaderBase)val).ReadRecord())
				{
					string[] values = ((ReaderBase)val).get_Values();
					for (int j = 0; j < date.Length; j++)
					{
						values[dataSet.Tables[tableName].Columns.IndexOf(date[j])] = checkDate(values[dataSet.Tables[tableName].Columns.IndexOf(date[j])]);
					}
					dataSet.Tables[tableName].Rows.Add(values);
				}
			}
			finally
			{
				((IDisposable)val)?.Dispose();
			}
		}
		oleDbDataAdapter.InsertCommand = oleDbCommandBuilder.GetInsertCommand();
		oleDbDataAdapter.Update(dataSet, tableName);
		dataSet.Dispose();
	}

	private void loadToTable(OleDbConnection conn, string tableName, string fileName, string extension, string[] date, bool polling)
	{
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Expected O, but got Unknown
		using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso." + tableName, conn);
		OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
		DataSet dataSet = new DataSet();
		oleDbDataAdapter.Fill(dataSet, tableName);
		dataSet.Tables[tableName].Rows.Clear();
		DirectoryInfo directoryInfo = new DirectoryInfo(ConfigurationManager.AppSettings["polling"]);
		FileInfo[] files = directoryInfo.GetFiles(fileName + "." + extension + "*");
		for (int i = 0; i < files.Count(); i++)
		{
			CsvReader val = new CsvReader(files[i].FullName);
			try
			{
				val.get_Settings().set_UseTextQualifier(true);
				while (((ReaderBase)val).ReadRecord())
				{
					string[] values = ((ReaderBase)val).get_Values();
					for (int j = 0; j < date.Length; j++)
					{
						values[dataSet.Tables[tableName].Columns.IndexOf(date[j])] = checkDate(values[dataSet.Tables[tableName].Columns.IndexOf(date[j])]);
					}
					dataSet.Tables[tableName].Rows.Add(values);
				}
			}
			finally
			{
				((IDisposable)val)?.Dispose();
			}
		}
		oleDbDataAdapter.InsertCommand = oleDbCommandBuilder.GetInsertCommand();
		oleDbDataAdapter.Update(dataSet, tableName);
		dataSet.Dispose();
	}

	private string checkDate(string date)
	{
		if (DateTime.TryParse(date, out var dateTime))
		{
			if (dateTime < DateTime.Parse("03/01/00") && dateTime.Year < 1990)
			{
				return dateTime.AddDays(36524.0).ToShortDateString();
			}
			if (dateTime >= DateTime.Parse("03/01/00") && dateTime.Year < 1990)
			{
				return dateTime.AddDays(36525.0).ToShortDateString();
			}
			if (dateTime == DateTime.Parse("02/29/2000"))
			{
				return string.Empty;
			}
			return date;
		}
		return string.Empty;
	}

	private void loadDataFromDb(OleDbConnection conn)
	{
		List<string> list = new List<string>();
		list.Add("rac");
		list.Add("ent");
		list.Add("hor");
		List<string> list2 = list;
		for (int i = 0; i < list2.Count; i++)
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso." + list2[i], conn);
			oleDbDataAdapter.Fill(_dataSet, list2[i]);
			_dataSet.AcceptChanges();
		}
	}

	private string getRacingType(int rtypen, int grade)
	{
		return rtypen switch
		{
			0 => "M", 
			1 => "S", 
			2 => "C", 
			3 => "A", 
			4 => grade switch
			{
				1 => "G1", 
				2 => "G2", 
				3 => "G3", 
				_ => "N", 
			}, 
			5 => "T", 
			_ => string.Empty, 
		};
	}

	private string getAge(string age)
	{
		string text = (Regex.Match(age, "[0-9]").Success ? Regex.Match(age, "[0-9]").Value : string.Empty);
		if (text.IndexOfAny(new char[4] { '2', '3', '4', '5' }) != -1)
		{
			text = ((char)(int.Parse(text) + 63)).ToString();
		}
		return age.Contains("UP") ? (text + "U") : (text + "O");
	}

	private string getSex(int sex, string age)
	{
		switch (sex)
		{
		case 0:
			return "C";
		case 1:
			if (age.IndexOfAny(new char[3] { '1', '2', '3' }) != -1)
			{
				return "F";
			}
			return "M";
		case 2:
			return "N";
		default:
			return string.Empty;
		}
	}

	private void bttnStandardized_Click(object sender, EventArgs e)
	{
		dataGridView1.DataSource = null;
		dataGridView1.Refresh();
		dataGridView2.DataSource = null;
		dataGridView2.Refresh();
		loadDataFromDb(_conn);
		OrderedEnumerableRowCollection<DataRow> orderedEnumerableRowCollection = from query in _dataSet.Tables["rac"].AsEnumerable()
			orderby query.Field<int>("RaceNum")
			select query;
		_trackInfo.NumOfRace = orderedEnumerableRowCollection.Count();
		_trackInfo.TrackCode = (from track in orderedEnumerableRowCollection.AsQueryable()
			select track.Field<string>("TrackCd")).Distinct().Single();
		_trackInfo.RaceDate = (from raceDate in orderedEnumerableRowCollection.AsQueryable()
			select raceDate.Field<DateTime>("RaceDt")).Distinct().Single();
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter($"SELECT * FROM kelso.timestat WHERE trackcd = '{_trackInfo.TrackCode}' ORDER BY pacelinedistance", _conn))
		{
			oleDbDataAdapter.Fill(_dataSet, "stat");
		}
		_raceInfo = new RaceInformation[_trackInfo.NumOfRace];
		int num = 0;
		foreach (DataRow item in orderedEnumerableRowCollection)
		{
			_raceInfo[num] = new RaceInformation();
			_raceInfo[num].RaceNum = item.Field<int>("RaceNum");
			_raceInfo[num].SurfaceArea = ((item.Field<int>("TurfInd") == 1) ? "T" : "D");
			_raceInfo[num].RacingType = getRacingType(item.Field<int>("TurfInd"), orderedEnumerableRowCollection.First().Field<int>("StkHandicapGrade"));
			_raceInfo[num].Age = getAge(item.Field<string>("AgeRestriction"));
			_raceInfo[num].Sex = getSex(item.Field<int>("SexRestriction"), orderedEnumerableRowCollection.First().Field<string>("AgeRestriction"));
			_raceInfo[num].AgeSex = _raceInfo[num].Age + _raceInfo[num].Sex;
			_raceInfo[num].ClaimPrize = item.Field<double>("TopClaimPrice");
			_raceInfo[num].SurfaceCondition = ((_raceInfo[num].SurfaceArea == "D") ? "dirt" : "turf");
			_raceInfo[num].Furlong = item.Field<double>("Distance") / 660.0;
			num++;
		}
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Number of races - " + _trackInfo.NumOfRace + ".");
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Track Code - " + _trackInfo.TrackCode + ".");
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Race Date - " + _trackInfo.RaceDate.ToShortDateString() + ".");
		lBoxEvent.Items.Add("\n");
		startProcess();
	}

	private void startProcess()
	{
		_def.BeyerPerformance = double.Parse(txtBoxBeyerPerformance.Text) / 100.0;
		_def.BeyerDistance = double.Parse(txtBoxBeyerDistance.Text) / 100.0;
		_def.ModifiedBeyerSpeed = double.Parse(txtBoxModifiedBeyerSpeed.Text) / 100.0;
		_def.HandimanPerformance = double.Parse(txtBoxHandimanPerformance.Text) / 100.0;
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Ready to process races.");
		string text = "SpeedRating";
		lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Using " + text);
		if (_trackInfo.NumOfRace > _Idx)
		{
			OrderedEnumerableRowCollection<DataRow> orderedEnumerableRowCollection = from query in _dataSet.Tables["ent"].AsEnumerable()
				where query.Field<int>("RaceNum") == _raceInfo[_Idx].RaceNum
				orderby query.Field<string>("PolePosition")
				select query;
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Race number :" + _raceInfo[_Idx].RaceNum + ".");
			_raceInfo[_Idx].RaceHorseInfo = new RaceHorseInformation[orderedEnumerableRowCollection.Count()];
			int num = 0;
			List<string> list = new List<string>();
			foreach (DataRow item in orderedEnumerableRowCollection)
			{
				RaceHorseInformation raceHorseInformation = new RaceHorseInformation();
				parseMorningLine(item.Field<string>("MorningLine"), raceHorseInformation);
				raceHorseInformation.PolePosition = item.Field<string>("PolePosition");
				raceHorseInformation.HorseName = item.Field<string>("HorseName").ToUpper().Trim();
				raceHorseInformation.Entry = ((item.Field<int>("ScratchFlagInd") == 1) ? "S" : item.Field<string>("EntryChar").Trim());
				raceHorseInformation.Trainer1Starts = item.Field<int>("TrainerStarts");
				raceHorseInformation.Trainer2Wins = item.Field<int>("TrainerWins");
				raceHorseInformation.Trainer3Places = item.Field<int>("TrainerPlaces");
				raceHorseInformation.Trainer4Shows = item.Field<int>("TrainerShows");
				raceHorseInformation.Jockey5Starts = item.Field<int>("JockeyStarts");
				raceHorseInformation.Jockey6Wins = item.Field<int>("JockeyWins");
				raceHorseInformation.Jockey7Places = item.Field<int>("JockeyPlaces");
				raceHorseInformation.Jockey8Shows = item.Field<int>("JockeyShows");
				raceHorseInformation.Jockey9Name = item.Field<string>("JockeyName");
				raceHorseInformation.Scratch = ((raceHorseInformation.Entry == "S") ? true : false);
				string value = Regex.Match(item.Field<string>("JockeyStatsYTD"), "\\.[0-9][0-9]").Value;
				double num2 = 0.0;
				if (double.TryParse(value, out num2))
				{
					raceHorseInformation.JockeyStat = num2 * 100.0;
				}
				string value2 = Regex.Match(item.Field<string>("TrainerStatsYTD"), "\\.[0-9][0-9]").Value;
				double num3 = 0.0;
				if (double.TryParse(value2, out num3))
				{
					raceHorseInformation.TrainerStat = num3 * 100.0;
				}
				_raceInfo[_Idx].RaceHorseInfo[num] = raceHorseInformation;
				standardizeHorData(raceHorseInformation.HorseName, _raceInfo[_Idx].RaceNum);
				list.Add(raceHorseInformation.HorseName);
				num++;
				Application.DoEvents();
			}
			listHorse();
			getDataFromHorseHistory(list.ToArray());
			for (int i = 0; i < _raceInfo[_Idx].RaceHorseInfo.Count(); i++)
			{
				racingCalculation(_raceInfo[_Idx], i);
				workout(_raceInfo[_Idx], i);
				Application.DoEvents();
			}
			insertIntoRaceComp();
			Application.DoEvents();
			rsdv();
			Application.DoEvents();
			showResult();
			Application.DoEvents();
		}
		else
		{
			MessageBox.Show("No more race.");
		}
	}

	private double claimPriceTrend(double[] price)
	{
		if (price.Count() > 0)
		{
			int num = 0;
			for (int i = 0; i < price.Count(); i++)
			{
				num += i;
			}
			double num2 = num / price.Count();
			double num3 = price.Sum() / (double)price.Count();
			double num4 = 0.0;
			double num5 = 0.0;
			for (int i = 0; i < price.Count(); i++)
			{
				num4 += ((double)i - num2) * (price[i] - num3);
				num5 += Math.Pow((double)i - num2, 2.0);
			}
			return double.IsNaN(Math.Round(num4 / num5, 2)) ? 0.0 : Math.Round(num4 / num5, 2);
		}
		return 0.0;
	}

	private double lineRegression(double[] value)
	{
		if (value.Count() > 0)
		{
			int num = 0;
			for (int i = 0; i < value.Count(); i++)
			{
				num += i;
			}
			double num2 = num / value.Count();
			double num3 = value.Sum() / (double)value.Count();
			double num4 = 0.0;
			double num5 = 0.0;
			for (int i = 0; i < value.Count(); i++)
			{
				num4 += ((double)i - num2) * (value[i] - num3);
				num5 += Math.Pow((double)i - num2, 2.0);
			}
			return double.IsNaN(Math.Round(num4 / num5, 2)) ? 0.0 : Math.Round(num4 / num5, 2);
		}
		return 0.0;
	}

	private void racingCalculation(RaceInformation rac, int idx)
	{
		bool hasRec = false;
		int iFlexKey = 0;
		string strRating = "SpeedRating";
		IEnumerable<DataRow>[] key = getKey(rac, idx, ref hasRec, strRating);
		_raceInfo[_Idx].RaceHorseInfo[idx].HasHistory = hasRec;
		if (!hasRec)
		{
			return;
		}
		double[] array = (from query in _dataSet.Tables["hor"].AsEnumerable()
			where query.Field<string>("HorseName").ToUpper() == rac.RaceHorseInfo[idx].HorseName && query.Field<double>("ClaimingPrice") > 0.0
			orderby query.Field<DateTime>("PaceLineDt")
			select query.Field<double>("ClaimingPrice")).ToArray();
		if (array.Count() > 0)
		{
			rac.RaceHorseInfo[idx].ClaimPriceTrend = claimPriceTrend(rac.ClaimPrize - array[0]);
		}
		var enumerableRowCollection = from query in _dataSet.Tables["hor"].AsEnumerable()
			where query.Field<string>("HorseName").ToUpper() == rac.RaceHorseInfo[idx].HorseName
			select new
			{
				first = query.Field<double>("FirstCallBeatenLengths"),
				second = query.Field<double>("SecondCallBeatenLengths"),
				stretch = query.Field<double>("StretchCallBeatenLengths"),
				final = query.Field<double>("FinalBeatenLengths"),
				trouble = query.Field<string>("TroubleLine")
			};
		rac.RaceHorseInfo[idx].Closer = 0.0;
		if (enumerableRowCollection.Count() > 0)
		{
			int num = 0;
			foreach (var item in enumerableRowCollection)
			{
				double[] array2 = new double[4] { item.first, item.second, item.stretch, item.final };
				double num2 = (array2[0] - array2[3]) / 3.0;
				if (num2 >= 1.0)
				{
					num++;
				}
			}
			if ((double)(num / enumerableRowCollection.Count()) >= 0.33)
			{
				rac.RaceHorseInfo[idx].Closer = 1.0;
			}
			int num3 = enumerableRowCollection.Count();
		}
		double[] array3 = new double[22];
		if (rac.Furlong < 8.0)
		{
			key[0] = key[2];
			iFlexKey = ((rac.Furlong < 6.0) ? 1 : 2);
		}
		else if (rac.Furlong < 9.0)
		{
			key[0] = key[2];
			iFlexKey = 3;
		}
		else
		{
			iFlexKey = 4;
		}
		IEnumerable<DataRow> enumerable = key[0];
		IEnumerable<DataRow> enumerable2 = key[3];
		IEnumerable<DataRow> keyy = enumerable;
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = (from para in key[0]
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select para.Field<DateTime>("PaceLineDt")).DefaultIfEmpty().Max();
		DateTime dateTime = (dateTime = (from para in enumerable
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select para.Field<DateTime>("PaceLineDt")).DefaultIfEmpty().Max());
		double num4 = key[0].Where((DataRow para) => para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate && para.Field<double>("PaceLineDistance") >= 4.0).DefaultIfEmpty().Count();
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[10] = key[1].Select((DataRow para) => para.Field<DateTime>("PaceLineDt")).DefaultIfEmpty().Max();
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] = key[1].Select((DataRow para) => para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate && para.Field<double>("PaceLineDistance") >= 4.0).DefaultIfEmpty().Count();
		DateTime dtPDX = dateTime;
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[3] = 0;
		int num5 = 0;
		int num6 = 0;
		array3[11] = 0.0;
		double num7 = 0.0;
		num7 = (from para in enumerable
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate && para.Field<double>("PaceLineDistance") <= _raceInfo[_Idx].Furlong + 1.0
			select para.Field<double>(strRating)).DefaultIfEmpty().Average();
		array3[9] = (from para in enumerable
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).DefaultIfEmpty().Average();
		DateTime minValue = DateTime.MinValue;
		DateTime dateTime2 = _trackInfo.RaceDate.AddDays(-1.0);
		DateTime dateTime3 = _trackInfo.RaceDate.AddDays(-1.0);
		DateTime dateTime4 = _trackInfo.RaceDate.AddDays(-1.0);
		DateTime dateTime5 = _trackInfo.RaceDate.AddDays(-1.0);
		DateTime dateTime6 = _trackInfo.RaceDate.AddDays(-1.0);
		IOrderedEnumerable<DataRow> source = enumerable.OrderByDescending((DataRow query) => query.Field<DateTime>("PaceLineDt"));
		if (num4 >= 1.0)
		{
			dateTime2 = ((!(num4 > 1.0)) ? DateTime.MinValue : source.ElementAt(1).Field<DateTime>("PaceLineDt"));
			if (enumerable.Count() > 0)
			{
				array3[0] = beyerFlex(enumerable.First().Field<double>(strRating), enumerable.DefaultIfEmpty().First().Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey);
				array3[15] = source.First().Field<double>("PaceLineDistance");
			}
			array3[10] = array3[0];
			dtPDX = dateTime2;
			num6 = 1;
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[0] = array3[0];
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] = (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9]).TotalDays;
			array3[11] = array3[0] * 5.0 / 5.0;
		}
		if (num4 >= 2.0)
		{
			dateTime3 = ((!(num4 > 2.0)) ? DateTime.MinValue : source.ElementAt(2).Field<DateTime>("PaceLineDt"));
			if (enumerable.Count() > 0)
			{
				array3[1] = beyerFlex(enumerable.ElementAt(1).Field<double>(strRating), enumerable.ElementAt(1).Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey);
				array3[16] = source.ElementAt(1).Field<double>("PaceLineDistance");
			}
			dtPDX = dateTime3;
			num6 = 2;
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[1] = array3[1];
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[6] = (_trackInfo.RaceDate - dateTime2).TotalDays;
			array3[11] = (array3[0] * 5.0 + array3[1] * 4.0) / 9.0;
		}
		if (num4 >= 3.0)
		{
			dateTime4 = ((!(num4 > 3.0)) ? DateTime.MinValue : source.ElementAt(3).Field<DateTime>("PaceLineDt"));
			if (enumerable.Count() > 0)
			{
				array3[2] = beyerFlex(enumerable.ElementAt(2).Field<double>(strRating), enumerable.DefaultIfEmpty().ElementAt(2).Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey);
				array3[17] = source.ElementAt(2).Field<double>("PaceLineDistance");
			}
			dtPDX = dateTime4;
			num6 = 3;
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[2] = array3[2];
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[7] = (_trackInfo.RaceDate - dateTime3).TotalDays;
			array3[11] = (array3[0] * 5.0 + array3[1] * 4.0 + array3[2] * 3.0) / 12.0;
		}
		if (num4 >= 4.0)
		{
			dateTime5 = ((!(num4 > 4.0)) ? DateTime.MinValue : source.ElementAt(4).Field<DateTime>("PaceLineDt"));
			if (enumerable.Count() > 0)
			{
				array3[3] = beyerFlex(enumerable.ElementAt(3).Field<double>(strRating), enumerable.DefaultIfEmpty().ElementAt(3).Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey);
				array3[18] = source.ElementAt(3).Field<double>("PaceLineDistance");
			}
			dtPDX = dateTime5;
			num6 = 4;
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[3] = array3[3];
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[8] = (_trackInfo.RaceDate - dateTime4).TotalDays;
			array3[11] = (array3[0] * 5.0 + array3[1] * 4.0 + array3[2] * 3.0 + array3[3] * 2.0) / 14.0;
		}
		if (num4 >= 5.0)
		{
			dateTime6 = ((!(num4 > 5.0)) ? DateTime.MinValue : source.ElementAt(5).Field<DateTime>("PaceLineDt"));
			if (enumerable.Count() > 0)
			{
				array3[4] = beyerFlex(enumerable.ElementAt(4).Field<double>(strRating), enumerable.ElementAt(4).Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey);
				array3[19] = source.ElementAt(4).Field<double>("PaceLineDistance");
			}
			dtPDX = dateTime6;
			num6 = 5;
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[4] = array3[4];
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[9] = (_trackInfo.RaceDate - dateTime5).TotalDays;
			array3[11] = (array3[0] * 5.0 + array3[1] * 4.0 + array3[2] * 3.0 + array3[3] * 2.0 + array3[4]) / 15.0;
		}
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[7] = (from para in key[0]
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).DefaultIfEmpty().Min();
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[8] = (from para in key[0]
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).DefaultIfEmpty().Max();
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] = num4;
		double num8 = 0.0;
		if (dtPDX == DateTime.MinValue)
		{
			var source2 = key[0].Select((DataRow query) => new
			{
				beyer = beyerFlex(query.Field<double>(strRating), query.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)
			});
			var source3 = from query in key[0]
				where query.Field<double>(strRating) > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[7]
				select new
				{
					beyer = beyerFlex(query.Field<double>(strRating), query.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)
				};
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[6] = standardDeviation(source2.Select(para => para.beyer));
			num8 = standardDeviation(source3.Select(para => para.beyer));
		}
		else
		{
			var source2 = from query in key[0]
				where query.Field<DateTime>("PaceLineDt") >= dtPDX
				select new
				{
					beyer = beyerFlex(query.Field<double>(strRating), query.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)
				};
			var source3 = from query in key[0]
				where query.Field<DateTime>("PaceLineDt") >= dtPDX && query.Field<double>(strRating) > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[7]
				select new
				{
					beyer = beyerFlex(query.Field<double>(strRating), query.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)
				};
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[6] = standardDeviation(source2.Select(para => para.beyer));
			num8 = standardDeviation(source3.Select(para => para.beyer));
		}
		if (num7 == 0.0)
		{
			num7 = array3[9] * 0.9875;
		}
		double num9 = (from para in key[0]
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select para.Field<double>(strRating) - (_raceInfo[_Idx].Furlong - para.Field<double>("PaceLineDistance")) * 0.5 - (para.Field<double>("PaceLineDistance") * 0.5 - 4.0) + para.Field<double>("SecondCallBeatenLengths") * (1.0 - 0.03 * para.Field<double>("SecondCallBeatenLengths")) - para.Field<double>("FirstCallBeatenLengths") * (0.95 + 0.02 * para.Field<double>("FirstCallBeatenLengths"))).DefaultIfEmpty().Average();
		if (array3[4] > 0.0 || array3[3] > 0.0 || array3[2] > 0.0)
		{
			array3[5] = array3[1] - array3[11];
			array3[6] = array3[0] - array3[11];
			array3[7] = array3[0] - array3[1];
			array3[8] = array3[1] - array3[2];
		}
		else if (array3[1] > 0.0)
		{
			array3[5] = array3[1] - array3[11];
			array3[6] = array3[0] - array3[11];
			array3[7] = array3[0] - array3[1];
		}
		else
		{
			array3[5] = 0.0;
			array3[6] = 0.0;
			array3[7] = 0.0;
		}
		double num10 = array3[5];
		double num11 = array3[6];
		double num12 = array3[7];
		double[] array4 = new double[9];
		array3[8] = array3[7];
		array4[1] = array4[0];
		if ((_raceInfo[_Idx].Furlong >= 8.0 && _raceInfo[_Idx].SurfaceCondition == "dirt") || array4[0] == 0.0)
		{
			array4[0] = array3[6] + 0.25 * array3[5] + array3[7] * 0.5;
		}
		array4[2] = array4[0];
		array4[7] = array4[0];
		if (array4[0] > 0.0)
		{
			array4[0] = Math.Pow(array4[0], 1.2);
		}
		else
		{
			array4[0] = 0.0 - Math.Pow(Math.Abs(array4[0]), 1.2);
		}
		if (_raceInfo[_Idx].Furlong < 8.0)
		{
			array4[0] *= 0.97;
		}
		else
		{
			array4[0] *= 0.9;
		}
		if (_raceInfo[_Idx].Furlong >= 8.0)
		{
			array4[0] = 0.0 - array4[0];
		}
		if (_raceInfo[_Idx].Furlong < 888.0)
		{
			if (array4[0] > 5.0)
			{
				array4[0] = array4[0] + 0.95 - array4[0] / 5.0;
			}
			else if (array4[0] < -5.0)
			{
				array4[0] = 0.0 - (array4[0] - array4[0] / 5.0);
			}
			array4[3] = array4[0];
			if (array4[0] > 0.0)
			{
				if (array4[0] >= (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6])
				{
					array4[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6];
				}
			}
			else if (array4[0] <= 0.0 - (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6])
			{
				array4[0] = 0.0 - (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6];
			}
		}
		array4[4] = array4[0];
		array3[8] = num8;
		double num13 = array3[8];
		if (_raceInfo[_Idx].RacingType == "A")
		{
			if (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] > 35.0 && (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays > 35.0)
			{
				if (array4[0] > 0.0)
				{
					array4[0] = Math.Abs(array4[0]) * 0.5;
				}
				else
				{
					array4[0] = -99.0;
				}
			}
		}
		else if (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] > 50.0 && (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays > 50.0)
		{
			if (array4[0] > 0.0)
			{
				array4[0] = Math.Abs(array4[0]) * 0.33;
			}
			else
			{
				array4[0] = -99.0;
			}
		}
		array4[5] = array4[0];
		double pxn = getPxn(_raceInfo[_Idx].Furlong);
		double num14 = 0.0;
		double pxa = 0.0;
		double pxb = 0.0;
		double pxc = 0.0;
		double pxd = 0.0;
		double pxe = 0.0;
		double pxe2 = 0.0;
		int pxx = 0;
		getPX(keyy, iFlexKey, _raceInfo[_Idx].Furlong, pxn, out pxb, out pxc, out pxa, out pxd, out pxe, out pxe2, out pxx, strRating);
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[3] = getFX4(pxa, pxb, pxc);
		pxa = ((pxa > 0.0) ? (pxa / (double)num6) : 0.0);
		pxb = ((pxb > 0.0) ? (pxb / (double)num6) : 0.0);
		pxc = ((pxc > 0.0) ? (pxc / (double)num6) : 0.0);
		pxd = ((pxd > 0.0) ? (pxd / (double)num6) : 0.0);
		pxe = ((pxa > 0.0) ? (pxe / (double)num6) : 0.0);
		pxe2 = ((pxb > 0.0) ? (pxe2 / (double)pxx) : 0.0);
		pxe2 = (0.4 * pxe + 1.6 * pxe2) / 2.0;
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = getFX5(pxa, pxb, pxc, pxd, pxe, pxe2);
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] < 4.0 && (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] > 0.0 && (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] != 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] * ((Math.Pow((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4], 2.25) + 75.0) / 100.0);
		}
		double num15 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4];
		if (pxe > 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[10] = 50.0 + Math.Pow(2.0 * (pxe2 + 1.0) / (1.0 + pxe), 2.0) * 2.0;
			if (_raceInfo[_Idx].RaceHorseInfo[idx].bt[10] > 75.0)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].bt[10] = 75.0;
			}
			_raceInfo[_Idx].RaceHorseInfo[idx].bt[10] += pxe2 * 0.25;
			if (_raceInfo[_Idx].AgeSex.Contains('A') || _raceInfo[_Idx].Furlong < 8.0)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (1.65 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] + _raceInfo[_Idx].RaceHorseInfo[idx].bt[10] * 0.6) * 0.65;
			}
			else
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (1.85 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] + _raceInfo[_Idx].RaceHorseInfo[idx].bt[10] * 0.4) * 0.65;
			}
		}
		double num16 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4];
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] < 4.0 && (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] > 0.0 && (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] != 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] * ((Math.Pow((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4], 2.25) + 75.0) / 100.0);
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] > 5.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] = 5.0;
		}
		double[] bt = new double[18];
		double num17 = 6.0;
		double num18 = 6.0;
		double num19 = 6.0;
		double num20 = 0.0;
		_raceInfo[_Idx].RaceHorseInfo[idx].mm = _raceInfo[_Idx].Furlong;
		if (_raceInfo[_Idx].RaceHorseInfo[idx].mm > 10.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].mm = 10.0;
		}
		else if (_raceInfo[_Idx].RaceHorseInfo[idx].mm < 5.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].mm = 5.0;
		}
		_raceInfo[_Idx].RaceHorseInfo[idx].mm *= 0.1;
		if (_raceInfo[_Idx].Furlong < 0.8)
		{
			getBt(keyy, dtPDX, dateTime2, iFlexKey, _raceInfo[_Idx].Furlong, ref bt, less: true, strRating);
		}
		else
		{
			getBt(keyy, dtPDX, dateTime2, iFlexKey, _raceInfo[_Idx].Furlong, ref bt, less: false, strRating);
		}
		if (bt[0] < 1.0)
		{
			bt[0] = 1.0;
		}
		if (bt[1] < 1.0)
		{
			bt[1] = 1.0;
		}
		if (bt[2] < 1.0)
		{
			bt[2] = 1.0;
		}
		if (bt[3] < 1.0)
		{
			bt[3] = 1.0;
		}
		if (bt[5] < 1.0)
		{
			bt[5] = 1.0;
		}
		if (bt[6] < 1.0)
		{
			bt[6] = 1.0;
		}
		if (bt[7] < 1.0)
		{
			bt[7] = 1.0;
		}
		if (bt[8] < 1.0)
		{
			bt[8] = 1.0;
		}
		if (bt[10] < 1.0)
		{
			bt[10] = 1.0;
		}
		if (bt[11] < 1.0)
		{
			bt[11] = 1.0;
		}
		if (bt[12] < 25.0)
		{
			bt[12] = 25.0;
		}
		if (bt[13] < 25.0)
		{
			bt[13] = 25.0;
		}
		double[] array5 = new double[13];
		if (Math.Floor((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3]) == 3.0)
		{
			array5[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3] - 3.0;
		}
		else if (Math.Floor((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3]) == 2.0)
		{
			array5[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3] - 2.0;
		}
		else if (Math.Floor((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3]) == 1.0)
		{
			array5[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3] - 1.0;
		}
		else
		{
			array5[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3];
		}
		if (bt[4] > 0.0)
		{
			array5[1] = bt[0] * (3.0 - _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[4] * 20.0;
			array5[2] = bt[1] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[4] * 20.0;
			array5[3] = bt[2] * (3.0 - _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[4] * 20.0;
			array5[4] = bt[3] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[4] * 20.0;
			array5[9] = bt[10] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[4] * 20.0;
			array5[10] = bt[11] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[4] * 20.0;
		}
		if (bt[9] > 0.0)
		{
			array5[5] = bt[5] * (3.0 - _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[9] * 20.0;
			array5[6] = bt[6] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[9] * 20.0;
			array5[7] = bt[7] * (3.0 - _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[9] * 20.0;
			array5[8] = bt[8] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[9] * 20.0;
			array5[11] = bt[12] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[9] * 20.0;
			array5[12] = bt[13] * (2.0 + _raceInfo[_Idx].RaceHorseInfo[idx].mm) / bt[9] * 20.0;
		}
		for (int j = 1; j <= 12; j++)
		{
			array5[j] = Math.Pow(array5[j] + 6.6, 1.25) * 0.5 - 15.0;
		}
		array5[0] = (array5[0] + 0.25) * 20.0;
		array5[0] = Math.Pow(array5[0] + 16.0, 1.25) * 0.25;
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] * 0.0025;
		num15 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4];
		for (int j = 1; j <= 12; j++)
		{
			if (array5[j] < 0.0)
			{
				array5[j] = 0.0;
			}
		}
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = getFX5(_raceInfo[_Idx].RacingType, _raceInfo[_Idx].AgeSex, (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4], array5) * 1.175;
		double px = 0.0;
		double num21 = -1.0;
		if (_raceInfo[_Idx].Furlong <= 6.0)
		{
			num14 = 3.5;
			pxn = 0.5;
		}
		else if (_raceInfo[_Idx].Furlong > 6.0 && _raceInfo[_Idx].Furlong < 8.0)
		{
			num14 = 4.675;
			pxn = 0.675;
		}
		else if (_raceInfo[_Idx].Furlong >= 8.0 && _raceInfo[_Idx].Furlong <= 9.0)
		{
			num14 = 5.75;
			pxn = 0.75;
		}
		else if (_raceInfo[_Idx].Furlong > 9.0 && _raceInfo[_Idx].Furlong <= 10.0)
		{
			num14 = 6.5;
			pxn = 1.0;
		}
		else if (_raceInfo[_Idx].Furlong > 10.0)
		{
			num14 = 7.0;
			pxn = 1.5;
		}
		IEnumerable<DataRow> source4 = from query in key[3].AsEnumerable()
			where query.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select query;
		double num22 = 0.0;
		double mind2 = 0.0;
		double num23 = 0.0;
		num22 = (from para in source4
			where para.Field<double>("PaceLineDistance") >= _raceInfo[_Idx].Furlong - (px + 1.0) && para.Field<double>("PaceLineDistance") <= _raceInfo[_Idx].Furlong + (px + 1.0)
			select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).DefaultIfEmpty().Max();
		mind2 = (from para in source4
			where para.Field<double>("PaceLineDistance") >= _raceInfo[_Idx].Furlong - (px + 1.0) && para.Field<double>("PaceLineDistance") <= _raceInfo[_Idx].Furlong + (px + 1.0)
			select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).DefaultIfEmpty().Min();
		num23 = num22 * Math.Pow(14.0 - 2.0 * px, 3.75);
		double num24 = 1.0 * Math.Pow(14.0 - 2.0 * px, 3.75);
		double num25 = 0.0;
		double num26 = 0.0;
		double num27 = 0.0;
		double num28 = 0.0;
		do
		{
			num23 = (from para in source4
				where para.Field<double>("PaceLineDistance") >= _raceInfo[_Idx].Furlong - px * pxn && para.Field<double>("PaceLineDistance") <= _raceInfo[_Idx].Furlong + px * pxn
				select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).Sum();
			num24 = source4.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= _raceInfo[_Idx].Furlong - px * pxn && para.Field<double>("PaceLineDistance") <= _raceInfo[_Idx].Furlong + px * pxn).Count();
			var source5 = from query in source4.AsQueryable()
				where query.Field<double>("PaceLineDistance") >= _raceInfo[_Idx].Furlong - px * pxn * 1.5 && query.Field<double>("PaceLineDistance") <= _raceInfo[_Idx].Furlong + px * pxn * 1.5
				select new
				{
					d2 = query.Field<double>(strRating) - ((_raceInfo[_Idx].Furlong - query.Field<double>("PaceLineDistance")) * 0.5 - Math.Pow(px, 1.5))
				};
			if (source5.Count() > 0)
			{
				if (num22 == 0.0)
				{
					num22 = source5.Select(para => para.d2).Max();
				}
				if (mind2 == 0.0)
				{
					mind2 = source5.Select(para => para.d2).Min();
				}
			}
			if (px > num14)
			{
				break;
			}
			var source6 = from query in key[2].AsQueryable()
				where query.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate && query.Field<double>("PaceLineDistance") >= _raceInfo[_Idx].Furlong - px * pxn * 1.5 && query.Field<double>("PaceLineDistance") <= _raceInfo[_Idx].Furlong + px * pxn * 1.5
				select new
				{
					d2 = query.Field<double>(strRating) - (_raceInfo[_Idx].Furlong - query.Field<double>("PaceLineDistance")) * 0.5 - Math.Pow(px, 1.5)
				};
			if (source6.Count() > 0)
			{
				if (num22 == 0.0)
				{
					num22 = source6.Select(para => para.d2).Max();
				}
				if (mind2 == 0.0)
				{
					mind2 = source6.Select(para => para.d2).Min();
				}
			}
			if (px > pxn)
			{
				num27 += num23 * Math.Pow(12.0 - 2.0 * px, 3.5);
				num28 += num24 * Math.Pow(12.0 - 2.0 * px, 3.5);
			}
			else
			{
				num27 += num23 * Math.Pow(14.0 - 2.0 * px, 3.75);
				num28 += num24 * Math.Pow(14.0 - 2.0 * px, 3.75);
			}
			if (num27 == 0.0)
			{
				num21 += 1.1;
			}
			num25 = num27 / 99999999999.0;
			num26 = num28 / 99999999999.0;
			px += pxn;
		}
		while (px < num14);
		num9 = (from para in key[0]
			where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate && para.Field<double>(strRating) > mind2
			select para.Field<double>(strRating) - (_raceInfo[_Idx].Furlong - para.Field<double>("PaceLineDistance")) * 0.5 - (para.Field<double>("PaceLineDistance") * 0.5 - 4.0) + para.Field<double>("FinalBeatenLengths") * (1.0 - 0.03 * para.Field<double>("FinalBeatenLengths")) - para.Field<double>("SecondCallBeatenLengths") * (0.95 + 0.02 * para.Field<double>("SecondCallBeatenLengths"))).DefaultIfEmpty().Average();
		if (num9 == 0.0)
		{
			num9 = (from para in key[0]
				where para.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate && para.Field<double>(strRating) >= mind2
				select para.Field<double>(strRating) - (_raceInfo[_Idx].Furlong - para.Field<double>("PaceLineDistance")) * 0.5 - (para.Field<double>("PaceLineDistance") * 0.5 - 4.0) + para.Field<double>("FinalBeatenLengths") * (1.0 - 0.03 * para.Field<double>("FinalBeatenLengths")) - para.Field<double>("SecondCallBeatenLengths") * (0.95 + 0.02 * para.Field<double>("SecondCallBeatenLengths"))).DefaultIfEmpty().Average();
		}
		px = 1.0;
		if (_raceInfo[_Idx].Furlong >= 88.0)
		{
			if (bt[0] > 0.0 && bt[5] < _def.MaxDate2)
			{
				num25 += bt[0] * 27.0;
				num26 += 4.0;
			}
			else
			{
				num25 += num7 * 4.0;
				num26 += 4.0;
			}
		}
		for (int j = 1; j < 12; j++)
		{
			if (j >= 6)
			{
				j = 11;
			}
			if (_raceInfo[_Idx].Furlong >= 8.0 && _raceInfo[_Idx].RaceHorseInfo[idx].bt[j - 1] > 0.0)
			{
				num25 += _raceInfo[_Idx].RaceHorseInfo[idx].bt[j - 1] * Math.Pow(7 - j, Convert.ToDouble(7 - j));
				num26 += 1.0 * Math.Pow(7 - j, Convert.ToDouble(7 - j));
			}
		}
		double num29 = (from para in key[3]
			where para.Field<DateTime>("PaceLineDt") == (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9]
			select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).Sum();
		double num30 = key[3].Where((DataRow para) => para.Field<DateTime>("PaceLineDt") == (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9]).Count();
		if (num29 > 0.0)
		{
			num25 += num29 * 11.313708498984752;
			num26 += num30 * 11.313708498984752;
		}
		px = 0.0;
		int i;
		for (i = 0; i < 7; i++)
		{
			num29 = (from para in key[3]
				where para.Field<DateTime>("PaceLineDt") <= _trackInfo.RaceDate.AddDays(0.0 - _def.MaxDate2 * (double)i) && para.Field<DateTime>("PaceLineDt") > _trackInfo.RaceDate.AddDays(0.0 - _def.MaxDate2 * (double)(i + 1))
				select beyerFlex(para.Field<double>(strRating), para.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, iFlexKey)).Sum();
			num30 = key[3].Where((DataRow para) => para.Field<DateTime>("PaceLineDt") <= _trackInfo.RaceDate.AddDays(0.0 - _def.MaxDate2 * (double)i) && para.Field<DateTime>("PaceLineDt") > _trackInfo.RaceDate.AddDays(0.0 - _def.MaxDate2 * (double)(i + 1))).Count();
			num25 += num29 * Math.Pow(15.0 - 2.0 * (double)i, 3.75);
			num26 += num30 * Math.Pow(15.0 - 2.0 * (double)i, 3.75);
		}
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = 0.0;
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = 0.0;
		double num31 = 0.0;
		double num32 = 0.0;
		if (num28 > 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = num27 / num28;
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = num25 / num26;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] > 0.0 && (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] == 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * 0.7;
		}
		else if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] > 0.0 && (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] == 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.7;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] < (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.7)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.7;
		}
		else if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] < (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * 0.7)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * 0.7;
		}
		num31 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0];
		num32 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1];
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] < 10.0 || (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] < 10.0 || num4 == 1.0 || (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] == 1.0)
		{
			array4[0] = 0.0;
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[6] = 0.0;
		}
		if (array4[0] > 100.0)
		{
			array4[0] = 0.0;
		}
		num4 = (num31 + num32) / 3.0;
		if (array4[0] == -99.0)
		{
			array4[7] = 0.0;
		}
		else if (array4[7] > 0.0)
		{
			array4[7] = array4[0] - num8 / 4.0;
		}
		else
		{
			array4[7] = array4[0] + num8 / 4.0;
		}
		_raceInfo[_Idx].RaceHorseInfo[idx].bt[10] *= 0.1;
		double num33 = 0.0;
		double num34 = 0.5;
		double num35 = 0.5;
		double num36 = 0.0;
		num33 = ((!_raceInfo[_Idx].RacingType.Contains("M") && !_raceInfo[_Idx].RacingType.Contains("S")) ? (num33 + 1.0) : (num33 + 2.5));
		if (array5[1] > num4)
		{
			num33 += num34;
		}
		if (array5[3] > num4)
		{
			num33 += num34;
		}
		if (array5[5] > num4)
		{
			num33 += num35;
		}
		if (array5[7] > num4)
		{
			num33 += num35;
		}
		if (array5[2] > num4)
		{
			num33 += num34;
		}
		if (array5[4] > num4)
		{
			num33 += num34;
		}
		if (array5[6] > num4)
		{
			num33 += num35;
		}
		if (array5[8] > num4)
		{
			num33 += num35;
		}
		if (array5[9] > num4 && (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] < 75.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays < 75.0) && (array5[2] > 0.0 || array5[4] > 0.0))
		{
			num33 += num34;
		}
		else if (array5[9] > num4 && (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] < 90.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays < 90.0) && (array5[1] > 0.0 || array5[3] > 0.0))
		{
			num33 += num35;
		}
		if (array5[10] > num4 && (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] < 75.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays < 75.0) && (array5[2] > 0.0 || array5[4] > 0.0))
		{
			num33 += num34;
		}
		else if (array5[10] > num4 && (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] < 90.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays < 90.0) && (array5[1] > 0.0 || array5[3] > 0.0))
		{
			num33 += num35;
		}
		if (array5[11] > num4)
		{
			num33 += num34;
		}
		if (array5[12] > num4)
		{
			num33 += num34;
		}
		if (array5[0] > 20.0)
		{
			num33 += num34;
		}
		if (_raceInfo[_Idx].RaceHorseInfo[idx].bt[10] >= 7.5)
		{
			num33 += num36;
		}
		if (_raceInfo[_Idx].RacingType.Contains("A"))
		{
			if (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] < 60.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays < 60.0)
			{
				num33 += num36;
			}
		}
		else if (_raceInfo[_Idx].Furlong < 8.0)
		{
			if (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] < 31.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays < 31.0)
			{
				num33 += num36;
			}
		}
		else if (_raceInfo[_Idx].RaceHorseInfo[idx].bt[5] < 46.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays < 46.0)
		{
			num33 += num36;
		}
		if (array4[1] > 0.0 || array4[2] > 0.0)
		{
			num33 += num36;
		}
		if (array4[3] > 0.0 || array4[4] > 0.0 || array4[5] > 0.0)
		{
			num33 += num36;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] >= array3[11])
		{
			num33 += num35;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] >= array3[11])
		{
			num33 += num35;
		}
		if (num33 > 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] * 0.85 + Math.Pow(num33, 1.2) * 1.25;
		}
		array4[6] = array4[7];
		if (_raceInfo[_Idx].Furlong < 8.0)
		{
			if (_raceInfo[_Idx].RacingType.Contains("M") || _raceInfo[_Idx].RacingType.Contains("S"))
			{
				if (num33 > 7.0)
				{
					array4[7] = Math.Abs(array4[0]) + num33 * 0.3;
				}
				else if (num33 < 6.0)
				{
					array4[7] = 0.0 - Math.Abs(array4[0]) + num33 * 0.1;
				}
			}
			else if (_raceInfo[_Idx].RacingType.Contains("C"))
			{
				if (num33 >= 7.5)
				{
					array4[7] = Math.Abs(array4[0]) + num33 * 0.25;
				}
				else if (num33 < 5.5)
				{
					array4[7] = 0.0 - Math.Abs(array4[0]) + num33 * 0.1;
				}
			}
			else if (num33 >= 8.0)
			{
				array4[7] = Math.Abs(array4[0]) + num33 * 0.2;
			}
			else if (num33 < 6.0)
			{
				array4[7] = 0.0 - Math.Abs(array4[0]) + num33 * 0.1;
			}
		}
		else if (_raceInfo[_Idx].RacingType.Contains("M") || _raceInfo[_Idx].RacingType.Contains("S"))
		{
			if (num33 > 7.0)
			{
				array4[7] = Math.Abs(array4[0]) + num33 * 0.3;
			}
			else if (num33 < 6.0)
			{
				array4[7] = 0.0 - Math.Abs(array4[0]) + num33 * 0.1;
			}
		}
		else if (_raceInfo[_Idx].RacingType.Contains("C"))
		{
			if (num33 >= 7.5)
			{
				array4[7] = Math.Abs(array4[0]) + num33 * 0.25;
			}
			else if (num33 < 5.5)
			{
				array4[7] = 0.0 - Math.Abs(array4[0]) + num33 * 0.1;
			}
		}
		else if (num33 >= 7.5)
		{
			array4[7] = Math.Abs(array4[0]) + num33 * 0.2;
		}
		else if (num33 < 5.5)
		{
			array4[7] = 0.0 - Math.Abs(array4[0]) + num33 * 0.1;
		}
		double num37 = 0.0;
		num37 = ((!(_raceInfo[_Idx].Furlong < 8.0)) ? 1.9 : (1.8 + 0.007 * _raceInfo[_Idx].Furlong));
		if (num33 > 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] * 0.85 + Math.Pow(num33, num37) * 1.5;
		}
		array4[6] = array4[7];
		if (array4[7] > 25.0)
		{
			array4[7] = 25.0;
			if (array4[7] > 3.0 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6])
			{
				array4[7] = 3.0 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6];
			}
		}
		if (array4[7] < -20.0)
		{
			array4[7] = -20.0;
			if (array4[7] < -2.5 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6])
			{
				array4[7] = -2.5 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6];
			}
		}
		if (_raceInfo[_Idx].RacingType.Contains("M") || _raceInfo[_Idx].RacingType.Contains("S"))
		{
			array4[7] = array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.75;
			array4[0] = array4[7];
		}
		else
		{
			array4[7] *= 0.75;
			array4[0] = array4[7];
		}
		double num38 = 0.0;
		double num39 = 0.0;
		double num40 = 0.0;
		if (array3[19] > 0.0)
		{
			num38 += array3[19];
			num39 += 1.0;
			if (array3[19] / 10.0 < _raceInfo[_Idx].Furlong)
			{
				num40 += 1.0;
			}
		}
		if (array3[18] > 0.0)
		{
			num38 += array3[18];
			num39 += 1.0;
			if (array3[18] / 10.0 < _raceInfo[_Idx].Furlong)
			{
				num40 += 1.0;
			}
		}
		if (array3[17] > 0.0)
		{
			num38 += array3[17];
			num39 += 1.0;
			if (array3[17] / 10.0 < _raceInfo[_Idx].Furlong)
			{
				num40 += 1.0;
			}
		}
		if (array3[16] > 0.0)
		{
			num38 += array3[16];
			num39 += 1.0;
			if (array3[16] / 10.0 < _raceInfo[_Idx].Furlong)
			{
				num40 += 1.0;
			}
		}
		if (array3[15] > 0.0)
		{
			num38 += array3[15];
			num39 += 1.0;
			if (array3[15] / 10.0 < _raceInfo[_Idx].Furlong)
			{
				num40 += 1.0;
			}
		}
		if (_raceInfo[_Idx].RacingType.Contains("M") || _raceInfo[_Idx].RacingType.Contains("S"))
		{
			if (_raceInfo[_Idx].Furlong < 8.0)
			{
				if (array3[20] / (num39 * 10.0) < _raceInfo[_Idx].Furlong && num39 > 0.0)
				{
					array4[0] -= _raceInfo[_Idx].Furlong - (0.0 - (2.0 + 0.02 * num33) + num38 / (num39 * 8.0));
				}
			}
			else if (num39 == num40 && num39 > 0.0)
			{
				array4[0] -= 2.0 + 0.02 * num33 + Math.Pow(num40, 2.1) / Math.Pow(num39, 1.45);
			}
		}
		else if (_raceInfo[_Idx].Furlong < 8.0)
		{
			if (array3[20] / (num39 * 10.0) < _raceInfo[_Idx].Furlong && num39 > 0.0)
			{
				array4[0] -= _raceInfo[_Idx].Furlong - (0.0 - (3.0 + 0.03 * num33) + num38 / (num39 * 8.0));
			}
		}
		else if (num39 == num40 && num39 > 0.0)
		{
			array4[0] -= 3.0 + 0.03 * num33 + Math.Pow(num40, 2.1) / Math.Pow(num39, 1.45);
		}
		if (_raceInfo[_Idx].RacingType.Contains("M") || _raceInfo[_Idx].RacingType.Contains("S"))
		{
			array4[7] -= (20.0 - num33) * 0.15;
		}
		else
		{
			array4[7] = (_raceInfo[_Idx].RacingType.Contains("C") ? (array4[7] - (23.0 - num33) * 0.25) : (array4[7] - (27.0 - num33) * 0.22));
		}
		array4[0] = array4[7];
		if (array4[7] > 0.0)
		{
			array4[7] = Math.Pow(array4[7], 1.45);
		}
		else if (array4[7] < 0.0)
		{
			array4[7] = 0.0 - Math.Pow(Math.Abs(array4[7]), 1.45);
		}
		if (_raceInfo[_Idx].RacingType.Contains("M") || _raceInfo[_Idx].RacingType.Contains("S"))
		{
			array4[7] *= _raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.2;
		}
		else if (_raceInfo[_Idx].RacingType.Contains("C"))
		{
			array4[7] *= _raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.7;
		}
		else
		{
			array4[7] *= _raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.6;
		}
		if (array4[7] > 25.0)
		{
			array4[7] = 25.0;
			if (array4[7] > 3.0 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6])
			{
				array4[7] = 3.0 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6];
			}
		}
		else if (array4[7] < -20.0)
		{
			array4[7] = -20.0;
			if (array4[7] > -2.5 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6])
			{
				array4[7] = -2.5 * (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[6];
			}
		}
		array4[0] = array4[7];
		if (array3[11] == 0.0)
		{
			array3[11] = ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] == 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = array3[11];
		}
		if (num22 == 0.0)
		{
			num22 = array3[11];
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] == 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = array3[11];
		}
		num31 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0];
		num32 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1];
		if (num22 < array3[11])
		{
			num22 = array3[11];
		}
		if (mind2 < array3[11] * 0.95)
		{
			mind2 = array3[11] * 0.95;
		}
		array3[10] = array3[10] * 0.75 + array3[11] * 0.25;
		if (_raceInfo[_Idx].RacingType.Contains("M"))
		{
			array4[7] *= _raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.35;
			if (array3[12] > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1])
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = array3[11] * 0.8 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.2 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.35);
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = array3[11] * 0.2 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.8 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.35);
				array3[0] = array3[11] * 0.7 + array3[0] * 0.3 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.35);
			}
			else
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * 0.6 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.2 + num22 * 0.2 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.5);
				array3[0] = array3[0] * 0.9 + array3[11] * 0.1 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.35);
			}
		}
		else if (_raceInfo[_Idx].RacingType.Contains("S"))
		{
			array4[7] *= _raceInfo[_Idx].RaceHorseInfo[idx].mm * 1.25;
			if (array3[12] > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1])
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = array3[11] * 0.8 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.2 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.5);
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = array3[11] * 0.2 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.8 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.5);
				array3[0] = array3[11] * 0.7 + array3[0] * 0.3 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.5);
			}
			else
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * 0.6 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.2 + num22 * 0.2 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.5);
				array3[0] = array3[0] * 0.9 + array3[11] * 0.1 + array4[7] * (_raceInfo[_Idx].RaceHorseInfo[idx].mm * 0.5);
			}
		}
		else if (_raceInfo[_Idx].RacingType.Contains("C"))
		{
			array4[7] *= _raceInfo[_Idx].RaceHorseInfo[idx].mm * 1.15;
			if (array3[12] > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1])
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = array3[11] + array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
				array3[0] = array3[11] * 0.7 + array3[0] * 0.3 + array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
			}
			else
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * 0.6 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.2 + num22 * 0.1 + array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
				array3[0] = array3[0] * 0.9 + array3[11] * 0.1 + array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
			}
		}
		else if (array3[12] > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1])
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] = array3[11] + array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
			array3[0] = array3[11] * 0.7 + array3[0] * 0.3 + (array4[7] + _raceInfo[_Idx].RaceHorseInfo[idx].mm);
		}
		else
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * 0.7 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * 0.1 + num22 * 0.2 + array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
			array3[0] = array3[0] * 0.9 + array3[11] * 0.1 + array4[7] * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
		}
		num31 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0];
		num32 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1];
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] > 0.0 && _raceInfo[_Idx].Furlong < 88.0)
		{
			if (_raceInfo[_Idx].RacingType.Contains("A") || _raceInfo[_Idx].RacingType.Contains("N") || _raceInfo[_Idx].RacingType.Contains("T") || _raceInfo[_Idx].RacingType.Contains("G"))
			{
				if (_raceInfo[_Idx].AgeSex.Contains("A"))
				{
					array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 0.99 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 1.06) * 7.1 + (3.9 * array3[0] + array4[7] - num13 * 0.45)) / 11.0;
				}
				else
				{
					array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.15 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.9) * 7.1 + (3.9 * array3[0] + array4[7] - num13 * 0.55)) / 11.0;
				}
			}
			else if (_raceInfo[_Idx].RacingType.Contains("C"))
			{
				if (_raceInfo[_Idx].Furlong < 8.0)
				{
					array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.25 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.8) * 7.0 + (4.0 * array3[0] + array4[7] - num13 * 0.35)) / 11.0;
				}
				else
				{
					array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.15 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.9) * 7.0 + (4.0 * array3[0] + array4[7] - num13 * 0.35)) / 11.0;
				}
			}
			else if (_raceInfo[_Idx].RacingType.Contains("M") || _raceInfo[_Idx].RacingType.Contains("S"))
			{
				array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.45 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.6) * 6.9 + 4.1 * (array3[0] + array4[7] - num13 * 0.55)) / 11.0;
			}
			else if (_raceInfo[_Idx].Furlong < 6.0)
			{
				array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.35 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.7) * 7.0 + 4.0 * (array3[0] + array4[7] - num13 * 0.35)) / 11.0;
			}
			else if (_raceInfo[_Idx].Furlong > 6.0 && _raceInfo[_Idx].Furlong < 8.0)
			{
				array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.3 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.75) * 7.1 + 3.9 * (array3[0] + array4[7] - num13 * 0.5)) / 11.0;
			}
			else if (_raceInfo[_Idx].Furlong >= 8.0)
			{
				array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.2 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.85) * 7.0 + 4.0 * (array3[0] + array4[7] - num13 * 0.45)) / 11.0;
			}
			else
			{
				array3[9] = (((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] * _def.BeyerDistance * 1.15 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] * _def.BeyerPerformance * 0.9) * 7.1 + 3.9 * (array3[0] + array4[7] - num13 * 0.45)) / 11.0;
			}
		}
		if (array3[9] >= num22 * 1.35 && num22 > 0.0)
		{
			array3[9] = num22 * 1.35;
		}
		if (array3[9] <= mind2 * 0.95 && num22 > 0.0)
		{
			array3[9] = mind2 * 0.95;
		}
		double num41 = array3[9];
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = array3[9] * 4.75;
		double num42 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] * 0.21;
		array3[9] = num41;
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[12] = _raceInfo[_Idx].RaceHorseInfo[idx].bt[0];
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = array3[9];
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[5] = array4[0];
		double num43 = 0.0;
		double num44 = 0.0;
		double num45 = 0.0;
		double num46 = 0.0;
		double num47 = 0.0;
		double num48 = 0.0;
		double num49 = 0.0;
		double num50 = 0.0;
		num43 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[3];
		num44 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[12];
		num45 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9];
		num46 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11];
		if (_raceInfo[_Idx].Furlong < 8.0)
		{
			if (array4[7] < -5.0)
			{
				array4[2] = -2.0;
			}
			else
			{
				array4[2] = ((array4[7] == 0.0) ? 0.0 : 2.0);
			}
		}
		else if (array4[7] < -5.0 || array4[7] > 5.0)
		{
			array4[2] = -2.0;
		}
		else
		{
			array4[2] = ((array4[7] == 0.0) ? 0.0 : 2.0);
		}
		if (num46 > 0.0)
		{
			num47 = num43;
			num50 = ((!(_raceInfo[_Idx].Furlong < 8.0)) ? ((num44 + array4[2]) / num45) : ((num44 + array4[7]) / num45));
			if (num50 > 1.25)
			{
				num50 = 1.25;
			}
			if (num50 < 0.75 && num50 > 0.0)
			{
				num50 = 0.75;
			}
			if (num50 > 0.0)
			{
				num50 = Math.Pow(num50, 1.1);
			}
			num47 = ((!(num50 < 1.0) || !(num43 >= 2.0)) ? num43 : (num43 / num43));
			num48 = ((!(_raceInfo[_Idx].Furlong < 8.0)) ? (num50 * 2.0 + 0.945 * num44 + num44 * ((6.0 + _raceInfo[_Idx].Furlong) / 5.0 * 0.05)) : (num50 * 5.0 + 0.935 * num44 + num44 * ((14.0 - _raceInfo[_Idx].Furlong) / 5.0 * 0.05)));
			if (_raceInfo[_Idx].Furlong < 8.0)
			{
				num48 += array4[7] * 0.3;
				if (num48 < (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + array4[7] * 0.3)
				{
					num48 *= 1.05;
				}
				if (num48 > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7] * 0.3)
				{
					num48 *= 0.98;
				}
			}
			num48 = ((!(num48 <= 0.0)) ? Math.Pow(num48, 0.965) : (num48 * 0.333));
			num49 = ((!(_raceInfo[_Idx].Furlong < 8.0)) ? (0.35 * ((num45 - (num44 + array4[2])) / 1.25 * num47 * ((_raceInfo[_Idx].Furlong - 5.0) / 2.5))) : (0.35 * ((num45 - (num44 + array4[2])) / 1.25 * num47 * ((_raceInfo[_Idx].Furlong + 3.0) / 2.5))));
			if (num49 > 0.0)
			{
				num49 = Math.Pow(num49, 1.15);
			}
			else if (num49 != 0.0)
			{
				num49 = 0.0 - Math.Pow(Math.Abs(num49), 0.8);
			}
			if (num49 > 7.0)
			{
				num49 = 7.0;
			}
			if (num49 < -7.0)
			{
				num49 = -7.0;
			}
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[8] == 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[8] = num45;
		}
		if (_raceInfo[_Idx].Furlong < 8.0)
		{
			if (_raceInfo[_Idx].Furlong <= 6.0)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = num45 * 0.835 + (num48 + 0.05 * num49) * 0.025 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[8] * 0.14;
			}
			else
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = num45 * 0.865 + (num48 + 0.05 * num49) * 0.025 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[8] * 0.11;
			}
		}
		else
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = num45 * 0.895 + (num48 + 0.05 * num49) * 0.025 + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[8] * 0.08;
		}
		_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 4.75;
		double num51 = 0.0;
		switch (Convert.ToInt16(Math.Floor(num43)))
		{
		case 3:
			num51 = num43 - 3.0;
			break;
		case 2:
			num51 = num43 - 2.0;
			break;
		case 1:
			num51 = num43 - 1.0;
			break;
		default:
			num51 = num43;
			break;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] < 10.0 || _raceInfo[_Idx].RaceHorseInfo[idx].Scratch)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = 0.0;
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = 0.0;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] > 0.0 && (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11] < 4.0)
		{
			num33 *= (Math.Pow((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[11], 2.0) + 87.0) / 100.0;
		}
		if (_raceInfo[_Idx].RaceHorseInfo[idx].fx[4].GetType() == Type.GetType("System.DateTime"))
		{
			if ((_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays > _def.MaxDate2)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] * 0.985;
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] * 0.985;
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 0.985;
				num33 *= 0.985;
			}
			if ((_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays > _def.MaxDate2 * 6.0)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] * 0.965;
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] * 0.965;
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 0.965;
				num33 *= 0.965;
			}
		}
		if (_raceInfo[_Idx].Furlong < 8.0)
		{
			if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] < ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 0.825)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 0.825;
			}
			if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] > ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 1.35)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 1.35;
			}
		}
		else
		{
			if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] < ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 0.875)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 0.875;
			}
			if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] > ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 1.35)
			{
				_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] = ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[0] + (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[1] + array4[7]) / 2.0 * 1.35;
			}
		}
		if (_raceInfo[_Idx].Furlong < 8.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 5.65 + num33 * 2.0 * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 1.1 + Math.Pow(num33 + 1.0, 2.0);
		}
		else if (_raceInfo[_Idx].SurfaceCondition.Contains("turf"))
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 5.65 + num33 * 2.0 * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 1.15 + Math.Pow(num33 + 1.0, 1.5);
		}
		else
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[2] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 5.65 + num33 * 2.0 * _raceInfo[_Idx].RaceHorseInfo[idx].mm;
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 1.1 + Math.Pow(num33 + 1.0, 2.0);
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] > 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[19] = num33;
		}
		else
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[19] = 0.0;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] > (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 2.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[9] * 2.0;
		}
		if ((double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] <= 0.0)
		{
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[4] = 0.0;
			_raceInfo[_Idx].RaceHorseInfo[idx].fx[19] = 0.0;
		}
		num33 = (double)_raceInfo[_Idx].RaceHorseInfo[idx].fx[19];
		double[] array6 = new double[5];
		array6[2] = key[3].Select((DataRow para) => 5.0 - para.Field<double>("SecondCallBeatenLengths")).DefaultIfEmpty().Average();
		array6[1] = key[3].Select((DataRow para) => 6.0 - para.Field<double>("StretchCallBeatenLengths")).DefaultIfEmpty().Average();
		array6[3] = key[3].Select((DataRow para) => 7.0 - para.Field<double>("FinalBeatenLengths")).DefaultIfEmpty().Average();
		for (int j = 1; j <= 3; j++)
		{
			if (array6[j] < 1.0)
			{
				array6[j] = 1.0;
			}
		}
		array6[0] = array6[1] * array6[2] * array6[3];
		if (array6[0] > 0.0)
		{
			array6[0] = Math.Pow(array6[0], 1.5);
		}
		if (array6[0] < 0.0)
		{
			array6[0] = 0.0 - Math.Pow(Math.Abs(array6[0]), 1.5);
		}
		array6[0] = num33 * 0.0015 + array6[0] * 0.05;
		if (_raceInfo[_Idx].RaceHorseInfo[idx].fx[10].GetType() == Type.GetType("System.DateTime") && (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[idx].fx[10]).TotalDays > _def.MaxDate2)
		{
			array6[0] *= 0.975;
		}
		_raceInfo[_Idx].RaceHorseInfo[idx].bt[10] = array6[0] * 0.25;
		key = null;
	}

	private OleDbType getDataType(string type)
	{
		return type switch
		{
			"VarChar" => OleDbType.VarChar, 
			"Integer" => OleDbType.Integer, 
			"Date" => OleDbType.Date, 
			_ => OleDbType.Double, 
		};
	}

	private double calcBettingLine(double line1, double line2)
	{
		try
		{
			if (line1 / line2 < 3.0)
			{
				return 35.0;
			}
			if (line1 / line2 >= 3.0 && line1 / line2 < 6.0)
			{
				return 25.0;
			}
			if (line1 / line2 >= 6.0 && line1 / line2 < 10.0)
			{
				return 20.0;
			}
			if (line1 / line2 >= 10.0 && line1 / line2 < 16.0)
			{
				return 10.0;
			}
			return 5.0;
		}
		catch
		{
			return 0.0;
		}
	}

	private double[] timePlacement(string condition, double stretchTime, double finalTime, double furlong)
	{
		double[] array = new double[6];
		if (stretchTime != 0.0 && finalTime != 0.0)
		{
			EnumerableRowCollection<DataRow> source = from query in _dataSet.Tables["stat"].AsEnumerable()
				where query.Field<double>("pacelinedistance") == furlong && query.Field<string>("condition").ToLower() == condition.ToLower()
				select query;
			if (source.Count() == 1)
			{
				array[0] = source.First().Field<double>("MinStretch");
				array[1] = source.First().Field<double>("MaxStretch");
				array[2] = 1.0 - (stretchTime - source.First().Field<double>("MinStretch")) / (source.First().Field<double>("MaxStretch") - source.First().Field<double>("MinStretch"));
				array[3] = source.First().Field<double>("MinFinal");
				array[4] = source.First().Field<double>("MaxFinal");
				array[5] = 1.0 - (finalTime - source.First().Field<double>("MinFinal")) / (source.First().Field<double>("MaxFinal") - source.First().Field<double>("MinFinal"));
			}
			else
			{
				string text = ((condition.ToLower() == "turf") ? "dirt" : "turf");
				EnumerableRowCollection<DataRow> source2 = from query in _dataSet.Tables["stat"].AsEnumerable()
					where query.Field<double>("pacelinedistance") == furlong && query.Field<string>("condition") == condition
					select query;
				if (source2.Count() == 1)
				{
					array[0] = source2.First().Field<double>("MinStretch");
					array[1] = source2.First().Field<double>("MaxStretch");
					array[2] = 1.0 - (stretchTime - source2.First().Field<double>("MinStretch")) / (source2.First().Field<double>("MaxStretch") - source2.First().Field<double>("MinStretch"));
					array[3] = source2.First().Field<double>("MinFinal");
					array[4] = source2.First().Field<double>("MaxFinal");
					array[5] = 1.0 - (finalTime - source2.First().Field<double>("MinFinal")) / (source2.First().Field<double>("MaxFinal") - source2.First().Field<double>("MinFinal"));
				}
			}
		}
		return array;
	}

	private void insertIntoRaceComp()
	{
		string cmdText = "INSERT INTO kelso.comp(id, calc, surface, rtype, agesex, claim, track, racedt, race, length, horse, pp, ppx, line1, line2, avebeyer, minbeyer, maxbeyer, sdv, mike, btrend, avespeed, tp1, tp2, tp3, tp4, tp5, tp6, tp7, tp8, tp9, tp10, tp11, tp12, tp13, tp14, tp15, tp16, tp17, tp18, tp19, tp20, tp21, tp22, jockey, layoff, speed, spts, sc, efx, points, al, worscore, totalwor, numofgoodwor, compositescore, claimpricetrend, bettingline, closingtrend, pastperformance, jockeystats, trainerstats, firsttimer, firstcalltime, secondcalltime, stretchcalltime, stretchcallmin, stretchcallmax, stretchcallplacement, finaltime, finalmin, finalmax, finalplacement, furlongtime, horseplacement) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		_conn.Open();
		truncateTable(_conn, new string[1] { "comp" });
		using (OleDbCommand oleDbCommand = new OleDbCommand(cmdText, _conn))
		{
			IEnumerable<XElement> enumerable = from query in XDocument.Load(Application.StartupPath + "\\Parameters.xml").Root.Element("Columns").Elements("Column")
				select (query);
			foreach (XElement item in enumerable)
			{
				oleDbCommand.Parameters.Add(new OleDbParameter(item.Attribute("name").Value, getDataType(item.Attribute("type").Value)));
				oleDbCommand.Parameters[item.Attribute("name").Value].SourceColumn = item.Attribute("name").Value;
			}
			for (int i = 0; i < _raceInfo[_Idx].RaceHorseInfo.Count(); i++)
			{
				for (int j = 0; j < oleDbCommand.Parameters.Count; j++)
				{
					if (oleDbCommand.Parameters[j].DbType == DbType.Double)
					{
						oleDbCommand.Parameters[j].Value = 0.0;
					}
					else if (oleDbCommand.Parameters[j].DbType == DbType.Int32)
					{
						oleDbCommand.Parameters[j].Value = 0;
					}
					else
					{
						oleDbCommand.Parameters[j].Value = DBNull.Value;
					}
				}
				oleDbCommand.Parameters["id"].Value = Convert.ToDouble(i + 1);
				oleDbCommand.Parameters["calc"].Value = "SpeedRating";
				oleDbCommand.Parameters["surface"].Value = _raceInfo[_Idx].SurfaceCondition;
				oleDbCommand.Parameters["rtype"].Value = _raceInfo[_Idx].RacingType;
				oleDbCommand.Parameters["agesex"].Value = _raceInfo[_Idx].AgeSex;
				oleDbCommand.Parameters["claim"].Value = _raceInfo[_Idx].ClaimPrize;
				oleDbCommand.Parameters["track"].Value = _trackInfo.TrackCode;
				oleDbCommand.Parameters["racedt"].Value = _trackInfo.RaceDate;
				oleDbCommand.Parameters["race"].Value = _raceInfo[_Idx].RaceNum;
				oleDbCommand.Parameters["length"].Value = _raceInfo[_Idx].Furlong;
				oleDbCommand.Parameters["horse"].Value = _raceInfo[_Idx].RaceHorseInfo[i].HorseName;
				oleDbCommand.Parameters["pp"].Value = _raceInfo[_Idx].RaceHorseInfo[i].PolePosition;
				oleDbCommand.Parameters["ppx"].Value = (_raceInfo[_Idx].RaceHorseInfo[i].Scratch ? "S" : string.Empty);
				oleDbCommand.Parameters["worscore"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].WorkOutScore, 2);
				oleDbCommand.Parameters["totalwor"].Value = _raceInfo[_Idx].RaceHorseInfo[i].TotalWorkOut;
				oleDbCommand.Parameters["numofgoodwor"].Value = _raceInfo[_Idx].RaceHorseInfo[i].TotalGoodWorkOut;
				oleDbCommand.Parameters["pastperformance"].Value = (_raceInfo[_Idx].RaceHorseInfo[i].HasHistory ? 1 : 0);
				oleDbCommand.Parameters["jockeystats"].Value = _raceInfo[_Idx].RaceHorseInfo[i].JockeyStat;
				oleDbCommand.Parameters["trainerstats"].Value = _raceInfo[_Idx].RaceHorseInfo[i].TrainerStat;
				oleDbCommand.Parameters["firstcalltime"].Value = _raceInfo[_Idx].RaceHorseInfo[i].FirstCallTime;
				oleDbCommand.Parameters["secondcalltime"].Value = _raceInfo[_Idx].RaceHorseInfo[i].SecondCallTime;
				oleDbCommand.Parameters["stretchcalltime"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].StretchCallTime, 2);
				oleDbCommand.Parameters["finaltime"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].FinalTime, 2);
				oleDbCommand.Parameters["furlongtime"].Value = _raceInfo[_Idx].RaceHorseInfo[i].FurlongTime;
				try
				{
					string condition = (_raceInfo[_Idx].SurfaceCondition.Contains("turf") ? "Turf" : "Dirt");
					double[] array = timePlacement(condition, _raceInfo[_Idx].RaceHorseInfo[i].StretchCallTime, _raceInfo[_Idx].RaceHorseInfo[i].FinalTime, _raceInfo[_Idx].RaceHorseInfo[i].FurlongTime);
					oleDbCommand.Parameters["stretchcallmin"].Value = Math.Round(array[0], 2);
					oleDbCommand.Parameters["stretchcallmax"].Value = Math.Round(array[1], 2);
					if ((double)oleDbCommand.Parameters["stretchcallmin"].Value >= (double)oleDbCommand.Parameters["stretchcalltime"].Value && (double)oleDbCommand.Parameters["stretchcalltime"].Value != 0.0)
					{
						oleDbCommand.Parameters["stretchcallplacement"].Value = 100.0;
					}
					else if ((double)oleDbCommand.Parameters["stretchcallmax"].Value <= (double)oleDbCommand.Parameters["stretchcalltime"].Value)
					{
						oleDbCommand.Parameters["stretchcallplacement"].Value = 0.0;
					}
					else
					{
						oleDbCommand.Parameters["stretchcallplacement"].Value = Math.Round(array[2] * 100.0, 2);
					}
					oleDbCommand.Parameters["finalmin"].Value = Math.Round(array[3], 2);
					oleDbCommand.Parameters["finalmax"].Value = Math.Round(array[4], 2);
					if ((double)oleDbCommand.Parameters["finalmin"].Value >= (double)oleDbCommand.Parameters["finaltime"].Value && (double)oleDbCommand.Parameters["finaltime"].Value != 0.0)
					{
						oleDbCommand.Parameters["finalplacement"].Value = 100.0;
					}
					else if ((double)oleDbCommand.Parameters["finalmax"].Value <= (double)oleDbCommand.Parameters["finaltime"].Value)
					{
						oleDbCommand.Parameters["finalplacement"].Value = 0.0;
					}
					else
					{
						oleDbCommand.Parameters["finalplacement"].Value = Math.Round(array[5] * 100.0, 2);
					}
					oleDbCommand.Parameters["horseplacement"].Value = Math.Round(((double)oleDbCommand.Parameters["stretchcallplacement"].Value + (double)oleDbCommand.Parameters["finalplacement"].Value) / 2.0, 2);
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
					oleDbCommand.Parameters["horseplacement"].Value = 0.0;
				}
				if (!_raceInfo[_Idx].RaceHorseInfo[i].HasHistory)
				{
					oleDbCommand.Parameters["firsttimer"].Value = 1;
				}
				if (!string.IsNullOrEmpty(_raceInfo[_Idx].RaceHorseInfo[i].Line1))
				{
					oleDbCommand.Parameters["line1"].Value = double.Parse(_raceInfo[_Idx].RaceHorseInfo[i].Line1);
				}
				else
				{
					oleDbCommand.Parameters["line1"].Value = 0.0;
				}
				if (!string.IsNullOrEmpty(_raceInfo[_Idx].RaceHorseInfo[i].Line2))
				{
					oleDbCommand.Parameters["line2"].Value = double.Parse(_raceInfo[_Idx].RaceHorseInfo[i].Line2);
				}
				else
				{
					oleDbCommand.Parameters["line2"].Value = 0.0;
				}
				oleDbCommand.Parameters["bettingline"].Value = calcBettingLine((double)oleDbCommand.Parameters["line1"].Value, (double)oleDbCommand.Parameters["line2"].Value);
				oleDbCommand.Parameters["closingtrend"].Value = _raceInfo[_Idx].RaceHorseInfo[i].Closer;
				if (_raceInfo[_Idx].RaceHorseInfo[i].ClaimPriceTrend == 0.0)
				{
					oleDbCommand.Parameters["claimpricetrend"].Value = 0.0;
				}
				else if (_raceInfo[_Idx].RaceHorseInfo[i].ClaimPriceTrend < 0.0)
				{
					oleDbCommand.Parameters["claimpricetrend"].Value = 1.0;
				}
				else
				{
					oleDbCommand.Parameters["claimpricetrend"].Value = -1.0;
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[0] != null)
				{
					oleDbCommand.Parameters["avebeyer"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[0], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[7] != null)
				{
					oleDbCommand.Parameters["minbeyer"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[7], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[8] != null)
				{
					oleDbCommand.Parameters["maxbeyer"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[8], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[6] != null)
				{
					oleDbCommand.Parameters["sdv"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[6], 2);
				}
				try
				{
					if (_raceInfo[_Idx].RaceHorseInfo[i].fx[9] != null)
					{
						oleDbCommand.Parameters["mike"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[9], 2);
					}
				}
				catch (Exception ex)
				{
					string message = ex.Message;
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[5] != null)
				{
					oleDbCommand.Parameters["btrend"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[5], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[1] != null)
				{
					oleDbCommand.Parameters["avespeed"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[1], 2);
				}
				oleDbCommand.Parameters["tp1"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[0], 2);
				oleDbCommand.Parameters["tp2"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[1], 2);
				oleDbCommand.Parameters["tp3"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[2], 2);
				oleDbCommand.Parameters["tp4"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[3], 2);
				oleDbCommand.Parameters["tp5"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[4], 2);
				oleDbCommand.Parameters["tp6"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[5], 2);
				oleDbCommand.Parameters["tp7"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[6], 2);
				oleDbCommand.Parameters["tp8"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[7], 2);
				oleDbCommand.Parameters["tp9"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[8], 2);
				oleDbCommand.Parameters["tp10"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[9], 2);
				oleDbCommand.Parameters["tp11"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].bt[10], 2);
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[19] != null)
				{
					oleDbCommand.Parameters["tp12"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[19], 2);
				}
				oleDbCommand.Parameters["tp13"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Trainer1Starts);
				oleDbCommand.Parameters["tp14"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Trainer2Wins);
				oleDbCommand.Parameters["tp15"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Trainer3Places);
				oleDbCommand.Parameters["tp16"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Trainer4Shows);
				oleDbCommand.Parameters["tp17"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Jockey5Starts);
				oleDbCommand.Parameters["tp18"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Jockey6Wins);
				oleDbCommand.Parameters["tp19"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Jockey7Places);
				oleDbCommand.Parameters["tp20"].Value = Convert.ToDouble(_raceInfo[_Idx].RaceHorseInfo[i].Jockey8Shows);
				oleDbCommand.Parameters["jockey"].Value = _raceInfo[_Idx].RaceHorseInfo[i].Jockey9Name;
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[10] == null)
				{
					oleDbCommand.Parameters["layoff"].Value = 999;
				}
				else if ((_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[i].fx[10]).TotalDays > 999.0 || (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[i].fx[10]).TotalDays < 0.0)
				{
					oleDbCommand.Parameters["layoff"].Value = 999;
				}
				else
				{
					oleDbCommand.Parameters["layoff"].Value = (_trackInfo.RaceDate - (DateTime)_raceInfo[_Idx].RaceHorseInfo[i].fx[10]).TotalDays;
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[11] != null)
				{
					oleDbCommand.Parameters["al"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[11], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[2] != null)
				{
					oleDbCommand.Parameters["speed"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[2], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[4] != null)
				{
					oleDbCommand.Parameters["spts"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[4], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[3] != null)
				{
					oleDbCommand.Parameters["sc"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[3], 2);
				}
				if (_raceInfo[_Idx].RaceHorseInfo[i].fx[12] != null)
				{
					oleDbCommand.Parameters["efx"].Value = Math.Round((double)_raceInfo[_Idx].RaceHorseInfo[i].fx[12], 2);
				}
				if (oleDbCommand.Parameters["tp12"].Value != DBNull.Value)
				{
					if ((double)oleDbCommand.Parameters["tp12"].Value < 1.0)
					{
						oleDbCommand.Parameters["tp12"].Value = 1.0;
					}
				}
				else
				{
					oleDbCommand.Parameters["tp12"].Value = 1.0;
				}
				double num = 8.0;
				if (_raceInfo[_Idx].Furlong < 0.8)
				{
					oleDbCommand.Parameters["spts"].Value = (Math.Sqrt(_def.BeyerPerformance * (double)oleDbCommand.Parameters["mike"].Value * 0.5 * (5.0 + 0.25 * num)) * Math.Sqrt(_def.BeyerDistance * (double)oleDbCommand.Parameters["spts"].Value * (2.5 - 0.25 * num)) + Math.Sqrt(_def.BeyerPerformance * (double)oleDbCommand.Parameters["mike"].Value * 0.5) * (double)oleDbCommand.Parameters["spts"].Value * 0.2) * 2.0;
				}
				else
				{
					num = _raceInfo[_Idx].Furlong;
					oleDbCommand.Parameters["spts"].Value = (Math.Sqrt(1.0 + Math.Abs(_def.BeyerPerformance * (double)oleDbCommand.Parameters["mike"].Value * 2.0)) * Math.Sqrt(1.0 + Math.Abs(_def.BeyerDistance * (double)oleDbCommand.Parameters["spts"].Value * 0.7)) * 0.75 + Math.Sqrt(1.0 + Math.Abs(_def.BeyerPerformance * (double)oleDbCommand.Parameters["mike"].Value * 0.5)) * (double)oleDbCommand.Parameters["tp12"].Value * 4.0) * 0.25;
				}
				double num2 = 0.0;
				if (_raceInfo[_Idx].SurfaceCondition.Contains("turf"))
				{
					oleDbCommand.Parameters["spts"].Value = ((double)oleDbCommand.Parameters["spts"].Value + (double)oleDbCommand.Parameters["spts"].Value * _raceInfo[_Idx].RaceHorseInfo[i].mm + num2 * 0.15) * _raceInfo[_Idx].RaceHorseInfo[i].mm * 0.125 + (5.0 + (double)oleDbCommand.Parameters["tp12"].Value) * 5.0;
				}
				else
				{
					oleDbCommand.Parameters["spts"].Value = ((double)oleDbCommand.Parameters["spts"].Value + (double)oleDbCommand.Parameters["spts"].Value * _raceInfo[_Idx].RaceHorseInfo[i].mm + num2 * 0.05) * _raceInfo[_Idx].RaceHorseInfo[i].mm * 0.0025 * ((5.0 + (double)oleDbCommand.Parameters["tp12"].Value) * 5.0);
				}
				try
				{
					if (_raceInfo[_Idx].RaceHorseInfo[i].fx[9] != null && (double)_raceInfo[_Idx].RaceHorseInfo[i].fx[9] <= 0.0)
					{
						oleDbCommand.Parameters["spts"].Value = 0.0;
						oleDbCommand.Parameters["speed"].Value = 0.0;
					}
				}
				catch (Exception ex)
				{
					string message = ex.Message;
				}
				if (oleDbCommand.Parameters["spts"].Value != null)
				{
					oleDbCommand.Parameters["spts"].Value = Math.Round((double)oleDbCommand.Parameters["spts"].Value, 2);
				}
				if (!_raceInfo[_Idx].RaceHorseInfo[i].Scratch)
				{
					oleDbCommand.Parameters["points"].Value = _def.ModifiedBeyerSpeed * (double)oleDbCommand.Parameters["speed"].Value * 1.5 + _def.HandimanPerformance * (double)oleDbCommand.Parameters["spts"].Value * 1.5;
				}
				else
				{
					oleDbCommand.Parameters["points"].Value = 999.0;
				}
				if ((double)oleDbCommand.Parameters["points"].Value < 70.0)
				{
					oleDbCommand.Parameters["points"].Value = _raceInfo[_Idx].RaceHorseInfo[i].AveBeyer;
					oleDbCommand.Parameters["mike"].Value = 0.0;
					oleDbCommand.Parameters["spts"].Value = 0.0;
					oleDbCommand.Parameters["speed"].Value = 0.0;
				}
				oleDbCommand.Parameters["mike"].Value = Math.Round(_raceInfo[_Idx].RaceHorseInfo[i].AveBeyer, 2);
				oleDbCommand.ExecuteNonQuery();
			}
		}
		_conn.Close();
	}

	private double getFX5(string rtypea, string agesexa, double fx_5, double[] boog)
	{
		if (rtypea.Contains("M") || rtypea.Contains("S"))
		{
			return fx_5 * 4.0 + boog[0] * 0.45 + boog[1] * 0.45 + boog[2] * 0.45 + boog[3] * 0.45 + boog[4] * 0.45 + boog[5] * 0.9 + boog[6] * 0.9 + boog[7] * 0.9 + boog[8] * 0.9 + boog[9] * 0.9 + boog[10] * 0.9 + boog[11] * 0.9 + boog[12] * 0.9;
		}
		if (agesexa.Contains("A"))
		{
			return fx_5 * 4.0 + boog[0] * 0.45 + boog[1] * 0.45 + boog[2] * 0.45 + boog[3] * 0.45 + boog[4] * 0.9 + boog[5] * 0.9 + boog[6] * 0.9 + boog[7] * 0.9 + boog[8] * 0.9 + boog[9] * 0.9 + boog[10] * 0.9 + boog[11] * 0.9 + boog[12] * 0.9;
		}
		if (rtypea.Contains("A") || rtypea.Contains("N") || rtypea.Contains("G") || rtypea.Contains("C"))
		{
			return fx_5 * 4.0 + boog[0] * 0.45 + boog[1] * 0.9 + boog[2] * 0.9 + boog[3] * 0.9 + boog[4] * 0.9 + boog[5] * 0.9 + boog[6] * 0.9 + boog[7] * 0.9 + boog[8] * 0.9 + boog[9] * 0.9 + boog[10] * 0.9 + boog[11] * 0.9 + boog[12] * 0.9;
		}
		return fx_5 * 4.0 + boog[0] * 0.45 + boog[1] * 0.45 + boog[2] * 0.45 + boog[3] * 0.45 + boog[4] * 0.45 + boog[5] * 0.9 + boog[6] * 0.9 + boog[7] * 0.9 + boog[8] * 0.9 + boog[9] * 0.9 + boog[10] * 0.9 + boog[11] * 0.9 + boog[12] * 0.9;
	}

	private void getBt(IEnumerable<DataRow> keyy, DateTime pdx, DateTime pd1, int key, double ff, ref double[] bt, bool less, string rating)
	{
		double dSelect1 = (less ? 8.0 : 12.0);
		double dSelect2 = (less ? 2.0 : 1.5);
		double dWhere1 = (less ? 2.0 : 3.0);
		double dWhere2 = (less ? 2.0 : 4.0);
		double dWhere3 = (less ? 4.5 : 5.5);
		var source = from query in keyy.AsEnumerable()
			where query.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate * 0.25) > _trackInfo.RaceDate && query.Field<DateTime>("PaceLineDt") > pdx && query.Field<double>("AdvancedSpeedFigure") > 0.0
			select new
			{
				beyerMinusFlex = beyerFlex(query.Field<double>(rating), query.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, key),
				date = query.Field<DateTime>("PaceLineDt"),
				length = query.Field<double>("PaceLineDistance"),
				bbehind = query.Field<double>("FirstCallBeatenLengths"),
				fbehind = query.Field<double>("SecondCallBeatenLengths"),
				sbehind = query.Field<double>("StretchCallBeatenLengths"),
				lbehind = query.Field<double>("FinalBeatenLengths")
			};
		var source2 = from query in keyy.AsEnumerable()
			where query.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate2 * 1.25) > _trackInfo.RaceDate && query.Field<DateTime>("PaceLineDt") > pdx && query.Field<double>("AdvancedSpeedFigure") > 0.0
			select new
			{
				beyerMinusFlex = beyerFlex(query.Field<double>(rating), query.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, key),
				date = query.Field<DateTime>("PaceLineDt"),
				length = query.Field<double>("PaceLineDistance"),
				bbehind = query.Field<double>("FirstCallBeatenLengths"),
				fbehind = query.Field<double>("SecondCallBeatenLengths"),
				sbehind = query.Field<double>("StretchCallBeatenLengths"),
				lbehind = query.Field<double>("FinalBeatenLengths")
			};
		bt[0] = (from para in source
			where para.fbehind < dWhere1 + ff * 0.5 && para.date == pd1
			select para.beyerMinusFlex + (dSelect1 - para.fbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[1] = (from para in source
			where para.fbehind >= para.sbehind - 2.0 && para.date == pd1
			select para.beyerMinusFlex + (para.fbehind - para.sbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[2] = (from para in source
			where para.sbehind < dWhere1 + ff * 0.5 && para.date == pd1
			select para.beyerMinusFlex + (dSelect1 - para.sbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[3] = (from para in source
			where para.bbehind >= para.fbehind - 2.0 && para.date == pd1
			select para.beyerMinusFlex + (para.bbehind - para.fbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[10] = (from para in source
			where para.fbehind < dWhere2 + ff * 0.5 && para.sbehind < dWhere2 + ff * 0.5 && para.date == pd1
			select para.beyerMinusFlex + (8.0 - para.fbehind) * dSelect2 + (8.0 - para.sbehind) * dSelect2).DefaultIfEmpty().Sum();
		bt[11] = (from para in source
			where para.sbehind - para.fbehind < dWhere2 + ff * 0.25 && (para.lbehind - para.sbehind < dWhere2 + ff * 0.25 || para.lbehind - para.fbehind < 2.0 + ff * 0.25) && para.date == pd1
			select para.beyerMinusFlex + (para.fbehind - para.lbehind) * dSelect2).DefaultIfEmpty().Sum();
		bt[4] = (from para in source
			where para.date == pd1
			select para.beyerMinusFlex).DefaultIfEmpty().Sum();
		bt[5] = (from para in source2
			where para.fbehind < dWhere3 + ff * 0.5
			select para.beyerMinusFlex + (12.0 - para.fbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[6] = (from para in source2
			where para.fbehind >= para.sbehind - 2.0
			select para.beyerMinusFlex + (para.fbehind - para.sbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[7] = (from para in source2
			where para.sbehind < dWhere3 + ff * 0.5
			select para.beyerMinusFlex + (12.0 - para.sbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[8] = (from para in source2
			where para.bbehind >= para.fbehind - 2.0
			select para.beyerMinusFlex + (para.bbehind - para.fbehind) * 2.0).DefaultIfEmpty().Sum();
		bt[12] = (from para in source2
			where para.fbehind < dWhere2 + ff * 0.5 && para.sbehind < dWhere2 + ff * 0.5
			select para.beyerMinusFlex + (8.0 - para.fbehind) * dSelect2 + (8.0 - para.sbehind) * dSelect2).DefaultIfEmpty().Sum();
		bt[13] = (from para in source2
			where para.sbehind - para.fbehind < dWhere2 + ff * 0.25 && (para.lbehind - para.sbehind < dWhere2 + ff * 0.25 || para.lbehind - para.fbehind < dWhere2 + ff * 0.25)
			select para.beyerMinusFlex + (para.fbehind - para.lbehind) * dSelect2).DefaultIfEmpty().Sum();
		bt[9] = source2.Select(para => para.beyerMinusFlex).DefaultIfEmpty().Sum();
	}

	private double getFX5(double pxa, double pxb, double pxc, double pxd, double pxe, double pxe2)
	{
		if (pxc > pxb && pxc > pxa)
		{
			return (pxc * 1.5 + pxd * 0.6 + pxe * 0.3 + pxe2 * 0.5) * 0.05;
		}
		if (pxa > pxb && pxa > pxc)
		{
			return (pxa * 1.5 + pxd * 0.6 + pxe * 0.3 + pxe2 * 0.5) * 0.05;
		}
		if (pxb > pxa && pxb > pxc)
		{
			return (pxb * 1.5 + pxd * 0.6 + pxe * 0.3 + pxe2 * 0.5) * 0.05;
		}
		if (pxc == 0.0)
		{
			return (pxa * 0.75 + pxb * 0.75 + pxd * 0.6 + pxe * 0.3 + pxe2 * 0.5) * 0.05;
		}
		if (pxa == 0.0)
		{
			return (pxc * 0.75 + pxb * 0.75 + pxd * 0.6 + pxe * 0.3 + pxe2 * 0.5) * 0.05;
		}
		return (pxa * 0.75 + pxc * 0.75 + pxd * 0.6 + pxe * 0.3 + pxe2 * 0.5) * 0.05;
	}

	private double getFX4(double pxa, double pxb, double pxc)
	{
		if (pxa > 0.0 || pxb > 0.0 || pxc > 0.0)
		{
			if (pxa > 0.0 && pxa > pxb)
			{
				return (pxb > 0.0) ? (2.1 + (1.0 - pxb / pxa)) : 2.99;
			}
			if (pxb > 0.0 && pxb > pxc)
			{
				if (pxc > pxa && pxc > 0.0)
				{
					return 1.1 + (1.0 - pxc / pxb);
				}
				return (pxa > 0.0) ? (1.1 + (1.0 - pxa / pxb)) : 1.99;
			}
			if (pxa > pxb && pxa > 0.0)
			{
				return 3.1 + (1.0 - pxa / pxc);
			}
			return (pxb > 0.0) ? (3.1 + (1.0 - pxb / pxc)) : 3.99;
		}
		return 0.0;
	}

	private void getPX(IEnumerable<DataRow> keyy, int key, double ff, double pxn, out double pxb, out double pxc, out double pxa, out double pxd, out double pxe, out double pxe2, out int pxx2, string rating)
	{
		var source = from query in keyy.AsEnumerable()
			where query.Field<DateTime>("PaceLineDt").AddDays(_def.MaxDate) > _trackInfo.RaceDate
			select new
			{
				beyerMinusFlex = beyerFlex(query.Field<double>(rating), query.Field<double>("PaceLineDistance"), _raceInfo[_Idx].Furlong, key),
				length = query.Field<double>("PaceLineDistance"),
				fbehind = query.Field<double>("SecondCallBeatenLengths"),
				sbehind = query.Field<double>("StretchCallBeatenLengths"),
				lbehind = query.Field<double>("FinalBeatenLengths")
			};
		pxb = (from query in source.AsQueryable()
			where query.fbehind <= (2.0 + query.length) / 4.0 && query.lbehind - query.fbehind <= 4.0 + query.length
			select 2.0 * query.beyerMinusFlex * ((27.0 - (Math.Pow(query.fbehind, 2.0) + 0.5 * Math.Pow(query.lbehind, 1.5))) / 10.0)).DefaultIfEmpty().Sum();
		pxc = (from query in source.AsQueryable()
			where query.lbehind <= 4.0 + query.length && query.fbehind - query.lbehind > (4.0 + query.length) / 2.0
			select 2.0 * query.beyerMinusFlex * ((25.0 + query.fbehind - query.lbehind - 0.5 * Math.Pow(query.lbehind, 1.5)) / 10.0)).DefaultIfEmpty().Sum();
		pxa = (from query in source.AsQueryable()
			where query.lbehind <= 4.0 + query.length && query.fbehind - query.lbehind <= (4.0 + query.length) / 2.0 && query.fbehind - query.lbehind > 0.0 - (2.0 + query.length) / 4.0 && query.fbehind > (2.0 + query.length) / 4.0
			select 2.0 * query.beyerMinusFlex * ((25.0 - (query.lbehind - query.fbehind) + 0.5 * Math.Pow(query.lbehind, 1.5)) / 10.0)).DefaultIfEmpty().Sum();
		pxd = (from query in source.AsQueryable()
			where query.lbehind <= 2.0
			select 2.0 * query.beyerMinusFlex * Math.Pow((3.0 - query.lbehind) / 2.0, 1.5)).DefaultIfEmpty().Sum();
		pxe = (from query in source.AsQueryable()
			where query.sbehind <= pxn * 3.25 + query.length + (double)Convert.ToInt32(10.0 / query.length)
			select 2.0 * query.beyerMinusFlex * ((16.0 - query.sbehind) / 17.0)).DefaultIfEmpty().Sum();
		pxe2 = (from query in source.AsQueryable()
			where query.length >= ff - pxn * 2.25 && query.length <= ff + pxn * 2.25 && query.sbehind <= pxn * 3.25 + query.length + (double)(int)(10.0 / query.length)
			select 2.0 * query.beyerMinusFlex * ((16.0 - query.sbehind) / 17.0)).DefaultIfEmpty().Sum();
		pxx2 = (from query in source.AsQueryable()
			where query.length >= ff - pxn * 2.25 && query.length <= ff + pxn * 2.25 && query.sbehind <= pxn * 3.25 + query.length + (double)(int)(10.0 / query.length)
			select query).DefaultIfEmpty().Count();
	}

	private double getPxn(double ff)
	{
		if (ff <= 6.0)
		{
			return 0.5;
		}
		if (ff > 6.0 && ff < 8.0)
		{
			return 0.625;
		}
		if (ff >= 8.0 && ff <= 10.0)
		{
			return 0.75;
		}
		return 0.875;
	}

	private double getTrz(double fx12, ref double[] bb, double ff)
	{
		if (fx12 == 2.0)
		{
			return (bb[7] > 0.0) ? (Math.Abs(bb[8]) * 0.675) : ((0.0 - Math.Abs(bb[8])) * 0.675);
		}
		if (ff >= bb[15] + 2.0)
		{
			return (bb[7] <= 10.0) ? ((0.0 - Math.Abs(bb[8])) * 0.75) : (0.0 - Math.Abs(bb[8]));
		}
		if (ff > bb[15] + 1.0 && ff < bb[15] + 2.0)
		{
			return (bb[7] > 0.0) ? (Math.Abs(bb[8]) * 0.75) : (0.0 - Math.Abs(bb[8]));
		}
		if (ff <= bb[15] - 2.0)
		{
			return Math.Abs(bb[8]);
		}
		if (ff < bb[15] - 1.0 && ff > bb[15] - 2.0)
		{
			return (bb[7] > 0.0) ? Math.Abs(bb[8]) : ((0.0 - Math.Abs(bb[8])) * 0.65);
		}
		if (bb[7] > 0.0)
		{
			return 0.0 - bb[8];
		}
		if (bb[7] < 0.0)
		{
			return Math.Abs(bb[8]);
		}
		return 0.0 - bb[8];
	}

	private double standardDeviation(IEnumerable<double> values)
	{
		if (values.Count() > 1)
		{
			double dAvg = values.Average();
			double num = values.Aggregate(0.0, (double total, double next) => total += Math.Pow(next - dAvg, 2.0));
			return Math.Sqrt(num / (double)(values.Count() - 1));
		}
		return 0.0;
	}

	private double beyerFlex(double beyer, double length, double furlong, int key)
	{
		return key switch
		{
			1 => beyer - Math.Abs(furlong - length * ((10.0 - furlong) * 0.2)), 
			2 => beyer - Math.Abs(furlong - length * ((13.0 - furlong) * 0.15)), 
			3 => beyer - Math.Abs(furlong - length * ((16.0 - furlong) * 0.15)), 
			4 => beyer - Math.Abs(furlong - length * ((20.0 - furlong) * 0.1)), 
			_ => 0.0, 
		};
	}

	private bool timeComparison(IEnumerable<DataRow> data, double furlong, ref double[] timeCall)
	{
		IEnumerable<DataRow> source = data.Where((DataRow query) => query.Field<double>("PaceLineDistance") == furlong);
		if (source.Count() > 0)
		{
			timeCall[0] = source.Select((DataRow para) => para.Field<double>("FirstCallTime")).Average();
			timeCall[1] = source.Select((DataRow para) => para.Field<double>("SecondCallTime")).Average();
			timeCall[2] = source.Select((DataRow para) => para.Field<double>("StretchCallTime")).Average();
			timeCall[3] = source.Select((DataRow para) => para.Field<double>("FinalTime")).Average();
			return false;
		}
		return true;
	}

	private IEnumerable<DataRow>[] getKey(RaceInformation rac, int idx, ref bool hasRec, string rating)
	{
		IEnumerable<DataRow>[] array = new IEnumerable<DataRow>[4];
		OrderedEnumerableRowCollection<DataRow> source = from query in _dataSet.Tables["HorseHistory"].AsEnumerable()
			where query.Field<string>("HorseName") == rac.RaceHorseInfo[idx].HorseName && query.Field<DateTime>("PaceLineDt") < _trackInfo.RaceDate && query.Field<double>(rating) > 0.0
			orderby query.Field<DateTime>("PaceLineDt") descending
			select query;
		if (source.Count() > 0)
		{
			hasRec = true;
			rac.RaceHorseInfo[idx].AveBeyer = source.Select((DataRow para) => para.Field<double>(rating)).Average();
			double[] array2 = new double[4];
			double[] dFurlong = new double[7]
			{
				rac.Furlong,
				rac.Furlong + 0.5,
				rac.Furlong + 1.0,
				rac.Furlong - 0.5,
				rac.Furlong - 1.0,
				rac.Furlong + 1.5,
				rac.Furlong - 1.5
			};
			int i = 0;
			while (true)
			{
				if (i >= dFurlong.Count())
				{
					break;
				}
				IQueryable<DataRow> source2 = from query in source.AsQueryable()
					where query.Field<double>("PaceLineDistance") == dFurlong[i] && query.Field<string>("TrackCondition").Contains(rac.SurfaceCondition)
					select query;
				if (source2.Count() != 0)
				{
					rac.RaceHorseInfo[idx].FirstCallTime = source2.Select((DataRow para) => para.Field<double>("FirstCallTime")).Average();
					rac.RaceHorseInfo[idx].SecondCallTime = source2.Select((DataRow para) => para.Field<double>("SecondCallTime")).Average();
					rac.RaceHorseInfo[idx].StretchCallTime = source2.Select((DataRow para) => para.Field<double>("StretchCallTime")).Average();
					rac.RaceHorseInfo[idx].FinalTime = source2.Select((DataRow para) => para.Field<double>("FinalTime")).Average();
					rac.RaceHorseInfo[idx].FurlongTime = dFurlong[i];
					break;
				}
				i++;
			}
			if (rac.Furlong < 6.0)
			{
				array[0] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") < 8.0 && para.Field<double>("PaceLineDistance") >= 4.0);
				array[2] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") < rac.Furlong + 1.5 && para.Field<double>("PaceLineDistance") >= 4.0);
				array[3] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") < rac.Furlong + 1.0 && para.Field<double>("PaceLineDistance") >= 4.0);
			}
			else if (rac.Furlong >= 6.0 && rac.Furlong < 7.0)
			{
				array[0] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 4.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.5);
				array[2] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 4.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.0);
				array[3] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 4.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 1.5);
			}
			else if (rac.Furlong >= 7.0 && rac.Furlong < 8.0)
			{
				array[0] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 5.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.5);
				array[2] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 5.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.0);
				array[3] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 5.5 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 1.5);
			}
			else if (rac.Furlong >= 8.0 && rac.Furlong < 8.5)
			{
				array[0] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 5.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 3.0);
				array[2] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= rac.Furlong - 2.5 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.5);
				array[3] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= rac.Furlong - 2.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.0);
			}
			else if (rac.Furlong >= 8.5 && rac.Furlong < 10.0)
			{
				array[0] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= rac.Furlong - 5.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 5.0);
				array[2] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= rac.Furlong - 3.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 3.0);
				array[3] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= rac.Furlong - 2.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.0);
			}
			else if (rac.Furlong >= 10.0)
			{
				array[0] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= 7.0);
				array[2] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= rac.Furlong - 4.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 4.0);
				array[3] = source.Where((DataRow para) => para.Field<double>("PaceLineDistance") >= rac.Furlong - 2.0 && para.Field<double>("PaceLineDistance") <= rac.Furlong + 2.0);
			}
			array[1] = source.Where((DataRow para) => para.Field<double>(rating) >= 0.0);
			array[0] = array[0].Where((DataRow para) => para.Field<double>(rating) > 0.0 && para.Field<string>("TrackCondition").Contains(rac.SurfaceCondition));
			array[2] = array[2].Where((DataRow para) => para.Field<double>(rating) > 0.0 && para.Field<string>("TrackCondition").Contains(rac.SurfaceCondition));
			array[3] = array[3].Where((DataRow para) => para.Field<double>(rating) > 0.0 && para.Field<string>("TrackCondition").Contains(rac.SurfaceCondition));
		}
		return array;
	}

	private void getDataFromHorseHistory(string[] name)
	{
		_conn.Open();
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT TOP 5 * FROM kelso.hist", _conn))
		{
			OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
			oleDbDataAdapter.Fill(_dataSet, "HorseHistory");
		}
		_dataSet.Tables["HorseHistory"].Rows.Clear();
		for (int i = 0; i < name.Count(); i++)
		{
			using OleDbCommand oleDbCommand = new OleDbCommand("SELECT * FROM kelso.hist WHERE HorseName = ?", _conn);
			oleDbCommand.Parameters.Add(new OleDbParameter("horse", name[i]));
			using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
			object[] values = new object[oleDbDataReader.FieldCount];
			while (oleDbDataReader.Read())
			{
				oleDbDataReader.GetValues(values);
				_dataSet.Tables["HorseHistory"].Rows.Add(values);
			}
		}
		_conn.Close();
	}

	private void standardizeHorData(string horse, int raceNum)
	{
		bool flag = false;
		DateTime minValue = DateTime.MinValue;
		string empty = string.Empty;
		double num = 0.0;
		double num2 = 0.0;
		double num3 = 0.0;
		double num4 = 0.0;
		double num5 = 0.0;
		string empty2 = string.Empty;
		double num6 = 0.0;
		string empty3 = string.Empty;
		double num7 = 0.0;
		double num8 = 0.0;
		string empty4 = string.Empty;
		string empty5 = string.Empty;
		string empty6 = string.Empty;
		string empty7 = string.Empty;
		double num9 = 0.0;
		double num10 = 0.0;
		double num11 = 0.0;
		double num12 = 0.0;
		double num13 = 0.0;
		EnumerableRowCollection<DataRow> enumerableRowCollection = from query in _dataSet.Tables["hor"].AsEnumerable()
			where query.Field<int>("RaceNum") == raceNum && query.Field<string>("HorseName").ToUpper() == horse
			select query;
		foreach (DataRow item in enumerableRowCollection)
		{
			flag = false;
			minValue = item.Field<DateTime>("PaceLineDt");
			empty3 = item.Field<string>("PaceLineRaceNum");
			empty = ((item.Field<int>("TurfInd") == 1) ? "turf" : "dirt");
			num = ((item.Field<double>("FirstCallBeatenLengths") < 0.0 || item.Field<int>("FirstCallPosition") == 1 || item.Field<int>("FirstCallPosition") >= 10) ? 0.0 : item.Field<double>("FirstCallBeatenLengths"));
			num2 = ((item.Field<double>("SecondCallBeatenLengths") < 0.0 || item.Field<int>("SecondCallPosition") == 1 || item.Field<int>("SecondCallPosition") >= 10) ? 0.0 : item.Field<double>("SecondCallBeatenLengths"));
			num3 = ((item.Field<double>("StretchCallBeatenLengths") < 0.0 || item.Field<int>("StretchCallPosition") == 1 || item.Field<int>("StretchCallPosition") >= 10) ? 0.0 : item.Field<double>("StretchCallBeatenLengths"));
			num4 = ((item.Field<double>("FinalBeatenLengths") < 0.0 || item.Field<int>("FinalCallPosition") == 1 || item.Field<int>("FinalCallPosition") >= 10) ? 0.0 : item.Field<double>("FinalBeatenLengths"));
			num5 = ((item.Field<double>("AdvancedSpeedFigure") < 0.0 && item.Field<double>("AdvancedSpeedFigure") > 200.0) ? 0.0 : item.Field<double>("AdvancedSpeedFigure"));
			num7 = ((item.Field<double>("SpeedRating") < 0.0 && item.Field<double>("SpeedRating") > 200.0) ? 0.0 : item.Field<double>("SpeedRating"));
			if (num5 < 20.0 && num5 > 0.0)
			{
				num5 = 20.0;
			}
			if (num7 < 20.0 && num7 > 0.0)
			{
				num7 = 20.0;
			}
			empty2 = ((item.Field<string>("TrackCondition").ToUpper() == "FST") ? "FT" : ((!(item.Field<string>("TrackCondition").ToUpper() == "SLY")) ? item.Field<string>("TrackCondition").ToUpper() : "SY"));
			num6 = Math.Abs(item.Field<double>("PaceLineDistance")) / 660.0;
			num7 = item.Field<double>("SpeedRating");
			num8 = item.Field<double>("TrackVariant");
			empty4 = item.Field<string>("TroubleLine");
			empty5 = item.Field<string>("ExtendedTroubleLineInfo");
			empty6 = item.Field<string>("TrackCd");
			empty7 = item.Field<string>("ClassString");
			num9 = item.Field<double>("ClaimingPrice");
			num10 = ((item.Field<double>("FirstCallTime") > item.Field<double>("AdditionalFractionalTime")) ? item.Field<double>("AdditionalFractionalTime") : item.Field<double>("FirstCallTime"));
			num11 = ((item.Field<double>("FirstCallTime") > item.Field<double>("AdditionalFractionalTime")) ? item.Field<double>("FirstCallTime") : item.Field<double>("SecondCallTime"));
			num12 = ((item.Field<double>("FirstCallTime") > item.Field<double>("AdditionalFractionalTime")) ? item.Field<double>("SecondCallTime") : item.Field<double>("AdditionalFractionalTime"));
			num13 = item.Field<double>("FinalTime");
			if (!isRecordDuplicate(horse, minValue))
			{
				_conn.Open();
				using (OleDbCommand oleDbCommand = new OleDbCommand("INSERT INTO kelso.hist(HorseName, PaceLineRaceNum, PaceLineDt, FirstCallBeatenLengths, SecondCallBeatenLengths, StretchCallBeatenLengths, FinalBeatenLengths, PaceLineDistance, AdvancedSpeedFigure, TrackCondition, SpeedRating, TrackVariant, TroubleLine, ExtendedTroubleLineInfo, TrackCd, ClassString, ClaimingPrice, FirstCalltime, SecondCallTime, StretchCallTime, FinalTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", _conn))
				{
					oleDbCommand.Parameters.Add(new OleDbParameter("HorseName", horse));
					oleDbCommand.Parameters.Add(new OleDbParameter("PaceLineRaceNum", empty3));
					oleDbCommand.Parameters.Add(new OleDbParameter("PaceLineDt", minValue));
					oleDbCommand.Parameters.Add(new OleDbParameter("FirstCallBeatenLengths", num));
					oleDbCommand.Parameters.Add(new OleDbParameter("SecondCallBeatenLengths", num2));
					oleDbCommand.Parameters.Add(new OleDbParameter("StretchCallBeatenLengths", num3));
					oleDbCommand.Parameters.Add(new OleDbParameter("FinalBeatenLengths", num4));
					oleDbCommand.Parameters.Add(new OleDbParameter("PaceLineDistance", num6));
					oleDbCommand.Parameters.Add(new OleDbParameter("AdvancedSpeedFigure", num5));
					oleDbCommand.Parameters.Add(new OleDbParameter("TrackCondition", empty2 + "/" + empty));
					oleDbCommand.Parameters.Add(new OleDbParameter("SpeedRating", num7));
					oleDbCommand.Parameters.Add(new OleDbParameter("TrackVariant", num8));
					oleDbCommand.Parameters.Add(new OleDbParameter("TroubleLine", empty4));
					oleDbCommand.Parameters.Add(new OleDbParameter("ExtendedTroubleLine", empty5));
					oleDbCommand.Parameters.Add(new OleDbParameter("TrackCd", empty6));
					oleDbCommand.Parameters.Add(new OleDbParameter("ClassString", empty7));
					oleDbCommand.Parameters.Add(new OleDbParameter("ClaimingPrice", num9));
					oleDbCommand.Parameters.Add(new OleDbParameter("FirstCallTime", num10));
					oleDbCommand.Parameters.Add(new OleDbParameter("SecondCallTime", num11));
					oleDbCommand.Parameters.Add(new OleDbParameter("StretchCallTime", num12));
					oleDbCommand.Parameters.Add(new OleDbParameter("FinalTime", num13));
					oleDbCommand.ExecuteNonQuery();
				}
				_conn.Close();
			}
		}
	}

	private void makeAdjustment()
	{
		lBoxEvent.Items.Add("\n");
		_def.chch = 0;
		_def.BeyerPerformance *= 100.0;
		_def.BeyerDistance *= 100.0;
		_def.ModifiedBeyerSpeed *= 100.0;
		_def.HandimanPerformance *= 100.0;
		if (_raceInfo[_Idx].RacingType == "C")
		{
			_def.chch = 1;
			_def.BeyerPerformance -= 5.0;
			_def.BeyerDistance += 5.0;
			_def.ModifiedBeyerSpeed += 10.0;
			_def.HandimanPerformance -= 10.0;
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": ADJUSTED FOR: Claimers'.");
		}
		if ("ART".IndexOf(_raceInfo[_Idx].RacingType) != -1)
		{
			_def.chch = 1;
			_def.BeyerPerformance -= 10.0;
			_def.BeyerDistance += 10.0;
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": ADJUSTED FOR: Allowance/Handicap'.");
		}
		if (_raceInfo[_Idx].RacingType == "S")
		{
			_def.chch = 1;
			_def.BeyerPerformance += 15.0;
			_def.BeyerDistance -= 15.0;
			_def.ModifiedBeyerSpeed += 15.0;
			_def.HandimanPerformance -= 15.0;
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": ADJUSTED FOR: Maidens'.");
		}
		if (_raceInfo[_Idx].RacingType == "M")
		{
			_def.chch = 1;
			_def.BeyerPerformance += 10.0;
			_def.BeyerDistance -= 10.0;
			_def.ModifiedBeyerSpeed += 20.0;
			_def.HandimanPerformance -= 20.0;
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": ADJUSTED FOR: Maiden Claimers'.");
		}
		if (_raceInfo[_Idx].Furlong >= 8.0)
		{
			_def.BeyerPerformance += 10.0;
			_def.BeyerDistance -= 10.0;
		}
		if (_def.BeyerPerformance <= 0.0 || _def.BeyerDistance >= 100.0)
		{
			_def.BeyerPerformance = 0.0;
			_def.BeyerDistance = 100.0;
		}
		else if (_def.BeyerPerformance >= 100.0 || _def.BeyerDistance <= 0.0)
		{
			_def.BeyerPerformance = 100.0;
			_def.BeyerDistance = 0.0;
		}
		if (_def.HandimanPerformance <= 0.0 || _def.ModifiedBeyerSpeed >= 100.0)
		{
			_def.HandimanPerformance = 0.0;
			_def.ModifiedBeyerSpeed = 100.0;
		}
		else if (_def.HandimanPerformance >= 100.0 || _def.ModifiedBeyerSpeed <= 0.0)
		{
			_def.HandimanPerformance = 100.0;
			_def.ModifiedBeyerSpeed = 0.0;
		}
		txtBoxBeyerPerformance.Text = _def.BeyerPerformance.ToString();
		txtBoxBeyerDistance.Text = _def.BeyerDistance.ToString();
		txtBoxModifiedBeyerSpeed.Text = _def.ModifiedBeyerSpeed.ToString();
		txtBoxHandimanPerformance.Text = _def.HandimanPerformance.ToString();
		lblCondition.Text = "Condition: " + _raceInfo[_Idx].SurfaceCondition;
		_def.BeyerPerformance /= 100.0;
		_def.BeyerDistance /= 100.0;
		_def.ModifiedBeyerSpeed /= 100.0;
		_def.HandimanPerformance /= 100.0;
	}

	private void listHorse()
	{
		lBoxEvent.Items.Add("\n");
		lBoxEvent.Items.Add("Here are the horses for race #" + _raceInfo[_Idx].RaceNum + " at " + _trackInfo.TrackCode + " on " + _trackInfo.RaceDate.ToShortDateString());
		lBoxEvent.Items.Add(_raceInfo[_Idx].RaceHorseInfo.Count() + " horses scheduled to go " + _raceInfo[_Idx].Furlong + " furlong.");
		lBoxEvent.Items.Add("\n");
		lBoxEvent.Items.Add("Pole Position\t\tHorse Name");
		for (int i = 0; i < _raceInfo[_Idx].RaceHorseInfo.Count(); i++)
		{
			lBoxEvent.Items.Add(_raceInfo[_Idx].RaceHorseInfo[i].PolePosition.ToString() + "\t\t\t" + _raceInfo[_Idx].RaceHorseInfo[i].HorseName);
		}
	}

	private bool isRecordDuplicate(string horse, DateTime raceDate)
	{
		bool flag = false;
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT count(1) FROM kelso.hist WHERE HorseName = ? and PaceLineDt = ?", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("@v1", horse));
			oleDbCommand.Parameters.Add(new OleDbParameter("@v2", raceDate));
			if ((int)oleDbCommand.ExecuteScalar() != 0)
			{
				flag = true;
			}
		}
		_conn.Close();
		return flag;
	}

	private void parseMorningLine(string morningLine, RaceHorseInformation info)
	{
		if (string.IsNullOrEmpty(morningLine))
		{
			return;
		}
		if (morningLine.Equals("EVEN", StringComparison.OrdinalIgnoreCase))
		{
			info.Line1 = "1";
			info.Line2 = "1";
			return;
		}
		string[] array = Regex.Split(morningLine, "-|/").ToArray();
		if (array.Count() == 2)
		{
			info.Line1 = array[0];
			info.Line2 = array[1];
		}
	}

	private string getTrend(double al, double trend)
	{
		if (al > 1.0)
		{
			if (trend > 5.0)
			{
				return "UP";
			}
			if (trend < -5.0)
			{
				return (trend == -99.0) ? "LOFF" : "DOWN";
			}
			return "SAME";
		}
		return "NONE";
	}

	private void showResult()
	{
		_conn.Open();
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso.comp ORDER BY compositescore DESC", _conn))
		{
			OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "racecomp");
			var enumerableRowCollection = from query in dataSet.Tables["racecomp"].AsEnumerable()
				where string.IsNullOrEmpty(query.Field<string>("PPX").Trim())
				orderby query.Field<double>("COMPOSITESCORE") + query.Field<double>("BONUS") descending
				select new
				{
					TrackCd = query.Field<string>("TRACK"),
					Race = query.Field<double>("RACE"),
					Length = query.Field<double>("LENGTH"),
					Surface = query.Field<string>("SURFACE"),
					Line = ((query.Field<double>("LINE1") == 0.0) ? string.Empty : (query.Field<double>("LINE1") + "/" + query.Field<double>("LINE2"))),
					PolePosition = query.Field<string>("PP"),
					HorseName = query.Field<string>("HORSE"),
					CompositeScore = Math.Round(query.Field<double>("COMPOSITESCORE"), 2) + query.Field<double>("BONUS"),
					Points = query.Field<double>("POINTS"),
					FastTrack = query.Field<double>("HANDIMAN"),
					Workout = query.Field<double>("WORSCORE"),
					TrainerScore = Math.Round(query.Field<double>("TRAINERSCORE"), 2),
					JockeyScore = Math.Round(query.Field<double>("JOCKEYSCORE"), 2),
					JockeyTier = query.Field<double>("JOCKEYRANKING"),
					Jockey = query.Field<string>("JOCKEY"),
					Closer = query.Field<double>("CLOSINGTREND"),
					Speed = query.Field<double>("MIKE"),
					ClaimPriceTrend = query.Field<double>("CLAIMPRICETREND"),
					BettingLine = query.Field<double>("BETTINGLINE"),
					StretchCall = query.Field<double>("STRETCHCALLTIME"),
					StretchCallMinTime = query.Field<double>("STRETCHCALLMIN"),
					StretchCallMaxTime = query.Field<double>("STRETCHCALLMAX"),
					StretchCallPlacement = query.Field<double>("STRETCHCALLPLACEMENT"),
					FinalCall = query.Field<double>("FINALTIME"),
					FinalMinTime = query.Field<double>("FINALMIN"),
					FinalMaxTime = query.Field<double>("FINALMAX"),
					FinalTimePlacement = query.Field<double>("FINALPLACEMENT"),
					HorseRanking = query.Field<double>("HORSEPLACEMENT"),
					HorseRankingPoint = query.Field<double>("PLACEMENTPOINT"),
					Furlong = query.Field<double>("FURLONGTIME"),
					Bonus = query.Field<double>("BONUS"),
					Trend = getTrend(query.Field<double>("AL"), query.Field<double>("BTREND")),
					LayOff = query.Field<double>("LAYOFF"),
					SDV = query.Field<double>("SDV")
				};
			DateTime dateTime = (DateTime)_dataSet.Tables["rac"].AsEnumerable().First()["RACEDT"];
			string text = (string)_dataSet.Tables["rac"].AsEnumerable().First()["TRACKNAME"];
			using (OleDbCommand oleDbCommand = new OleDbCommand("DELETE FROM kelso.process WHERE racedt = ? AND track = ? AND race = ?", _conn))
			{
				oleDbCommand.Parameters.Add(new OleDbParameter("racedt", dateTime));
				oleDbCommand.Parameters.Add(new OleDbParameter("track", text));
				oleDbCommand.Parameters.Add(new OleDbParameter("race", enumerableRowCollection.First().Race));
				oleDbCommand.ExecuteNonQuery();
			}
			using (OleDbDataAdapter oleDbDataAdapter2 = new OleDbDataAdapter("SELECT racedt, track, race, poleposition, line, horse, jockey, compositescore, handiman, speedrating, worscore, trainerscore, jockeyscore, bettingline, closingtrend, furlong, horseplacement, bonus, frank, track_type, distance, trackcd, place FROM kelso.process WHERE race = 999", _conn))
			{
				OleDbCommandBuilder oleDbCommandBuilder2 = new OleDbCommandBuilder(oleDbDataAdapter2);
				DataSet dataSet2 = new DataSet();
				oleDbDataAdapter2.Fill(dataSet2, "raceprocess");
				dataSet2.Tables["raceprocess"].Rows.Clear();
				int num = 1;
				foreach (var item in enumerableRowCollection)
				{
					dataSet2.Tables["raceprocess"].Rows.Add(dateTime, text, item.Race, item.PolePosition, item.Line, item.HorseName, item.Jockey, item.CompositeScore, item.FastTrack, item.Speed, item.Workout, item.TrainerScore, item.JockeyScore, item.BettingLine, item.Closer, item.Furlong, item.HorseRanking, item.Bonus, 0, item.Surface, item.Length, item.TrackCd, num);
					num++;
				}
				oleDbDataAdapter2.InsertCommand = oleDbCommandBuilder2.GetInsertCommand();
				oleDbDataAdapter2.Update(dataSet2, "raceprocess");
				dataSet2.Dispose();
				cbModTrack.Text = text;
				cbModRacingDt.Text = dateTime.ToShortDateString();
				cbModRaceNum.Text = Convert.ToInt16(enumerableRowCollection.First().Race).ToString();
				cbModHorseName.Items.Clear();
				cbModHorseName.Items.AddRange((from para in enumerableRowCollection.AsQueryable()
					select para.HorseName).ToArray());
			}
			var source = from query in dataSet.Tables["racecomp"].AsEnumerable()
				where query.Field<int>("FIRSTTIMER") == 1 && string.IsNullOrEmpty(query.Field<string>("PPX"))
				select new
				{
					Line = ((query.Field<double>("LINE1") == 0.0) ? string.Empty : (query.Field<double>("LINE1") + "/" + query.Field<double>("LINE2"))),
					PolePosition = query.Field<string>("PP"),
					HorseName = query.Field<string>("HORSE"),
					CompositeScore = query.Field<double>("COMPOSITESCORE"),
					Points = query.Field<double>("POINTS"),
					Workout = query.Field<double>("WORSCORE"),
					TrainerScore = Math.Round(query.Field<double>("TRAINERSCORE"), 2),
					JockeyScore = Math.Round(query.Field<double>("JOCKEYSCORE"), 2),
					JockeyTier = query.Field<double>("JOCKEYRANKING"),
					Jockey = query.Field<string>("JOCKEY"),
					Closer = query.Field<double>("CLOSINGTREND"),
					Speed = query.Field<double>("MIKE"),
					ClaimPriceTrend = query.Field<double>("CLAIMPRICETREND"),
					BettingLine = query.Field<double>("BETTINGLINE"),
					Trend = getTrend(query.Field<double>("AL"), query.Field<double>("BTREND")),
					LayOff = query.Field<double>("LAYOFF"),
					SDV = query.Field<double>("SDV")
				};
			lBoxEvent.Items.Add("");
			lBoxEvent.Items.Add("");
			lBoxEvent.Items.Add("Track: " + _trackInfo.TrackCode);
			lBoxEvent.Items.Add("Date: " + _trackInfo.RaceDate.ToShortDateString());
			lBoxEvent.Items.Add("Race Num: " + (_Idx + 1));
			string text2 = "SpeedRating";
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Using " + text2);
			lblRaceTrack.Text = _trackInfo.TrackCode;
			lblDate.Text = _trackInfo.RaceDate.ToShortDateString();
			lblRaceNum.Text = (_Idx + 1).ToString();
			lblCalcType.Text = "SpeedRating";
			dataGridView1.DataSource = enumerableRowCollection.ToList();
			dataGridView1.Refresh();
			dataGridView2.DataSource = source.ToList();
			dataGridView2.Refresh();
			Application.DoEvents();
		}
		using (OleDbCommand oleDbCommand2 = new OleDbCommand("SELECT DISTINCT track FROM kelso.process", _conn))
		{
			using OleDbDataReader oleDbDataReader = oleDbCommand2.ExecuteReader();
			cbTrack.Items.Clear();
			cbRacingDate.Items.Clear();
			while (oleDbDataReader.Read())
			{
				cbTrack.Items.Add(oleDbDataReader.GetValue(0));
			}
		}
		_conn.Close();
	}

	private void rsdv()
	{
		double num = 0.0;
		double num2 = 0.0;
		double num3 = 0.0;
		double num4 = 0.0;
		double num5 = 0.0;
		double num6 = 0.0;
		double num7 = 0.0;
		double num8 = 0.0;
		double[] array = new double[15];
		double num9 = 0.0;
		double num10 = 0.0;
		double num11 = 0.0;
		double num12 = 0.0;
		double num13 = 0.0;
		double num14 = Convert.ToDouble(txtBoxHandimanPercent.Text) / 100.0;
		double num15 = Convert.ToDouble(txtBoxWorkout.Text) / 100.0;
		double num16 = Convert.ToDouble(txtBoxTrainer.Text) / 100.0;
		double num17 = Convert.ToDouble(txtBoxJockey.Text) / 100.0;
		double num18 = Convert.ToDouble(txtBoxEq0Workout.Text) / 100.0;
		double num19 = Convert.ToDouble(txtBoxEq0Trainer.Text) / 100.0;
		double num20 = Convert.ToDouble(txtBoxEq0Jockey.Text) / 100.0;
		double num21 = Convert.ToDouble(txtBoxBettingLine.Text) / 100.0;
		double num22 = Convert.ToDouble(txtBoxClaimPrice.Text) / 100.0;
		double num23 = Convert.ToDouble(txtBoxEq0BettingLine.Text) / 100.0;
		double num24 = Convert.ToDouble(txtBoxEq0ClaimPrice.Text) / 100.0;
		double num25 = Convert.ToDouble(txtBoxClosingTrend.Text) / 100.0;
		double num26 = Convert.ToDouble(txtBoxMinNumOfRaces.Text);
		double num27 = Convert.ToDouble(txtBoxStretchCall.Text) / 100.0;
		int iFavorite = int.Parse(txtBoxFavorite.Text);
		double num28 = double.Parse(txtBoxDefineFavorite.Text);
		double num29 = double.Parse(txtBoxSpeedRating.Text) / 100.0;
		_conn.Open();
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso.comp WHERE LEN(ppx) = 0", _conn))
		{
			OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "racecomp");
			array[6] = (from para in dataSet.Tables["racecomp"].AsEnumerable()
				where para.Field<double>("POINTS") != 0.0 && para.Field<double>("POINTS") != 999.0
				select para.Field<double>("POINTS")).DefaultIfEmpty().Max();
			for (int i = 0; i < dataSet.Tables["racecomp"].Rows.Count; i++)
			{
				if ((double)dataSet.Tables["racecomp"].Rows[i]["POINTS"] != 0.0 && (double)dataSet.Tables["racecomp"].Rows[i]["POINTS"] != 999.0)
				{
					dataSet.Tables["racecomp"].Rows[i]["POINTS"] = Math.Round(((double)dataSet.Tables["racecomp"].Rows[i]["POINTS"] + 0.01) / array[6] * 100.0, 2);
				}
				if ((double)dataSet.Tables["racecomp"].Rows[i]["POINTS"] > 100.0)
				{
					dataSet.Tables["racecomp"].Rows[i]["POINTS"] = 100.0;
				}
				dataSet.Tables["racecomp"].Rows[i]["HANDIMAN"] = dataSet.Tables["racecomp"].Rows[i]["POINTS"];
				double num30 = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["TP14"] / (double)dataSet.Tables["racecomp"].Rows[i]["TP13"], 2) * 100.0;
				dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] = ((num30.ToString() == double.NaN.ToString()) ? 0.0 : num30);
				if ((double)dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] == 0.0)
				{
					dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] = dataSet.Tables["racecomp"].Rows[i]["TRAINERSTATS"];
				}
				double num31 = 0.0;
				num31 = ((!((double)dataSet.Tables["racecomp"].Rows[i]["TP17"] < num26)) ? (Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["TP18"] / (double)dataSet.Tables["racecomp"].Rows[i]["TP17"], 2) * 100.0) : Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["JOCKEYSTATS"], 2));
				dataSet.Tables["racecomp"].Rows[i]["JOCKEYRANKING"] = ((num31.ToString() == double.NaN.ToString()) ? 0.0 : jockeyScore(num31));
			}
			double num32 = dataSet.Tables["racecomp"].Rows.Count;
			var source = from query in dataSet.Tables["racecomp"].AsEnumerable()
				orderby query.Field<double>("TRAINERSCORE") descending
				group query by query.Field<double>("TRAINERSCORE") into g
				select new
				{
					score = g.Key,
					count = g.Count()
				};
			int num33 = dataSet.Tables["racecomp"].Rows.Count;
			for (int i = 0; i < source.Count(); i++)
			{
				int num34 = 0;
				for (int j = 0; j < dataSet.Tables["racecomp"].Rows.Count; j++)
				{
					if ((double)dataSet.Tables["racecomp"].Rows[j]["TRAINERSCORE"] == source.ElementAt(i).score)
					{
						if (source.ElementAt(i).score == 0.0)
						{
							dataSet.Tables["racecomp"].Rows[j]["TRAINERRANKING"] = 0.0;
						}
						else
						{
							dataSet.Tables["racecomp"].Rows[j]["TRAINERRANKING"] = (double)num33 / num32;
						}
						num34++;
						if (num34 == source.ElementAt(i).count)
						{
							break;
						}
					}
				}
				num33--;
			}
			for (int i = 0; i < dataSet.Tables["racecomp"].Rows.Count; i++)
			{
				if ((int)dataSet.Tables["racecomp"].Rows[i]["FIRSTTIMER"] == 1)
				{
					double num35 = (((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] == 0.0) ? (num15 / 4.0) : 0.0);
					if ((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] == 0.0)
					{
						dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["TRAINERRANKING"] * (num19 * 100.0), 2);
						dataSet.Tables["racecomp"].Rows[i]["JOCKEYSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["JOCKEYRANKING"] / 5.0 * ((num20 + num15) * 100.0), 2);
						dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] * num24 * 100.0, 2);
						dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"] / 35.0 * 100.0 * (num23 + num15), 2);
						dataSet.Tables["racecomp"].Rows[i]["PLACEMENTPOINT"] = 0.0;
						dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["JOCKEYSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] + (double)dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"], 2);
						dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"], 2);
					}
					else
					{
						dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] * num18, 2);
						dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["TRAINERRANKING"] * (num19 * 100.0), 2);
						dataSet.Tables["racecomp"].Rows[i]["JOCKEYSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["JOCKEYRANKING"] / 5.0 * (num20 * 100.0), 2);
						dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] * (num24 * 100.0), 2);
						dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"] / 35.0 * 100.0 * num23, 2);
						dataSet.Tables["racecomp"].Rows[i]["PLACEMENTPOINT"] = 0.0;
						dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["JOCKEYSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] + (double)dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"], 2);
						dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"], 2);
					}
				}
				else if ((double)dataSet.Tables["racecomp"].Rows[i]["POINTS"] == 999.0)
				{
					dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"] = 0.0;
				}
				else
				{
					double num35 = (((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] == 0.0) ? 0.0 : num15);
					double num36 = (((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] == 0.0) ? (num21 + num15) : num21);
					double num31 = (((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] == 0.0) ? (num17 + num15) : num17);
					dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["TRAINERRANKING"] * (num16 * 100.0), 2);
					dataSet.Tables["racecomp"].Rows[i]["JOCKEYSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["JOCKEYRANKING"] / 5.0 * (num31 * 100.0), 2);
					dataSet.Tables["racecomp"].Rows[i]["POINTS"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["POINTS"] * num14, 2);
					dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] * num35, 2);
					dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] * num22 * 100.0, 2);
					dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"] / 35.0 * 100.0 * num36, 2);
					dataSet.Tables["racecomp"].Rows[i]["CLOSINGTREND"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["CLOSINGTREND"] * num25 * 100.0, 2);
					dataSet.Tables["racecomp"].Rows[i]["PLACEMENTPOINT"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["HORSEPLACEMENT"] / 100.0 * num27 * 100.0, 2);
					dataSet.Tables["racecomp"].Rows[i]["AVESPEED"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["AVESPEED"] / 100.0 * num29 * 100.0, 2);
					dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["POINTS"] + (double)dataSet.Tables["racecomp"].Rows[i]["WORSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["TRAINERSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["JOCKEYSCORE"] + (double)dataSet.Tables["racecomp"].Rows[i]["CLAIMPRICETREND"] + (double)dataSet.Tables["racecomp"].Rows[i]["BETTINGLINE"] + (double)dataSet.Tables["racecomp"].Rows[i]["CLOSINGTREND"] + (double)dataSet.Tables["racecomp"].Rows[i]["AVESPEED"], 2);
					dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"] = Math.Round((double)dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"], 2);
				}
			}
			oleDbDataAdapter.Update(dataSet, "RaceComp");
		}
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso.comp WHERE LEN(ppx) = 0 ORDER BY compositescore DESC", _conn))
		{
			OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "racecomp");
			for (int i = 0; i < dataSet.Tables["racecomp"].Rows.Count; i++)
			{
				dataSet.Tables["racecomp"].Rows[i]["PLACEMENT"] = i + 1;
				dataSet.Tables["racecomp"].Rows[i]["BONUS"] = 0.0;
			}
			OrderedEnumerableRowCollection<DataRow> source2 = from query in dataSet.Tables["racecomp"].AsEnumerable()
				orderby query.Field<double>("LINE1") / query.Field<double>("LINE2")
				select query;
			if (source2.First().Field<double>("LINE1") / source2.First().Field<double>("LINE2") <= num28 && source2.First().Field<int>("PLACEMENT") > iFavorite)
			{
				double num37 = (from para in dataSet.Tables["racecomp"].AsEnumerable()
					where para.Field<int>("PLACEMENT") == iFavorite
					select para.Field<double>("COMPOSITESCORE")).Single();
				for (int i = 0; i < dataSet.Tables["racecomp"].Rows.Count; i++)
				{
					if ((int)dataSet.Tables["racecomp"].Rows[i]["PLACEMENT"] == source2.First().Field<int>("PLACEMENT"))
					{
						dataSet.Tables["racecomp"].Rows[i]["BONUS"] = Math.Round(num37 - (double)dataSet.Tables["racecomp"].Rows[i]["COMPOSITESCORE"], 2) + 0.01;
					}
				}
			}
			oleDbDataAdapter.Update(dataSet, "racecomp");
		}
		_conn.Close();
	}

	private double jockeyScore(double value)
	{
		if (value >= 20.0)
		{
			return 5.0;
		}
		if (value >= 15.0 && value < 20.0)
		{
			return 4.0;
		}
		if (value >= 10.0 && value < 15.0)
		{
			return 3.0;
		}
		if (value >= 5.0 && value < 10.0)
		{
			return 2.0;
		}
		return 0.0;
	}

	private double claimPriceTrend(double value)
	{
		if (value == 0.0)
		{
			return 0.0;
		}
		if (value < 10000.0)
		{
			return 1.0;
		}
		if (value >= 10000.0)
		{
			return -1.0;
		}
		return 0.0;
	}

	private double getTS10(double[] ts, double tstp)
	{
		switch (_raceInfo[_Idx].RacingType)
		{
		case "M":
			ts[9] = ts[1] * 0.4 + 15.0 + Math.Pow(tstp * 2.0 + 1.0, 1.25);
			if (ts[7] * 2.5 - (ts[10] + ts[8]) + 1.0 > 0.0)
			{
				ts[9] += Math.Pow(ts[7] * 2.5 - (ts[10] + ts[8]) + 1.0, 1.25);
			}
			break;
		case "C":
			if (_raceInfo[_Idx].Furlong < 8.0)
			{
				ts[9] = ts[1] * 0.65 + 35.0 - Math.Pow(tstp * 2.0 + 1.0, 1.35);
				if (ts[7] * 2.1 - (ts[10] + ts[8]) + 1.0 > 0.0)
				{
					ts[9] += Math.Pow(ts[7] * 2.1 - (ts[10] + ts[8]) + 1.0, 1.35);
				}
			}
			else
			{
				ts[9] = ts[1] * 0.65 + 35.0 - Math.Pow(tstp * 2.0 + 1.0, 1.55);
				if (ts[7] * 2.5 - (ts[10] + ts[8]) + 1.0 > 0.0)
				{
					ts[9] += Math.Pow(ts[7] * 2.5 - (ts[10] + ts[8]) + 1.0, 1.35);
				}
			}
			break;
		default:
			if (_raceInfo[_Idx].Furlong < 8.0)
			{
				ts[9] = ts[1] * 0.65 + 35.0 - Math.Pow(tstp * 2.0 + 1.0, 1.35);
				if (ts[7] * 2.1 - (ts[10] + ts[8]) + 1.0 > 0.0)
				{
					ts[9] += Math.Pow(ts[7] * 2.5 - (ts[10] + ts[8]) + 1.0, 1.25);
				}
			}
			else
			{
				ts[9] = ts[1] * 0.35 + 35.0 - Math.Pow(tstp * 2.0 + 1.0, 1.75);
				if (ts[7] * 2.5 - (ts[10] + ts[8]) + 1.0 > 0.0)
				{
					ts[9] += Math.Pow(ts[7] * 2.5 - (ts[10] + ts[8]) + 1.0, 1.25);
				}
			}
			break;
		}
		return ts[9];
	}

	private void bttnProcess_Click(object sender, EventArgs e)
	{
		_conn.Open();
		truncateTable(_conn, new string[1] { "comp" });
		_conn.Close();
		dataGridView1.DataSource = null;
		dataGridView1.Refresh();
		dataGridView2.DataSource = null;
		dataGridView2.Refresh();
		_def.BeyerPerformance = double.Parse(txtBoxBeyerPerformance.Text) / 100.0;
		_def.BeyerDistance = double.Parse(txtBoxBeyerDistance.Text) / 100.0;
		_def.ModifiedBeyerSpeed = double.Parse(txtBoxModifiedBeyerSpeed.Text) / 100.0;
		_def.HandimanPerformance = double.Parse(txtBoxHandimanPerformance.Text) / 100.0;
		for (int i = 0; i < _raceInfo[_Idx].RaceHorseInfo.Count(); i++)
		{
			racingCalculation(_raceInfo[_Idx], i);
			workout(_raceInfo[_Idx], i);
		}
		insertIntoRaceComp();
		rsdv();
		showResult();
	}

	private void bttnNext_Click(object sender, EventArgs e)
	{
		dataGridView1.DataSource = null;
		dataGridView1.Refresh();
		dataGridView2.DataSource = null;
		dataGridView2.Refresh();
		bttnNext.Enabled = false;
		_Idx++;
		_conn.Open();
		truncateTable(_conn, new string[1] { "comp" });
		_conn.Close();
		lBoxEvent.Items.Clear();
		startProcess();
		Application.DoEvents();
		bttnNext.Enabled = true;
	}

	private void frmMain_Load(object sender, EventArgs e)
	{
	}

	private void lBoxEvent_SelectedIndexChanged(object sender, EventArgs e)
	{
		lBoxEvent.SelectedIndex = lBoxEvent.Items.Count - 1;
	}

	private void lBoxEvent_ValueMemberChanged(object sender, EventArgs e)
	{
	}

	private void workout(RaceInformation rac, int idx)
	{
		_conn.Open();
		DataSet dataSet = new DataSet();
		rac.RaceHorseInfo[idx].WorkOutScore = 0.0;
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT * FROM kelso.wor WHERE RaceNum = ? AND UPPER(HorseName) = ? AND WorkOutTrack NOT IN ('LA', 'SLR', 'FPX') ORDER BY WorkOutDt", _conn))
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceNum", rac.RaceNum));
			oleDbCommand.Parameters.Add(new OleDbParameter("HorseName", rac.RaceHorseInfo[idx].HorseName));
			oleDbDataAdapter.SelectCommand = oleDbCommand;
			oleDbDataAdapter.Fill(dataSet, "wor");
		}
		_conn.Close();
		EnumerableRowCollection<DataRow> source = from query in dataSet.Tables["wor"].AsEnumerable()
			where query.Field<DateTime>("WorkOutDt") > _trackInfo.RaceDate.AddDays(0.0 - Convert.ToDouble(txtBoxMaxWorkoutDays.Text))
			select query;
		rac.RaceHorseInfo[idx].TotalWorkOut = source.Count();
		if (source.Count() > 0)
		{
			var source2 = from query in source.AsQueryable()
				where !query.Field<string>("WorkOutTrack").Contains("SLR") && query.Field<double>("WorkOutDistance") / 660.0 >= rac.Furlong / 2.0
				orderby query.Field<DateTime>("WorkOutDt")
				select new
				{
					furlong = query.Field<double>("WorkOutDistance") / 660.0,
					time = query.Field<double>("WorkOutTime"),
					grade = calcGrade(query.Field<double>("WorkOutTime"), givenTime(query.Field<double>("WorkOutDistance") / 660.0), query.Field<short>("BreezingInd"), query.Field<short>("GateWorkOutInd"))
				};
			if ((double)source2.Count() > 0.0)
			{
				rac.RaceHorseInfo[idx].WorkOutScore = (from para in source2
					where para.furlong == rac.Furlong && para.grade != 0.0
					select para.grade).DefaultIfEmpty().Average();
				if (rac.RaceHorseInfo[idx].WorkOutScore == 0.0)
				{
					rac.RaceHorseInfo[idx].WorkOutScore = (from para in source2
						where para.grade != 0.0
						select para.grade - ((rac.Furlong - para.furlong < 0.0) ? 0.0 : ((rac.Furlong - para.furlong) * 0.05))).DefaultIfEmpty().Average();
				}
			}
		}
		dataSet.Dispose();
	}

	private void TrainingScore(RaceInformation rac, int idx)
	{
	}

	private double givenTime(double furlong)
	{
		if (furlong == 3.0)
		{
			return 35.0;
		}
		if (furlong == 4.0)
		{
			return 47.0;
		}
		if (furlong == 5.0)
		{
			return 58.0;
		}
		if (furlong == 6.0)
		{
			return 72.0;
		}
		if (furlong == 7.0)
		{
			return 85.0;
		}
		if (furlong == 8.0)
		{
			return 97.0;
		}
		return 0.0;
	}

	private double calcGrade(double time, double givenTime, short breezing, short gate)
	{
		double num = 0.0;
		double num2 = time - givenTime;
		if (Math.Abs(num2) >= 3.0)
		{
			return (num2 <= 0.0) ? 130.0 : 0.0;
		}
		double num3 = Math.Abs(Math.Floor(num2));
		double num4 = Math.Abs((time - Math.Floor(time)) * 10.0);
		num = ((num2 <= 0.0) ? (100.0 + num3 * 10.0) : (100.0 - num3 * 10.0));
		if (num4 != 0.0 && num2 < 0.0)
		{
			num += num4;
		}
		else if (num4 != 0.0 && num2 > 0.0)
		{
			num += 10.0 - num4;
		}
		if (breezing == 1)
		{
			num += 10.0;
		}
		if (gate == 1)
		{
			num += 5.0;
		}
		return num;
	}

	private void bttnSaveAdjustment_Click(object sender, EventArgs e)
	{
		if (_conn.State != ConnectionState.Open)
		{
			_conn.Open();
		}
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso.adjustment WHERE id = " + cbBoxProfile.Text, _conn))
		{
			OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "adjustment");
			dataSet.Tables["adjustment"].Rows[0]["BeyerPerformance"] = txtBoxBeyerPerformance.Text;
			dataSet.Tables["adjustment"].Rows[0]["BeyerDistance"] = txtBoxBeyerDistance.Text;
			dataSet.Tables["adjustment"].Rows[0]["BeyerSpeed"] = txtBoxModifiedBeyerSpeed.Text;
			dataSet.Tables["adjustment"].Rows[0]["HandimanPerformance"] = txtBoxHandimanPerformance.Text;
			dataSet.Tables["adjustment"].Rows[0]["MaxDaysRecentPerf"] = txtBoxMaxDatePerformance.Text;
			dataSet.Tables["adjustment"].Rows[0]["HandimanGreater0Adj"] = txtBoxHandimanPercent.Text;
			dataSet.Tables["adjustment"].Rows[0]["WorkoutGreater0Adj"] = txtBoxWorkout.Text;
			dataSet.Tables["adjustment"].Rows[0]["JockeyGreater0Adj"] = txtBoxJockey.Text;
			dataSet.Tables["adjustment"].Rows[0]["TrainerGreater0Adj"] = txtBoxTrainer.Text;
			dataSet.Tables["adjustment"].Rows[0]["WorkoutEqual0Adj"] = txtBoxEq0Workout.Text;
			dataSet.Tables["adjustment"].Rows[0]["JockeyEqual0Adj"] = txtBoxEq0Jockey.Text;
			dataSet.Tables["adjustment"].Rows[0]["TrainerEqual0Adj"] = txtBoxEq0Trainer.Text;
			dataSet.Tables["adjustment"].Rows[0]["MaxDaysRecentWor"] = txtBoxMaxWorkoutDays.Text;
			dataSet.Tables["adjustment"].Rows[0]["ClaimPriceTrend"] = txtBoxClaimPrice.Text;
			dataSet.Tables["adjustment"].Rows[0]["BettingLine"] = txtBoxBettingLine.Text;
			dataSet.Tables["adjustment"].Rows[0]["ClaimPriceTrendEqual0Adj"] = txtBoxEq0ClaimPrice.Text;
			dataSet.Tables["adjustment"].Rows[0]["BettingLineEqual0Adj"] = txtBoxEq0BettingLine.Text;
			dataSet.Tables["adjustment"].Rows[0]["Closer"] = txtBoxClosingTrend.Text;
			dataSet.Tables["adjustment"].Rows[0]["JockeyMinRaces"] = txtBoxMinNumOfRaces.Text;
			dataSet.Tables["adjustment"].Rows[0]["StretchCall"] = txtBoxStretchCall.Text;
			dataSet.Tables["adjustment"].Rows[0]["TopFavorite"] = txtBoxFavorite.Text;
			dataSet.Tables["adjustment"].Rows[0]["DefineFavorite"] = txtBoxDefineFavorite.Text;
			dataSet.Tables["adjustment"].Rows[0]["SpeedRating"] = txtBoxSpeedRating.Text;
			oleDbDataAdapter.InsertCommand = oleDbCommandBuilder.GetUpdateCommand();
			oleDbDataAdapter.Update(dataSet, "adjustment");
			dataSet.Dispose();
		}
		_conn.Close();
	}

	private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
	{
	}

	private string createXml(IEnumerable<DataRow> query, string column)
	{
		XDocument xDocument = XDocument.Parse("<?xml version='1.0' encoding='UTF-8' ?><FAST_TRACK/>");
		xDocument.Root.Add(new XElement("TRACK", query.First().Field<string>("TRACK")));
		xDocument.Root.Add(new XElement("RACE_DATE", query.First().Field<DateTime>("RACEDT").ToShortDateString()));
		var enumerable = ((column == "POLEPOSITION") ? (from q in query
			group q by q.Field<double>("RACE") into g
			orderby g.Key
			select new
			{
				race = g.Key,
				record = g.OrderBy((DataRow para) => para.Field<object>(column))
			}) : (from q in query
			group q by q.Field<double>("RACE") into g
			orderby g.Key
			select new
			{
				race = g.Key,
				record = g.OrderByDescending((DataRow para) => para.Field<object>(column))
			}));
		xDocument.Root.Add(new XElement("RACES"));
		foreach (var item in enumerable)
		{
			XElement xElement = new XElement("RACE");
			xElement.Add(new XAttribute("num", Convert.ToInt16(item.race)));
			XElement xElement2 = new XElement("TRACK_TYPE");
			xElement2.Value = item.record.First().Field<string>("TRACK_TYPE");
			xElement.Add(xElement2);
			XElement xElement3 = new XElement("DISTANCE");
			xElement3.Value = item.record.First().Field<double>("DISTANCE").ToString();
			xElement.Add(xElement3);
			xElement.Add(new XElement("HORSES"));
			if (column == "POLEPOSITION")
			{
				string[] array = item.record.Select((DataRow para) => para.Field<string>("POLEPOSITION")).ToArray();
				Hashtable hashtable = new Hashtable();
				for (int i = 0; i < item.record.Count(); i++)
				{
					hashtable.Add(item.record.ElementAt(i).Field<string>("POLEPOSITION"), i);
				}
				Array.Sort(array, new AlphanumComparatorFast());
				for (int i = 0; i < array.Count(); i++)
				{
					XElement xElement4 = new XElement("HORSE");
					xElement4.Add(new XElement("NAME", item.record.ElementAt((int)hashtable[array[i]]).Field<string>("HORSE")));
					xElement4.Add(new XElement("POLE_POSITION", item.record.ElementAt((int)hashtable[array[i]]).Field<string>("POLEPOSITION")));
					xElement4.Add(new XElement("LINE", item.record.ElementAt((int)hashtable[array[i]]).Field<string>("LINE")));
					xElement4.Add(new XElement("JOCKEY", item.record.ElementAt((int)hashtable[array[i]]).Field<string>("JOCKEY")));
					xElement4.Add(new XElement("COMPOSITESCORE", item.record.ElementAt((int)hashtable[array[i]]).Field<double>("COMPOSITESCORE")));
					xElement.Element("HORSES").Add(xElement4);
				}
				xDocument.Root.Element("RACES").Add(xElement);
				continue;
			}
			foreach (DataRow item2 in item.record)
			{
				XElement xElement4 = new XElement("HORSE");
				xElement4.Add(new XElement("NAME", item2.Field<string>("HORSE")));
				xElement4.Add(new XElement("POLE_POSITION", item2.Field<string>("POLEPOSITION")));
				xElement4.Add(new XElement("LINE", item2.Field<string>("LINE")));
				xElement4.Add(new XElement("JOCKEY", item2.Field<string>("JOCKEY")));
				xElement4.Add(new XElement("COMPOSITESCORE", item2.Field<double>("COMPOSITESCORE")));
				xElement.Element("HORSES").Add(xElement4);
			}
			xDocument.Root.Element("RACES").Add(xElement);
		}
		return xDocument.ToString(SaveOptions.None);
	}

	private void createReport(string track, DateTime racedt)
	{
		DataSet dataSet = new DataSet();
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT track, racedt, race, poleposition, line, horse, jockey, compositescore, track_type, distance FROM kelso.process WHERE track = ? AND racedt = ?", _conn))
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand.Parameters.Add(new OleDbParameter("Track", track));
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceDt", racedt));
			oleDbDataAdapter.SelectCommand = oleDbCommand;
			oleDbDataAdapter.Fill(dataSet, "raceprocess");
		}
		_conn.Close();
		EnumerableRowCollection<DataRow> enumerableRowCollection = from query in dataSet.Tables["raceprocess"].AsEnumerable()
			select (query);
		string contents = createXml(enumerableRowCollection, "POLEPOSITION");
		string text = createXml(enumerableRowCollection, "COMPOSITESCORE");
		string text2 = "\\" + enumerableRowCollection.First().Field<string>("TRACK") + " " + enumerableRowCollection.First().Field<DateTime>("RACEDT").ToString("yyyyMMdd");
		if (File.Exists(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml"))
		{
			File.Delete(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml");
		}
		File.WriteAllText(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml", contents);
		if (File.Exists(ConfigurationManager.AppSettings["xml"] + text2 + " Result.xml"))
		{
			File.Delete(ConfigurationManager.AppSettings["xml"] + text2 + " Result.xml");
		}
		File.WriteAllText(ConfigurationManager.AppSettings["xml"] + text2 + " Result.xml", text);
		if (File.Exists(ConfigurationManager.AppSettings["report"] + text2 + ".html"))
		{
			File.Delete(ConfigurationManager.AppSettings["report"] + text2 + ".html");
		}
		if (File.Exists(ConfigurationManager.AppSettings["report"] + text2 + ".pdf"))
		{
			File.Delete(ConfigurationManager.AppSettings["report"] + text2 + ".pdf");
		}
		XmlDocument xmlDocument = new XmlDocument();
		xmlDocument.LoadXml(text);
		XPathNavigator input = xmlDocument.CreateNavigator();
		XslTransform xslTransform = new XslTransform();
		xslTransform.Load(ConfigurationManager.AppSettings["report"] + "\\_TheSelection.xsl");
		XmlTextWriter xmlTextWriter = new XmlTextWriter(ConfigurationManager.AppSettings["report"] + text2 + ".html", null);
		xslTransform.Transform(input, null, xmlTextWriter, null);
		xmlTextWriter.Flush();
		xmlTextWriter.Close();
		gtMany2PDFX gtMany2PDFX = (gtMany2PDFX)Activator.CreateInstance(Type.GetTypeFromCLSID(new Guid("59995656-309C-4AA3-A9EB-691988815C28")));
		gtMany2PDFX.ActivateLicense("A474CE1E-1FF3-4010-B62E-16C8BC64BA8D");
		gtMany2PDFX.InputFile = ConfigurationManager.AppSettings["report"] + text2 + ".html";
		gtMany2PDFX.DocInfoAuthor = "Phung Le";
		gtMany2PDFX.PagePaperSize = TxgtPaperSize.Letter;
		gtMany2PDFX.PageTopMargin = 0.5;
		gtMany2PDFX.PageBottomMargin = 0.5;
		gtMany2PDFX.PageLeftMargin = 0.25;
		gtMany2PDFX.PrefShowSetupDialog = false;
		gtMany2PDFX.PageOrientation = TxgtPrinterOrientation.poPortrait;
		gtMany2PDFX.PagePaperSize = TxgtPaperSize.Letter;
		gtMany2PDFX.Visible = false;
		gtMany2PDFX.OutputPDFFileName = ConfigurationManager.AppSettings["report"] + text2 + ".pdf";
		gtMany2PDFX.Visible = false;
		gtMany2PDFX.PrefOpenAfterCreate = false;
		gtMany2PDFX.RenderDocument();
		Marshal.FinalReleaseComObject(gtMany2PDFX);
		if (ckBoxCloud.Checked)
		{
			ftpfile(ConfigurationManager.AppSettings["report"] + text2 + ".pdf", text2 + ".pdf");
			ftpfile(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml", text2 + " Program.xml");
		}
	}

	private void bttnReport_Click(object sender, EventArgs e)
	{
		if (cbTrack.SelectedItem == null || cbRacingDate.SelectedItem == null)
		{
			MessageBox.Show("Please, select the track and or date.");
			return;
		}
		DataSet dataSet = new DataSet();
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT track, racedt, race, poleposition, line, horse, jockey, compositescore, track_type, distance FROM kelso.process WHERE track = ? AND racedt = ?", _conn))
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand.Parameters.Add(new OleDbParameter("Track", cbTrack.SelectedItem));
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceDt", cbRacingDate.SelectedItem));
			oleDbDataAdapter.SelectCommand = oleDbCommand;
			oleDbDataAdapter.Fill(dataSet, "raceprocess");
		}
		_conn.Close();
		EnumerableRowCollection<DataRow> enumerableRowCollection = from query in dataSet.Tables["raceprocess"].AsEnumerable()
			select (query);
		string contents = createXml(enumerableRowCollection, "POLEPOSITION");
		string text = createXml(enumerableRowCollection, "COMPOSITESCORE");
		string text2 = "\\" + enumerableRowCollection.First().Field<string>("TRACK") + " " + enumerableRowCollection.First().Field<DateTime>("RACEDT").ToString("yyyyMMdd");
		if (File.Exists(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml"))
		{
			File.Delete(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml");
		}
		File.WriteAllText(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml", contents);
		if (File.Exists(ConfigurationManager.AppSettings["xml"] + text2 + " Result.xml"))
		{
			File.Delete(ConfigurationManager.AppSettings["xml"] + text2 + " Result.xml");
		}
		File.WriteAllText(ConfigurationManager.AppSettings["xml"] + text2 + " Result.xml", text);
		if (File.Exists(ConfigurationManager.AppSettings["report"] + text2 + ".html"))
		{
			File.Delete(ConfigurationManager.AppSettings["report"] + text2 + ".html");
		}
		if (File.Exists(ConfigurationManager.AppSettings["report"] + text2 + ".pdf"))
		{
			File.Delete(ConfigurationManager.AppSettings["report"] + text2 + ".pdf");
		}
		XmlDocument xmlDocument = new XmlDocument();
		xmlDocument.LoadXml(text);
		XPathNavigator input = xmlDocument.CreateNavigator();
		XslTransform xslTransform = new XslTransform();
		xslTransform.Load(ConfigurationManager.AppSettings["report"] + "\\_TheSelection.xsl");
		XmlTextWriter xmlTextWriter = new XmlTextWriter(ConfigurationManager.AppSettings["report"] + text2 + ".html", null);
		xslTransform.Transform(input, null, xmlTextWriter, null);
		xmlTextWriter.Flush();
		xmlTextWriter.Close();
		gtMany2PDFX gtMany2PDFX = (gtMany2PDFX)Activator.CreateInstance(Type.GetTypeFromCLSID(new Guid("59995656-309C-4AA3-A9EB-691988815C28")));
		gtMany2PDFX.ActivateLicense("A474CE1E-1FF3-4010-B62E-16C8BC64BA8D");
		gtMany2PDFX.InputFile = ConfigurationManager.AppSettings["report"] + text2 + ".html";
		gtMany2PDFX.DocInfoAuthor = "Phung Le";
		gtMany2PDFX.PagePaperSize = TxgtPaperSize.Letter;
		gtMany2PDFX.PageTopMargin = 0.5;
		gtMany2PDFX.PageBottomMargin = 0.5;
		gtMany2PDFX.PageLeftMargin = 0.25;
		gtMany2PDFX.PrefShowSetupDialog = false;
		gtMany2PDFX.PageOrientation = TxgtPrinterOrientation.poPortrait;
		gtMany2PDFX.PagePaperSize = TxgtPaperSize.Letter;
		gtMany2PDFX.Visible = false;
		gtMany2PDFX.OutputPDFFileName = ConfigurationManager.AppSettings["report"] + text2 + ".pdf";
		gtMany2PDFX.Visible = false;
		gtMany2PDFX.PrefOpenAfterCreate = false;
		gtMany2PDFX.RenderDocument();
		Marshal.FinalReleaseComObject(gtMany2PDFX);
		ftpfile(ConfigurationManager.AppSettings["report"] + text2 + ".pdf", text2 + ".pdf");
		ftpfile(ConfigurationManager.AppSettings["xml"] + text2 + " Program.xml", text2 + " Program.xml");
		MessageBox.Show("Report and xml done.");
	}

	private void cbTrack_SelectedIndexChanged(object sender, EventArgs e)
	{
		if (_conn.State != ConnectionState.Open)
		{
			_conn.Open();
		}
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT DISTINCT racedt FROM kelso.process WHERE track = ? ORDER BY racedt", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("track", cbTrack.SelectedItem));
			cbRacingDate.Items.Clear();
			using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
			while (oleDbDataReader.Read())
			{
				cbRacingDate.Items.Add(oleDbDataReader.GetValue(0));
			}
		}
		_conn.Close();
	}

	public void ftpfile(string inputfilepath, string filename)
	{
		string text = "ftp.fasttracktowinning.com/Staging/";
		string requestUriString = "ftp://" + text + filename;
		FtpWebRequest ftpWebRequest = (FtpWebRequest)WebRequest.Create(requestUriString);
		ftpWebRequest.Credentials = new NetworkCredential("fast1226", "Nothing789!");
		ftpWebRequest.KeepAlive = true;
		ftpWebRequest.UseBinary = true;
		ftpWebRequest.Method = "STOR";
		FileStream fileStream = File.OpenRead(inputfilepath);
		byte[] array = new byte[fileStream.Length];
		fileStream.Read(array, 0, array.Length);
		fileStream.Close();
		Stream requestStream = ftpWebRequest.GetRequestStream();
		requestStream.Write(array, 0, array.Length);
		requestStream.Close();
	}

	private void bttnAllRace_Click(object sender, EventArgs e)
	{
		dataGridView1.DataSource = null;
		dataGridView1.Refresh();
		dataGridView2.DataSource = null;
		dataGridView2.Refresh();
		_conn.Open();
		_dataSet.Clear();
		truncateTable(_conn, new string[1] { "comp" });
		loadDataFromDb(_conn);
		OrderedEnumerableRowCollection<DataRow> orderedEnumerableRowCollection = from query in _dataSet.Tables["rac"].AsEnumerable()
			orderby query.Field<int>("RaceNum")
			select query;
		_trackInfo.NumOfRace = orderedEnumerableRowCollection.Count();
		_trackInfo.TrackCode = (from track in orderedEnumerableRowCollection.AsQueryable()
			select track.Field<string>("TrackCd")).Distinct().Single();
		_trackInfo.RaceDate = (from raceDate in orderedEnumerableRowCollection.AsQueryable()
			select raceDate.Field<DateTime>("RaceDt")).Distinct().Single();
		_raceInfo = new RaceInformation[_trackInfo.NumOfRace];
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter($"SELECT * FROM kelso.timestat WHERE trackcd = '{_trackInfo.TrackCode}' ORDER BY pacelinedistance", _conn))
		{
			oleDbDataAdapter.Fill(_dataSet, "stat");
		}
		_conn.Close();
		int num = 0;
		_Idx = 0;
		foreach (DataRow item in orderedEnumerableRowCollection)
		{
			_raceInfo[num] = new RaceInformation();
			_raceInfo[num].RaceNum = item.Field<int>("RaceNum");
			_raceInfo[num].SurfaceArea = ((item.Field<int>("TurfInd") == 1) ? "T" : "D");
			_raceInfo[num].RacingType = getRacingType(item.Field<int>("TurfInd"), orderedEnumerableRowCollection.First().Field<int>("StkHandicapGrade"));
			_raceInfo[num].Age = getAge(item.Field<string>("AgeRestriction"));
			_raceInfo[num].Sex = getSex(item.Field<int>("SexRestriction"), orderedEnumerableRowCollection.First().Field<string>("AgeRestriction"));
			_raceInfo[num].AgeSex = _raceInfo[num].Age + _raceInfo[num].Sex;
			_raceInfo[num].ClaimPrize = item.Field<double>("TopClaimPrice");
			_raceInfo[num].SurfaceCondition = ((_raceInfo[num].SurfaceArea == "D") ? "dirt" : "turf");
			_raceInfo[num].Furlong = item.Field<double>("Distance") / 660.0;
			num++;
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Number of races - " + _trackInfo.NumOfRace + ".");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Track Code - " + _trackInfo.TrackCode + ".");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Race Date - " + _trackInfo.RaceDate.ToShortDateString() + ".");
			lBoxEvent.Items.Add("\n");
			dataGridView1.DataSource = null;
			dataGridView1.Refresh();
			dataGridView2.DataSource = null;
			dataGridView2.Refresh();
			_conn.Open();
			truncateTable(_conn, new string[1] { "comp" });
			_conn.Close();
			lBoxEvent.Items.Clear();
			startProcess();
			_Idx++;
			Application.DoEvents();
		}
		MessageBox.Show("Process complete.");
	}

	private void bttnSave_Click(object sender, EventArgs e)
	{
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("UPDATE kelso.process SET frank = ?,compositescore = compositescore + ? WHERE racedt = ? AND track = ? AND race = ? AND horse = ?", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("frank", double.Parse(txtBoxFrankPoint.Text)));
			oleDbCommand.Parameters.Add(new OleDbParameter("score", double.Parse(txtBoxFrankPoint.Text)));
			oleDbCommand.Parameters.Add(new OleDbParameter("racedt", DateTime.Parse(cbModRacingDt.Text)));
			oleDbCommand.Parameters.Add(new OleDbParameter("track", cbModTrack.Text));
			oleDbCommand.Parameters.Add(new OleDbParameter("race", double.Parse(cbModRaceNum.Text)));
			oleDbCommand.Parameters.Add(new OleDbParameter("horse", cbModHorseName.Text));
			oleDbCommand.ExecuteNonQuery();
			using OleDbCommand oleDbCommand2 = new OleDbCommand("SELECT * FROM kelso.process WHERE racedt = ? AND track = ? AND race = ? ORDER BY compositescore DESC", _conn);
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand2.Parameters.Add(new OleDbParameter("racedt", DateTime.Parse(cbModRacingDt.Text)));
			oleDbCommand2.Parameters.Add(new OleDbParameter("track", cbModTrack.Text));
			oleDbCommand2.Parameters.Add(new OleDbParameter("race", double.Parse(cbModRaceNum.Text)));
			oleDbDataAdapter.SelectCommand = oleDbCommand2;
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "raceprocess");
			var source = from query in dataSet.Tables["raceprocess"].AsEnumerable()
				orderby query.Field<double>("COMPOSITESCORE") descending
				select new
				{
					Line = query.Field<string>("LINE"),
					PolePosition = query.Field<string>("POLEPOSITION"),
					HorseName = query.Field<string>("HORSE"),
					CompositeScore = query.Field<double>("COMPOSITESCORE"),
					FastTrack = query.Field<double>("HANDIMAN"),
					SpeedRating = query.Field<double>("SPEEDRATING"),
					Workout = query.Field<double>("WORSCORE"),
					TrainerScore = Math.Round(query.Field<double>("TRAINERSCORE"), 2),
					Jockey = query.Field<string>("JOCKEY"),
					JockeyScore = Math.Round(query.Field<double>("JOCKEYSCORE"), 2),
					BettingLine = query.Field<double>("BETTINGLINE"),
					Closer = query.Field<double>("CLOSINGTREND"),
					HorseRanking = query.Field<double>("HORSEPLACEMENT"),
					Furlong = query.Field<double>("FURLONG"),
					Bonus = query.Field<double>("BONUS"),
					Frank = query.Field<double>("FRANK")
				};
			dataGridView1.ClearSelection();
			dataGridView1.DataSource = source.ToList();
			dataGridView1.Refresh();
			dataGridView2.DataSource = null;
			dataGridView2.Refresh();
		}
		_conn.Close();
	}

	private void cbModTrack_SelectedIndexChanged(object sender, EventArgs e)
	{
		if (_conn.State != 0)
		{
			return;
		}
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT DISTINCT racedt FROM kelso.process WHERE track = ? ORDER BY racedt", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("track", cbModTrack.Text));
			cbModRacingDt.Items.Clear();
			using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
			while (oleDbDataReader.Read())
			{
				cbModRacingDt.Items.Add(oleDbDataReader.GetValue(0));
			}
		}
		_conn.Close();
	}

	private void cbModRacingDt_SelectedIndexChanged(object sender, EventArgs e)
	{
		if (_conn.State != 0)
		{
			return;
		}
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT DISTINCT race FROM kelso.process WHERE track = ? AND racedt = ? ORDER BY race", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("track", cbModTrack.Text));
			oleDbCommand.Parameters.Add(new OleDbParameter("racedt", DateTime.Parse(cbModRacingDt.Text)));
			cbModRaceNum.Items.Clear();
			using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
			while (oleDbDataReader.Read())
			{
				cbModRaceNum.Items.Add(oleDbDataReader.GetValue(0));
			}
		}
		_conn.Close();
	}

	private void cbModRaceNum_SelectedIndexChanged(object sender, EventArgs e)
	{
		if (_conn.State != 0)
		{
			return;
		}
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT DISTINCT horse FROM kelso.process WHERE track = ? AND racedt = ? and race = ? ORDER BY horse", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("track", cbModTrack.Text));
			oleDbCommand.Parameters.Add(new OleDbParameter("racedt", DateTime.Parse(cbModRacingDt.Text)));
			oleDbCommand.Parameters.Add(new OleDbParameter("race", double.Parse(cbModRaceNum.Text)));
			cbModHorseName.Items.Clear();
			using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
			while (oleDbDataReader.Read())
			{
				cbModHorseName.Items.Add(oleDbDataReader.GetValue(0));
			}
		}
		using (OleDbCommand oleDbCommand2 = new OleDbCommand("SELECT * FROM kelso.process WHERE racedt = ? AND track = ? AND race = ? ORDER BY compositescore DESC", _conn))
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand2.Parameters.Add(new OleDbParameter("racedt", DateTime.Parse(cbModRacingDt.Text)));
			oleDbCommand2.Parameters.Add(new OleDbParameter("track", cbModTrack.Text));
			oleDbCommand2.Parameters.Add(new OleDbParameter("race", double.Parse(cbModRaceNum.Text)));
			oleDbDataAdapter.SelectCommand = oleDbCommand2;
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "raceprocess");
			var source = from query in dataSet.Tables["raceprocess"].AsEnumerable()
				orderby query.Field<double>("COMPOSITESCORE") descending
				select new
				{
					Line = query.Field<string>("LINE"),
					PolePosition = query.Field<string>("POLEPOSITION"),
					HorseName = query.Field<string>("HORSE"),
					CompositeScore = query.Field<double>("COMPOSITESCORE"),
					FastTrack = query.Field<double>("HANDIMAN"),
					SpeedRating = query.Field<double>("SPEEDRATING"),
					Workout = query.Field<double>("WORSCORE"),
					TrainerScore = Math.Round(query.Field<double>("TRAINERSCORE"), 2),
					Jockey = query.Field<string>("JOCKEY"),
					JockeyScore = Math.Round(query.Field<double>("JOCKEYSCORE"), 2),
					BettingLine = query.Field<double>("BETTINGLINE"),
					Closer = query.Field<double>("CLOSINGTREND"),
					HorseRanking = query.Field<double>("HORSEPLACEMENT"),
					Furlong = query.Field<double>("FURLONG"),
					Bonus = query.Field<double>("BONUS"),
					Frank = (query.IsNull("FRANK") ? 0.0 : query.Field<double>("FRANK"))
				};
			dataGridView1.ClearSelection();
			dataGridView1.DataSource = source.ToList();
			dataGridView1.Refresh();
			dataGridView2.DataSource = null;
			dataGridView2.Refresh();
		}
		_conn.Close();
	}

	private void fileSystemWatcher1_Changed(object sender, FileSystemEventArgs e)
	{
		MessageBox.Show("new file.");
	}

	private void lBoxEvent_ControlAdded(object sender, ControlEventArgs e)
	{
	}

	private void bttnBeginPolling_Click(object sender, EventArgs e)
	{
		_bPolling = true;
		polling();
	}

	private void bttnEndPolling_Click(object sender, EventArgs e)
	{
	}

	private void polling()
	{
		DirectoryInfo directoryInfo = new DirectoryInfo(ConfigurationManager.AppSettings["polling"]);
		FileInfo[] files = directoryInfo.GetFiles("*.c*");
		lBoxFiles.Items.Clear();
		FileInfo[] array = files;
		foreach (FileInfo fileInfo in array)
		{
			lBoxFiles.Items.Add(fileInfo.Name.Replace(fileInfo.Extension, string.Empty));
			Application.DoEvents();
		}
		while (lBoxFiles.Items.Count > 0)
		{
			_dataSet.Clear();
			if (_trackInfo != null)
			{
				_trackInfo = null;
			}
			_trackInfo = new TrackInformation();
			lBoxEvent.Items.Clear();
			_conn.Open();
			string fileName = (string)lBoxFiles.Items[0];
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Files located at " + ConfigurationManager.AppSettings["polling"]);
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Deleting data from rac, ent, and hor tables");
			truncateTable(_conn, new string[5] { "rac", "ent", "hor", "wor", "comp" });
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Deletion completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to rac.");
			loadToTable(_conn, "rac", fileName, "r", new string[1] { "RaceDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of rac completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to ent.");
			loadToTable(_conn, "ent", fileName, "e", new string[1] { "RaceDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of ent completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to hor.");
			loadToTable(_conn, "hor", fileName, "h", new string[2] { "RaceDt", "PaceLineDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of hor completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to wor.");
			loadToTable(_conn, "wor", fileName, "w", new string[2] { "RaceDt", "WorkOutDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of wor completed.");
			_conn.Close();
			Application.DoEvents();
			dataGridView1.DataSource = null;
			dataGridView1.Refresh();
			dataGridView2.DataSource = null;
			dataGridView2.Refresh();
			_conn.Open();
			_dataSet.Clear();
			truncateTable(_conn, new string[1] { "comp" });
			loadDataFromDb(_conn);
			OrderedEnumerableRowCollection<DataRow> orderedEnumerableRowCollection = from query in _dataSet.Tables["rac"].AsEnumerable()
				orderby query.Field<int>("RaceNum")
				select query;
			_trackInfo.NumOfRace = orderedEnumerableRowCollection.Count();
			_trackInfo.TrackCode = (from track in orderedEnumerableRowCollection.AsQueryable()
				select track.Field<string>("TrackCd")).Distinct().Single();
			_trackInfo.RaceDate = (from raceDate in orderedEnumerableRowCollection.AsQueryable()
				select raceDate.Field<DateTime>("RaceDt")).Distinct().Single();
			string track2 = (from trackname in orderedEnumerableRowCollection.AsQueryable()
				select trackname.Field<string>("TrackName")).Distinct().Single();
			_raceInfo = new RaceInformation[_trackInfo.NumOfRace];
			using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter($"SELECT * FROM kelso.timestat WHERE trackcd = '{_trackInfo.TrackCode}' ORDER BY pacelinedistance", _conn))
			{
				oleDbDataAdapter.Fill(_dataSet, "stat");
			}
			_conn.Close();
			int num = 0;
			_Idx = 0;
			foreach (DataRow item in orderedEnumerableRowCollection)
			{
				_raceInfo[num] = new RaceInformation();
				_raceInfo[num].RaceNum = item.Field<int>("RaceNum");
				_raceInfo[num].SurfaceArea = ((item.Field<int>("TurfInd") == 1) ? "T" : "D");
				_raceInfo[num].RacingType = getRacingType(item.Field<int>("TurfInd"), orderedEnumerableRowCollection.First().Field<int>("StkHandicapGrade"));
				_raceInfo[num].Age = getAge(item.Field<string>("AgeRestriction"));
				_raceInfo[num].Sex = getSex(item.Field<int>("SexRestriction"), orderedEnumerableRowCollection.First().Field<string>("AgeRestriction"));
				_raceInfo[num].AgeSex = _raceInfo[num].Age + _raceInfo[num].Sex;
				_raceInfo[num].ClaimPrize = item.Field<double>("TopClaimPrice");
				_raceInfo[num].SurfaceCondition = ((_raceInfo[num].SurfaceArea == "D") ? "dirt" : "turf");
				_raceInfo[num].Furlong = item.Field<double>("Distance") / 660.0;
				num++;
				lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Number of races - " + _trackInfo.NumOfRace + ".");
				lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Track Code - " + _trackInfo.TrackCode + ".");
				lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Race Date - " + _trackInfo.RaceDate.ToShortDateString() + ".");
				lBoxEvent.Items.Add("\n");
				dataGridView1.DataSource = null;
				dataGridView1.Refresh();
				dataGridView2.DataSource = null;
				dataGridView2.Refresh();
				_conn.Open();
				truncateTable(_conn, new string[1] { "comp" });
				_conn.Close();
				lBoxEvent.Items.Clear();
				startProcess();
				createReport(track2, _trackInfo.RaceDate);
				_Idx++;
				Application.DoEvents();
			}
			DirectoryInfo directoryInfo2 = new DirectoryInfo(ConfigurationManager.AppSettings["polling"]);
			array = directoryInfo2.GetFiles((string)lBoxFiles.Items[0] + "*.*");
			foreach (FileInfo fileInfo in array)
			{
				fileInfo.Delete();
			}
			lBoxFiles.Items.RemoveAt(0);
			Application.DoEvents();
		}
	}

	private void button1_Click(object sender, EventArgs e)
	{
		_conn.Open();
		loadDataFromDb(_conn);
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter($"SELECT * FROM kelso.timestat WHERE trackcd in (SELECT DISTINCT pacelinetrackcd FROM kelso.hor) ORDER BY pacelinedistance", _conn))
		{
			if (_dataSet.Tables["stat"] != null)
			{
				_dataSet.Tables["stat"].Dispose();
			}
			oleDbDataAdapter.Fill(_dataSet, "stat");
		}
		_conn.Close();
		EnumerableRowCollection<DataRow> enumerableRowCollection = from query in _dataSet.Tables["rac"].AsEnumerable()
			select (query);
		foreach (DataRow dataRow in enumerableRowCollection)
		{
			EnumerableRowCollection<DataRow> source = _dataSet.Tables["ent"].AsEnumerable();
			Func<DataRow, bool> predicate = (DataRow query) => query.Field<int>("RaceNum") == dataRow.Field<int>("RaceNum");
			EnumerableRowCollection<DataRow> enumerableRowCollection2 = source.Where(predicate);
			HorseComparison[] comparisons = new HorseComparison[enumerableRowCollection2.Count()];
			int iIdx = 0;
			double speed = 0.0;
			double time = 0.0;
			foreach (DataRow row in enumerableRowCollection2)
			{
				EnumerableRowCollection<DataRow> source2 = _dataSet.Tables["hor"].AsEnumerable();
				Func<DataRow, bool> predicate2 = (DataRow query) => query.Field<int>("RaceNum") == dataRow.Field<int>("RaceNum") && query.Field<string>("HorseName").Equals(row.Field<string>("HorseName"), StringComparison.OrdinalIgnoreCase) && query.Field<DateTime>("PaceLineDt") >= query.Field<DateTime>("RaceDt").AddMonths(-6);
				OrderedEnumerableRowCollection<DataRow> orderedEnumerableRowCollection = from query in source2.Where(predicate2)
					orderby query.Field<DateTime>("PaceLineDt") descending
					select query;
				comparisons[iIdx] = new HorseComparison();
				comparisons[iIdx].PolePosition = row.Field<string>("PolePosition");
				comparisons[iIdx].Distance = dataRow.Field<double>("Distance");
				if (orderedEnumerableRowCollection.Where((DataRow para) => para.Field<double>("PaceLineDistance") == comparisons[iIdx].Distance).Any())
				{
				}
				if (orderedEnumerableRowCollection.Any())
				{
					double[] array = new double[9]
					{
						comparisons[iIdx].Distance,
						comparisons[iIdx].Distance - 330.0,
						comparisons[iIdx].Distance + 330.0,
						comparisons[iIdx].Distance - 660.0,
						comparisons[iIdx].Distance + 660.0,
						comparisons[iIdx].Distance - 990.0,
						comparisons[iIdx].Distance + 990.0,
						comparisons[iIdx].Distance - 1320.0,
						comparisons[iIdx].Distance + 1320.0
					};
					for (int i = 0; i < array.Count(); i++)
					{
						AnalyzeHorsePastPerformance(orderedEnumerableRowCollection, dataRow.Field<string>("TrackCd"), dataRow.Field<int>("TurfInd"), array[i], comparisons[iIdx], ref speed, ref time);
						if (comparisons[iIdx].NumOfComparable >= 2)
						{
							break;
						}
					}
					if (comparisons[iIdx].FinishTime == 0.0)
					{
						AnalysisOfDifferentRaceTrack(orderedEnumerableRowCollection, array, dataRow.Field<string>("TrackCd"), dataRow.Field<int>("TurfInd"), comparisons[iIdx], speed, time);
					}
					int num = 0;
				}
				iIdx++;
			}
		}
	}

	private double calcTrueFinishTime(double finish, double finalBeatenLength)
	{
		return finish + finalBeatenLength / 5.0;
	}

	private double calcSpeedRating(double originalTime, double time, double speed)
	{
		if (originalTime < time)
		{
			return speed - Math.Abs(originalTime - time) / 0.2;
		}
		if (originalTime > time)
		{
			return speed + Math.Abs(time - originalTime) / 0.2;
		}
		return speed;
	}

	private void addJockeyAnalysis(string current, string past, int start, double percentage, string lifetime, HorseComparison horse)
	{
		string value = Regex.Match(lifetime, "\\.[0-9]+").Value;
		if (!horse.FirstTimer)
		{
			if (current.Equals(past))
			{
				horse.BetterJockey = true;
			}
			else if (double.Parse(value) >= 0.15 || percentage >= 0.15)
			{
				horse.BetterJockey = true;
			}
		}
		if (start >= int.Parse(txtBoxMinNumOfRaces.Text))
		{
			horse.JockeyPercentage = percentage;
		}
		else
		{
			horse.JockeyPercentage = double.Parse(value);
		}
	}

	private void AnalyzeHorsePastPerformance(IEnumerable<DataRow> history, string track, int turfInd, double distance, HorseComparison comparison, ref double speed, ref double time)
	{
		double num = (comparison.Distance - distance) / 330.0;
		IEnumerable<DataRow> enumerable = history.Where((DataRow query) => query.Field<string>("PaceLineTrackCd").Equals(track, StringComparison.OrdinalIgnoreCase) && query.Field<int>("TurfInd") == turfInd && query.Field<double>("PaceLineDistance") == distance);
		if (!enumerable.Any())
		{
			return;
		}
		Dictionary<DateTime, double> dictionary = new Dictionary<DateTime, double>();
		Dictionary<DateTime, double> dictionary2 = new Dictionary<DateTime, double>();
		foreach (DataRow item in enumerable)
		{
			double[] array = new double[4]
			{
				item.Field<double>("FirstCallTime"),
				item.Field<double>("SecondCallTime"),
				item.Field<double>("FinalTime"),
				item.Field<double>("AdditionalFractionalTime")
			};
			Array.Sort(array);
			dictionary2.Add(item.Field<DateTime>("PaceLineDt"), calcTrueFinishTime(array[3] + num * 6.3, item.Field<double>("FinalBeatenLengths")));
			dictionary.Add(item.Field<DateTime>("PaceLineDt"), item.Field<double>("SpeedRating"));
		}
		if (dictionary2.Count() > 1)
		{
			double dStandardDeviation = standardDeviation(dictionary2.Values.ToArray());
			double dAverage = dictionary2.Values.ToArray().Average();
			IEnumerable<KeyValuePair<DateTime, double>> enumerable2 = dictionary2.Where((KeyValuePair<DateTime, double> query) => Math.Abs(query.Value - dAverage) > dStandardDeviation * 3.0);
			foreach (KeyValuePair<DateTime, double> item2 in enumerable2)
			{
				if (dictionary.ContainsKey(item2.Key))
				{
					dictionary.Remove(item2.Key);
				}
				if (dictionary2.ContainsKey(item2.Key))
				{
					dictionary2.Remove(item2.Key);
				}
			}
			comparison.NumOfComparable += dictionary2.Count;
			if (speed == 0.0)
			{
				speed = dictionary.Select((KeyValuePair<DateTime, double> para) => para.Value).Max();
				foreach (KeyValuePair<DateTime, double> item3 in dictionary)
				{
					if (item3.Value == speed)
					{
						time = dictionary2[item3.Key];
						break;
					}
				}
			}
			if (comparison.FinishTime == 0.0)
			{
				comparison.FinishTime = dictionary2.Select((KeyValuePair<DateTime, double> para) => para.Value).Average();
			}
			else
			{
				comparison.FinishTime = (dictionary2.Select((KeyValuePair<DateTime, double> para) => para.Value).Average() + comparison.FinishTime) / 2.0;
			}
			comparison.SpeedRating = dictionary.Select((KeyValuePair<DateTime, double> para) => para.Value).Average();
		}
		else
		{
			if (comparison.FinishTime == 0.0)
			{
				comparison.FinishTime = dictionary2.First().Value;
			}
			else
			{
				comparison.FinishTime = (dictionary2.First().Value + comparison.FinishTime) / 2.0;
			}
			if (speed == 0.0)
			{
				speed = dictionary.First().Value;
				time = dictionary2.First().Value;
			}
			comparison.SpeedRating = dictionary.First().Value;
			comparison.NumOfComparable++;
		}
	}

	private void AnalysisOfDifferentRaceTrack(IEnumerable<DataRow> history, double[] distance, string originalTrack, int turfInd, HorseComparison comparison, double speed, double time)
	{
		string[] array = (from para in history
			where para.Field<string>("PaceLineTrackCd") != originalTrack
			select para.Field<string>("PaceLineTrackCd")).Distinct().ToArray();
		string[] array2 = array;
		foreach (string track in array2)
		{
			int i;
			for (i = 0; i < distance.Count(); i++)
			{
				double num = (comparison.Distance - distance[i]) / 330.0;
				IEnumerable<DataRow> enumerable = history.Where((DataRow query) => query.Field<string>("PaceLineTrackCd").Equals(track, StringComparison.OrdinalIgnoreCase) && query.Field<int>("TurfInd") == turfInd && query.Field<double>("PaceLineDistance") == distance[i]);
				if (!enumerable.Any())
				{
					continue;
				}
				EnumerableRowCollection<DataRow> source = from query in _dataSet.Tables["stat"].AsEnumerable()
					where (query.Field<string>("TrackCd") == track || query.Field<string>("TrackCd") == originalTrack) && query.Field<string>("Condition") == ((turfInd == 1) ? "turf" : "dirt") && query.Field<double>("PaceLineDistance") == distance[i] / 660.0
					select query;
				double num2 = (from para in source
					where para.Field<string>("TrackCd") == originalTrack
					select para.Field<double>("AvgFinal")).First() - (from para in source
					where para.Field<string>("TrackCd") == track
					select para.Field<double>("AvgFinal")).First();
				Dictionary<DateTime, double> dictionary = new Dictionary<DateTime, double>();
				foreach (DataRow item in enumerable)
				{
					double[] array3 = new double[4]
					{
						item.Field<double>("FirstCallTime"),
						item.Field<double>("SecondCallTime"),
						item.Field<double>("FinalTime"),
						item.Field<double>("AdditionalFractionalTime")
					};
					Array.Sort(array3);
					array3[3] -= num2;
					dictionary.Add(item.Field<DateTime>("PaceLineDt"), calcTrueFinishTime(array3[3] + num * 6.3, item.Field<double>("FinalBeatenLengths")));
				}
				if (dictionary.Count() > 1)
				{
					double dStandardDeviation = standardDeviation(dictionary.Values.ToArray());
					double dAverage = dictionary.Values.ToArray().Average();
					IEnumerable<KeyValuePair<DateTime, double>> enumerable2 = dictionary.Where((KeyValuePair<DateTime, double> query) => Math.Abs(query.Value - dAverage) > dStandardDeviation * 3.0);
					foreach (KeyValuePair<DateTime, double> item2 in enumerable2)
					{
						if (dictionary.ContainsKey(item2.Key))
						{
							dictionary.Remove(item2.Key);
						}
					}
					comparison.NumOfComparable += dictionary.Count;
					if (comparison.FinishTime == 0.0)
					{
						comparison.FinishTime = dictionary.Select((KeyValuePair<DateTime, double> para) => para.Value).Average();
					}
					else
					{
						comparison.FinishTime = (dictionary.Select((KeyValuePair<DateTime, double> para) => para.Value).Average() + comparison.FinishTime) / 2.0;
					}
				}
				else
				{
					if (comparison.FinishTime == 0.0)
					{
						comparison.FinishTime = dictionary.First().Value;
					}
					else
					{
						comparison.FinishTime = (dictionary.First().Value + comparison.FinishTime) / 2.0;
					}
					comparison.NumOfComparable++;
				}
			}
		}
	}

	private void workout(int num, string name, HorseComparison horse)
	{
		_conn.Open();
		DataSet dataSet = new DataSet();
		using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT * FROM kelso.wor WHERE RaceNum = ? AND UPPER(HorseName) = ? AND WorkOutTotalNum >= 10 ORDER BY WorkOutDt", _conn))
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceNum", num));
			oleDbCommand.Parameters.Add(new OleDbParameter("HorseName", name.ToUpper()));
			oleDbDataAdapter.SelectCommand = oleDbCommand;
			oleDbDataAdapter.Fill(dataSet, "wor");
		}
		_conn.Close();
		var source = from query in dataSet.Tables["wor"].AsEnumerable()
			select new
			{
				Percentage = 1.0 - (double)query.Field<short>("WorkOutRank") / (double)query.Field<short>("WorkOutTotalNum")
			};
		List<double> list = (from para in source
			orderby para.Percentage descending
			select para.Percentage).ToList();
		if (list.Count > 3)
		{
			list.RemoveRange(3, list.Count - 3);
		}
		if (list.Count > 0)
		{
			if (horse.FirstTimer)
			{
				horse.WorkoutScore = list.Average() * double.Parse(txtBoxEq0Workout.Text);
			}
			else
			{
				horse.WorkoutScore = list.Average() * double.Parse(txtBoxWorkout.Text);
			}
		}
	}

	private void button2_Click(object sender, EventArgs e)
	{
		double[] array = new double[15]
		{
			4.8, 4.8, 4.5, 3.9, 4.4, 3.6, 3.6, 2.9, 3.5, 3.0,
			2.5, 2.2, 2.6, 2.1, 2.2
		};
		double num = 0.0;
		double num2 = 0.0;
		for (int i = 0; i < array.Length; i++)
		{
			num += (double)i;
			num2 += array[i];
		}
		num /= (double)array.Length;
		num2 /= (double)array.Length;
		double num3 = 0.0;
		double num4 = 0.0;
		for (int i = 0; i < array.Length; i++)
		{
			num3 += ((double)i - num) * (array[i] - num2);
			num4 += Math.Pow((double)i - num, 2.0);
		}
		double num5 = num3 / num4;
		double value = num2 - num5 * num;
		Console.WriteLine("y = ax + b");
		Console.WriteLine("a = {0}, the slope of the trend line.", Math.Round(num5, 2));
		Console.WriteLine("b = {0}, the intercept of the trend line.", Math.Round(value, 2));
		Console.ReadLine();
	}

	private void analyzeRace(DataRow row)
	{
	}

	private void button4_Click(object sender, EventArgs e)
	{
		DirectoryInfo directoryInfo = new DirectoryInfo(ConfigurationManager.AppSettings["polling"]);
		FileInfo[] files = directoryInfo.GetFiles("*.c*");
		lBoxFiles.Items.Clear();
		FileInfo[] array = files;
		foreach (FileInfo fileInfo in array)
		{
			lBoxFiles.Items.Add(fileInfo.Name.Replace(fileInfo.Extension, string.Empty));
			Application.DoEvents();
		}
		while (lBoxFiles.Items.Count > 0)
		{
			_dataSet.Clear();
			lBoxEvent.Items.Clear();
			_conn.Open();
			string fileName = (string)lBoxFiles.Items[0];
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Files located at " + ConfigurationManager.AppSettings["polling"]);
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Deleting data from rac, ent, and hor tables");
			truncateTable(_conn, new string[5] { "rac", "ent", "hor", "wor", "comp" });
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Deletion completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to rac.");
			loadToTable(_conn, "rac", fileName, "r", new string[1] { "RaceDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of rac completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to ent.");
			loadToTable(_conn, "ent", fileName, "e", new string[1] { "RaceDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of ent completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to hor.");
			loadToTable(_conn, "hor", fileName, "h", new string[2] { "RaceDt", "PaceLineDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of hor completed.");
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import data to wor.");
			loadToTable(_conn, "wor", fileName, "w", new string[2] { "RaceDt", "WorkOutDt" }, polling: true);
			Application.DoEvents();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Import of wor completed.");
			updateTime_StatTable();
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Start Processing");
			loadDataFromDb(_conn);
			using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter($"SELECT * FROM kelso.vTrackTimeStatFilter ORDER BY trackcd, distance", _conn))
			{
				if (_dataSet.Tables["stat"] != null)
				{
					_dataSet.Tables["stat"].Dispose();
				}
				oleDbDataAdapter.Fill(_dataSet, "stat");
			}
			_conn.Close();
			EnumerableRowCollection<DataRow> enumerableRowCollection = from query in _dataSet.Tables["rac"].AsEnumerable()
				select (query);
			foreach (DataRow race in enumerableRowCollection)
			{
				EnumerableRowCollection<DataRow> source = _dataSet.Tables["ent"].AsEnumerable();
				Func<DataRow, bool> predicate = (DataRow query) => query.Field<int>("RaceNum") == race.Field<int>("RaceNum") && !string.IsNullOrEmpty(query.Field<string>("MorningLine"));
				EnumerableRowCollection<DataRow> race2 = source.Where(predicate);
				lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Processing Race: " + race.Field<int>("RaceNum"));
				analyzeRace(race, race2, race.Field<int>("RaceNum"), race.Field<string>("TrackCd"), race.Field<double>("Distance"), race.Field<int>("TurfInd"), race.Field<double>("RacePurse"));
				Application.DoEvents();
			}
			createReport(enumerableRowCollection.First().Field<string>("TrackName"), enumerableRowCollection.First().Field<DateTime>("RaceDt"));
			DirectoryInfo directoryInfo2 = new DirectoryInfo(ConfigurationManager.AppSettings["polling"]);
			array = directoryInfo2.GetFiles((string)lBoxFiles.Items[0] + "*.*");
			foreach (FileInfo fileInfo in array)
			{
				fileInfo.Delete();
			}
			lBoxFiles.Items.RemoveAt(0);
			Application.DoEvents();
		}
		MessageBox.Show("Completed.");
	}

	private void analyzeRace(DataRow rac, IEnumerable<DataRow> race, int num, string track, double distance, int turf, double purse)
	{
		HorseComparison[] array = new HorseComparison[race.Count()];
		int num2 = 0;
		foreach (DataRow item in race)
		{
			array[num2] = new HorseComparison();
			array[num2].PolePosition = item.Field<string>("PolePosition");
			array[num2].HorseName = item.Field<string>("HorseName");
			if (!string.IsNullOrEmpty(item.Field<string>("MorningLine")))
			{
				if (item.Field<string>("MorningLine").Equals("even", StringComparison.OrdinalIgnoreCase))
				{
					array[num2].Line = "1/1";
				}
				else
				{
					array[num2].Line = item.Field<string>("MorningLine").Replace("-", "/");
				}
			}
			array[num2].Jockey = item.Field<string>("JockeyName");
			if (item.Field<int>("TrainerStarts") >= int.Parse(txtBoxMinNumOfRaces.Text))
			{
				array[num2].TrainerPercentage = item.Field<double>("TrainerPercentage");
			}
			else
			{
				array[num2].TrainerPercentage = double.Parse(Regex.Match(item.Field<string>("TrainerStatsYTD"), "\\.[0-9]+").Value);
			}
			analyzeHorse(array[num2], item.Field<string>("HorseName"), num, track, distance, turf);
			Console.WriteLine("Horse: " + array[num2].HorseName);
			Console.WriteLine("Time: " + array[num2].FinishTime);
			if (!array[num2].FirstTimer && array[num2].FinishTime != 0.0)
			{
				EnumerableRowCollection<DataRow> source = from query in _dataSet.Tables["stat"].AsEnumerable()
					where query.Field<string>("TrackCd").Equals(track, StringComparison.OrdinalIgnoreCase) && query.Field<double>("Distance") == distance && query.Field<int>("TurfInd") == turf
					select query;
				array[num2].Percentile = (1.0 - NormalDistribution.DistributionFunction(array[num2].FinishTime, source.First().Field<double>("Mean"), source.First().Field<double>("Deviation"))) * 100.0;
				array[num2].FastTrack += Math.Round(array[num2].Percentile, 3);
				if (array[num2].HasRaceDistance)
				{
					array[num2].FastTrack += 2.0;
				}
				if (array[num2].BetterJockey)
				{
					array[num2].FastTrack += 3.0;
				}
				if (array[num2].LastRacePurse < purse)
				{
					array[num2].ClaimPriceTrend = 0.0 - double.Parse(txtBoxClaimPrice.Text);
				}
				else if (array[num2].LastRacePurse > purse)
				{
					array[num2].ClaimPriceTrend = double.Parse(txtBoxClaimPrice.Text);
				}
			}
			workout(num, array[num2].HorseName, array[num2]);
			addJockeyAnalysis(item.Field<string>("JockeyName"), array[num2].FormerJockey, item.Field<int>("JockeyStarts"), item.Field<double>("JockeyPercentage"), item.Field<string>("JockeyStatsYTD"), array[num2]);
			getLine(array[num2]);
			num2++;
		}
		computeJockeyAndTrainerScore(array);
		insertIntoRaceProcess(array, rac.Field<DateTime>("RaceDt"), rac.Field<string>("TrackName"), num, distance, turf, rac.Field<string>("TrackCd"));
	}

	private void getLine(HorseComparison horse)
	{
		if (string.IsNullOrEmpty(horse.Line))
		{
			return;
		}
		if (horse.Line.Equals("EVEN", StringComparison.OrdinalIgnoreCase))
		{
			horse.BettingLine = (horse.FirstTimer ? double.Parse(txtBoxEq0BettingLine.Text) : double.Parse(txtBoxBettingLine.Text));
			return;
		}
		double line = double.Parse(horse.Line.Split('/')[0]);
		double line2 = double.Parse(horse.Line.Split('/')[1]);
		horse.BettingLine = calcBettingLine(line, line2);
		if (horse.FirstTimer)
		{
			horse.BettingLine = horse.BettingLine / 35.0 * double.Parse(txtBoxEq0BettingLine.Text);
		}
		else
		{
			horse.BettingLine = horse.BettingLine / 35.0 * double.Parse(txtBoxBettingLine.Text);
		}
	}

	private void insertIntoRaceProcess(HorseComparison[] horses, DateTime date, string track, int num, double distance, int turf, string code)
	{
		_conn.Open();
		using (OleDbCommand oleDbCommand = new OleDbCommand("DELETE FROM kelso.process WHERE racedt = ? AND track = ? AND race = ?", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("racedt", date));
			oleDbCommand.Parameters.Add(new OleDbParameter("track", track));
			oleDbCommand.Parameters.Add(new OleDbParameter("race", num));
			oleDbCommand.ExecuteNonQuery();
		}
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT racedt, track, race, poleposition, line, horse, jockey, compositescore, handiman, speedrating, worscore, trainerscore, jockeyscore, bettingline, closingtrend, furlong, horseplacement, bonus, frank, track_type, distance, trackcd, place FROM kelso.process WHERE race = 999", _conn))
		{
			OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "raceprocess");
			dataSet.Tables["raceprocess"].Rows.Clear();
			double num2 = horses.Max((HorseComparison para) => para.FastTrack);
			string strFavorite = string.Empty;
			try
			{
				IOrderedEnumerable<HorseComparison> source = horses.OrderBy((HorseComparison query) => double.Parse(query.Line.Split('/')[0]) / double.Parse(query.Line.Split('/')[1]));
				strFavorite = source.First().HorseName;
			}
			catch
			{
			}
			double num3 = 0.0;
			foreach (HorseComparison horseComparison in horses)
			{
				if (!horseComparison.FirstTimer && horseComparison.FastTrack > 0.0)
				{
					horseComparison.FastTrack = horseComparison.FastTrack / num2 * double.Parse(txtBoxHandimanPercent.Text);
				}
				horseComparison.CompositeScore = Math.Round(horseComparison.FastTrack + horseComparison.ClaimPriceTrend + horseComparison.BettingLine + horseComparison.Closer + horseComparison.JockeyScore + horseComparison.TrainerScore + horseComparison.WorkoutScore, 2);
				if (horseComparison.HorseName == strFavorite)
				{
					horseComparison.Favorite = true;
					num3 = horseComparison.CompositeScore;
				}
			}
			IOrderedEnumerable<HorseComparison> orderedEnumerable = horses.OrderByDescending((HorseComparison query) => query.CompositeScore);
			int num4 = 1;
			foreach (HorseComparison item in orderedEnumerable)
			{
				dataSet.Tables["raceprocess"].Rows.Add(date, track, num, item.PolePosition, item.Line, item.HorseName, item.Jockey, item.CompositeScore, item.FastTrack, 0.0, item.WorkoutScore, item.TrainerScore, item.JockeyScore, item.BettingLine, item.Closer, 0.0, 0.0, 0.0, 0.0, (turf == 1) ? "turf" : "dirt", Math.Round(distance / 660.0, 2), code, num4);
				num4++;
			}
			EnumerableRowCollection<DataRow> source2 = from query in dataSet.Tables["raceprocess"].AsEnumerable()
				where query.Field<string>("horse") == strFavorite && query.Field<int>("place") > int.Parse(txtBoxFavorite.Text)
				select query;
			if (source2.Count() > 0)
			{
				EnumerableRowCollection<DataRow> source3 = from query in dataSet.Tables["raceprocess"].AsEnumerable()
					where query.Field<int>("place") == 3
					select query;
				double num5 = source3.First().Field<double>("compositescore") - num3;
				foreach (DataRow row in dataSet.Tables["raceprocess"].Rows)
				{
					if (row.Field<string>("horse") == strFavorite)
					{
						row.SetField("bonus", num5 + 0.01);
						row.SetField("compositescore", num3 + (num5 + 0.01));
						break;
					}
				}
			}
			oleDbDataAdapter.InsertCommand = oleDbCommandBuilder.GetInsertCommand();
			oleDbDataAdapter.Update(dataSet, "raceprocess");
			dataSet.Dispose();
		}
		_conn.Close();
	}

	private void computeJockeyAndTrainerScore(HorseComparison[] horses)
	{
		IOrderedEnumerable<HorseComparison> orderedEnumerable = horses.OrderByDescending((HorseComparison query) => query.TrainerPercentage);
		double num = double.Parse(txtBoxTrainer.Text) / (double)orderedEnumerable.Count();
		double num2 = double.Parse(txtBoxEq0Trainer.Text) / (double)orderedEnumerable.Count();
		int num3 = orderedEnumerable.Count() - 1;
		foreach (HorseComparison item in orderedEnumerable)
		{
			item.TrainerScore = (item.FirstTimer ? ((double)num3 * num) : ((double)num3 * num2));
			num3--;
		}
		IOrderedEnumerable<HorseComparison> orderedEnumerable2 = horses.OrderByDescending((HorseComparison query) => query.JockeyPercentage);
		double num4 = double.Parse(txtBoxTrainer.Text) / (double)orderedEnumerable2.Count();
		double num5 = double.Parse(txtBoxEq0Trainer.Text) / (double)orderedEnumerable2.Count();
		num3 = orderedEnumerable2.Count() - 1;
		foreach (HorseComparison item2 in orderedEnumerable2)
		{
			item2.JockeyScore = (item2.FirstTimer ? ((double)num3 * num4) : ((double)num3 * num5));
			num3--;
		}
	}

	private double calcDiffTrackTime(string track, string otherTrack, double distance, int turf)
	{
		EnumerableRowCollection<DataRow> source = from query in _dataSet.Tables["stat"].AsEnumerable()
			where (query.Field<string>("TrackCd").Equals(track, StringComparison.OrdinalIgnoreCase) || query.Field<string>("TrackCd").Equals(otherTrack, StringComparison.OrdinalIgnoreCase)) && query.Field<double>("Distance") == distance && query.Field<int>("TurfInd") == turf
			select query;
		double num = (from para in source
			where para.Field<string>("TrackCd").Equals(track, StringComparison.OrdinalIgnoreCase)
			select para.Field<double>("Mean")).SingleOrDefault();
		double num2 = (from para in source
			where para.Field<string>("TrackCd").Equals(otherTrack, StringComparison.OrdinalIgnoreCase)
			select para.Field<double>("Mean")).SingleOrDefault();
		if (num2 == 0.0)
		{
			return 0.0;
		}
		return num - num2;
	}

	private void bttnLoadAdjustment_Click(object sender, EventArgs e)
	{
		try
		{
			if (_conn.State != ConnectionState.Open)
			{
				_conn.Open();
			}
			using OleDbCommand oleDbCommand = new OleDbCommand("SELECT * FROM kelso.adjustment WHERE id = " + cbBoxProfile.Text, _conn);
			using OleDbDataReader oleDbDataReader = oleDbCommand.ExecuteReader();
			object[] array = new object[oleDbDataReader.FieldCount];
			oleDbDataReader.Read();
			oleDbDataReader.GetValues(array);
			txtBoxBeyerPerformance.Text = array[1].ToString();
			txtBoxBeyerDistance.Text = array[2].ToString();
			txtBoxModifiedBeyerSpeed.Text = array[3].ToString();
			txtBoxHandimanPerformance.Text = array[4].ToString();
			txtBoxMaxDatePerformance.Text = array[5].ToString();
			txtBoxHandimanPercent.Text = array[6].ToString();
			txtBoxWorkout.Text = array[7].ToString();
			txtBoxJockey.Text = array[8].ToString();
			txtBoxTrainer.Text = array[9].ToString();
			txtBoxEq0Workout.Text = array[10].ToString();
			txtBoxEq0Jockey.Text = array[11].ToString();
			txtBoxEq0Trainer.Text = array[12].ToString();
			txtBoxMaxWorkoutDays.Text = array[13].ToString();
			txtBoxBettingLine.Text = array[14].ToString();
			txtBoxClaimPrice.Text = array[15].ToString();
			txtBoxEq0BettingLine.Text = array[16].ToString();
			txtBoxEq0ClaimPrice.Text = array[17].ToString();
			txtBoxClosingTrend.Text = array[18].ToString();
			txtBoxMinNumOfRaces.Text = array[19].ToString();
			txtBoxStretchCall.Text = array[20].ToString();
			txtBoxFavorite.Text = array[21].ToString();
			txtBoxDefineFavorite.Text = array[22].ToString();
			txtBoxSpeedRating.Text = array[23].ToString();
		}
		catch (Exception ex)
		{
			MessageBox.Show(ex.Message);
		}
	}

	private string updateTime_StatTable()
	{
		string text = "INSERT INTO kelso.track_time (HorseName, PaceLineDt, PaceLineTrackCd, PaceLineDistance, TurfInd, FinishTime)";
		text += "SELECT h.HorseName,";
		text += "h.PaceLineDt,";
		text += "h.PaceLineTrackCd,";
		text += "h.PaceLineDistance,";
		text += "h.TurfInd,";
		text += "(SELECT MAX(aa)FROM (";
		text += "(SELECT (h.FirstCallTime + (h.FinalBeatenLengths / 5.0)) aa";
		text += " UNION ";
		text += "SELECT (h.SecondCallTime + (h.FinalBeatenLengths / 5.0)) aa";
		text += " UNION ";
		text += "SELECT (h.FinalTime + (h.FinalBeatenLengths / 5.0)) aa";
		text += " UNION ";
		text += "SELECT (h.AdditionalFractionalTime + (h.FinalBeatenLengths / 5.0)) aa)";
		text += ") array) Finishtime";
		text += " FROM kelso.hor h";
		text += " WHERE NOT EXISTS";
		text += "(";
		text += "SELECT * FROM kelso.track_time t";
		text += " WHERE h.HorseName = t.HorseName";
		text += " AND h.PaceLineDt = t.PaceLineDt";
		text += " AND h.PaceLineTrackCd = t.PaceLineTrackCd";
		return text + ")";
	}

	private string updateTimeStatTable()
	{
		string text = "INSERT INTO kelso.timestat_n (HorseName, PaceLineDt, PaceLineTrackCd, PaceLineDistance, TurfInd, FirstCallTime, SecondCallTime, AdditionalFractionalTime, FinalTime, SecondCall, ThirdCall, StretchCall)";
		text += "SELECT h.HorseName,";
		text += "h.PaceLineDt,";
		text += "h.PaceLineTrackCd,";
		text += "h.PaceLineDistance,";
		text += "h.TurfInd,";
		text += "h.FirstCallTime + (h.FirstCallBeatenLengths / 5.0),";
		text += "h.SecondCallTime + (h.SecondCallBeatenLengths / 5.0),";
		text += "h.AdditionalFractionalTime + (h.StretchCallBeatenLengths / 5.0),";
		text += "h.FinalTime + (h.FinalBeatenLengths / 5.0),";
		text += "h.SecondCallTime + (h.SecondCallBeatenLengths / 5.0) - h.FirstCallTime + (h.FirstCallBeatenLengths / 5.0),";
		text += "h.AdditionalFractionalTime + (h.StretchCallBeatenLengths / 5.0) - h.SecondCallTime + (h.SecondCallBeatenLengths / 5.0),";
		text += "h.FinalTime + (h.FinalBeatenLengths / 5.0) - h.AdditionalFractionalTime + (h.StretchCallBeatenLengths / 5.0)";
		text += " FROM kelso.hor h";
		text += " WHERE NOT EXISTS";
		text += "(";
		text += "SELECT * FROM kelso.timestat_n t";
		text += " WHERE h.HorseName = t.HorseName";
		text += " AND h.PaceLineDt = t.PaceLineDt";
		text += " AND h.PaceLineTrackCd = t.PaceLineTrackCd";
		return text + ")";
	}

	private string updateWorkout_StatTable()
	{
		string text = "INSERT INTO kelso.workoutstat (HorseName, WorkOutDt, WorkOutTrack, WorkOutDistance, TurfInd, WorkOutTime)";
		text += "SELECT DISTINCT w.HorseName, w.WorkOutDt, w.WorkOutTrack, w.WorkOutDistance, w.TurfInd, w.WorkOutTime";
		text += " FROM kelso.wor w";
		text += " WHERE NOT EXISTS";
		text += "(";
		text += "SELECT * FROM kelso.workoutstat s";
		text += " WHERE w.HorseName = s.horsename";
		text += " AND w.WorkOutDt = s.workoutdt";
		return text + ")";
	}

	private void bttnProcessNew_Click(object sender, EventArgs e)
	{
		ckBoxCloud.Checked = false;
		Application.DoEvents();
		if (!string.IsNullOrEmpty(cbBoxNewRaceNum.Text))
		{
			lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Start Processing");
			if (_conn.State != ConnectionState.Open)
			{
				_conn.Open();
			}
			_dataSet.Clear();
			loadDataFromDb(_conn);
			using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter($"SELECT * FROM kelso.vTrackTimeStatFilter ORDER BY trackcd, distance", _conn))
			{
				if (_dataSet.Tables["stat"] != null)
				{
					_dataSet.Tables["stat"].Dispose();
				}
				oleDbDataAdapter.Fill(_dataSet, "stat");
			}
			_conn.Close();
			EnumerableRowCollection<DataRow> enumerableRowCollection = from query in _dataSet.Tables["rac"].AsEnumerable()
				where query.Field<int>("RaceNum") == int.Parse(cbBoxNewRaceNum.Text)
				select query;
			foreach (DataRow race in enumerableRowCollection)
			{
				EnumerableRowCollection<DataRow> source = _dataSet.Tables["ent"].AsEnumerable();
				Func<DataRow, bool> predicate = (DataRow query) => query.Field<int>("RaceNum") == race.Field<int>("RaceNum");
				EnumerableRowCollection<DataRow> race2 = source.Where(predicate);
				lBoxEvent.Items.Add(DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss.ffffff tt") + ": Processing Race: " + race.Field<int>("RaceNum"));
				analyzeRace(race, race2, race.Field<int>("RaceNum"), race.Field<string>("TrackCd"), race.Field<double>("Distance"), race.Field<int>("TurfInd"), race.Field<double>("RacePurse"));
				Application.DoEvents();
			}
			DataTable dataTable = new DataTable();
			_conn.Open();
			using (OleDbCommand oleDbCommand = new OleDbCommand("SELECT track, racedt, race, poleposition, line, horse, jockey, compositescore, track_type, distance FROM kelso.process WHERE track = ? AND racedt = ? AND race = ? ORDER BY compositescore DESC", _conn))
			{
				using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
				oleDbCommand.Parameters.Add(new OleDbParameter("Track", enumerableRowCollection.First().Field<string>("TrackName")));
				oleDbCommand.Parameters.Add(new OleDbParameter("RaceDt", enumerableRowCollection.First().Field<DateTime>("RaceDt")));
				oleDbCommand.Parameters.Add(new OleDbParameter("Race", int.Parse(cbBoxNewRaceNum.Text)));
				oleDbDataAdapter.SelectCommand = oleDbCommand;
				oleDbDataAdapter.Fill(dataTable);
			}
			dataTable.Dispose();
			_conn.Close();
			dataGridView1.DataSource = null;
			dataGridView1.Refresh();
			dataGridView1.DataSource = dataTable;
			dataGridView1.Refresh();
			Application.DoEvents();
		}
		else
		{
			MessageBox.Show("Select a race.");
		}
	}

	private string resultQuery1()
	{
		string text = "SELECT * FROM kelso.vResult ";
		text += "WHERE track = ? ";
		text += "AND racedt = ? ";
		return text + "ORDER BY race";
	}

	private void result()
	{
		if (_conn.State != ConnectionState.Open)
		{
			_conn.Open();
		}
		DataSet dataSet = new DataSet();
		using (OleDbCommand oleDbCommand = new OleDbCommand(resultQuery1(), _conn))
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand.Parameters.Add(new OleDbParameter("TrackCd", cbTrack.Text));
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceDt", DateTime.Parse(cbRacingDate.Text)));
			oleDbDataAdapter.SelectCommand = oleDbCommand;
			oleDbDataAdapter.Fill(dataSet, "result");
		}
		if (dataSet.Tables["result"].Rows.Count == 0)
		{
			MessageBox.Show("Result not loaded.");
			return;
		}
		IEnumerable<double> enumerable = (from query in dataSet.Tables["result"].AsEnumerable()
			select query.Field<double>("race")).Distinct();
		XDocument xDocument = new XDocument();
		xDocument.Add(new XElement("FAST_TRACK"));
		xDocument.Root.Add(new XElement("TRACK", (from para in dataSet.Tables["result"].AsEnumerable()
			select para.Field<string>("track")).Distinct()));
		xDocument.Root.Add(new XElement("RACE_DATE", (from para in dataSet.Tables["result"].AsEnumerable()
			select para.Field<DateTime>("racedt").ToShortDateString()).Distinct()));
		xDocument.Root.Add(new XElement("RACES"));
		string text = "NN";
		string text2 = "NNN";
		string text3 = "NNNN";
		string text4 = "NNNNN";
		string text5 = "NNNNNN";
		double num = 0.0;
		foreach (double item in enumerable)
		{
			double row = item;
			EnumerableRowCollection<DataRow> source = dataSet.Tables["result"].AsEnumerable();
			Func<DataRow, bool> predicate = (DataRow query) => query.Field<double>("race") == row;
			OrderedEnumerableRowCollection<DataRow> source2 = from query in source.Where(predicate)
				orderby query.Field<int>("official_finish_position")
				select query;
			List<string> list = new List<string>();
			if (source2.Count() > 0)
			{
				for (int i = 1; i < 15; i++)
				{
					string text6 = source2.First().Field<string>("wagertype" + i);
					if (!string.IsNullOrEmpty(text6) && text6 != "0")
					{
						list.Add(text6);
					}
				}
			}
			XElement xElement = new XElement("RACE");
			xElement.Add(new XAttribute("num", row));
			xElement.Add(new XElement("HORSES"));
			EnumerableRowCollection<DataRow> enumerableRowCollection = source2.Where((DataRow query) => query.Field<long>("RowNo") <= 3 && query.Field<int>("official_finish_position") == 1);
			int num2 = 0;
		}
		_conn.Close();
		MessageBox.Show("Completed.");
	}

	private string resultQuery()
	{
		string text = "SELECT r.TrackCd,";
		text += "p.TRACK,";
		text += "r.RaceDt,";
		text += "p.DISTANCE,";
		text += "r.RaceNum,";
		text += "p.PolePosition,";
		text += "r.HorseName,";
		text += "p.LINE,";
		text += "p.COMPOSITESCORE,";
		text += "r.official_finish_position FinishPosition,";
		text += "r.starter_field_size,";
		text += "r.TwoDollarsWinPayOff,";
		text += "r.TwoDollarsPlacePayOff,";
		text += "r.TwoDollarsShowPayOff,";
		text += "r.WagerType1,";
		text += "r.BetAmt1,";
		text += "r.TwoDollarsPayoff1,";
		text += "r.winningnums1,";
		text += "r.WagerType2,";
		text += "r.BetAmt2,";
		text += "r.TwoDollarsPayoff2,";
		text += "r.winningnums2,";
		text += "r.WagerType3,";
		text += "r.BetAmt3,";
		text += "r.TwoDollarsPayoff3,";
		text += "r.winningnums3,";
		text += "r.WagerType4,";
		text += "r.BetAmt4,";
		text += "r.TwoDollarsPayoff4,";
		text += "r.winningnums4,";
		text += "r.WagerType5,";
		text += "r.BetAmt5,";
		text += "r.TwoDollarsPayoff5,";
		text += "r.winningnums5,";
		text += "r.WagerType6,";
		text += "r.BetAmt6,";
		text += "r.TwoDollarsPayoff6,";
		text += "r.winningnums6,";
		text += "r.WagerType7,";
		text += "r.BetAmt7,";
		text += "r.TwoDollarsPayoff7,";
		text += "r.winningnums7,";
		text += "r.WagerType8,";
		text += "r.BetAmt8,";
		text += "r.TwoDollarsPayoff8,";
		text += "r.winningnums8,";
		text += "r.WagerType9,";
		text += "r.BetAmt9,";
		text += "r.TwoDollarsPayoff9,";
		text += "r.winningnums9,";
		text += "r.WagerType10,";
		text += "r.BetAmt10,";
		text += "r.TwoDollarsPayoff10, ";
		text += "r.winningnums10, ";
		text += "r.WagerType11,";
		text += "r.BetAmt11,";
		text += "r.TwoDollarsPayoff11, ";
		text += "r.winningnums11, ";
		text += "r.WagerType12,";
		text += "r.BetAmt12,";
		text += "r.TwoDollarsPayoff12, ";
		text += "r.winningnums12, ";
		text += "r.WagerType13,";
		text += "r.BetAmt13,";
		text += "r.TwoDollarsPayoff13, ";
		text += "r.winningnums13, ";
		text += "r.WagerType14,";
		text += "r.BetAmt14,";
		text += "r.TwoDollarsPayoff14, ";
		text += "r.winningnums14 ";
		text += "FROM kelso.result r, kelso.process p ";
		text += "WHERE p.track = ? ";
		text += "AND r.TrackCd = p.TRACKCD ";
		text += "AND r.RaceDt = p.RACEDT ";
		text += "AND r.RaceNum = p.RACE ";
		text += "AND (r.HorseName = p.HORSE OR p.HORSE LIKE (r.HorseName + '%')) ";
		text += "AND r.racedt = ? ";
		return text + "ORDER BY r.RaceNum, p.compositescore DESC";
	}

	private void bttnResult_Click(object sender, EventArgs e)
	{
		result();
		if (_conn.State != ConnectionState.Open)
		{
			_conn.Open();
		}
		DataSet dataSet = new DataSet();
		using (OleDbCommand oleDbCommand = new OleDbCommand(resultQuery(), _conn))
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter();
			oleDbCommand.Parameters.Add(new OleDbParameter("TrackCd", cbTrack.Text));
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceDt", DateTime.Parse(cbRacingDate.Text)));
			oleDbDataAdapter.SelectCommand = oleDbCommand;
			oleDbDataAdapter.Fill(dataSet, "result");
		}
		if (dataSet.Tables["result"].Rows.Count == 0)
		{
			MessageBox.Show("Result not loaded.");
			return;
		}
		IEnumerable<int> enumerable = (from query in dataSet.Tables["result"].AsEnumerable()
			select query.Field<int>("RaceNum")).Distinct();
		XDocument xDocument = new XDocument();
		xDocument.Add(new XElement("FAST_TRACK"));
		xDocument.Root.Add(new XElement("TRACK", (from para in dataSet.Tables["result"].AsEnumerable()
			select para.Field<string>("track")).Distinct()));
		xDocument.Root.Add(new XElement("RACE_DATE", (from para in dataSet.Tables["result"].AsEnumerable()
			select para.Field<DateTime>("racedt").ToShortDateString()).Distinct()));
		xDocument.Root.Add(new XElement("RACES"));
		string text = "NN";
		string text2 = "NNN";
		string text3 = "NNNN";
		string text4 = "NNNNN";
		string text5 = "NNNNNN";
		double num = 0.0;
		foreach (int row in enumerable)
		{
			EnumerableRowCollection<DataRow> source = dataSet.Tables["result"].AsEnumerable();
			Func<DataRow, bool> predicate = (DataRow query) => query.Field<int>("RaceNum") == row;
			IEnumerable<DataRow> enumerable2 = (from query in source.Where(predicate)
				orderby query.Field<double>("compositescore") descending
				select query).Take(6);
			List<string> list = new List<string>();
			foreach (DataRow item in enumerable2)
			{
				list.Add(item.Field<string>("horsename"));
			}
			IOrderedEnumerable<DataRow> orderedEnumerable = enumerable2.OrderBy((DataRow query) => query.Field<int>("finishposition"));
			List<string> list2 = new List<string>();
			if (orderedEnumerable.Count() > 0)
			{
				for (int i = 1; i <= 14; i++)
				{
					string text6 = orderedEnumerable.First().Field<string>("wagertype" + i);
					if (!string.IsNullOrEmpty(text6))
					{
						list2.Add(text6);
					}
				}
			}
			XElement xElement = new XElement("RACE");
			xElement.Add(new XAttribute("num", row));
			xElement.Add(new XElement("HORSES"));
			List<int> list3 = new List<int>();
			Hashtable hashtable = new Hashtable();
			double num2 = 0.0;
			double num3 = 0.0;
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			foreach (DataRow item2 in orderedEnumerable)
			{
				list3.Add(item2.Field<int>("finishposition"));
				hashtable.Add(item2.Field<string>("horsename"), item2.Field<int>("finishposition"));
				if (list.IndexOf(item2.Field<string>("horsename")) < 3 && item2.Field<int>("finishposition") <= 3)
				{
					XElement xElement2 = new XElement("HORSE");
					xElement2.Add(new XElement("NAME", item2.Field<string>("horsename")));
					xElement2.Add(new XElement("POLE_POSITION", item2.Field<string>("poleposition")));
					xElement2.Add(new XElement("LINE", item2.Field<string>("line")));
					xElement2.Add(new XElement("FINISH", item2.Field<int>("finishposition")));
					if (list.IndexOf(item2.Field<string>("horsename")) == 0)
					{
						flag3 = true;
					}
					else if (list.IndexOf(item2.Field<string>("horsename")) == 1)
					{
						flag4 = true;
					}
					if (item2.Field<int>("finishposition") == 1)
					{
						xElement2.Add(new XElement("WIN", item2.Field<double>("twodollarswinpayoff")));
						xElement2.Add(new XElement("PLACE", item2.Field<double>("twodollarsplacepayoff")));
						xElement2.Add(new XElement("SHOW", item2.Field<double>("twodollarsshowpayoff")));
						num2 += item2.Field<double>("twodollarswinpayoff");
						num2 += item2.Field<double>("twodollarsplacepayoff");
						num2 += item2.Field<double>("twodollarsshowpayoff");
						flag = true;
					}
					else if (item2.Field<int>("finishposition") == 2)
					{
						flag2 = true;
					}
					xElement.Element("HORSES").Add(xElement2);
				}
			}
			XElement xElement3 = new XElement("WAGERS");
			if (list2.Contains("EXACTA") && flag && flag2)
			{
				XElement xElement4 = new XElement("WAGER");
				xElement4.Add(new XAttribute("type", "EXACTA"));
				int num4 = list2.FindIndex((string para) => para.Equals("EXACTA"));
				double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
				if (num5 == 0.0)
				{
					num5 = 0.5;
				}
				double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
				xElement4.Add(new XElement("BET", num5.ToString("0.00")));
				xElement4.Add(new XElement("PAYOUT", num6.ToString("0.00")));
				xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
				xElement3.Add(xElement4);
				num2 += num6;
			}
			if (list2.Contains("TRIFECTA"))
			{
				int num7 = 0;
				int num8 = ((list.Count < 4) ? list.Count : 4);
				for (int i = 0; i < num8; i++)
				{
					if (hashtable.ContainsKey(list.ElementAt(i)) && (int)hashtable[list.ElementAt(i)] < 4)
					{
						num7++;
					}
				}
				if (num7 == 3)
				{
					XElement xElement4 = new XElement("WAGER");
					xElement4.Add(new XAttribute("type", "TRIFECTA"));
					int num4 = list2.FindIndex((string para) => para.Equals("TRIFECTA"));
					double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
					if (num5 == 0.0)
					{
						num5 = 0.5;
					}
					double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
					xElement4.Add(new XElement("BET", num5.ToString("0.00")));
					xElement4.Add(new XElement("PAYOUT", num6.ToString("0.00")));
					xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
					xElement3.Add(xElement4);
					num2 += num6;
				}
			}
			if (list2.Contains("SUPERFECTA"))
			{
				int num7 = 0;
				int num8 = ((list.Count < 5) ? list.Count : 5);
				for (int i = 0; i < num8; i++)
				{
					if (hashtable.ContainsKey(list.ElementAt(i)) && (int)hashtable[list.ElementAt(i)] < 5)
					{
						num7++;
					}
				}
				if (num7 == 4)
				{
					XElement xElement4 = new XElement("WAGER");
					xElement4.Add(new XAttribute("type", "SUPERFECTA"));
					int num4 = list2.FindIndex((string para) => para.Equals("SUPERFECTA"));
					double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
					if (num5 == 0.0)
					{
						num5 = 0.5;
					}
					double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
					xElement4.Add(new XElement("BET", num5.ToString("0.00")));
					xElement4.Add(new XElement("PAYOUT", num6.ToString("0.00")));
					xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
					xElement3.Add(xElement4);
					num2 += num6;
				}
			}
			if (list2.Contains("SUPER HIGH FIVE"))
			{
				int num7 = 0;
				int num8 = ((list.Count < 6) ? list.Count : 5);
				for (int i = 0; i < num8; i++)
				{
					if (hashtable.ContainsKey(list.ElementAt(i)) && (int)hashtable[list.ElementAt(i)] < 5)
					{
						num7++;
					}
				}
				if (num7 == 4)
				{
					XElement xElement4 = new XElement("WAGER");
					xElement4.Add(new XAttribute("type", "SUPER HIGH FIVE"));
					int num4 = list2.FindIndex((string para) => para.Equals("SUPER HIGH FIVE"));
					double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
					if (num5 == 0.0)
					{
						num5 = 0.5;
					}
					double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
					xElement4.Add(new XElement("BET", num5.ToString("0.00")));
					xElement4.Add(new XElement("PAYOUT", num6.ToString("0.00")));
					xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
					xElement3.Add(xElement4);
					num2 += num6;
				}
			}
			text = text.Remove(0, 1);
			text2 = text2.Remove(0, 1);
			text3 = text3.Remove(0, 1);
			text4 = text4.Remove(0, 1);
			text5 = text5.Remove(0, 1);
			if (flag)
			{
				text = ((!flag3 && !flag4) ? (text + "N") : (text + "Y"));
				text2 += "Y";
				text3 += "Y";
				text4 += "Y";
				text5 += "Y";
			}
			else
			{
				text += "N";
				text2 += "N";
				text3 += "N";
				text4 += "N";
				text5 += "N";
			}
			if (list2.Contains("DAILY DOUBLE") && text == "YY")
			{
				XElement xElement4 = new XElement("WAGER");
				xElement4.Add(new XAttribute("type", "DAILY DOUBLE"));
				int num4 = list2.FindIndex((string para) => para.Equals("DAILY DOUBLE"));
				double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
				if (num5 == 0.0)
				{
					num5 = 0.5;
				}
				double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
				xElement4.Add(new XElement("BET", num5.ToString("0.00")));
				xElement4.Add(new XElement("PAYOUT", num6.ToString("0.00")));
				xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
				xElement3.Add(xElement4);
				num2 += num6;
			}
			if (list2.Contains("PICK THREE") && text2 == "YYY")
			{
				XElement xElement4 = new XElement("WAGER");
				xElement4.Add(new XAttribute("type", "PICK THREE"));
				int num4 = list2.FindIndex((string para) => para.Equals("PICK THREE"));
				double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
				if (num5 == 0.0)
				{
					num5 = 0.5;
				}
				double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
				xElement4.Add(new XElement("BET", num5.ToString("0.00")));
				xElement4.Add(new XElement("PAYOUT", num6.ToString("0.00")));
				xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
				xElement3.Add(xElement4);
				num2 += num6;
			}
			if (list2.Contains("PICK FOUR") && text3 == "YYYY")
			{
				XElement xElement4 = new XElement("WAGER");
				xElement4.Add(new XAttribute("type", "PICK FOUR"));
				int num4 = list2.FindIndex((string para) => para.Equals("PICK FOUR"));
				double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
				if (num5 == 0.0)
				{
					num5 = 0.5;
				}
				double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
				xElement4.Add(new XElement("BET", num5.ToString("0.00")));
				xElement4.Add(new XElement("PAYOUT", num6.ToString("#.#0")));
				xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
				xElement3.Add(xElement4);
				num2 += num6;
			}
			if (list2.Contains("PICK FIVE") && text4 == "YYYYY")
			{
				XElement xElement4 = new XElement("WAGER");
				xElement4.Add(new XAttribute("type", "PICK FIVE"));
				int num4 = list2.FindIndex((string para) => para.Equals("PICK FIVE"));
				double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
				if (num5 == 0.0)
				{
					num5 = 0.5;
				}
				double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
				xElement4.Add(new XElement("BET", num5.ToString("0.00")));
				xElement4.Add(new XElement("PAYOUT", num6.ToString("#.#0")));
				xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
				xElement3.Add(xElement4);
				num2 += num6;
			}
			if (list2.Contains("PICK SIX") && text5 == "YYYYYY")
			{
				XElement xElement4 = new XElement("WAGER");
				xElement4.Add(new XAttribute("type", "PICK SIX"));
				int num4 = list2.FindLastIndex((string para) => para.Equals("PICK SIX"));
				double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
				if (num5 == 0.0)
				{
					num5 = 0.5;
				}
				double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
				xElement4.Add(new XElement("BET", num5.ToString("0.00")));
				xElement4.Add(new XElement("PAYOUT", num6.ToString("#.#0")));
				xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
				xElement3.Add(xElement4);
				num2 += num6;
			}
			if (list2.Contains("PICK SIX") && text5.Count((char para) => para == 'Y') == 5 && list2.Where((string para) => para == "PICK SIX").Count() == 2)
			{
				XElement xElement4 = new XElement("WAGER");
				xElement4.Add(new XAttribute("type", "PICK SIX"));
				int num4 = list2.FindIndex((string para) => para.Equals("PICK SIX"));
				double num5 = orderedEnumerable.First().Field<double>("betamt" + (num4 + 1));
				if (num5 == 0.0)
				{
					num5 = 0.5;
				}
				double num6 = Math.Round(orderedEnumerable.First().Field<double>("twodollarspayoff" + (num4 + 1)) / 20.0, 3) * (num5 / 0.1);
				xElement4.Add(new XElement("BET", num5.ToString("0.00")));
				xElement4.Add(new XElement("PAYOUT", num6.ToString("#.#0")));
				xElement4.Add(new XElement("WINNING", orderedEnumerable.First().Field<string>("winningnums" + (num4 + 1))));
				xElement3.Add(xElement4);
				num2 += num6;
			}
			xElement.Add(xElement3);
			xElement.Add(new XElement("TOTAL", num2.ToString("0.00")));
			xDocument.Root.Element("RACES").Add(xElement);
			num += num2;
		}
		xDocument.Root.Add(new XElement("TODAY_TOTAL", num.ToString("0.00")));
		string text7 = "\\" + cbTrack.Text + " " + DateTime.Parse(cbRacingDate.Text).ToString("yyyyMMdd");
		if (File.Exists(ConfigurationManager.AppSettings["xml"] + text7 + " RaceResult.xml"))
		{
			File.Delete(ConfigurationManager.AppSettings["xml"] + text7 + " RaceResult.xml");
		}
		File.WriteAllText(ConfigurationManager.AppSettings["xml"] + text7 + " RaceResult.xml", xDocument.ToString());
		if (File.Exists(ConfigurationManager.AppSettings["report"] + text7 + ".html"))
		{
			File.Delete(ConfigurationManager.AppSettings["report"] + text7 + ".html");
		}
		if (File.Exists(ConfigurationManager.AppSettings["report"] + text7 + " FastTrack Result.pdf"))
		{
			File.Delete(ConfigurationManager.AppSettings["report"] + text7 + " FastTrack Result.pdf");
		}
		XmlDocument xmlDocument = new XmlDocument();
		xmlDocument.LoadXml(xDocument.ToString());
		XPathNavigator input = xmlDocument.CreateNavigator();
		XslTransform xslTransform = new XslTransform();
		xslTransform.Load(ConfigurationManager.AppSettings["report"] + "\\_TheResult.xsl");
		XmlTextWriter xmlTextWriter = new XmlTextWriter(ConfigurationManager.AppSettings["report"] + text7 + ".html", null);
		xslTransform.Transform(input, null, xmlTextWriter, null);
		xmlTextWriter.Flush();
		xmlTextWriter.Close();
		gtMany2PDFX gtMany2PDFX = (gtMany2PDFX)Activator.CreateInstance(Type.GetTypeFromCLSID(new Guid("59995656-309C-4AA3-A9EB-691988815C28")));
		gtMany2PDFX.ActivateLicense("A474CE1E-1FF3-4010-B62E-16C8BC64BA8D");
		gtMany2PDFX.InputFile = ConfigurationManager.AppSettings["report"] + text7 + ".html";
		gtMany2PDFX.DocInfoAuthor = "Phung Le";
		gtMany2PDFX.PagePaperSize = TxgtPaperSize.Letter;
		gtMany2PDFX.PageTopMargin = 0.5;
		gtMany2PDFX.PageBottomMargin = 0.5;
		gtMany2PDFX.PageLeftMargin = 0.25;
		gtMany2PDFX.PrefShowSetupDialog = false;
		gtMany2PDFX.PageOrientation = TxgtPrinterOrientation.poPortrait;
		gtMany2PDFX.PagePaperSize = TxgtPaperSize.Letter;
		gtMany2PDFX.Visible = false;
		gtMany2PDFX.OutputPDFFileName = ConfigurationManager.AppSettings["report"] + text7 + " FastTrack Result.pdf";
		gtMany2PDFX.Visible = false;
		gtMany2PDFX.PrefOpenAfterCreate = false;
		gtMany2PDFX.RenderDocument();
		Marshal.FinalReleaseComObject(gtMany2PDFX);
		using (OleDbCommand oleDbCommand = new OleDbCommand("DELETE FROM kelso.result_date_summary WHERE RaceDt = ? AND TrackName = ?", _conn))
		{
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceDt", DateTime.Parse(cbRacingDate.Text)));
			oleDbCommand.Parameters.Add(new OleDbParameter("TrackName", cbTrack.Text));
			oleDbCommand.ExecuteNonQuery();
			oleDbCommand.Parameters.Clear();
			oleDbCommand.CommandText = "INSERT INTO kelso.result_date_summary (RaceDt, TotalAmt, TrackName) VALUES ( ?, ?, ?)";
			oleDbCommand.Parameters.Add(new OleDbParameter("RaceDt", DateTime.Parse(cbRacingDate.Text)));
			oleDbCommand.Parameters.Add(new OleDbParameter("TotalAmt", num));
			oleDbCommand.Parameters.Add(new OleDbParameter("TrackName", cbTrack.Text));
			oleDbCommand.ExecuteNonQuery();
		}
		_conn.Close();
		MessageBox.Show("Completed.");
	}

	private void bttnProcessResult_Click(object sender, EventArgs e)
	{
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Expected O, but got Unknown
		if (_conn.State != ConnectionState.Open)
		{
			_conn.Open();
		}
		using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT TOP 5 * FROM kelso.result", _conn))
		{
			OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
			DataSet dataSet = new DataSet();
			oleDbDataAdapter.Fill(dataSet, "result");
			dataSet.Tables["result"].Rows.Clear();
			DirectoryInfo directoryInfo = new DirectoryInfo(ConfigurationManager.AppSettings["Files"]);
			FileInfo[] files = directoryInfo.GetFiles("*.xrd");
			for (int i = 0; i < files.Count(); i++)
			{
				CsvReader val = new CsvReader(files[i].FullName);
				try
				{
					val.get_Settings().set_UseTextQualifier(true);
					bool flag = true;
					while (((ReaderBase)val).ReadRecord())
					{
						string[] values = ((ReaderBase)val).get_Values();
						if (flag)
						{
							string cmdText = "DELETE FROM kelso.result WHERE trackcd = '" + values[0] + "' AND racedt = '" + values[1].Substring(4, 2) + "/" + values[1].Substring(6, 2) + "/" + values[1].Substring(0, 4) + "'";
							using (OleDbCommand oleDbCommand = new OleDbCommand(cmdText, _conn))
							{
								oleDbCommand.ExecuteNonQuery();
							}
							flag = false;
						}
						for (int j = 0; j < 1; j++)
						{
							string date = values[dataSet.Tables["result"].Columns.IndexOf("RaceDt")].Substring(4, 2) + "/" + values[dataSet.Tables["result"].Columns.IndexOf("RaceDt")].Substring(6, 2) + "/" + values[dataSet.Tables["result"].Columns.IndexOf("RaceDt")].Substring(0, 4);
							values[dataSet.Tables["result"].Columns.IndexOf("RaceDt")] = checkDate(date);
						}
						for (int j = 0; j < values.Count(); j++)
						{
							if (string.IsNullOrEmpty(values[j]))
							{
								values[j] = "0";
							}
						}
						dataSet.Tables["result"].Rows.Add(values);
					}
					oleDbDataAdapter.InsertCommand = oleDbCommandBuilder.GetInsertCommand();
					oleDbDataAdapter.Update(dataSet, "result");
					dataSet.Dispose();
				}
				finally
				{
					((IDisposable)val)?.Dispose();
				}
				File.Delete(files[i].FullName);
			}
		}
		MessageBox.Show("Loading Complete.");
	}

	private void loadData(FileInfo file)
	{
		//IL_0125: Unknown result type (might be due to invalid IL or missing references)
		//IL_012b: Expected O, but got Unknown
		string[] array = null;
		string text = string.Empty;
		if (file.Extension.ToLower().Contains("r"))
		{
			array = new string[1] { "RaceDt" };
			text = "rac";
		}
		else if (file.Extension.ToLower().Contains("e"))
		{
			array = new string[1] { "RaceDt" };
			text = "ent";
		}
		else if (file.Extension.ToLower().Contains("h"))
		{
			array = new string[2] { "RaceDt", "PaceLineDt" };
			text = "hor";
		}
		else if (file.Extension.ToLower().Contains("w"))
		{
			array = new string[2] { "RaceDt", "WorkOutDt" };
			text = "wor";
		}
		if (string.IsNullOrWhiteSpace(text))
		{
			return;
		}
		CsvReader val = new CsvReader(file.FullName);
		try
		{
			val.get_Settings().set_UseTextQualifier(true);
			while (((ReaderBase)val).ReadRecord())
			{
				string[] values = ((ReaderBase)val).get_Values();
				for (int i = 0; i < array.Length; i++)
				{
					values[_dataSet.Tables[text].Columns.IndexOf(array[i])] = checkDate(values[_dataSet.Tables[text].Columns.IndexOf(array[i])]);
				}
				if (text.Equals("hor", StringComparison.OrdinalIgnoreCase))
				{
					int ordinal = _dataSet.Tables["hor"].Columns["firstcalltime"].Ordinal;
					double[] array2 = new double[4]
					{
						double.Parse(values[ordinal]),
						double.Parse(values[ordinal + 1]),
						double.Parse(values[ordinal + 2]),
						double.Parse(values[ordinal + 3])
					};
					Array.Sort(array2);
					values[_dataSet.Tables["hor"].Columns["firstcalltime"].Ordinal] = array2[0].ToString();
					values[_dataSet.Tables["hor"].Columns["SecondCallTime"].Ordinal] = array2[1].ToString();
					values[_dataSet.Tables["hor"].Columns["AdditionalFractionalTime"].Ordinal] = array2[2].ToString();
					values[_dataSet.Tables["hor"].Columns["FinalTime"].Ordinal] = array2[3].ToString();
				}
				_dataSet.Tables[text].Rows.Add(values);
			}
		}
		finally
		{
			((IDisposable)val)?.Dispose();
		}
	}

	private void button1_Click_1(object sender, EventArgs e)
	{
		_dataSet.Clear();
		_conn.Open();
		List<string> list = new List<string>();
		list.Add("rac");
		list.Add("ent");
		list.Add("hor");
		list.Add("wor");
		List<string> list2 = list;
		for (int i = 0; i < list2.Count; i++)
		{
			using OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT TOP 0 * FROM kelso." + list2[i], _conn);
			oleDbDataAdapter.Fill(_dataSet, list2[i]);
		}
		DirectoryInfo directoryInfo = new DirectoryInfo(ConfigurationManager.AppSettings["Files"]);
		FileInfo[] files = directoryInfo.GetFiles();
		IQueryable<string> queryable = (from query in files.AsQueryable()
			select query.Name.Substring(0, query.Name.Length - 4)).Distinct();
		foreach (string item in queryable)
		{
			FileInfo[] files2 = directoryInfo.GetFiles(item + "*.*");
			FileInfo[] array = files2;
			foreach (FileInfo file in array)
			{
				loadData(file);
			}
			for (int i = 0; i < 2; i++)
			{
				string text = ((i == 0) ? "hor" : "wor");
				using (OleDbCommand oleDbCommand = new OleDbCommand("DELETE FROM kelso." + text, _conn))
				{
					oleDbCommand.ExecuteNonQuery();
				}
				using (OleDbDataAdapter oleDbDataAdapter = new OleDbDataAdapter("SELECT * FROM kelso." + text, _conn))
				{
					OleDbCommandBuilder oleDbCommandBuilder = new OleDbCommandBuilder(oleDbDataAdapter);
					oleDbDataAdapter.InsertCommand = oleDbCommandBuilder.GetInsertCommand();
					oleDbDataAdapter.Update(_dataSet, text);
				}
				using OleDbCommand oleDbCommand = new OleDbCommand((i == 0) ? updateTimeStatTable() : updateWorkout_StatTable(), _conn);
				oleDbCommand.ExecuteNonQuery();
			}
			process();
		}
		int num = 0;
	}

	private double timeDiffBetweenTrack(string subjTrack, string compTrack, double distance, int turf)
	{
		double num = 0.0;
		string text = "SELECT (";
		text += "( SELECT mean";
		text += " FROM kelso.vTrackTimeStat";
		text = text + " WHERE TrackCd = '" + subjTrack + "'";
		string text2 = text;
		text = text2 + "AND distance = " + distance + "AND turfind = " + turf + ") - ";
		text += "( SELECT mean";
		text += " FROM kelso.vTrackTimeStat";
		text = text + " WHERE TrackCd = '" + compTrack + "'";
		text2 = text;
		text = text2 + "AND distance = " + distance + "AND turfind = " + turf + ")) diff";
		if (_conn.State != ConnectionState.Open)
		{
			_conn.Open();
		}
		using (OleDbCommand oleDbCommand = new OleDbCommand(text, _conn))
		{
			num = (double)oleDbCommand.ExecuteScalar();
		}
		return num;
	}

	private void analyzeHorse(HorseComparison horse, string name, int num, string track, double distance, int turf)
	{
		List<double> list = new List<double>();
		EnumerableRowCollection<DataRow> source = from query in _dataSet.Tables["hor"].AsEnumerable()
			where query.Field<int>("RaceNum") == num && query.Field<string>("HorseName").Equals(name, StringComparison.OrdinalIgnoreCase) && query.Field<DateTime>("PaceLineDt") >= query.Field<DateTime>("RaceDt").AddDays(-int.Parse(txtBoxMaxDatePerformance.Text)) && query.Field<int>("TurfInd") == turf
			select query;
		if (source.Any())
		{
			EnumerableRowCollection<DataRow> source2 = source.Where((DataRow query) => query.Field<double>("PaceLineDistance") == distance);
			if (source2.Any())
			{
				horse.HasRaceDistance = true;
				EnumerableRowCollection<DataRow> enumerableRowCollection = source2.Where((DataRow query) => query.Field<string>("TrackCd") == track);
				horse.NumOfComparable += enumerableRowCollection.Count();
				foreach (DataRow item in enumerableRowCollection)
				{
					list.Add(calcTrueFinishTime(item.Field<double>("FinalTime"), item.Field<double>("FinalBeatenLengths")));
				}
				EnumerableRowCollection<DataRow> enumerableRowCollection2 = source2.Where((DataRow query) => query.Field<string>("TrackCd") != track);
				foreach (DataRow item2 in enumerableRowCollection2)
				{
					double num2 = timeDiffBetweenTrack(track, item2.Field<string>("TrackCd"), distance, turf);
					list.Add(calcTrueFinishTime(item2.Field<double>("FinalTime"), item2.Field<double>("FinalBeatenLengths") - num2));
				}
			}
			int num3 = 0;
		}
		var source3 = source.Select((DataRow query) => new
		{
			regression = lineRegression(new double[5]
			{
				query.Field<int>("StartCallPosition"),
				query.Field<int>("FirstCallPosition"),
				query.Field<int>("SecondCallPosition"),
				query.Field<int>("StretchCallPosition"),
				query.Field<int>("FinalCallPosition")
			})
		});
		if (source3.Where(para => para.regression > -0.5).Count() > 1)
		{
			horse.Closer = double.Parse(txtBoxClosingTrend.Text);
		}
		if (source.Any())
		{
			horse.FormerJockey = (from para in source
				orderby para.Field<DateTime>("PaceLineDt") descending
				select para.Field<string>("JockeyName")).First();
			horse.LastRacePurse = (from para in source
				orderby para.Field<DateTime>("PaceLineDt") descending
				select para.Field<double>("ClaimingPrice")).First();
		}
		else
		{
			horse.FirstTimer = true;
		}
	}

	private void process()
	{
		EnumerableRowCollection<DataRow> enumerableRowCollection = from query in _dataSet.Tables["rac"].AsEnumerable()
			select (query);
		foreach (DataRow race in enumerableRowCollection)
		{
			EnumerableRowCollection<DataRow> source = _dataSet.Tables["ent"].AsEnumerable();
			Func<DataRow, bool> predicate = (DataRow query) => query.Field<int>("RaceNum") == race.Field<int>("RaceNum") && !string.IsNullOrEmpty(query.Field<string>("MorningLine"));
			EnumerableRowCollection<DataRow> enumerableRowCollection2 = source.Where(predicate);
			HorseComparison[] array = new HorseComparison[enumerableRowCollection2.Count()];
			int num = 0;
			foreach (DataRow item in enumerableRowCollection2)
			{
				array[num] = new HorseComparison();
				array[num].PolePosition = item.Field<string>("PolePosition");
				array[num].HorseName = item.Field<string>("HorseName");
				if (!string.IsNullOrEmpty(item.Field<string>("MorningLine")))
				{
					if (item.Field<string>("MorningLine").Equals("even", StringComparison.OrdinalIgnoreCase))
					{
						array[num].Line = "1/1";
						array[num].LineNumber = 1.0;
					}
					else
					{
						array[num].Line = item.Field<string>("MorningLine").Replace("-", "/");
						array[num].LineNumber = double.Parse(array[num].Line.Split('/')[0]) / double.Parse(array[num].Line.Split('/')[1]);
					}
				}
				array[num].Jockey = item.Field<string>("JockeyName");
				if (item.Field<int>("TrainerStarts") >= int.Parse(txtBoxMinNumOfRaces.Text))
				{
					array[num].TrainerPercentage = item.Field<double>("TrainerPercentage");
				}
				else
				{
					array[num].TrainerPercentage = double.Parse(Regex.Match(item.Field<string>("TrainerStatsYTD"), "\\.[0-9]+").Value);
				}
				analyzeHorse(array[num], item.Field<string>("HorseName"), race.Field<int>("RaceNum"), race.Field<string>("TrackCd"), race.Field<double>("Distance"), race.Field<int>("TurfInd"));
				num++;
			}
			Application.DoEvents();
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing && components != null)
		{
			components.Dispose();
		}
		base.Dispose(disposing);
	}

	private void InitializeComponent()
	{
		this.components = new System.ComponentModel.Container();
		System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle = new System.Windows.Forms.DataGridViewCellStyle();
		System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
		System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
		System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
		System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
		System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
		System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FastTrack.frmMain));
		this.bttnImport = new System.Windows.Forms.Button();
		this.folderBrowserDialog1 = new System.Windows.Forms.FolderBrowserDialog();
		this.lblCondition = new System.Windows.Forms.Label();
		this.txtBoxMaxDatePerformance = new System.Windows.Forms.TextBox();
		this.lblMaxDateConsiderPerf = new System.Windows.Forms.Label();
		this.txtBoxHandimanPerformance = new System.Windows.Forms.TextBox();
		this.txtBoxModifiedBeyerSpeed = new System.Windows.Forms.TextBox();
		this.lblHandimansPerformance = new System.Windows.Forms.Label();
		this.lblModifiedBeyerSpeed = new System.Windows.Forms.Label();
		this.txtBoxBeyerDistance = new System.Windows.Forms.TextBox();
		this.txtBoxBeyerPerformance = new System.Windows.Forms.TextBox();
		this.lblBeyerDistance = new System.Windows.Forms.Label();
		this.lblBeyerPerformance = new System.Windows.Forms.Label();
		this.lBoxEvent = new System.Windows.Forms.ListBox();
		this.bttnStandardized = new System.Windows.Forms.Button();
		this.bttnProcess = new System.Windows.Forms.Button();
		this.bttnNext = new System.Windows.Forms.Button();
		this.lBoxFiles = new System.Windows.Forms.ListBox();
		this.bttnAllRace = new System.Windows.Forms.Button();
		this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
		this.dataGridView1 = new System.Windows.Forms.DataGridView();
		this.lblTRaceTrack = new System.Windows.Forms.Label();
		this.lblRaceTrack = new System.Windows.Forms.Label();
		this.lblDate = new System.Windows.Forms.Label();
		this.lblTDate = new System.Windows.Forms.Label();
		this.lblRaceNum = new System.Windows.Forms.Label();
		this.lblTRaceNum = new System.Windows.Forms.Label();
		this.lblCalcType = new System.Windows.Forms.Label();
		this.txtBoxWorkout = new System.Windows.Forms.TextBox();
		this.txtBoxHandimanPercent = new System.Windows.Forms.TextBox();
		this.lblGreater0Workout = new System.Windows.Forms.Label();
		this.lblGreater0Handiman = new System.Windows.Forms.Label();
		this.txtBoxJockey = new System.Windows.Forms.TextBox();
		this.lblGreater0Jockey = new System.Windows.Forms.Label();
		this.txtBoxTrainer = new System.Windows.Forms.TextBox();
		this.lblGreater0Trainer = new System.Windows.Forms.Label();
		this.lblTitleAdjustmentGreater0 = new System.Windows.Forms.Label();
		this.lblTitleAdjustmentEqual0 = new System.Windows.Forms.Label();
		this.txtBoxEq0Trainer = new System.Windows.Forms.TextBox();
		this.txtBoxEq0Jockey = new System.Windows.Forms.TextBox();
		this.txtBoxEq0Workout = new System.Windows.Forms.TextBox();
		this.lblMaxDaysWorkout = new System.Windows.Forms.Label();
		this.txtBoxMaxWorkoutDays = new System.Windows.Forms.TextBox();
		this.bttnSaveAdjustment = new System.Windows.Forms.Button();
		this.txtBoxClaimPrice = new System.Windows.Forms.TextBox();
		this.lblClaimPriceTrend = new System.Windows.Forms.Label();
		this.txtBoxBettingLine = new System.Windows.Forms.TextBox();
		this.lblBettingLine = new System.Windows.Forms.Label();
		this.txtBoxEq0BettingLine = new System.Windows.Forms.TextBox();
		this.txtBoxEq0ClaimPrice = new System.Windows.Forms.TextBox();
		this.dataGridView2 = new System.Windows.Forms.DataGridView();
		this.txtBoxClosingTrend = new System.Windows.Forms.TextBox();
		this.lblClosingTrend = new System.Windows.Forms.Label();
		this.lblJockeyNumOfRaces = new System.Windows.Forms.Label();
		this.txtBoxMinNumOfRaces = new System.Windows.Forms.TextBox();
		this.txtBoxStretchCall = new System.Windows.Forms.TextBox();
		this.lblStretchCall = new System.Windows.Forms.Label();
		this.txtBoxFavorite = new System.Windows.Forms.TextBox();
		this.lblFavorite = new System.Windows.Forms.Label();
		this.txtBoxDefineFavorite = new System.Windows.Forms.TextBox();
		this.label1 = new System.Windows.Forms.Label();
		this.bttnReport = new System.Windows.Forms.Button();
		this.cbTrack = new System.Windows.Forms.ComboBox();
		this.cbRacingDate = new System.Windows.Forms.ComboBox();
		this.cbModRacingDt = new System.Windows.Forms.ComboBox();
		this.cbModTrack = new System.Windows.Forms.ComboBox();
		this.bttnSave = new System.Windows.Forms.Button();
		this.cbModHorseName = new System.Windows.Forms.ComboBox();
		this.cbModRaceNum = new System.Windows.Forms.ComboBox();
		this.txtBoxFrankPoint = new System.Windows.Forms.TextBox();
		this.txtBoxSpeedRating = new System.Windows.Forms.TextBox();
		this.lblGreater0SpeedRating = new System.Windows.Forms.Label();
		this.fileSystemWatcher1 = new System.IO.FileSystemWatcher();
		this.bttnBeginPolling = new System.Windows.Forms.Button();
		this.button4 = new System.Windows.Forms.Button();
		this.ckBoxCloud = new System.Windows.Forms.CheckBox();
		this.cbBoxProfile = new System.Windows.Forms.ComboBox();
		this.bttnLoadAdjustment = new System.Windows.Forms.Button();
		this.cbBoxNewRaceNum = new System.Windows.Forms.ComboBox();
		this.bttnProcessNew = new System.Windows.Forms.Button();
		this.bttnResult = new System.Windows.Forms.Button();
		this.bttnProcessResult = new System.Windows.Forms.Button();
		this.button1 = new System.Windows.Forms.Button();
		((System.ComponentModel.ISupportInitialize)this.bindingSource1).BeginInit();
		((System.ComponentModel.ISupportInitialize)this.dataGridView1).BeginInit();
		((System.ComponentModel.ISupportInitialize)this.dataGridView2).BeginInit();
		((System.ComponentModel.ISupportInitialize)this.fileSystemWatcher1).BeginInit();
		base.SuspendLayout();
		this.bttnImport.Location = new System.Drawing.Point(12, 112);
		this.bttnImport.Name = "bttnImport";
		this.bttnImport.Size = new System.Drawing.Size(100, 26);
		this.bttnImport.TabIndex = 0;
		this.bttnImport.Text = "Import";
		this.bttnImport.UseVisualStyleBackColor = true;
		this.bttnImport.Click += new System.EventHandler(bttnImport_Click);
		this.lblCondition.AutoSize = true;
		this.lblCondition.Location = new System.Drawing.Point(115, 235);
		this.lblCondition.Name = "lblCondition";
		this.lblCondition.Size = new System.Drawing.Size(54, 13);
		this.lblCondition.TabIndex = 25;
		this.lblCondition.Text = "Condition:";
		this.txtBoxMaxDatePerformance.Location = new System.Drawing.Point(118, 212);
		this.txtBoxMaxDatePerformance.Name = "txtBoxMaxDatePerformance";
		this.txtBoxMaxDatePerformance.Size = new System.Drawing.Size(157, 20);
		this.txtBoxMaxDatePerformance.TabIndex = 24;
		this.lblMaxDateConsiderPerf.Location = new System.Drawing.Point(115, 165);
		this.lblMaxDateConsiderPerf.Name = "lblMaxDateConsiderPerf";
		this.lblMaxDateConsiderPerf.Size = new System.Drawing.Size(160, 44);
		this.lblMaxDateConsiderPerf.TabIndex = 23;
		this.lblMaxDateConsiderPerf.Text = "Maximum number of days to consider as recent performance. (Range 45 - 1200 days)";
		this.txtBoxHandimanPerformance.Location = new System.Drawing.Point(118, 142);
		this.txtBoxHandimanPerformance.Name = "txtBoxHandimanPerformance";
		this.txtBoxHandimanPerformance.Size = new System.Drawing.Size(157, 20);
		this.txtBoxHandimanPerformance.TabIndex = 22;
		this.txtBoxModifiedBeyerSpeed.Location = new System.Drawing.Point(118, 103);
		this.txtBoxModifiedBeyerSpeed.Name = "txtBoxModifiedBeyerSpeed";
		this.txtBoxModifiedBeyerSpeed.Size = new System.Drawing.Size(157, 20);
		this.txtBoxModifiedBeyerSpeed.TabIndex = 21;
		this.lblHandimansPerformance.AutoSize = true;
		this.lblHandimansPerformance.Location = new System.Drawing.Point(115, 126);
		this.lblHandimansPerformance.Name = "lblHandimansPerformance";
		this.lblHandimansPerformance.Size = new System.Drawing.Size(136, 13);
		this.lblHandimansPerformance.TabIndex = 20;
		this.lblHandimansPerformance.Text = "FastTrack's Performance %";
		this.lblModifiedBeyerSpeed.AutoSize = true;
		this.lblModifiedBeyerSpeed.Location = new System.Drawing.Point(115, 87);
		this.lblModifiedBeyerSpeed.Name = "lblModifiedBeyerSpeed";
		this.lblModifiedBeyerSpeed.Size = new System.Drawing.Size(122, 13);
		this.lblModifiedBeyerSpeed.TabIndex = 19;
		this.lblModifiedBeyerSpeed.Text = "Modified Beyer Speed %";
		this.txtBoxBeyerDistance.Location = new System.Drawing.Point(118, 64);
		this.txtBoxBeyerDistance.Name = "txtBoxBeyerDistance";
		this.txtBoxBeyerDistance.Size = new System.Drawing.Size(157, 20);
		this.txtBoxBeyerDistance.TabIndex = 18;
		this.txtBoxBeyerPerformance.Location = new System.Drawing.Point(118, 25);
		this.txtBoxBeyerPerformance.Name = "txtBoxBeyerPerformance";
		this.txtBoxBeyerPerformance.Size = new System.Drawing.Size(157, 20);
		this.txtBoxBeyerPerformance.TabIndex = 17;
		this.lblBeyerDistance.AutoSize = true;
		this.lblBeyerDistance.Location = new System.Drawing.Point(115, 48);
		this.lblBeyerDistance.Name = "lblBeyerDistance";
		this.lblBeyerDistance.Size = new System.Drawing.Size(104, 13);
		this.lblBeyerDistance.TabIndex = 16;
		this.lblBeyerDistance.Text = "Beyer by Distance %";
		this.lblBeyerPerformance.AutoSize = true;
		this.lblBeyerPerformance.Location = new System.Drawing.Point(115, 9);
		this.lblBeyerPerformance.Name = "lblBeyerPerformance";
		this.lblBeyerPerformance.Size = new System.Drawing.Size(160, 13);
		this.lblBeyerPerformance.TabIndex = 15;
		this.lblBeyerPerformance.Text = "Beyer by Recent Performance %";
		this.lBoxEvent.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.lBoxEvent.FormattingEnabled = true;
		this.lBoxEvent.HorizontalScrollbar = true;
		this.lBoxEvent.Location = new System.Drawing.Point(282, 9);
		this.lBoxEvent.Name = "lBoxEvent";
		this.lBoxEvent.Size = new System.Drawing.Size(652, 145);
		this.lBoxEvent.TabIndex = 14;
		this.lBoxEvent.SelectedIndexChanged += new System.EventHandler(lBoxEvent_SelectedIndexChanged);
		this.lBoxEvent.ValueMemberChanged += new System.EventHandler(lBoxEvent_ValueMemberChanged);
		this.lBoxEvent.ControlAdded += new System.Windows.Forms.ControlEventHandler(lBoxEvent_ControlAdded);
		this.bttnStandardized.Enabled = false;
		this.bttnStandardized.Location = new System.Drawing.Point(12, 164);
		this.bttnStandardized.Name = "bttnStandardized";
		this.bttnStandardized.Size = new System.Drawing.Size(100, 24);
		this.bttnStandardized.TabIndex = 26;
		this.bttnStandardized.Text = "Standardized";
		this.bttnStandardized.UseVisualStyleBackColor = true;
		this.bttnStandardized.Click += new System.EventHandler(bttnStandardized_Click);
		this.bttnProcess.Enabled = false;
		this.bttnProcess.Location = new System.Drawing.Point(13, 189);
		this.bttnProcess.Name = "bttnProcess";
		this.bttnProcess.Size = new System.Drawing.Size(100, 24);
		this.bttnProcess.TabIndex = 27;
		this.bttnProcess.Text = "Process";
		this.bttnProcess.UseVisualStyleBackColor = true;
		this.bttnProcess.Click += new System.EventHandler(bttnProcess_Click);
		this.bttnNext.Enabled = false;
		this.bttnNext.Location = new System.Drawing.Point(12, 214);
		this.bttnNext.Name = "bttnNext";
		this.bttnNext.Size = new System.Drawing.Size(100, 24);
		this.bttnNext.TabIndex = 28;
		this.bttnNext.Text = "Next Race";
		this.bttnNext.UseVisualStyleBackColor = true;
		this.bttnNext.Click += new System.EventHandler(bttnNext_Click);
		this.lBoxFiles.FormattingEnabled = true;
		this.lBoxFiles.Location = new System.Drawing.Point(12, 12);
		this.lBoxFiles.Name = "lBoxFiles";
		this.lBoxFiles.Size = new System.Drawing.Size(102, 95);
		this.lBoxFiles.TabIndex = 29;
		this.bttnAllRace.Enabled = false;
		this.bttnAllRace.Location = new System.Drawing.Point(11, 139);
		this.bttnAllRace.Name = "bttnAllRace";
		this.bttnAllRace.Size = new System.Drawing.Size(100, 24);
		this.bttnAllRace.TabIndex = 80;
		this.bttnAllRace.Text = "All Race";
		this.bttnAllRace.UseVisualStyleBackColor = true;
		this.bttnAllRace.Click += new System.EventHandler(bttnAllRace_Click);
		dataGridViewCellStyle.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
		dataGridViewCellStyle.BackColor = System.Drawing.SystemColors.Control;
		dataGridViewCellStyle.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0);
		dataGridViewCellStyle.ForeColor = System.Drawing.SystemColors.WindowText;
		dataGridViewCellStyle.SelectionBackColor = System.Drawing.SystemColors.Highlight;
		dataGridViewCellStyle.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
		dataGridViewCellStyle.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
		this.dataGridView1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle;
		this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
		dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
		dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
		dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0);
		dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
		dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
		dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
		dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
		this.dataGridView1.DefaultCellStyle = dataGridViewCellStyle2;
		this.dataGridView1.Location = new System.Drawing.Point(281, 197);
		this.dataGridView1.Name = "dataGridView1";
		dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
		dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control;
		dataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0);
		dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText;
		dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
		dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
		dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
		this.dataGridView1.RowHeadersDefaultCellStyle = dataGridViewCellStyle3;
		this.dataGridView1.Size = new System.Drawing.Size(527, 266);
		this.dataGridView1.TabIndex = 31;
		this.lblTRaceTrack.AutoSize = true;
		this.lblTRaceTrack.Location = new System.Drawing.Point(281, 157);
		this.lblTRaceTrack.Name = "lblTRaceTrack";
		this.lblTRaceTrack.Size = new System.Drawing.Size(75, 13);
		this.lblTRaceTrack.TabIndex = 32;
		this.lblTRaceTrack.Text = "RACE TRACK";
		this.lblRaceTrack.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.lblRaceTrack.Location = new System.Drawing.Point(281, 171);
		this.lblRaceTrack.Name = "lblRaceTrack";
		this.lblRaceTrack.Size = new System.Drawing.Size(120, 23);
		this.lblRaceTrack.TabIndex = 33;
		this.lblRaceTrack.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
		this.lblDate.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.lblDate.Location = new System.Drawing.Point(407, 171);
		this.lblDate.Name = "lblDate";
		this.lblDate.Size = new System.Drawing.Size(120, 23);
		this.lblDate.TabIndex = 35;
		this.lblDate.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
		this.lblTDate.AutoSize = true;
		this.lblTDate.Location = new System.Drawing.Point(407, 157);
		this.lblTDate.Name = "lblTDate";
		this.lblTDate.Size = new System.Drawing.Size(36, 13);
		this.lblTDate.TabIndex = 34;
		this.lblTDate.Text = "DATE";
		this.lblRaceNum.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.lblRaceNum.Location = new System.Drawing.Point(534, 171);
		this.lblRaceNum.Name = "lblRaceNum";
		this.lblRaceNum.Size = new System.Drawing.Size(120, 23);
		this.lblRaceNum.TabIndex = 37;
		this.lblRaceNum.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
		this.lblTRaceNum.AutoSize = true;
		this.lblTRaceNum.Location = new System.Drawing.Point(534, 157);
		this.lblTRaceNum.Name = "lblTRaceNum";
		this.lblTRaceNum.Size = new System.Drawing.Size(86, 13);
		this.lblTRaceNum.TabIndex = 36;
		this.lblTRaceNum.Text = "RACE NUMBER";
		this.lblCalcType.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.lblCalcType.Location = new System.Drawing.Point(660, 170);
		this.lblCalcType.Name = "lblCalcType";
		this.lblCalcType.Size = new System.Drawing.Size(120, 23);
		this.lblCalcType.TabIndex = 38;
		this.lblCalcType.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
		this.txtBoxWorkout.Location = new System.Drawing.Point(113, 345);
		this.txtBoxWorkout.Name = "txtBoxWorkout";
		this.txtBoxWorkout.Size = new System.Drawing.Size(29, 20);
		this.txtBoxWorkout.TabIndex = 42;
		this.txtBoxWorkout.Text = "20";
		this.txtBoxWorkout.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.txtBoxHandimanPercent.Location = new System.Drawing.Point(112, 297);
		this.txtBoxHandimanPercent.Name = "txtBoxHandimanPercent";
		this.txtBoxHandimanPercent.Size = new System.Drawing.Size(29, 20);
		this.txtBoxHandimanPercent.TabIndex = 41;
		this.txtBoxHandimanPercent.Text = "80";
		this.txtBoxHandimanPercent.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblGreater0Workout.AutoSize = true;
		this.lblGreater0Workout.Location = new System.Drawing.Point(8, 348);
		this.lblGreater0Workout.Name = "lblGreater0Workout";
		this.lblGreater0Workout.Size = new System.Drawing.Size(59, 13);
		this.lblGreater0Workout.TabIndex = 40;
		this.lblGreater0Workout.Text = "Workout %";
		this.lblGreater0Handiman.AutoSize = true;
		this.lblGreater0Handiman.Location = new System.Drawing.Point(8, 301);
		this.lblGreater0Handiman.Name = "lblGreater0Handiman";
		this.lblGreater0Handiman.Size = new System.Drawing.Size(66, 13);
		this.lblGreater0Handiman.TabIndex = 39;
		this.lblGreater0Handiman.Text = "FastTrack %";
		this.txtBoxJockey.Location = new System.Drawing.Point(112, 371);
		this.txtBoxJockey.Name = "txtBoxJockey";
		this.txtBoxJockey.Size = new System.Drawing.Size(29, 20);
		this.txtBoxJockey.TabIndex = 44;
		this.txtBoxJockey.Text = "20";
		this.txtBoxJockey.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblGreater0Jockey.AutoSize = true;
		this.lblGreater0Jockey.Location = new System.Drawing.Point(8, 373);
		this.lblGreater0Jockey.Name = "lblGreater0Jockey";
		this.lblGreater0Jockey.Size = new System.Drawing.Size(52, 13);
		this.lblGreater0Jockey.TabIndex = 43;
		this.lblGreater0Jockey.Text = "Jockey %";
		this.txtBoxTrainer.Location = new System.Drawing.Point(112, 397);
		this.txtBoxTrainer.Name = "txtBoxTrainer";
		this.txtBoxTrainer.Size = new System.Drawing.Size(29, 20);
		this.txtBoxTrainer.TabIndex = 46;
		this.txtBoxTrainer.Text = "20";
		this.txtBoxTrainer.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblGreater0Trainer.AutoSize = true;
		this.lblGreater0Trainer.Location = new System.Drawing.Point(8, 398);
		this.lblGreater0Trainer.Name = "lblGreater0Trainer";
		this.lblGreater0Trainer.Size = new System.Drawing.Size(51, 13);
		this.lblGreater0Trainer.TabIndex = 45;
		this.lblGreater0Trainer.Text = "Trainer %";
		this.lblTitleAdjustmentGreater0.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0);
		this.lblTitleAdjustmentGreater0.Location = new System.Drawing.Point(76, 273);
		this.lblTitleAdjustmentGreater0.Name = "lblTitleAdjustmentGreater0";
		this.lblTitleAdjustmentGreater0.Size = new System.Drawing.Size(100, 24);
		this.lblTitleAdjustmentGreater0.TabIndex = 47;
		this.lblTitleAdjustmentGreater0.Text = "Adjustment";
		this.lblTitleAdjustmentGreater0.TextAlign = System.Drawing.ContentAlignment.TopCenter;
		this.lblTitleAdjustmentEqual0.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0);
		this.lblTitleAdjustmentEqual0.Location = new System.Drawing.Point(174, 263);
		this.lblTitleAdjustmentEqual0.Name = "lblTitleAdjustmentEqual0";
		this.lblTitleAdjustmentEqual0.Size = new System.Drawing.Size(100, 35);
		this.lblTitleAdjustmentEqual0.TabIndex = 48;
		this.lblTitleAdjustmentEqual0.Text = "Adjustment For 1st Time Horse";
		this.lblTitleAdjustmentEqual0.TextAlign = System.Drawing.ContentAlignment.TopCenter;
		this.txtBoxEq0Trainer.Location = new System.Drawing.Point(208, 397);
		this.txtBoxEq0Trainer.Name = "txtBoxEq0Trainer";
		this.txtBoxEq0Trainer.Size = new System.Drawing.Size(29, 20);
		this.txtBoxEq0Trainer.TabIndex = 56;
		this.txtBoxEq0Trainer.Text = "20";
		this.txtBoxEq0Trainer.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.txtBoxEq0Jockey.Location = new System.Drawing.Point(208, 371);
		this.txtBoxEq0Jockey.Name = "txtBoxEq0Jockey";
		this.txtBoxEq0Jockey.Size = new System.Drawing.Size(29, 20);
		this.txtBoxEq0Jockey.TabIndex = 54;
		this.txtBoxEq0Jockey.Text = "20";
		this.txtBoxEq0Jockey.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.txtBoxEq0Workout.Location = new System.Drawing.Point(208, 345);
		this.txtBoxEq0Workout.Name = "txtBoxEq0Workout";
		this.txtBoxEq0Workout.Size = new System.Drawing.Size(29, 20);
		this.txtBoxEq0Workout.TabIndex = 51;
		this.txtBoxEq0Workout.Text = "80";
		this.txtBoxEq0Workout.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblMaxDaysWorkout.Location = new System.Drawing.Point(10, 527);
		this.lblMaxDaysWorkout.Name = "lblMaxDaysWorkout";
		this.lblMaxDaysWorkout.Size = new System.Drawing.Size(132, 41);
		this.lblMaxDaysWorkout.TabIndex = 57;
		this.lblMaxDaysWorkout.Text = "Maximum days to consider as recent workout";
		this.txtBoxMaxWorkoutDays.Location = new System.Drawing.Point(152, 534);
		this.txtBoxMaxWorkoutDays.Name = "txtBoxMaxWorkoutDays";
		this.txtBoxMaxWorkoutDays.Size = new System.Drawing.Size(95, 20);
		this.txtBoxMaxWorkoutDays.TabIndex = 58;
		this.txtBoxMaxWorkoutDays.Text = "60";
		this.bttnSaveAdjustment.Location = new System.Drawing.Point(13, 648);
		this.bttnSaveAdjustment.Name = "bttnSaveAdjustment";
		this.bttnSaveAdjustment.Size = new System.Drawing.Size(103, 38);
		this.bttnSaveAdjustment.TabIndex = 59;
		this.bttnSaveAdjustment.Text = "Save Adjustment Parameters";
		this.bttnSaveAdjustment.UseVisualStyleBackColor = true;
		this.bttnSaveAdjustment.Click += new System.EventHandler(bttnSaveAdjustment_Click);
		this.txtBoxClaimPrice.Location = new System.Drawing.Point(112, 423);
		this.txtBoxClaimPrice.Name = "txtBoxClaimPrice";
		this.txtBoxClaimPrice.Size = new System.Drawing.Size(29, 20);
		this.txtBoxClaimPrice.TabIndex = 61;
		this.txtBoxClaimPrice.Text = "20";
		this.txtBoxClaimPrice.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblClaimPriceTrend.Location = new System.Drawing.Point(8, 423);
		this.lblClaimPriceTrend.Name = "lblClaimPriceTrend";
		this.lblClaimPriceTrend.Size = new System.Drawing.Size(102, 17);
		this.lblClaimPriceTrend.TabIndex = 60;
		this.lblClaimPriceTrend.Text = "Claim Price Trend %";
		this.txtBoxBettingLine.Location = new System.Drawing.Point(112, 449);
		this.txtBoxBettingLine.Name = "txtBoxBettingLine";
		this.txtBoxBettingLine.Size = new System.Drawing.Size(29, 20);
		this.txtBoxBettingLine.TabIndex = 63;
		this.txtBoxBettingLine.Text = "20";
		this.txtBoxBettingLine.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblBettingLine.Location = new System.Drawing.Point(8, 452);
		this.lblBettingLine.Name = "lblBettingLine";
		this.lblBettingLine.Size = new System.Drawing.Size(98, 17);
		this.lblBettingLine.TabIndex = 62;
		this.lblBettingLine.Text = "Betting Line %";
		this.txtBoxEq0BettingLine.Location = new System.Drawing.Point(208, 449);
		this.txtBoxEq0BettingLine.Name = "txtBoxEq0BettingLine";
		this.txtBoxEq0BettingLine.Size = new System.Drawing.Size(29, 20);
		this.txtBoxEq0BettingLine.TabIndex = 65;
		this.txtBoxEq0BettingLine.Text = "20";
		this.txtBoxEq0BettingLine.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.txtBoxEq0ClaimPrice.Location = new System.Drawing.Point(208, 423);
		this.txtBoxEq0ClaimPrice.Name = "txtBoxEq0ClaimPrice";
		this.txtBoxEq0ClaimPrice.Size = new System.Drawing.Size(29, 20);
		this.txtBoxEq0ClaimPrice.TabIndex = 64;
		this.txtBoxEq0ClaimPrice.Text = "20";
		this.txtBoxEq0ClaimPrice.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
		dataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control;
		dataGridViewCellStyle4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0);
		dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
		dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
		dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
		dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
		this.dataGridView2.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle4;
		this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
		dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
		dataGridViewCellStyle5.BackColor = System.Drawing.SystemColors.Window;
		dataGridViewCellStyle5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0);
		dataGridViewCellStyle5.ForeColor = System.Drawing.SystemColors.ControlText;
		dataGridViewCellStyle5.SelectionBackColor = System.Drawing.SystemColors.Highlight;
		dataGridViewCellStyle5.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
		dataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
		this.dataGridView2.DefaultCellStyle = dataGridViewCellStyle5;
		this.dataGridView2.Location = new System.Drawing.Point(282, 469);
		this.dataGridView2.Name = "dataGridView2";
		dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
		dataGridViewCellStyle6.BackColor = System.Drawing.SystemColors.Control;
		dataGridViewCellStyle6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0);
		dataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.WindowText;
		dataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight;
		dataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
		dataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
		this.dataGridView2.RowHeadersDefaultCellStyle = dataGridViewCellStyle6;
		this.dataGridView2.Size = new System.Drawing.Size(653, 109);
		this.dataGridView2.TabIndex = 66;
		this.dataGridView2.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(dataGridView2_CellContentClick);
		this.txtBoxClosingTrend.Location = new System.Drawing.Point(112, 473);
		this.txtBoxClosingTrend.Name = "txtBoxClosingTrend";
		this.txtBoxClosingTrend.Size = new System.Drawing.Size(29, 20);
		this.txtBoxClosingTrend.TabIndex = 68;
		this.txtBoxClosingTrend.Text = "20";
		this.txtBoxClosingTrend.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblClosingTrend.Location = new System.Drawing.Point(8, 476);
		this.lblClosingTrend.Name = "lblClosingTrend";
		this.lblClosingTrend.Size = new System.Drawing.Size(99, 17);
		this.lblClosingTrend.TabIndex = 67;
		this.lblClosingTrend.Text = "Closer %";
		this.lblJockeyNumOfRaces.Location = new System.Drawing.Point(9, 557);
		this.lblJockeyNumOfRaces.Name = "lblJockeyNumOfRaces";
		this.lblJockeyNumOfRaces.Size = new System.Drawing.Size(131, 28);
		this.lblJockeyNumOfRaces.TabIndex = 69;
		this.lblJockeyNumOfRaces.Text = "Jockey minimum number of Races";
		this.lblJockeyNumOfRaces.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
		this.txtBoxMinNumOfRaces.Location = new System.Drawing.Point(151, 560);
		this.txtBoxMinNumOfRaces.Name = "txtBoxMinNumOfRaces";
		this.txtBoxMinNumOfRaces.Size = new System.Drawing.Size(95, 20);
		this.txtBoxMinNumOfRaces.TabIndex = 70;
		this.txtBoxMinNumOfRaces.Text = "10";
		this.txtBoxStretchCall.Location = new System.Drawing.Point(112, 497);
		this.txtBoxStretchCall.Name = "txtBoxStretchCall";
		this.txtBoxStretchCall.Size = new System.Drawing.Size(29, 20);
		this.txtBoxStretchCall.TabIndex = 72;
		this.txtBoxStretchCall.Text = "0";
		this.txtBoxStretchCall.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblStretchCall.Location = new System.Drawing.Point(8, 500);
		this.lblStretchCall.Name = "lblStretchCall";
		this.lblStretchCall.Size = new System.Drawing.Size(99, 17);
		this.lblStretchCall.TabIndex = 71;
		this.lblStretchCall.Text = "Time Placement %";
		this.txtBoxFavorite.Location = new System.Drawing.Point(151, 587);
		this.txtBoxFavorite.Name = "txtBoxFavorite";
		this.txtBoxFavorite.Size = new System.Drawing.Size(95, 20);
		this.txtBoxFavorite.TabIndex = 74;
		this.txtBoxFavorite.Text = "4";
		this.lblFavorite.Location = new System.Drawing.Point(11, 587);
		this.lblFavorite.Name = "lblFavorite";
		this.lblFavorite.Size = new System.Drawing.Size(130, 28);
		this.lblFavorite.TabIndex = 73;
		this.lblFavorite.Text = "Favorite needs to be in top:";
		this.lblFavorite.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
		this.txtBoxDefineFavorite.Location = new System.Drawing.Point(150, 617);
		this.txtBoxDefineFavorite.Name = "txtBoxDefineFavorite";
		this.txtBoxDefineFavorite.Size = new System.Drawing.Size(95, 20);
		this.txtBoxDefineFavorite.TabIndex = 76;
		this.txtBoxDefineFavorite.Text = "4";
		this.label1.Location = new System.Drawing.Point(10, 617);
		this.label1.Name = "label1";
		this.label1.Size = new System.Drawing.Size(130, 28);
		this.label1.TabIndex = 75;
		this.label1.Text = "Favorite define as any line less than or equal to";
		this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
		this.bttnReport.Location = new System.Drawing.Point(281, 635);
		this.bttnReport.Name = "bttnReport";
		this.bttnReport.Size = new System.Drawing.Size(63, 41);
		this.bttnReport.TabIndex = 77;
		this.bttnReport.Text = "Create Report";
		this.bttnReport.UseVisualStyleBackColor = true;
		this.bttnReport.Click += new System.EventHandler(bttnReport_Click);
		this.cbTrack.FormattingEnabled = true;
		this.cbTrack.Location = new System.Drawing.Point(281, 584);
		this.cbTrack.Name = "cbTrack";
		this.cbTrack.Size = new System.Drawing.Size(129, 21);
		this.cbTrack.TabIndex = 78;
		this.cbTrack.Text = "Track";
		this.cbTrack.SelectedIndexChanged += new System.EventHandler(cbTrack_SelectedIndexChanged);
		this.cbRacingDate.FormattingEnabled = true;
		this.cbRacingDate.Location = new System.Drawing.Point(281, 610);
		this.cbRacingDate.Name = "cbRacingDate";
		this.cbRacingDate.Size = new System.Drawing.Size(129, 21);
		this.cbRacingDate.TabIndex = 79;
		this.cbRacingDate.Text = "Racing Date";
		this.cbModRacingDt.FormattingEnabled = true;
		this.cbModRacingDt.Location = new System.Drawing.Point(814, 223);
		this.cbModRacingDt.Name = "cbModRacingDt";
		this.cbModRacingDt.Size = new System.Drawing.Size(120, 21);
		this.cbModRacingDt.TabIndex = 83;
		this.cbModRacingDt.Text = "Racing Date";
		this.cbModRacingDt.SelectedIndexChanged += new System.EventHandler(cbModRacingDt_SelectedIndexChanged);
		this.cbModTrack.FormattingEnabled = true;
		this.cbModTrack.Location = new System.Drawing.Point(814, 197);
		this.cbModTrack.Name = "cbModTrack";
		this.cbModTrack.Size = new System.Drawing.Size(120, 21);
		this.cbModTrack.TabIndex = 82;
		this.cbModTrack.Text = "Track";
		this.cbModTrack.SelectedIndexChanged += new System.EventHandler(cbModTrack_SelectedIndexChanged);
		this.bttnSave.Location = new System.Drawing.Point(814, 323);
		this.bttnSave.Name = "bttnSave";
		this.bttnSave.Size = new System.Drawing.Size(120, 41);
		this.bttnSave.TabIndex = 81;
		this.bttnSave.Text = "SAVE";
		this.bttnSave.UseVisualStyleBackColor = true;
		this.bttnSave.Click += new System.EventHandler(bttnSave_Click);
		this.cbModHorseName.FormattingEnabled = true;
		this.cbModHorseName.Location = new System.Drawing.Point(814, 272);
		this.cbModHorseName.Name = "cbModHorseName";
		this.cbModHorseName.Size = new System.Drawing.Size(120, 21);
		this.cbModHorseName.TabIndex = 85;
		this.cbModHorseName.Text = "Horse Name";
		this.cbModRaceNum.FormattingEnabled = true;
		this.cbModRaceNum.Location = new System.Drawing.Point(814, 246);
		this.cbModRaceNum.Name = "cbModRaceNum";
		this.cbModRaceNum.Size = new System.Drawing.Size(120, 21);
		this.cbModRaceNum.TabIndex = 84;
		this.cbModRaceNum.Text = "Race Number";
		this.cbModRaceNum.SelectedIndexChanged += new System.EventHandler(cbModRaceNum_SelectedIndexChanged);
		this.txtBoxFrankPoint.Location = new System.Drawing.Point(814, 299);
		this.txtBoxFrankPoint.Name = "txtBoxFrankPoint";
		this.txtBoxFrankPoint.Size = new System.Drawing.Size(120, 20);
		this.txtBoxFrankPoint.TabIndex = 86;
		this.txtBoxSpeedRating.Location = new System.Drawing.Point(112, 321);
		this.txtBoxSpeedRating.Name = "txtBoxSpeedRating";
		this.txtBoxSpeedRating.Size = new System.Drawing.Size(29, 20);
		this.txtBoxSpeedRating.TabIndex = 88;
		this.txtBoxSpeedRating.Text = "80";
		this.txtBoxSpeedRating.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
		this.lblGreater0SpeedRating.AutoSize = true;
		this.lblGreater0SpeedRating.Location = new System.Drawing.Point(8, 325);
		this.lblGreater0SpeedRating.Name = "lblGreater0SpeedRating";
		this.lblGreater0SpeedRating.Size = new System.Drawing.Size(83, 13);
		this.lblGreater0SpeedRating.TabIndex = 87;
		this.lblGreater0SpeedRating.Text = "Speed Rating %";
		this.fileSystemWatcher1.EnableRaisingEvents = true;
		this.fileSystemWatcher1.NotifyFilter = System.IO.NotifyFilters.FileName;
		this.fileSystemWatcher1.SynchronizingObject = this;
		this.fileSystemWatcher1.Changed += new System.IO.FileSystemEventHandler(fileSystemWatcher1_Changed);
		this.bttnBeginPolling.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0);
		this.bttnBeginPolling.Location = new System.Drawing.Point(452, 584);
		this.bttnBeginPolling.Name = "bttnBeginPolling";
		this.bttnBeginPolling.Size = new System.Drawing.Size(96, 90);
		this.bttnBeginPolling.TabIndex = 89;
		this.bttnBeginPolling.Text = "OLD";
		this.bttnBeginPolling.UseVisualStyleBackColor = true;
		this.bttnBeginPolling.Click += new System.EventHandler(bttnBeginPolling_Click);
		this.button4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0);
		this.button4.Location = new System.Drawing.Point(554, 584);
		this.button4.Name = "button4";
		this.button4.Size = new System.Drawing.Size(96, 90);
		this.button4.TabIndex = 94;
		this.button4.Text = "NEW";
		this.button4.UseVisualStyleBackColor = true;
		this.button4.Click += new System.EventHandler(button4_Click);
		this.ckBoxCloud.AutoSize = true;
		this.ckBoxCloud.Checked = true;
		this.ckBoxCloud.CheckState = System.Windows.Forms.CheckState.Checked;
		this.ckBoxCloud.Location = new System.Drawing.Point(660, 584);
		this.ckBoxCloud.Name = "ckBoxCloud";
		this.ckBoxCloud.Size = new System.Drawing.Size(91, 17);
		this.ckBoxCloud.TabIndex = 95;
		this.ckBoxCloud.Text = "To The Cloud";
		this.ckBoxCloud.UseVisualStyleBackColor = true;
		this.cbBoxProfile.FormattingEnabled = true;
		this.cbBoxProfile.Items.AddRange(new object[2] { "1", "2" });
		this.cbBoxProfile.Location = new System.Drawing.Point(120, 653);
		this.cbBoxProfile.Name = "cbBoxProfile";
		this.cbBoxProfile.Size = new System.Drawing.Size(47, 21);
		this.cbBoxProfile.TabIndex = 96;
		this.cbBoxProfile.Text = "1";
		this.bttnLoadAdjustment.Location = new System.Drawing.Point(172, 648);
		this.bttnLoadAdjustment.Name = "bttnLoadAdjustment";
		this.bttnLoadAdjustment.Size = new System.Drawing.Size(103, 38);
		this.bttnLoadAdjustment.TabIndex = 97;
		this.bttnLoadAdjustment.Text = "Load Adjustment Parameters";
		this.bttnLoadAdjustment.UseVisualStyleBackColor = true;
		this.bttnLoadAdjustment.Click += new System.EventHandler(bttnLoadAdjustment_Click);
		this.cbBoxNewRaceNum.FormattingEnabled = true;
		this.cbBoxNewRaceNum.Location = new System.Drawing.Point(660, 607);
		this.cbBoxNewRaceNum.Name = "cbBoxNewRaceNum";
		this.cbBoxNewRaceNum.Size = new System.Drawing.Size(91, 21);
		this.cbBoxNewRaceNum.TabIndex = 98;
		this.bttnProcessNew.Location = new System.Drawing.Point(660, 635);
		this.bttnProcessNew.Name = "bttnProcessNew";
		this.bttnProcessNew.Size = new System.Drawing.Size(91, 39);
		this.bttnProcessNew.TabIndex = 99;
		this.bttnProcessNew.Text = "Process New ";
		this.bttnProcessNew.UseVisualStyleBackColor = true;
		this.bttnProcessNew.Click += new System.EventHandler(bttnProcessNew_Click);
		this.bttnResult.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 0);
		this.bttnResult.Location = new System.Drawing.Point(347, 635);
		this.bttnResult.Name = "bttnResult";
		this.bttnResult.Size = new System.Drawing.Size(63, 41);
		this.bttnResult.TabIndex = 100;
		this.bttnResult.Text = "Result";
		this.bttnResult.UseVisualStyleBackColor = true;
		this.bttnResult.Click += new System.EventHandler(bttnResult_Click);
		this.bttnProcessResult.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, 0);
		this.bttnProcessResult.Location = new System.Drawing.Point(757, 584);
		this.bttnProcessResult.Name = "bttnProcessResult";
		this.bttnProcessResult.Size = new System.Drawing.Size(96, 90);
		this.bttnProcessResult.TabIndex = 101;
		this.bttnProcessResult.Text = "LOAD RESULT";
		this.bttnProcessResult.UseVisualStyleBackColor = true;
		this.bttnProcessResult.Click += new System.EventHandler(bttnProcessResult_Click);
		this.button1.Location = new System.Drawing.Point(859, 622);
		this.button1.Name = "button1";
		this.button1.Size = new System.Drawing.Size(75, 23);
		this.button1.TabIndex = 102;
		this.button1.Text = "button1";
		this.button1.UseVisualStyleBackColor = true;
		this.button1.Click += new System.EventHandler(button1_Click_1);
		base.AutoScaleDimensions = new System.Drawing.SizeF(6f, 13f);
		base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
		base.ClientSize = new System.Drawing.Size(942, 686);
		base.Controls.Add(this.button1);
		base.Controls.Add(this.bttnProcessResult);
		base.Controls.Add(this.bttnResult);
		base.Controls.Add(this.bttnProcessNew);
		base.Controls.Add(this.cbBoxNewRaceNum);
		base.Controls.Add(this.bttnLoadAdjustment);
		base.Controls.Add(this.cbBoxProfile);
		base.Controls.Add(this.ckBoxCloud);
		base.Controls.Add(this.button4);
		base.Controls.Add(this.bttnBeginPolling);
		base.Controls.Add(this.bttnAllRace);
		base.Controls.Add(this.txtBoxSpeedRating);
		base.Controls.Add(this.bttnStandardized);
		base.Controls.Add(this.lblGreater0SpeedRating);
		base.Controls.Add(this.txtBoxFrankPoint);
		base.Controls.Add(this.cbModHorseName);
		base.Controls.Add(this.cbModRaceNum);
		base.Controls.Add(this.cbModRacingDt);
		base.Controls.Add(this.cbModTrack);
		base.Controls.Add(this.bttnSave);
		base.Controls.Add(this.cbRacingDate);
		base.Controls.Add(this.cbTrack);
		base.Controls.Add(this.bttnReport);
		base.Controls.Add(this.txtBoxDefineFavorite);
		base.Controls.Add(this.label1);
		base.Controls.Add(this.txtBoxFavorite);
		base.Controls.Add(this.lblFavorite);
		base.Controls.Add(this.txtBoxStretchCall);
		base.Controls.Add(this.lblStretchCall);
		base.Controls.Add(this.txtBoxMinNumOfRaces);
		base.Controls.Add(this.lblJockeyNumOfRaces);
		base.Controls.Add(this.txtBoxClosingTrend);
		base.Controls.Add(this.lblClosingTrend);
		base.Controls.Add(this.dataGridView2);
		base.Controls.Add(this.txtBoxEq0BettingLine);
		base.Controls.Add(this.txtBoxEq0ClaimPrice);
		base.Controls.Add(this.txtBoxBettingLine);
		base.Controls.Add(this.lblBettingLine);
		base.Controls.Add(this.txtBoxClaimPrice);
		base.Controls.Add(this.lblClaimPriceTrend);
		base.Controls.Add(this.bttnSaveAdjustment);
		base.Controls.Add(this.txtBoxMaxWorkoutDays);
		base.Controls.Add(this.lblMaxDaysWorkout);
		base.Controls.Add(this.txtBoxEq0Trainer);
		base.Controls.Add(this.txtBoxEq0Jockey);
		base.Controls.Add(this.txtBoxEq0Workout);
		base.Controls.Add(this.lblTitleAdjustmentEqual0);
		base.Controls.Add(this.lblTitleAdjustmentGreater0);
		base.Controls.Add(this.txtBoxTrainer);
		base.Controls.Add(this.lblGreater0Trainer);
		base.Controls.Add(this.txtBoxJockey);
		base.Controls.Add(this.lblGreater0Jockey);
		base.Controls.Add(this.txtBoxWorkout);
		base.Controls.Add(this.txtBoxHandimanPercent);
		base.Controls.Add(this.lblGreater0Workout);
		base.Controls.Add(this.lblGreater0Handiman);
		base.Controls.Add(this.lblCalcType);
		base.Controls.Add(this.lblRaceNum);
		base.Controls.Add(this.lblTRaceNum);
		base.Controls.Add(this.lblDate);
		base.Controls.Add(this.lblTDate);
		base.Controls.Add(this.lblRaceTrack);
		base.Controls.Add(this.lblTRaceTrack);
		base.Controls.Add(this.dataGridView1);
		base.Controls.Add(this.lBoxFiles);
		base.Controls.Add(this.bttnNext);
		base.Controls.Add(this.bttnProcess);
		base.Controls.Add(this.lblCondition);
		base.Controls.Add(this.txtBoxMaxDatePerformance);
		base.Controls.Add(this.lblMaxDateConsiderPerf);
		base.Controls.Add(this.txtBoxHandimanPerformance);
		base.Controls.Add(this.txtBoxModifiedBeyerSpeed);
		base.Controls.Add(this.lblHandimansPerformance);
		base.Controls.Add(this.lblModifiedBeyerSpeed);
		base.Controls.Add(this.txtBoxBeyerDistance);
		base.Controls.Add(this.txtBoxBeyerPerformance);
		base.Controls.Add(this.lblBeyerDistance);
		base.Controls.Add(this.lblBeyerPerformance);
		base.Controls.Add(this.lBoxEvent);
		base.Controls.Add(this.bttnImport);
		base.Icon = (System.Drawing.Icon)resources.GetObject("$this.Icon");
		this.MaximumSize = new System.Drawing.Size(958, 724);
		this.MinimumSize = new System.Drawing.Size(958, 724);
		base.Name = "frmMain";
		this.Text = "FastTrack";
		base.Load += new System.EventHandler(frmMain_Load);
		((System.ComponentModel.ISupportInitialize)this.bindingSource1).EndInit();
		((System.ComponentModel.ISupportInitialize)this.dataGridView1).EndInit();
		((System.ComponentModel.ISupportInitialize)this.dataGridView2).EndInit();
		((System.ComponentModel.ISupportInitialize)this.fileSystemWatcher1).EndInit();
		base.ResumeLayout(false);
		base.PerformLayout();
	}
}
