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
    public partial class AddShiftForm : Form
    {
        Employee Employee = new Employee();
        public AddShiftForm(Employee employee)
        {
            InitializeComponent();
            Employee = employee;
        }

        

        private void buttonCreateShift_Click(object sender, EventArgs e)
        {
            try
            {
                PostgreSqlConnector sqlConnector = new PostgreSqlConnector();

                List<Employee> AllEmployes = sqlConnector.GetAll_Employees();

                List<Shift_type> AllShift_Types = sqlConnector.Get_All_Shift_Types();

                Employee employee = new Employee();

                Shift_type shift_Type = new Shift_type();

                foreach (Employee emp in AllEmployes)
                {
                    if (emp.FirstName + " " + emp.LastName == this.comboBoxEmployee.Text)
                    {
                        employee = emp;
                    }
                }

                foreach (var shiftType in AllShift_Types)
                {
                    if (shiftType.Type == this.comboBoxType_of_shift.Text)
                    {
                        shift_Type = shiftType;
                    }
                }

                Shift shift = new Shift();

                shift.Employee = employee;

                shift.Type_of_shift = shift_Type;

                shift.Date_of_shift = dateTimePicker1.Value;


                sqlConnector.InsertShift(shift);

                this.Close();

            }
            catch (Exception)
            {
                MessageBox.Show("You already entered your shift for that date!","Shift Created");
            }
            

        }

        public void InitializeData()
        {
            if (Employee.Role == 2) 
            {
                PostgreSqlConnector sqlConnector = new PostgreSqlConnector();
                List<Employee> employees = sqlConnector.GetAll_Employees();

                foreach (var employee in employees)
                {
                    this.comboBoxEmployee.Items.Add(employee.FirstName + " " + employee.LastName);
                }


                List<Shift_type> shift_Types = sqlConnector.Get_All_Shift_Types();

                foreach (var shift_type in shift_Types)
                {
                    this.comboBoxType_of_shift.Items.Add(shift_type.Type);
                }

                this.comboBoxEmployee.SelectedIndex = 0;
                this.comboBoxType_of_shift.SelectedIndex = 0;
            }
            else
            {
                this.comboBoxEmployee.Text = Employee.FirstName + " " + Employee.LastName;

                this.comboBoxEmployee.Enabled = false;

                PostgreSqlConnector sqlConnector = new PostgreSqlConnector();
                List<Shift_type> shift_Types = sqlConnector.Get_All_Shift_Types();

                foreach (var shift_type in shift_Types)
                {
                    this.comboBoxType_of_shift.Items.Add(shift_type.Type);
                }

            }
              


        }

        private void AddShiftForm_Load(object sender, EventArgs e)
        {
            InitializeData();
        }
    }
}
