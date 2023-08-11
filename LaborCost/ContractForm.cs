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
    public partial class ContractForm : Form
    {
        List<Employee> employees = null;
        List<JobPosition> jobPositions = null;

        public ContractForm()
        {
            InitializeComponent();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        public void InitializeData()
        {
            PostgreSqlConnector sqlConnector = new PostgreSqlConnector();
            employees = sqlConnector.GetAll_Employees();

            jobPositions = sqlConnector.getAllJobPosition();


            foreach (var employee in employees)
            {
                this.comboBoxEmployee.Items.Add(employee.FirstName +" "+ employee.LastName);
            }

            foreach (var job in jobPositions)
            {
                this.comboBoxJobPosition.Items.Add(job.Name);
            }

            this.dateTimePickerStart_contract.MaxDate = DateTime.Now.Date;


        }


        private void ContractForm_Load(object sender, EventArgs e)
        {
            InitializeData();
            
        }

        private void buttonCreateContract_Click(object sender, EventArgs e)
        {
            try
            {
                Contract contract = new Contract();

                Employee employee =null;
                JobPosition jobPosition = null;

             

                foreach (var emp in employees)
                {
                    if (emp.FirstName + " " + emp.LastName == this.comboBoxEmployee.SelectedItem.ToString())
                    {
                        employee = emp;
                    }

                }



                foreach (var jb in jobPositions)
                {
                    if (jb.Name.Equals(this.comboBoxJobPosition.SelectedItem))
                    {
                        jobPosition = jb;
                    }

                }


                contract.Employee = employee;

                contract.Job = jobPosition;

                contract.Start_Contract = dateTimePickerStart_contract.Value;

                contract.Price_of_hour = decimal.Parse(this.textBoxPriceOfHour.Text);

                contract.Number_of_Vacation_Days = int.Parse(this.textBoxVacationDays.Text);

                PostgreSqlConnector postgreSql = new PostgreSqlConnector();

                postgreSql.Insert_Contract(contract);

                this.Close();
            }
            catch (SystemException )
            {
                MessageBox.Show("Employee already have contract!,Check entered data!");
            }
        }

        private void buttonUpadateContract_Click(object sender, EventArgs e)
        {
            
        }
    }
}
