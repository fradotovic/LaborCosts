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
    public partial class AllEmployeesForm : Form
    {
        public AllEmployeesForm()
        {
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        public void AllEmployeesForm_Load(object sender, EventArgs e)
        {
            PostgreSqlConnector sqlConnector = new PostgreSqlConnector();


            List<Employee> employees = sqlConnector.GetAll_Employees();

            employees = employees.OrderBy(o => o.LastName).ToList();

            dataGridView1.DataSource = employees;

            dataGridView1.Columns.RemoveAt(dataGridView1.Columns.Count - 1);

        }

        private void buttonDelete_Click(object sender, EventArgs e)
        {
            Employee employee = new Employee();

            if (dataGridView1.SelectedRows.Count > 0)
            {
                DataGridViewRow row = dataGridView1.SelectedRows[0];
               employee = (Employee)row.DataBoundItem;
             
            }

            PostgreSqlConnector sqlConnector = new PostgreSqlConnector();

            sqlConnector.Delete_Employee_Contract(employee);

            sqlConnector.Delete_Employee(employee);

            AllEmployeesForm_Load(sender, e);

        }

        private void buttonUpdate_Click(object sender, EventArgs e)
        {
            Employee employee = new Employee();

            if (dataGridView1.SelectedRows.Count > 0)
            {
                DataGridViewRow row = dataGridView1.SelectedRows[0];
                employee = (Employee)row.DataBoundItem;

            }

            UpdateEmployeeForm form = new UpdateEmployeeForm(employee);

            form.ShowDialog();

            AllEmployeesForm_Load(sender, e);



        }
    }
}
