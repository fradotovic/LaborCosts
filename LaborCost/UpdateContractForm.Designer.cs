
namespace LaborCost
{
    partial class UpdateContractForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UpdateContractForm));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.buttonUpdateContract = new System.Windows.Forms.Button();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.comboBoxEmployess = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(0, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(74, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Employee:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(0, 47);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(93, 17);
            this.label2.TabIndex = 1;
            this.label2.Text = "Price of hour:";
            // 
            // buttonUpdateContract
            // 
            this.buttonUpdateContract.Location = new System.Drawing.Point(120, 75);
            this.buttonUpdateContract.Name = "buttonUpdateContract";
            this.buttonUpdateContract.Size = new System.Drawing.Size(140, 30);
            this.buttonUpdateContract.TabIndex = 2;
            this.buttonUpdateContract.Text = "Update contract";
            this.buttonUpdateContract.UseVisualStyleBackColor = true;
            this.buttonUpdateContract.Click += new System.EventHandler(this.buttonUpdateContract_Click);
            // 
            // textBox2
            // 
            this.textBox2.Location = new System.Drawing.Point(92, 47);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(205, 22);
            this.textBox2.TabIndex = 4;
            // 
            // comboBoxEmployess
            // 
            this.comboBoxEmployess.FormattingEnabled = true;
            this.comboBoxEmployess.Location = new System.Drawing.Point(92, 6);
            this.comboBoxEmployess.Name = "comboBoxEmployess";
            this.comboBoxEmployess.Size = new System.Drawing.Size(205, 24);
            this.comboBoxEmployess.TabIndex = 5;
            // 
            // UpdateContractForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.ClientSize = new System.Drawing.Size(321, 117);
            this.Controls.Add(this.comboBoxEmployess);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.buttonUpdateContract);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "UpdateContractForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Update Contract";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button buttonUpdateContract;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.ComboBox comboBoxEmployess;
    }
}