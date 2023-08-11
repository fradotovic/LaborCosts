using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LaborCost
{
    public partial class Shift_type_form : Form
    {
        public Shift_type_form()
        {
            InitializeComponent();
        }

        private void Shift_type_form_Load(object sender, EventArgs e)
        {

        }

        public bool Check_Data()
        {
            if(this.textBoxShiftName.Text == "")
            {
                MessageBox.Show("Check entered data!");
                return false;
            }
            if(this.textBoxPayweight.Text == "")
            {
                MessageBox.Show("Check entered data!");
                return false;
            }
            if(this.textBoxStartTime.Text == "")
            {
                MessageBox.Show("Check entered data!");
                return false;
            }
            if(this.textBoxEndTime.Text == "")
            {
                MessageBox.Show("Check entered data!");
                return false;
            }
            else
            {
                return true;
            }
        }

        private void buttonCreate_shift_type_Click(object sender, EventArgs e)
        {
            if (Check_Data())
            {
                Shift_type shift_Type = new Shift_type();

                shift_Type.Type = this.textBoxShiftName.Text;

                shift_Type.Payweight = decimal.Parse(this.textBoxPayweight.Text);

                shift_Type.Start_time = TimeSpan.FromHours(double.Parse(this.textBoxStartTime.Text));

                shift_Type.End_time = TimeSpan.FromHours(double.Parse(this.textBoxEndTime.Text));

                if(shift_Type.End_time.Hours - shift_Type.Start_time.Hours < 8)
                {
                    MessageBox.Show("Shift must last exactly 8 hours!","Shift Hours");
                    return;
                }
              
                PostgreSqlConnector postgreSql = new PostgreSqlConnector();

                postgreSql.Insert_Shift_Type(shift_Type);
                this.Close();

            }
         
        }
    }
}
