
namespace LaborCost
{
    partial class Shift_type_form
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Shift_type_form));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.textBoxShiftName = new System.Windows.Forms.TextBox();
            this.textBoxStartTime = new System.Windows.Forms.TextBox();
            this.textBoxEndTime = new System.Windows.Forms.TextBox();
            this.textBoxPayweight = new System.Windows.Forms.TextBox();
            this.buttonCreate_shift_type = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(79, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Shift name:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 42);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(76, 17);
            this.label2.TabIndex = 1;
            this.label2.Text = "Payweight:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 77);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(72, 17);
            this.label3.TabIndex = 2;
            this.label3.Text = "Start time:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 105);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(67, 17);
            this.label4.TabIndex = 3;
            this.label4.Text = "End time:";
            // 
            // textBoxShiftName
            // 
            this.textBoxShiftName.Location = new System.Drawing.Point(97, 6);
            this.textBoxShiftName.Name = "textBoxShiftName";
            this.textBoxShiftName.Size = new System.Drawing.Size(206, 22);
            this.textBoxShiftName.TabIndex = 4;
            // 
            // textBoxStartTime
            // 
            this.textBoxStartTime.Location = new System.Drawing.Point(97, 72);
            this.textBoxStartTime.Name = "textBoxStartTime";
            this.textBoxStartTime.Size = new System.Drawing.Size(206, 22);
            this.textBoxStartTime.TabIndex = 5;
            // 
            // textBoxEndTime
            // 
            this.textBoxEndTime.Location = new System.Drawing.Point(97, 105);
            this.textBoxEndTime.Name = "textBoxEndTime";
            this.textBoxEndTime.Size = new System.Drawing.Size(206, 22);
            this.textBoxEndTime.TabIndex = 6;
            // 
            // textBoxPayweight
            // 
            this.textBoxPayweight.Location = new System.Drawing.Point(97, 39);
            this.textBoxPayweight.Name = "textBoxPayweight";
            this.textBoxPayweight.Size = new System.Drawing.Size(206, 22);
            this.textBoxPayweight.TabIndex = 7;
            // 
            // buttonCreate_shift_type
            // 
            this.buttonCreate_shift_type.Location = new System.Drawing.Point(119, 133);
            this.buttonCreate_shift_type.Name = "buttonCreate_shift_type";
            this.buttonCreate_shift_type.Size = new System.Drawing.Size(149, 36);
            this.buttonCreate_shift_type.TabIndex = 8;
            this.buttonCreate_shift_type.Text = "Create shift type";
            this.buttonCreate_shift_type.UseVisualStyleBackColor = true;
            this.buttonCreate_shift_type.Click += new System.EventHandler(this.buttonCreate_shift_type_Click);
            // 
            // Shift_type_form
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.ClientSize = new System.Drawing.Size(326, 175);
            this.Controls.Add(this.buttonCreate_shift_type);
            this.Controls.Add(this.textBoxPayweight);
            this.Controls.Add(this.textBoxEndTime);
            this.Controls.Add(this.textBoxStartTime);
            this.Controls.Add(this.textBoxShiftName);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Shift_type_form";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Create new shift type";
            this.Load += new System.EventHandler(this.Shift_type_form_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textBoxShiftName;
        private System.Windows.Forms.TextBox textBoxStartTime;
        private System.Windows.Forms.TextBox textBoxEndTime;
        private System.Windows.Forms.TextBox textBoxPayweight;
        private System.Windows.Forms.Button buttonCreate_shift_type;
    }
}