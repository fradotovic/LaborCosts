
namespace LaborCost
{
    partial class ContractForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ContractForm));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.comboBoxEmployee = new System.Windows.Forms.ComboBox();
            this.comboBoxJobPosition = new System.Windows.Forms.ComboBox();
            this.textBoxPriceOfHour = new System.Windows.Forms.TextBox();
            this.textBoxVacationDays = new System.Windows.Forms.TextBox();
            this.buttonCreateContract = new System.Windows.Forms.Button();
            this.dateTimePickerStart_contract = new System.Windows.Forms.DateTimePicker();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(-4, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(88, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Employee:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(-4, 110);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(106, 22);
            this.label2.TabIndex = 1;
            this.label2.Text = "Job position:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(-4, 42);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(138, 22);
            this.label4.TabIndex = 3;
            this.label4.Text = "Start of contract:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(-4, 74);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(114, 22);
            this.label5.TabIndex = 4;
            this.label5.Text = "Price of Hour:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(-4, 146);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(120, 22);
            this.label7.TabIndex = 6;
            this.label7.Text = "Vacation days:";
            // 
            // comboBoxEmployee
            // 
            this.comboBoxEmployee.FormattingEnabled = true;
            this.comboBoxEmployee.Location = new System.Drawing.Point(147, 1);
            this.comboBoxEmployee.Name = "comboBoxEmployee";
            this.comboBoxEmployee.Size = new System.Drawing.Size(280, 30);
            this.comboBoxEmployee.TabIndex = 7;
            this.comboBoxEmployee.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // comboBoxJobPosition
            // 
            this.comboBoxJobPosition.FormattingEnabled = true;
            this.comboBoxJobPosition.Location = new System.Drawing.Point(147, 107);
            this.comboBoxJobPosition.Name = "comboBoxJobPosition";
            this.comboBoxJobPosition.Size = new System.Drawing.Size(280, 30);
            this.comboBoxJobPosition.TabIndex = 8;
            // 
            // textBoxPriceOfHour
            // 
            this.textBoxPriceOfHour.Location = new System.Drawing.Point(147, 71);
            this.textBoxPriceOfHour.Name = "textBoxPriceOfHour";
            this.textBoxPriceOfHour.Size = new System.Drawing.Size(280, 29);
            this.textBoxPriceOfHour.TabIndex = 10;
            // 
            // textBoxVacationDays
            // 
            this.textBoxVacationDays.Location = new System.Drawing.Point(147, 143);
            this.textBoxVacationDays.Name = "textBoxVacationDays";
            this.textBoxVacationDays.Size = new System.Drawing.Size(280, 29);
            this.textBoxVacationDays.TabIndex = 12;
            // 
            // buttonCreateContract
            // 
            this.buttonCreateContract.Location = new System.Drawing.Point(147, 178);
            this.buttonCreateContract.Name = "buttonCreateContract";
            this.buttonCreateContract.Size = new System.Drawing.Size(280, 42);
            this.buttonCreateContract.TabIndex = 13;
            this.buttonCreateContract.Text = "Create new contract";
            this.buttonCreateContract.UseVisualStyleBackColor = true;
            this.buttonCreateContract.Click += new System.EventHandler(this.buttonCreateContract_Click);
            // 
            // dateTimePickerStart_contract
            // 
            this.dateTimePickerStart_contract.Location = new System.Drawing.Point(147, 37);
            this.dateTimePickerStart_contract.Name = "dateTimePickerStart_contract";
            this.dateTimePickerStart_contract.Size = new System.Drawing.Size(280, 29);
            this.dateTimePickerStart_contract.TabIndex = 14;
            // 
            // ContractForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 22F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.ClientSize = new System.Drawing.Size(447, 227);
            this.Controls.Add(this.dateTimePickerStart_contract);
            this.Controls.Add(this.buttonCreateContract);
            this.Controls.Add(this.textBoxVacationDays);
            this.Controls.Add(this.textBoxPriceOfHour);
            this.Controls.Add(this.comboBoxJobPosition);
            this.Controls.Add(this.comboBoxEmployee);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Font = new System.Drawing.Font("Microsoft Tai Le", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.MaximizeBox = false;
            this.Name = "ContractForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Contract";
            this.Load += new System.EventHandler(this.ContractForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox comboBoxEmployee;
        private System.Windows.Forms.ComboBox comboBoxJobPosition;
        private System.Windows.Forms.TextBox textBoxPriceOfHour;
        private System.Windows.Forms.TextBox textBoxVacationDays;
        private System.Windows.Forms.Button buttonCreateContract;
        private System.Windows.Forms.DateTimePicker dateTimePickerStart_contract;
    }
}