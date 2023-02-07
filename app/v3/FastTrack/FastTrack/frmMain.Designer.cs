namespace FastTrack
{
    partial class frmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.bttnStart = new System.Windows.Forms.Button();
            this.lBoxFiles = new System.Windows.Forms.ListBox();
            this.lblFileLocation = new System.Windows.Forms.Label();
            this.lblFileLocationPath = new System.Windows.Forms.Label();
            this.lblFilesInQueueCount = new System.Windows.Forms.Label();
            this.lblFilesInQueue = new System.Windows.Forms.Label();
            this.lblProcessCount = new System.Windows.Forms.Label();
            this.lblProcess = new System.Windows.Forms.Label();
            this.lblTotalFilesCount = new System.Windows.Forms.Label();
            this.lblTotalFiles = new System.Windows.Forms.Label();
            this.lblFileName = new System.Windows.Forms.Label();
            this.lblFileNameProcess = new System.Windows.Forms.Label();
            this.lblRaceNumTitle = new System.Windows.Forms.Label();
            this.lblRaceNum = new System.Windows.Forms.Label();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.pickerRaceDt = new System.Windows.Forms.DateTimePicker();
            this.gBoxProgram = new System.Windows.Forms.GroupBox();
            this.cbTrack = new System.Windows.Forms.ComboBox();
            this.btnProgram = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.gBoxProgram.SuspendLayout();
            this.SuspendLayout();
            // 
            // bttnStart
            // 
            this.bttnStart.Location = new System.Drawing.Point(251, 189);
            this.bttnStart.Name = "bttnStart";
            this.bttnStart.Size = new System.Drawing.Size(144, 23);
            this.bttnStart.TabIndex = 0;
            this.bttnStart.Text = "START";
            this.bttnStart.UseVisualStyleBackColor = true;
            this.bttnStart.Click += new System.EventHandler(this.bttnStart_Click);
            // 
            // lBoxFiles
            // 
            this.lBoxFiles.FormattingEnabled = true;
            this.lBoxFiles.Location = new System.Drawing.Point(12, 15);
            this.lBoxFiles.Name = "lBoxFiles";
            this.lBoxFiles.Size = new System.Drawing.Size(181, 329);
            this.lBoxFiles.TabIndex = 1;
            // 
            // lblFileLocation
            // 
            this.lblFileLocation.AutoSize = true;
            this.lblFileLocation.Location = new System.Drawing.Point(199, 15);
            this.lblFileLocation.Name = "lblFileLocation";
            this.lblFileLocation.Size = new System.Drawing.Size(73, 13);
            this.lblFileLocation.TabIndex = 2;
            this.lblFileLocation.Text = "File Location: ";
            // 
            // lblFileLocationPath
            // 
            this.lblFileLocationPath.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblFileLocationPath.Location = new System.Drawing.Point(288, 15);
            this.lblFileLocationPath.Name = "lblFileLocationPath";
            this.lblFileLocationPath.Size = new System.Drawing.Size(160, 15);
            this.lblFileLocationPath.TabIndex = 3;
            // 
            // lblFilesInQueueCount
            // 
            this.lblFilesInQueueCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblFilesInQueueCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFilesInQueueCount.Location = new System.Drawing.Point(285, 75);
            this.lblFilesInQueueCount.Name = "lblFilesInQueueCount";
            this.lblFilesInQueueCount.Size = new System.Drawing.Size(76, 51);
            this.lblFilesInQueueCount.TabIndex = 5;
            this.lblFilesInQueueCount.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblFilesInQueue
            // 
            this.lblFilesInQueue.AutoSize = true;
            this.lblFilesInQueue.Location = new System.Drawing.Point(282, 57);
            this.lblFilesInQueue.Name = "lblFilesInQueue";
            this.lblFilesInQueue.Size = new System.Drawing.Size(74, 13);
            this.lblFilesInQueue.TabIndex = 4;
            this.lblFilesInQueue.Text = "Files in Queue";
            // 
            // lblProcessCount
            // 
            this.lblProcessCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblProcessCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblProcessCount.Location = new System.Drawing.Point(372, 75);
            this.lblProcessCount.Name = "lblProcessCount";
            this.lblProcessCount.Size = new System.Drawing.Size(76, 51);
            this.lblProcessCount.TabIndex = 7;
            this.lblProcessCount.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblProcess
            // 
            this.lblProcess.AutoSize = true;
            this.lblProcess.Location = new System.Drawing.Point(370, 57);
            this.lblProcess.Name = "lblProcess";
            this.lblProcess.Size = new System.Drawing.Size(69, 13);
            this.lblProcess.TabIndex = 6;
            this.lblProcess.Text = "Files Process";
            // 
            // lblTotalFilesCount
            // 
            this.lblTotalFilesCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblTotalFilesCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTotalFilesCount.Location = new System.Drawing.Point(197, 75);
            this.lblTotalFilesCount.Name = "lblTotalFilesCount";
            this.lblTotalFilesCount.Size = new System.Drawing.Size(76, 51);
            this.lblTotalFilesCount.TabIndex = 9;
            this.lblTotalFilesCount.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblTotalFiles
            // 
            this.lblTotalFiles.AutoSize = true;
            this.lblTotalFiles.Location = new System.Drawing.Point(202, 57);
            this.lblTotalFiles.Name = "lblTotalFiles";
            this.lblTotalFiles.Size = new System.Drawing.Size(55, 13);
            this.lblTotalFiles.TabIndex = 8;
            this.lblTotalFiles.Text = "Total Files";
            // 
            // lblFileName
            // 
            this.lblFileName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblFileName.Location = new System.Drawing.Point(288, 35);
            this.lblFileName.Name = "lblFileName";
            this.lblFileName.Size = new System.Drawing.Size(160, 15);
            this.lblFileName.TabIndex = 11;
            // 
            // lblFileNameProcess
            // 
            this.lblFileNameProcess.AutoSize = true;
            this.lblFileNameProcess.Location = new System.Drawing.Point(199, 35);
            this.lblFileNameProcess.Name = "lblFileNameProcess";
            this.lblFileNameProcess.Size = new System.Drawing.Size(60, 13);
            this.lblFileNameProcess.TabIndex = 10;
            this.lblFileNameProcess.Text = "File Name: ";
            // 
            // lblRaceNumTitle
            // 
            this.lblRaceNumTitle.Location = new System.Drawing.Point(212, 140);
            this.lblRaceNumTitle.Name = "lblRaceNumTitle";
            this.lblRaceNumTitle.Size = new System.Drawing.Size(61, 30);
            this.lblRaceNumTitle.TabIndex = 12;
            this.lblRaceNumTitle.Text = "Race Num:";
            this.lblRaceNumTitle.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lblRaceNum
            // 
            this.lblRaceNum.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblRaceNum.Location = new System.Drawing.Point(279, 140);
            this.lblRaceNum.Name = "lblRaceNum";
            this.lblRaceNum.Size = new System.Drawing.Size(146, 30);
            this.lblRaceNum.TabIndex = 13;
            this.lblRaceNum.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(850, 732);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(448, 413);
            this.dataGridView1.TabIndex = 14;
            // 
            // pickerRaceDt
            // 
            this.pickerRaceDt.Location = new System.Drawing.Point(6, 19);
            this.pickerRaceDt.Name = "pickerRaceDt";
            this.pickerRaceDt.Size = new System.Drawing.Size(234, 20);
            this.pickerRaceDt.TabIndex = 15;
            // 
            // gBoxProgram
            // 
            this.gBoxProgram.Controls.Add(this.btnProgram);
            this.gBoxProgram.Controls.Add(this.pickerRaceDt);
            this.gBoxProgram.Controls.Add(this.cbTrack);
            this.gBoxProgram.Location = new System.Drawing.Point(199, 230);
            this.gBoxProgram.Name = "gBoxProgram";
            this.gBoxProgram.Size = new System.Drawing.Size(249, 115);
            this.gBoxProgram.TabIndex = 16;
            this.gBoxProgram.TabStop = false;
            this.gBoxProgram.Text = "PROGRAM";
            // 
            // cbTrack
            // 
            this.cbTrack.FormattingEnabled = true;
            this.cbTrack.Location = new System.Drawing.Point(6, 45);
            this.cbTrack.Name = "cbTrack";
            this.cbTrack.Size = new System.Drawing.Size(234, 21);
            this.cbTrack.TabIndex = 16;
            this.cbTrack.Enter += new System.EventHandler(this.cbTrack_Enter);
            // 
            // btnProgram
            // 
            this.btnProgram.Location = new System.Drawing.Point(52, 78);
            this.btnProgram.Name = "btnProgram";
            this.btnProgram.Size = new System.Drawing.Size(144, 23);
            this.btnProgram.TabIndex = 17;
            this.btnProgram.Text = "CREATE PROGRAM";
            this.btnProgram.UseVisualStyleBackColor = true;
            this.btnProgram.Click += new System.EventHandler(this.btnProgram_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(456, 357);
            this.Controls.Add(this.gBoxProgram);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.lblRaceNum);
            this.Controls.Add(this.lblRaceNumTitle);
            this.Controls.Add(this.lblFileName);
            this.Controls.Add(this.lblFileNameProcess);
            this.Controls.Add(this.lblTotalFilesCount);
            this.Controls.Add(this.lblTotalFiles);
            this.Controls.Add(this.lblProcessCount);
            this.Controls.Add(this.lblProcess);
            this.Controls.Add(this.lblFilesInQueueCount);
            this.Controls.Add(this.lblFilesInQueue);
            this.Controls.Add(this.lblFileLocationPath);
            this.Controls.Add(this.lblFileLocation);
            this.Controls.Add(this.lBoxFiles);
            this.Controls.Add(this.bttnStart);
            this.Name = "frmMain";
            this.Text = "FAST TRACK v3.0";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.gBoxProgram.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button bttnStart;
        private System.Windows.Forms.ListBox lBoxFiles;
        private System.Windows.Forms.Label lblFileLocation;
        private System.Windows.Forms.Label lblFileLocationPath;
        private System.Windows.Forms.Label lblFilesInQueueCount;
        private System.Windows.Forms.Label lblFilesInQueue;
        private System.Windows.Forms.Label lblProcessCount;
        private System.Windows.Forms.Label lblProcess;
        private System.Windows.Forms.Label lblTotalFilesCount;
        private System.Windows.Forms.Label lblTotalFiles;
        private System.Windows.Forms.Label lblFileName;
        private System.Windows.Forms.Label lblFileNameProcess;
        private System.Windows.Forms.Label lblRaceNumTitle;
        private System.Windows.Forms.Label lblRaceNum;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.DateTimePicker pickerRaceDt;
        private System.Windows.Forms.GroupBox gBoxProgram;
        private System.Windows.Forms.ComboBox cbTrack;
        private System.Windows.Forms.Button btnProgram;
    }
}

