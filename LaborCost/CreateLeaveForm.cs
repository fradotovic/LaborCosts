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
    public partial class CreateLeaveForm : Form
    {
        public CreateLeaveForm()
        {
            InitializeComponent();
        }

        private void buttonCreateLeave_Click(object sender, EventArgs e)
        {
            try
            {
                PostgreSqlConnector sqlConnector = new PostgreSqlConnector();

                Employee employee = new Employee();

                Mode_of_operation mod = new Mode_of_operation();

                foreach (var emp in sqlConnector.GetAll_Employees())
                {
                    if (emp.FirstName + " " + emp.LastName == this.comboBoxEmployee.Text)
                    {
                        employee = emp;
                    }
                }

                foreach (var mod_of_operation in sqlConnector.GetAllModes_of_Operation())
                {
                    if (mod_of_operation.Type == this.comboBoxMods.Text)
                    {
                        mod = mod_of_operation;
                    }
                }

                Leave leave = new Leave();

                leave.Employee = employee;

                leave.Mode = mod;

                leave.Start_date = dateTimePickerStartDate.Value;

                leave.End_date = dateTimePickerEndDate.Value;

                leave.Reason = this.textBoxReason.Text;

                sqlConnector.InsertLeave(leave);

                this.Close();

            }
            catch (Exception)
            {
                MessageBox.Show("Employee is already on vacation or leave or has no more vacation days!","Notification",MessageBoxButtons.OK);

            }
            

        }

        public void InitializeData()
        {
            PostgreSqlConnector sqlConnector = new PostgreSqlConnector();
            List<Employee> employees = sqlConnector.GetAll_Employees();

            foreach (var employee in employees)
            {
                this.comboBoxEmployee.Items.Add(employee.FirstName + " " + employee.LastName);
            }

            List<Mode_of_operation> mods = sqlConnector.GetAllModes_of_Operation();

            foreach (var mod in mods)
            {
                this.comboBoxMods.Items.Add(mod.Type);
            }

            this.comboBoxEmployee.SelectedIndex = 0;
            this.comboBoxMods.SelectedIndex = 0;

        }

        private void CreateLeaveForm_Load(object sender, EventArgs e)
        {
            InitializeData();
        }
    }
}
