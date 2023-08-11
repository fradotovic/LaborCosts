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
    public partial class UpdateContractForm : Form
    {
        public UpdateContractForm()
        {
            InitializeComponent();
            Initialize_ComboBox_data();
        }


        public void Initialize_ComboBox_data()
        {
            PostgreSqlConnector sqlConnector = new PostgreSqlConnector();
            List<Employee> employees = sqlConnector.GetAll_Employees();


            foreach (var employee in employees)
            {
                this.comboBoxEmployess.Items.Add(employee.FirstName + " " + employee.LastName);
            }
        }

        private void buttonUpdateContract_Click(object sender, EventArgs e)
        {
            Employee employee = new Employee();
            PostgreSqlConnector sqlConnector = new PostgreSqlConnector();

            foreach (Employee emp in sqlConnector.GetAll_Employees())
            {
                if(emp.FirstName+" "+emp.LastName == this.comboBoxEmployess.Text)
                {
                    employee = emp;
                }
            }

            sqlConnector.Update_Contract(decimal.Parse(this.textBox2.Text),employee);
            this.Close();
            

        }
    }
}
