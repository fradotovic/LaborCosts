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
    public partial class UpdateEmployeeForm : Form
    {
        Employee Employee = new Employee();
        public UpdateEmployeeForm(Employee employee)
        {
            InitializeComponent();
            Employee = employee;
            this.textBoxFirstName.Text = employee.FirstName;
            this.textBoxLastName.Text = employee.LastName;
            this.textBoxAdress.Text = employee.Adress;
            this.textBoxEmail.Text = employee.Email;
            this.textBoxPhoneNumber.Text = employee.PhoneNumber;
            this.textBoxUserName.Text = employee.Username;
            this.textBoxPassword.Text = employee.Password;
            //this.comboBox1.SelectedIndex = employee.Role -1;
            if (employee.Role == 2)
            {
                this.comboBox1.SelectedIndex = 0;

            }
            else
            {
                this.comboBox1.SelectedIndex = 1;

            }
            this.dateTimePicker1.Value = employee.BirthDay;

        }

        public bool check_Data()
        {


            if (this.textBoxFirstName.Text == "")
            {
                return false;
            }
            if (this.textBoxLastName.Text == "")
            {
                return false;
            }
            if (this.textBoxEmail.Text == "")
            {

                return false;
            }
            if (this.textBoxPhoneNumber.Text == "")
            {
                return false;
            }
            if (this.textBoxUserName.Text == "")
            {
                return false;
            }
            if (this.textBoxPassword.Text == "")
            {
                return false;
            }
            if (this.textBoxAdress.Text == "")
            {
                return false;
            }
            if (this.comboBox1.SelectedIndex == -1)
            {
                return false;
            }
            else
            {
                return true;
            }
        }




        private void buttonUpdateEmployee_Click(object sender, EventArgs e)
        {
            int timeSpan = 0;
            try
            {
              
                if (check_Data())
                {
                    int Role = 0;

                    if (this.comboBox1.SelectedItem.Equals("Shift Manager"))
                    {
                        Role = 2;
                    }
                    if (this.comboBox1.SelectedItem.Equals("Employee"))
                    {
                        Role = 1;
                    }

                    timeSpan = DateTime.Now.Date.Year - this.dateTimePicker1.Value.Year;

                    PostgreSqlConnector sqlConnector = new PostgreSqlConnector();

                    sqlConnector.UpdateEmployee(Employee.Id, this.textBoxFirstName.Text, this.textBoxLastName.Text, this.textBoxEmail.Text,
                        this.textBoxPhoneNumber.Text, this.dateTimePicker1.Value, this.textBoxAdress.Text, this.textBoxUserName.Text,
                        this.textBoxPassword.Text, Role);
                    MessageBox.Show("You have succesfully updated employee!", "Employee update");

                    this.Close();
                }
            }
            catch (Exception)
            {
                if (!(this.textBoxEmail.Text.Contains("@")))
                {
                    MessageBox.Show("Email doesn't contain @ sign");

                }
                if (timeSpan <= 18)
                {
                    MessageBox.Show("You can't register employee that is under 18 years old!", "Checking age");
                }

            }

        }












    
        }
    }

