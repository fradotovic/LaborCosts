
namespace LaborCost
{
    partial class MainForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.toolStripMenuNEW = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuEmployee = new System.Windows.Forms.ToolStripMenuItem();
            this.allEmployeesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuContract = new System.Windows.Forms.ToolStripMenuItem();
            this.jobPositionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.updateContractToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.allContractsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuCreateShift = new System.Windows.Forms.ToolStripMenuItem();
            this.newShiftTypeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.allShiftsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuCreateLeave = new System.Windows.Forms.ToolStripMenuItem();
            this.allLeavesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuCreatePaycheck = new System.Windows.Forms.ToolStripMenuItem();
            this.allPaychecksToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripMenuMyShift = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripMenuMyPaychecks = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripMenuMyContract = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripMenuLeaves = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
            this.eToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.panel1 = new System.Windows.Forms.Panel();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.menuStrip1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripMenuNEW,
            this.toolStripSeparator4,
            this.toolStripMenuMyShift,
            this.toolStripSeparator1,
            this.toolStripMenuMyPaychecks,
            this.toolStripSeparator3,
            this.toolStripMenuMyContract,
            this.toolStripSeparator2,
            this.toolStripMenuLeaves,
            this.toolStripSeparator5,
            this.eToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.RenderMode = System.Windows.Forms.ToolStripRenderMode.Professional;
            this.menuStrip1.Size = new System.Drawing.Size(949, 51);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            this.menuStrip1.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.menuStrip1_ItemClicked);
            // 
            // toolStripMenuNEW
            // 
            this.toolStripMenuNEW.AutoSize = false;
            this.toolStripMenuNEW.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.toolStripMenuNEW.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("toolStripMenuNEW.BackgroundImage")));
            this.toolStripMenuNEW.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.toolStripMenuNEW.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripMenuEmployee,
            this.toolStripMenuContract,
            this.toolStripMenuCreateShift,
            this.toolStripMenuCreateLeave,
            this.toolStripMenuCreatePaycheck});
            this.toolStripMenuNEW.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.toolStripMenuNEW.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuNEW.Image")));
            this.toolStripMenuNEW.Name = "toolStripMenuNEW";
            this.toolStripMenuNEW.Size = new System.Drawing.Size(152, 47);
            this.toolStripMenuNEW.Text = "New";
            this.toolStripMenuNEW.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            // 
            // toolStripMenuEmployee
            // 
            this.toolStripMenuEmployee.BackColor = System.Drawing.SystemColors.Control;
            this.toolStripMenuEmployee.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.toolStripMenuEmployee.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.allEmployeesToolStripMenuItem});
            this.toolStripMenuEmployee.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuEmployee.Image")));
            this.toolStripMenuEmployee.Name = "toolStripMenuEmployee";
            this.toolStripMenuEmployee.Size = new System.Drawing.Size(224, 28);
            this.toolStripMenuEmployee.Text = "Employee";
            this.toolStripMenuEmployee.Click += new System.EventHandler(this.toolStripMenuEmployee_Click_1);
            // 
            // allEmployeesToolStripMenuItem
            // 
            this.allEmployeesToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("allEmployeesToolStripMenuItem.Image")));
            this.allEmployeesToolStripMenuItem.Name = "allEmployeesToolStripMenuItem";
            this.allEmployeesToolStripMenuItem.Size = new System.Drawing.Size(199, 28);
            this.allEmployeesToolStripMenuItem.Text = "All Employees";
            this.allEmployeesToolStripMenuItem.Click += new System.EventHandler(this.allEmployeesToolStripMenuItem_Click);
            // 
            // toolStripMenuContract
            // 
            this.toolStripMenuContract.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.jobPositionToolStripMenuItem,
            this.updateContractToolStripMenuItem,
            this.allContractsToolStripMenuItem});
            this.toolStripMenuContract.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuContract.Image")));
            this.toolStripMenuContract.Name = "toolStripMenuContract";
            this.toolStripMenuContract.Size = new System.Drawing.Size(224, 28);
            this.toolStripMenuContract.Text = "Contract";
            this.toolStripMenuContract.Click += new System.EventHandler(this.toolStripMenuItem6_Click);
            // 
            // jobPositionToolStripMenuItem
            // 
            this.jobPositionToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("jobPositionToolStripMenuItem.Image")));
            this.jobPositionToolStripMenuItem.Name = "jobPositionToolStripMenuItem";
            this.jobPositionToolStripMenuItem.Size = new System.Drawing.Size(224, 28);
            this.jobPositionToolStripMenuItem.Text = "New Job";
            this.jobPositionToolStripMenuItem.Click += new System.EventHandler(this.jobPositionToolStripMenuItem_Click);
            // 
            // updateContractToolStripMenuItem
            // 
            this.updateContractToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("updateContractToolStripMenuItem.Image")));
            this.updateContractToolStripMenuItem.Name = "updateContractToolStripMenuItem";
            this.updateContractToolStripMenuItem.Size = new System.Drawing.Size(224, 28);
            this.updateContractToolStripMenuItem.Text = "Update Contract";
            this.updateContractToolStripMenuItem.Click += new System.EventHandler(this.updateContractToolStripMenuItem_Click_1);
            // 
            // allContractsToolStripMenuItem
            // 
            this.allContractsToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("allContractsToolStripMenuItem.Image")));
            this.allContractsToolStripMenuItem.Name = "allContractsToolStripMenuItem";
            this.allContractsToolStripMenuItem.Size = new System.Drawing.Size(224, 28);
            this.allContractsToolStripMenuItem.Text = "All Contracts";
            this.allContractsToolStripMenuItem.Click += new System.EventHandler(this.allContractsToolStripMenuItem_Click);
            // 
            // toolStripMenuCreateShift
            // 
            this.toolStripMenuCreateShift.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newShiftTypeToolStripMenuItem,
            this.allShiftsToolStripMenuItem});
            this.toolStripMenuCreateShift.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuCreateShift.Image")));
            this.toolStripMenuCreateShift.Name = "toolStripMenuCreateShift";
            this.toolStripMenuCreateShift.Size = new System.Drawing.Size(224, 28);
            this.toolStripMenuCreateShift.Text = "Shift";
            this.toolStripMenuCreateShift.Click += new System.EventHandler(this.toolStripMenuCreateShift_Click);
            // 
            // newShiftTypeToolStripMenuItem
            // 
            this.newShiftTypeToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("newShiftTypeToolStripMenuItem.Image")));
            this.newShiftTypeToolStripMenuItem.Name = "newShiftTypeToolStripMenuItem";
            this.newShiftTypeToolStripMenuItem.Size = new System.Drawing.Size(224, 28);
            this.newShiftTypeToolStripMenuItem.Text = "New Shift Type";
            this.newShiftTypeToolStripMenuItem.Click += new System.EventHandler(this.newShiftTypeToolStripMenuItem_Click);
            // 
            // allShiftsToolStripMenuItem
            // 
            this.allShiftsToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("allShiftsToolStripMenuItem.Image")));
            this.allShiftsToolStripMenuItem.Name = "allShiftsToolStripMenuItem";
            this.allShiftsToolStripMenuItem.Size = new System.Drawing.Size(224, 28);
            this.allShiftsToolStripMenuItem.Text = "All Shifts";
            this.allShiftsToolStripMenuItem.Click += new System.EventHandler(this.allShiftsToolStripMenuItem_Click_1);
            // 
            // toolStripMenuCreateLeave
            // 
            this.toolStripMenuCreateLeave.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.allLeavesToolStripMenuItem});
            this.toolStripMenuCreateLeave.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuCreateLeave.Image")));
            this.toolStripMenuCreateLeave.Name = "toolStripMenuCreateLeave";
            this.toolStripMenuCreateLeave.Size = new System.Drawing.Size(224, 28);
            this.toolStripMenuCreateLeave.Text = "Leave";
            this.toolStripMenuCreateLeave.Click += new System.EventHandler(this.toolStripMenuCreateLeave_Click);
            // 
            // allLeavesToolStripMenuItem
            // 
            this.allLeavesToolStripMenuItem.BackColor = System.Drawing.SystemColors.Control;
            this.allLeavesToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("allLeavesToolStripMenuItem.Image")));
            this.allLeavesToolStripMenuItem.Name = "allLeavesToolStripMenuItem";
            this.allLeavesToolStripMenuItem.Size = new System.Drawing.Size(224, 28);
            this.allLeavesToolStripMenuItem.Text = "All Leaves";
            this.allLeavesToolStripMenuItem.Click += new System.EventHandler(this.allLeavesToolStripMenuItem_Click);
            // 
            // toolStripMenuCreatePaycheck
            // 
            this.toolStripMenuCreatePaycheck.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.allPaychecksToolStripMenuItem});
            this.toolStripMenuCreatePaycheck.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuCreatePaycheck.Image")));
            this.toolStripMenuCreatePaycheck.Name = "toolStripMenuCreatePaycheck";
            this.toolStripMenuCreatePaycheck.Size = new System.Drawing.Size(224, 28);
            this.toolStripMenuCreatePaycheck.Text = "Paycheck";
            this.toolStripMenuCreatePaycheck.Click += new System.EventHandler(this.toolStripMenuCreatePaycheck_Click);
            // 
            // allPaychecksToolStripMenuItem
            // 
            this.allPaychecksToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("allPaychecksToolStripMenuItem.Image")));
            this.allPaychecksToolStripMenuItem.Name = "allPaychecksToolStripMenuItem";
            this.allPaychecksToolStripMenuItem.Size = new System.Drawing.Size(224, 28);
            this.allPaychecksToolStripMenuItem.Text = "All Paychecks";
            this.allPaychecksToolStripMenuItem.Click += new System.EventHandler(this.allPaychecksToolStripMenuItem_Click);
            // 
            // toolStripSeparator4
            // 
            this.toolStripSeparator4.Name = "toolStripSeparator4";
            this.toolStripSeparator4.Size = new System.Drawing.Size(6, 47);
            // 
            // toolStripMenuMyShift
            // 
            this.toolStripMenuMyShift.AutoSize = false;
            this.toolStripMenuMyShift.BackColor = System.Drawing.Color.DarkGray;
            this.toolStripMenuMyShift.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("toolStripMenuMyShift.BackgroundImage")));
            this.toolStripMenuMyShift.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.toolStripMenuMyShift.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.toolStripMenuMyShift.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuMyShift.Image")));
            this.toolStripMenuMyShift.Name = "toolStripMenuMyShift";
            this.toolStripMenuMyShift.Size = new System.Drawing.Size(152, 47);
            this.toolStripMenuMyShift.Text = "My shifts";
            this.toolStripMenuMyShift.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            this.toolStripMenuMyShift.Click += new System.EventHandler(this.toolStripMenuMyShift_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 47);
            // 
            // toolStripMenuMyPaychecks
            // 
            this.toolStripMenuMyPaychecks.AutoSize = false;
            this.toolStripMenuMyPaychecks.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("toolStripMenuMyPaychecks.BackgroundImage")));
            this.toolStripMenuMyPaychecks.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.toolStripMenuMyPaychecks.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.toolStripMenuMyPaychecks.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuMyPaychecks.Image")));
            this.toolStripMenuMyPaychecks.Name = "toolStripMenuMyPaychecks";
            this.toolStripMenuMyPaychecks.Size = new System.Drawing.Size(150, 47);
            this.toolStripMenuMyPaychecks.Text = "My Paychecks";
            this.toolStripMenuMyPaychecks.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            this.toolStripMenuMyPaychecks.Click += new System.EventHandler(this.toolStripMenuMyPaychecks_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 47);
            // 
            // toolStripMenuMyContract
            // 
            this.toolStripMenuMyContract.AutoSize = false;
            this.toolStripMenuMyContract.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("toolStripMenuMyContract.BackgroundImage")));
            this.toolStripMenuMyContract.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.toolStripMenuMyContract.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.toolStripMenuMyContract.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuMyContract.Image")));
            this.toolStripMenuMyContract.ImageAlign = System.Drawing.ContentAlignment.TopCenter;
            this.toolStripMenuMyContract.Name = "toolStripMenuMyContract";
            this.toolStripMenuMyContract.Size = new System.Drawing.Size(150, 47);
            this.toolStripMenuMyContract.Text = "My Contract";
            this.toolStripMenuMyContract.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            this.toolStripMenuMyContract.Click += new System.EventHandler(this.toolStripMenuMyContract_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 47);
            // 
            // toolStripMenuLeaves
            // 
            this.toolStripMenuLeaves.AutoSize = false;
            this.toolStripMenuLeaves.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("toolStripMenuLeaves.BackgroundImage")));
            this.toolStripMenuLeaves.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.toolStripMenuLeaves.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.toolStripMenuLeaves.Image = ((System.Drawing.Image)(resources.GetObject("toolStripMenuLeaves.Image")));
            this.toolStripMenuLeaves.Name = "toolStripMenuLeaves";
            this.toolStripMenuLeaves.Size = new System.Drawing.Size(152, 47);
            this.toolStripMenuLeaves.Text = "Sickness/Vacation";
            this.toolStripMenuLeaves.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            this.toolStripMenuLeaves.Click += new System.EventHandler(this.toolStripMenuLeaves_Click);
            // 
            // toolStripSeparator5
            // 
            this.toolStripSeparator5.Name = "toolStripSeparator5";
            this.toolStripSeparator5.Size = new System.Drawing.Size(6, 47);
            // 
            // eToolStripMenuItem
            // 
            this.eToolStripMenuItem.AutoSize = false;
            this.eToolStripMenuItem.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("eToolStripMenuItem.BackgroundImage")));
            this.eToolStripMenuItem.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.eToolStripMenuItem.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.eToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("eToolStripMenuItem.Image")));
            this.eToolStripMenuItem.Name = "eToolStripMenuItem";
            this.eToolStripMenuItem.Size = new System.Drawing.Size(152, 47);
            this.eToolStripMenuItem.Text = "Sign out";
            this.eToolStripMenuItem.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            this.eToolStripMenuItem.Click += new System.EventHandler(this.eToolStripMenuItem_Click);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.LightBlue;
            this.panel1.Controls.Add(this.dataGridView1);
            this.panel1.Location = new System.Drawing.Point(12, 54);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(937, 311);
            this.panel1.TabIndex = 1;
            this.panel1.Paint += new System.Windows.Forms.PaintEventHandler(this.panel1_Paint);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.BackgroundColor = System.Drawing.Color.Azure;
            this.dataGridView1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.dataGridView1.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.Raised;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(3, 18);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(931, 276);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 22F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(949, 374);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.menuStrip1);
            this.Font = new System.Drawing.Font("Microsoft Tai Le", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Menu";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuMyShift;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuMyPaychecks;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuMyContract;
        private System.Windows.Forms.ToolStripMenuItem eToolStripMenuItem;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuNEW;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuEmployee;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuContract;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuCreateShift;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuCreateLeave;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuCreatePaycheck;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuLeaves;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
        private System.Windows.Forms.ToolStripMenuItem jobPositionToolStripMenuItem;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.ToolStripMenuItem updateContractToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newShiftTypeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem allEmployeesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem allContractsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem allShiftsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem allLeavesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem allPaychecksToolStripMenuItem;
    }
}