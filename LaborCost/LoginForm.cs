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
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void LoginForm_Load(object sender, EventArgs e)
        {
            
        }

        

        private void userNameTextBox_Click(object sender, EventArgs e)
        {
            if(this.userNameTextBox.Text == "Username")
            {
                this.userNameTextBox.Text = "";
            }
           
        }

        private void PasswordTextBox_Click(object sender, EventArgs e)
        {
            if(this.PasswordTextBox.Text == "Password")
            {
                this.PasswordTextBox.Text = "";
                this.PasswordTextBox.UseSystemPasswordChar = true;
            }
        }

        private void buttonLogin_Click(object sender, EventArgs e)
        {
            PostgreSqlConnector postgreSql = new PostgreSqlConnector();

            bool uspjesnaPrijava = false;
            Employee employee = null;

            List<Employee> employees = postgreSql.GetAll_Employees();

           foreach (Employee employeeLoop in employees)
            {
              if(employeeLoop.Username == this.userNameTextBox.Text && employeeLoop.Password == this.PasswordTextBox.Text)
                {
                    uspjesnaPrijava = true;
                    employee = employeeLoop;
                }
              
            }

           if(uspjesnaPrijava == true)
            {
             
                this.Hide();
                MainForm form1 = new MainForm(employee);
                form1.ShowDialog();

            }
            else
            {
                MessageBox.Show("Invalid username or password!","Logging IN!");
            }

       
            

        }

        private void LoginForm_Load_1(object sender, EventArgs e)
        {

        }

       

    }
}
