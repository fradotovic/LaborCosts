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
    public partial class MainForm : Form
    {
        Employee EmployeeLogged = new Employee();
        public MainForm(Employee employee)
        {
            InitializeComponent();
            if (employee.Role == 1)
            {
                toolStripMenuEmployee.Enabled = false;

                toolStripMenuCreateLeave.Enabled = false;

                toolStripMenuContract.Enabled = false;

                toolStripMenuCreatePaycheck.Enabled = false;

                newShiftTypeToolStripMenuItem.Enabled = false;
                allShiftsToolStripMenuItem.Enabled = false;


            }

            EmployeeLogged = employee;
        }
     
        private void Form1_Load(object sender, EventArgs e)
        {
           
        }

        private void toolStripButton11_Click(object sender, EventArgs e)
        {

        }


        private void menuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

   
        private void toolStripMenuEmployee_Click_1(object sender, EventArgs e)
        {
            RegisterEmployeeForm form = new RegisterEmployeeForm();
            form.ShowDialog();
        }

        private void eToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Hide();
            LoginForm form = new LoginForm();
            form.ShowDialog();
        }

        private void toolStripMenuItem6_Click(object sender, EventArgs e)
        {
            ContractForm form = new ContractForm();
            form.ShowDialog();
        }

        private void jobPositionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Add_jobForm form = new Add_jobForm();
            form.ShowDialog();

        }

        public void Show_Datagrid_My_Shifts()
        {
            PostgreSqlConnector connector = new PostgreSqlConnector();

            List<Shift> Allshifts = new List<Shift>();

            Allshifts = connector.Get_All_Shifts();

            List<Shift> EmployeesShift = new List<Shift>();


            foreach (var shift1 in Allshifts)
            {
                if (shift1.Employee.Id == EmployeeLogged.Id)
                {
                    EmployeesShift.Add(shift1);
                }
            }

            EmployeesShift = EmployeesShift.OrderBy(o => o.Date_of_shift).ToList();

            foreach (var shift in EmployeesShift)
            {
                dataGridView1.Rows.Add(shift.Id, shift.Employee.FirstName + " " + shift.Employee.LastName,
                    shift.Date_of_shift.ToShortDateString(), shift.Type_of_shift.Type, shift.Type_of_shift.Start_time,
                    shift.Type_of_shift.End_time);

            }
        }


        public void InitializeMyShiftDatagridView()
        {
            dataGridView1.Rows.Clear();
            dataGridView1.Columns.Clear();
            dataGridView1.Columns.Add("ID", "Shift No");
            dataGridView1.Columns.Add("Employee", "Employee");
            dataGridView1.Columns.Add("Date", "Date");
            dataGridView1.Columns.Add("Shift Type", "Shift Type");
            dataGridView1.Columns.Add("Start Time", "Start Time");
            dataGridView1.Columns.Add("End Time", "End Time");

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

        private void toolStripMenuMyShift_Click(object sender, EventArgs e)
        {
            
            InitializeMyShiftDatagridView();
            Show_Datagrid_My_Shifts();
        }

        public void Show_Datagrid_My_Paychecks()
        {
            PostgreSqlConnector connector = new PostgreSqlConnector();

          

            List<Paycheck> EmployeePaychecks = new List<Paycheck>();


            foreach (var paycheck in connector.GetAllPaychecks())
            {
                if (paycheck.Employee.Id == EmployeeLogged.Id)
                {
                    EmployeePaychecks.Add(paycheck);
                }
            }

            EmployeePaychecks = EmployeePaychecks.OrderBy(o => o.Date_From).ToList();
           
            foreach (var paycheck in EmployeePaychecks)
            {
                dataGridView1.Rows.Add(paycheck.Id, paycheck.Employee.FirstName + " " + paycheck.Employee.LastName,
                    paycheck.PaymentDate.ToShortDateString(), paycheck.Total_sick_leave_days,
                    paycheck.Total_vacation_days,
                    paycheck.Total_overtime_hours,paycheck.Total_hours, 
                    paycheck.Gross_salary,paycheck.Contributions,
                    paycheck.Net_Salary);
            }

        }

        private void toolStripMenuMyPaychecks_Click(object sender, EventArgs e)
        {
            InitializeMyPaycheckDatagridView();
            Show_Datagrid_My_Paychecks();
        }


        public void InitializeMy_Contract_Datagridview()
        {
            dataGridView1.Rows.Clear();
            dataGridView1.Columns.Clear();
            dataGridView1.Columns.Add("ID", "Contract No");
            dataGridView1.Columns.Add("Employee", "Employee");
            dataGridView1.Columns.Add("Job Position", "Job Position");
            dataGridView1.Columns.Add("Start of Contract", "Start of Contract");
            dataGridView1.Columns.Add("Price of hour", "Price of hour");
            dataGridView1.Columns.Add("Number of vacation days", "Number of vacation days");

        }

        public void Show_My_Contract_in_Datagridview()
        {

            PostgreSqlConnector connector = new PostgreSqlConnector();

            List<Contract> AllContracts = new List<Contract>();

            AllContracts = connector.Get_All_Contracts();


            List<Contract> EmployeeContract = new List<Contract>();


            foreach (var contract in AllContracts)
            {
                if(contract.Employee.Id == EmployeeLogged.Id)
                {
                    EmployeeContract.Add(contract);
                }
            }



            foreach (var contract in EmployeeContract)
            {
                dataGridView1.Rows.Add(contract.Id, contract.Employee.FirstName + " " + contract.Employee.LastName,
                    contract.Job.Name,contract.Start_Contract.Date.ToShortDateString(),contract.Price_of_hour,
                    contract.Number_of_Vacation_Days);
            }



        }


        private void toolStripMenuMyContract_Click(object sender, EventArgs e)
        {
            InitializeMy_Contract_Datagridview();
            Show_My_Contract_in_Datagridview();

        }

        public void Intialize_My_Leaves_DatagridView()
        {
            dataGridView1.Rows.Clear();
            dataGridView1.Columns.Clear();
            dataGridView1.Columns.Add("ID", "Leave No");
            dataGridView1.Columns.Add("Employee", "Employee");
            dataGridView1.Columns.Add("Leave Type", "Leave Type");
            dataGridView1.Columns.Add("Leave Start", "Leave Start");
            dataGridView1.Columns.Add("Leave End", "Leave End");
            dataGridView1.Columns.Add("Reason", "Reason");

        }


        public void Show_My_Leaves_in_DatagridView()
        {
            PostgreSqlConnector connector = new PostgreSqlConnector();

            List<Leave> AllLeaves = new List<Leave>();

            AllLeaves = connector.Get_All_Leaves();


            List<Leave> EmployeeLeaves = new List<Leave>();


            foreach (var leave in AllLeaves)
            {
                if (leave.Employee.Id == EmployeeLogged.Id)
                {
                    EmployeeLeaves.Add(leave);
                }
            }

            EmployeeLeaves = EmployeeLeaves.OrderBy(o => o.Start_date).ToList();

            foreach (var leave in EmployeeLeaves)
            {
                dataGridView1.Rows.Add(leave.Id, leave.Employee.FirstName + " " + leave.Employee.LastName,
                    leave.Mode.Type, leave.Start_date.Date.ToShortDateString(),leave.End_date.Date.ToShortDateString(),
                    leave.Reason);
            }



        }

        private void toolStripMenuLeaves_Click(object sender, EventArgs e)
        {
            Intialize_My_Leaves_DatagridView();
            Show_My_Leaves_in_DatagridView();
        }

        private void updateContractToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            UpdateContractForm form = new UpdateContractForm();
            form.ShowDialog();


        }

        private void deleteShiftToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void newShiftTypeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Shift_type_form form = new Shift_type_form();
            form.ShowDialog();

        }

        private void toolStripMenuCreateShift_Click(object sender, EventArgs e)
        {
            AddShiftForm form = new AddShiftForm(EmployeeLogged);
            form.Show();


        }

        private void toolStripMenuCreateLeave_Click(object sender, EventArgs e)
        {

            CreateLeaveForm form = new CreateLeaveForm();

            form.ShowDialog();

        }

        private void toolStripMenuCreatePaycheck_Click(object sender, EventArgs e)
        {
            CreatePaycheckForm form = new CreatePaycheckForm();
            form.ShowDialog();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void allEmployeesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AllEmployeesForm form = new AllEmployeesForm();
            form.ShowDialog();
        }

        private void allContractsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AllContractsForm form = new AllContractsForm();
            form.ShowDialog();

        }

        private void allShiftsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AllShiftsForm form = new AllShiftsForm();
            form.ShowDialog();
        }

        private void allShiftsToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            AllShiftsForm form = new AllShiftsForm();
            form.ShowDialog();
        }

        private void deleteShiftToolStripMenuItem_Click_1(object sender, EventArgs e)
        {

        }

        private void allLeavesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AllLeavesForm form = new AllLeavesForm();
            form.ShowDialog();
        }

        private void allPaychecksToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AllPaychecksForm form = new AllPaychecksForm();
            form.ShowDialog();
        }
    }
}
