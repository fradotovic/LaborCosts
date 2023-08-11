
namespace LaborCost
{
    partial class CreatePaycheckForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CreatePaycheckForm));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.comboBoxEmployees = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.dateTimePickerFrom = new System.Windows.Forms.DateTimePicker();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.dateTimePicker_To = new System.Windows.Forms.DateTimePicker();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.buttonCreatePaycheck = new System.Windows.Forms.Button();
            this.textBoxTotalVacationdays = new System.Windows.Forms.TextBox();
            this.textBoxTotalOvertime = new System.Windows.Forms.TextBox();
            this.textBoxGrossSalary = new System.Windows.Forms.TextBox();
            this.textBoxContributions = new System.Windows.Forms.TextBox();
            this.textBoxNetSalary = new System.Windows.Forms.TextBox();
            this.textBoxTotal_sick_days = new System.Windows.Forms.TextBox();
            this.textBoxTotalHours = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.textBoxPaymentDate = new System.Windows.Forms.TextBox();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 85);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(74, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Employee:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(99, 17);
            this.label2.TabIndex = 1;
            this.label2.Text = "Payment date:";
            // 
            // comboBoxEmployees
            // 
            this.comboBoxEmployees.FormattingEnabled = true;
            this.comboBoxEmployees.Location = new System.Drawing.Point(111, 82);
            this.comboBoxEmployees.Name = "comboBoxEmployees";
            this.comboBoxEmployees.Size = new System.Drawing.Size(253, 24);
            this.comboBoxEmployees.TabIndex = 2;
            this.comboBoxEmployees.SelectedIndexChanged += new System.EventHandler(this.comboBoxEmployees_SelectedIndexChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label6.Location = new System.Drawing.Point(6, 18);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(98, 20);
            this.label6.TabIndex = 6;
            this.label6.Text = "Total hours:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label7.Location = new System.Drawing.Point(6, 51);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(175, 20);
            this.label7.TabIndex = 7;
            this.label7.Text = "Total sick leave days :";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label8.Location = new System.Drawing.Point(6, 84);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(158, 20);
            this.label8.TabIndex = 8;
            this.label8.Text = "Total vacation days:";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label9.Location = new System.Drawing.Point(6, 113);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(167, 20);
            this.label9.TabIndex = 9;
            this.label9.Text = "Total overtime hours:";
            // 
            // dateTimePickerFrom
            // 
            this.dateTimePickerFrom.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dateTimePickerFrom.Location = new System.Drawing.Point(70, 46);
            this.dateTimePickerFrom.Name = "dateTimePickerFrom";
            this.dateTimePickerFrom.Size = new System.Drawing.Size(217, 22);
            this.dateTimePickerFrom.TabIndex = 10;
            this.dateTimePickerFrom.ValueChanged += new System.EventHandler(this.dateTimePickerFrom_ValueChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Tai Le", 7.8F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(12, 50);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(52, 18);
            this.label3.TabIndex = 11;
            this.label3.Text = "FROM:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Tai Le", 7.8F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(292, 51);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(31, 18);
            this.label4.TabIndex = 12;
            this.label4.Text = "TO:";
            // 
            // dateTimePicker_To
            // 
            this.dateTimePicker_To.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dateTimePicker_To.Location = new System.Drawing.Point(328, 46);
            this.dateTimePicker_To.Name = "dateTimePicker_To";
            this.dateTimePicker_To.Size = new System.Drawing.Size(200, 22);
            this.dateTimePicker_To.TabIndex = 13;
            this.dateTimePicker_To.ValueChanged += new System.EventHandler(this.dateTimePicker_To_ValueChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.GhostWhite;
            this.groupBox1.Controls.Add(this.buttonCreatePaycheck);
            this.groupBox1.Controls.Add(this.textBoxTotalVacationdays);
            this.groupBox1.Controls.Add(this.textBoxTotalOvertime);
            this.groupBox1.Controls.Add(this.textBoxGrossSalary);
            this.groupBox1.Controls.Add(this.textBoxContributions);
            this.groupBox1.Controls.Add(this.textBoxNetSalary);
            this.groupBox1.Controls.Add(this.textBoxTotal_sick_days);
            this.groupBox1.Controls.Add(this.textBoxTotalHours);
            this.groupBox1.Controls.Add(this.label11);
            this.groupBox1.Controls.Add(this.label10);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.label8);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Location = new System.Drawing.Point(15, 124);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(513, 302);
            this.groupBox1.TabIndex = 14;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Paycheck";
            // 
            // buttonCreatePaycheck
            // 
            this.buttonCreatePaycheck.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.buttonCreatePaycheck.Location = new System.Drawing.Point(206, 233);
            this.buttonCreatePaycheck.Name = "buttonCreatePaycheck";
            this.buttonCreatePaycheck.Size = new System.Drawing.Size(143, 37);
            this.buttonCreatePaycheck.TabIndex = 20;
            this.buttonCreatePaycheck.Text = "Create";
            this.buttonCreatePaycheck.UseVisualStyleBackColor = true;
            this.buttonCreatePaycheck.Click += new System.EventHandler(this.buttonCreatePaycheck_Click);
            // 
            // textBoxTotalVacationdays
            // 
            this.textBoxTotalVacationdays.Location = new System.Drawing.Point(206, 84);
            this.textBoxTotalVacationdays.Name = "textBoxTotalVacationdays";
            this.textBoxTotalVacationdays.Size = new System.Drawing.Size(143, 22);
            this.textBoxTotalVacationdays.TabIndex = 19;
            // 
            // textBoxTotalOvertime
            // 
            this.textBoxTotalOvertime.Location = new System.Drawing.Point(206, 113);
            this.textBoxTotalOvertime.Name = "textBoxTotalOvertime";
            this.textBoxTotalOvertime.Size = new System.Drawing.Size(143, 22);
            this.textBoxTotalOvertime.TabIndex = 18;
            // 
            // textBoxGrossSalary
            // 
            this.textBoxGrossSalary.Location = new System.Drawing.Point(206, 140);
            this.textBoxGrossSalary.Name = "textBoxGrossSalary";
            this.textBoxGrossSalary.Size = new System.Drawing.Size(143, 22);
            this.textBoxGrossSalary.TabIndex = 17;
            // 
            // textBoxContributions
            // 
            this.textBoxContributions.Location = new System.Drawing.Point(206, 168);
            this.textBoxContributions.Name = "textBoxContributions";
            this.textBoxContributions.Size = new System.Drawing.Size(143, 22);
            this.textBoxContributions.TabIndex = 16;
            // 
            // textBoxNetSalary
            // 
            this.textBoxNetSalary.Location = new System.Drawing.Point(206, 196);
            this.textBoxNetSalary.Name = "textBoxNetSalary";
            this.textBoxNetSalary.Size = new System.Drawing.Size(143, 22);
            this.textBoxNetSalary.TabIndex = 15;
            // 
            // textBoxTotal_sick_days
            // 
            this.textBoxTotal_sick_days.Location = new System.Drawing.Point(206, 51);
            this.textBoxTotal_sick_days.Name = "textBoxTotal_sick_days";
            this.textBoxTotal_sick_days.Size = new System.Drawing.Size(143, 22);
            this.textBoxTotal_sick_days.TabIndex = 14;
            // 
            // textBoxTotalHours
            // 
            this.textBoxTotalHours.Location = new System.Drawing.Point(206, 18);
            this.textBoxTotalHours.Name = "textBoxTotalHours";
            this.textBoxTotalHours.Size = new System.Drawing.Size(143, 22);
            this.textBoxTotalHours.TabIndex = 13;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label11.Location = new System.Drawing.Point(6, 196);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(90, 20);
            this.label11.TabIndex = 12;
            this.label11.Text = "Net salary:";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label10.Location = new System.Drawing.Point(3, 168);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(113, 20);
            this.label10.TabIndex = 11;
            this.label10.Text = "Contributions:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.label5.Location = new System.Drawing.Point(6, 140);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(110, 20);
            this.label5.TabIndex = 10;
            this.label5.Text = "Gross salary:";
            // 
            // textBoxPaymentDate
            // 
            this.textBoxPaymentDate.Location = new System.Drawing.Point(111, 12);
            this.textBoxPaymentDate.Name = "textBoxPaymentDate";
            this.textBoxPaymentDate.Size = new System.Drawing.Size(253, 22);
            this.textBoxPaymentDate.TabIndex = 15;
            // 
            // CreatePaycheckForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.ClientSize = new System.Drawing.Size(569, 445);
            this.Controls.Add(this.textBoxPaymentDate);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.dateTimePicker_To);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.dateTimePickerFrom);
            this.Controls.Add(this.comboBoxEmployees);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "CreatePaycheckForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Create Paycheck";
            this.Load += new System.EventHandler(this.CreatePaycheckForm_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox comboBoxEmployees;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.DateTimePicker dateTimePickerFrom;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DateTimePicker dateTimePicker_To;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox textBoxPaymentDate;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox textBoxTotalHours;
        private System.Windows.Forms.TextBox textBoxTotalVacationdays;
        private System.Windows.Forms.TextBox textBoxTotalOvertime;
        private System.Windows.Forms.TextBox textBoxGrossSalary;
        private System.Windows.Forms.TextBox textBoxContributions;
        private System.Windows.Forms.TextBox textBoxNetSalary;
        private System.Windows.Forms.TextBox textBoxTotal_sick_days;
        private System.Windows.Forms.Button buttonCreatePaycheck;
    }
}