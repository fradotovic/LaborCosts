using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Text.RegularExpressions;

namespace LaborCost
{
    public partial class RegisterEmployeeForm : Form
    {
        public RegisterEmployeeForm()
        {
            InitializeComponent();
            this.comboBox1.SelectedIndex = 1;
            this.dateTimePicker1.MaxDate = DateTime.Now.Date;
        }

     



        public bool check_Data()
        {

          /*  string datetimepickervalueString = dateTimePicker1.Value.ToShortDateString();

            DateTime datetimepickerValue = DateTime.Parse(datetimepickervalueString);

            TimeSpan years18 = new TimeSpan(365 * 18, 0, 0, 0);*/

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
          /*  if (!(this.textBoxEmail.Text.Contains("@")))
            {
                MessageBox.Show("Email doesn't contain @ sign");
                return false;
            }
            if (this.dateTimePicker1.Value.Subtract(DateTime.Now.Date) <= years18)
            {
                MessageBox.Show("You can't register employee that is under 18 years old!", "Checking age");
            }*/
            if (this.textBoxPhoneNumber.Text == "")
            {
                return false;
            }
            if(this.textBoxUserName.Text == "")
            {
                return false;
            }
            if (this.textBoxPassword.Text == "")
            {
                return false;
            }
            if(this.textBoxAdress.Text == "")
            {
                return false;
            }
            else
            {
                return true;
            }
        }


        private void buttonSaveEmployee_Click(object sender, EventArgs e)
        {
            if (check_Data())
            {


                int timeSpan = 0;
                try
                {
                    Employee employee = new Employee();

                    employee.FirstName = this.textBoxFirstName.Text;
                    employee.LastName = this.textBoxLastName.Text;
                    employee.Email = this.textBoxEmail.Text;
                    employee.PhoneNumber = this.textBoxPhoneNumber.Text;

                    //dateTimePicker1.Format = DateTimePickerFormat.Custom;
                    employee.BirthDay = dateTimePicker1.Value.Date;
                    timeSpan = DateTime.Now.Date.Year - employee.BirthDay.Year;


                    employee.Adress = this.textBoxAdress.Text;
                    employee.Username = this.textBoxUserName.Text;
                    employee.Password = this.textBoxPassword.Text;

                    if (this.comboBox1.SelectedItem.Equals("Shift Manager"))
                    {
                        employee.Role = 2;
                    }
                    if (this.comboBox1.SelectedItem.Equals("Employee"))
                    {
                        employee.Role = 1;
                    }

                    PostgreSqlConnector connector = new PostgreSqlConnector();

                    connector.Insert_Employee(employee);

                    MessageBox.Show("You have succesfully register employee!", "Employee registration");

                    this.Close();
                }
                catch (Exception)
                {
                    string pattern = @"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$";
                    if (Regex.IsMatch(this.textBoxEmail.Text, pattern) == false)
                    {
                        MessageBox.Show("Incorrect format of email","Email Format");
                    }
                    if (timeSpan <= 18)
                    {
                        MessageBox.Show("You can't register employee that is under 18 years old!", "Checking age");
                    }

                }
                






            }
        }

        private void RegisterEmployeeForm_Load(object sender, EventArgs e)
        {

        }
    }
}
