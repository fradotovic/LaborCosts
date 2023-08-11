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
    public partial class AllPaychecksForm : Form
    {
        public AllPaychecksForm()
        {
            InitializeComponent();
        }
        public void InitializeMyPaycheckDatagridView()
        {
            dataGridView1.Rows.Clear();
            dataGridView1.Columns.Clear();
            dataGridView1.Columns.Add("ID", "Paycheck No");
            dataGridView1.Columns.Add("Employee", "Employee");
            dataGridView1.Columns.Add("Payment Date", "Payment Date");
            dataGridView1.Columns.Add("Sick Days", "Sick Days");
            dataGridView1.Columns.Add("Vacation Days", "Vacation Days");
            dataGridView1.Columns.Add("Total overtime", "Total overtime");
            dataGridView1.Columns.Add("Total hours", "Total hours");
            dataGridView1.Columns.Add("Gross salary", "Gross salary");
            dataGridView1.Columns.Add("Contributions", "Contributions");
            dataGridView1.Columns.Add("Net salary", "Net salary");


        }

        public void Show_Datagrid_My_Paychecks()
        {
            PostgreSqlConnector connector = new PostgreSqlConnector();


            List<Paycheck> EmployeePaychecks = connector.GetAllPaychecks();

            EmployeePaychecks = EmployeePaychecks.OrderBy(o => o.Date_From).ToList();

            foreach (var paycheck in EmployeePaychecks)
            {
                dataGridView1.Rows.Add(paycheck.Id, paycheck.Employee.FirstName + " " + paycheck.Employee.LastName,
                    paycheck.PaymentDate.ToShortDateString(), paycheck.Total_sick_leave_days,
                    paycheck.Total_vacation_days,
                    paycheck.Total_overtime_hours, paycheck.Total_hours,
                    paycheck.Gross_salary, paycheck.Contributions,
                    paycheck.Net_Salary);
            }

        }
        private void AllPaychecksForm_Load(object sender, EventArgs e)
        {
            InitializeMyPaycheckDatagridView();
            Show_Datagrid_My_Paychecks();
        }
    }
}
