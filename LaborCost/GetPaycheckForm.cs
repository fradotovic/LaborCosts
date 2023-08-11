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
    public partial class GetPaycheckForm : Form
    {
        public GetPaycheckForm()
        {
            InitializeComponent();
            this.comboBox1.SelectedIndex = 1;
            this.dateTimePicker1.MaxDate = DateTime.Now.Date;
        }

        

        private void buttonSavePaycheck_Click(object sender, EventArgs e)
        {
            int timeSpan = 0;
            try
            {
                PostgreSqlConnector connector = new PostgreSqlConnector();
                Employee employee = connector.SearchEmployee((int)textBoxEmployee.Text);

                Paycheck Paycheck = new Paycheck();

                lastPC = connector.GetLastPaycheck(employee);
                Paycheck.Date_From = lastPC.PaymentDate.AddDay(1); //the day right after last payment 

                Paycheck.PaymentDate = dateTimePicker1.Value.Date;

                Paycheck.Date_To = Paycheck.PaymentDate;

                int price_of_hour = connector.Get_Contract(employee.ID).price_of_hour;

                connector.Insert_Paycheck(Paycheck);
                // I have no idea what that means so letting it that way, it probably needs change
                MessageBox.Show("Uspjesno ste registrirali zaposlenika!", "Registracija zaposlenika");
                
                this.Close();
            }
            catch (Exception)
            {
            }
        }

        private void RegisterPaycheckForm_Load(object sender, EventArgs e)
        {

        }
    }
}
