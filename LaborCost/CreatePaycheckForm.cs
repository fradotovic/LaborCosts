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
    public partial class CreatePaycheckForm : Form
    {
        public CreatePaycheckForm()
        {
            InitializeComponent();
        }


        public void InitializeData()
        {

            PostgreSqlConnector sqlConnector = new PostgreSqlConnector();
            List<Employee> employees = sqlConnector.GetAll_Employees();

            foreach (var employee in employees)
            {
                this.comboBoxEmployees.Items.Add(employee.FirstName + " " + employee.LastName);
            }

            this.textBoxPaymentDate.Text = DateTime.Now.ToShortDateString();

            DateTime currentDate = DateTime.Now;
            DateTime firstDayOfCurrentMonth = new DateTime(currentDate.Year, currentDate.Month, 1);

            this.dateTimePickerFrom.Value = firstDayOfCurrentMonth;

            
            DateTime lastDayOfCurrentMonth = new DateTime(currentDate.Year, currentDate.Month, DateTime.DaysInMonth(currentDate.Year, currentDate.Month));
            dateTimePicker_To.Value = lastDayOfCurrentMonth;






        }
        private void CreatePaycheckForm_Load(object sender, EventArgs e)
        {
            InitializeData();
        }

        

        private void comboBoxEmployees_SelectedIndexChanged(object sender, EventArgs e)
        {

            PostgreSqlConnector postgreSql = new PostgreSqlConnector();

            List<Employee> AllEmployees = postgreSql.GetAll_Employees();

            Employee employee = new Employee();

            foreach (var emp in AllEmployees)
            {
                if (emp.FirstName + " " + emp.LastName == this.comboBoxEmployees.Text)
                {
                    employee = emp;
                }
            }

            List<Shift> EmployeeShifts = new List<Shift>();


            string dateFrom = dateTimePickerFrom.Value.ToShortDateString();

            DateTime date_From = DateTime.Parse(dateFrom);

            string dateTo = dateTimePicker_To.Value.ToShortDateString();

            DateTime date_To = DateTime.Parse(dateTo);


            


            /* foreach (var shift in postgreSql.Get_All_Shifts())
             {
                 if (shift.Employee.Id == employee.Id && 
                     shift.Date_of_shift.Date >= date_From.Date
                     && shift.Date_of_shift.Date <= date_To.Date)
                 {
                     EmployeeShifts.Add(shift);
                 }
             }*/


            foreach (var shift in postgreSql.Get_All_Shifts())
            {
                if (shift.Employee.Id == employee.Id)
                {
                    

                    if (shift.Date_of_shift >= date_From.Date && shift.Date_of_shift <= date_To)
                    {
                        EmployeeShifts.Add(shift);
                    }

                }
            }




             List<Leave> EmployeeLeaves = new List<Leave>();



            foreach (var leave in postgreSql.Get_All_Leaves())
            {
                if (leave.Employee.Id == employee.Id && date_From <= leave.Start_date
                    && date_To >= leave.End_date)
                {
                    EmployeeLeaves.Add(leave);
                }
            }

            int sick_leave_days = 0;
            int vacation_leave_days = 0;

            foreach (var sickLeave in EmployeeLeaves)
            {
                if (sickLeave.Mode.Id == 2)
                {
                    TimeSpan duration_of_sick_leave = sickLeave.End_date.Subtract(sickLeave.Start_date);
                    string duration = duration_of_sick_leave.ToString("%d");
                    sick_leave_days += int.Parse(duration);

                }
                if (sickLeave.Mode.Id == 1)
                {
                    TimeSpan duration_of_vacation = sickLeave.End_date.Subtract(sickLeave.Start_date);
                    string duration = duration_of_vacation.ToString("%d");
                    vacation_leave_days += int.Parse(duration);
                }
            }

            this.textBoxTotalVacationdays.Text = vacation_leave_days.ToString();
            this.textBoxTotal_sick_days.Text = sick_leave_days.ToString();


            int total_hours = 0;

            foreach (var shift in EmployeeShifts)
            {
                
                    
                        total_hours += 8;

                    
                

            }

            this.textBoxTotalHours.Text = total_hours.ToString();

            int over_time = 0;

            if (total_hours > 160)
            {
                over_time = total_hours - 160;
            }

            this.textBoxTotalOvertime.Text = over_time.ToString();


            int more_paid_shifts = 0;

            foreach (var shift in EmployeeShifts)
            {
                if (shift.Type_of_shift.Payweight > 1)
                {
                    more_paid_shifts += 1;
                }
            }

            int more_paid_hours = more_paid_shifts * 8;

            int normall_paid_hours = total_hours - more_paid_hours;

            int sick_paid_hours = sick_leave_days * 8;

            int vacation_paid_hours = vacation_leave_days * 8;


            Contract employeeContract = new Contract();

            foreach (var contract in postgreSql.Get_All_Contracts())
            {
                if (contract.Employee.Id == employee.Id)
                {
                    employeeContract = contract;
                }
            }


            decimal paycheck_normal_hours = normall_paid_hours * employeeContract.Price_of_hour;

            decimal paycheck_more_paid_hours = more_paid_hours * employeeContract.Price_of_hour * decimal.Parse("1,5");

            decimal paycheck_sick_paid_hours = sick_paid_hours * employeeContract.Price_of_hour * decimal.Parse("0,8");

            decimal paycheck_vacation_paid_hours = vacation_paid_hours * employeeContract.Price_of_hour * decimal.Parse("1,1");

            decimal paycheck_overtime_paid_hours = over_time * employeeContract.Price_of_hour * decimal.Parse("1,5");


            decimal gross_salary = paycheck_normal_hours + paycheck_more_paid_hours +
                paycheck_sick_paid_hours + paycheck_vacation_paid_hours + paycheck_overtime_paid_hours;


            decimal contributions = gross_salary * decimal.Parse("0,215");

            decimal netSalary = gross_salary - contributions;

            this.textBoxGrossSalary.Text = gross_salary.ToString("0.00");

            this.textBoxContributions.Text = contributions.ToString("0.00");

            this.textBoxNetSalary.Text = netSalary.ToString("0.00");


        }


        private void buttonCreatePaycheck_Click(object sender, EventArgs e)
        {
            try
            {
                PostgreSqlConnector postgreSql = new PostgreSqlConnector();

                List<Employee> AllEmployees = postgreSql.GetAll_Employees();

                Employee employee = new Employee();

                foreach (var emp in AllEmployees)
                {
                    if (emp.FirstName + " " + emp.LastName == this.comboBoxEmployees.Text)
                    {
                        employee = emp;
                    }
                }


                Paycheck paycheck = new Paycheck();

                paycheck.Employee = employee;

                paycheck.PaymentDate = DateTime.Parse(this.textBoxPaymentDate.Text);

                paycheck.Total_hours = int.Parse(this.textBoxTotalHours.Text);

                paycheck.Total_overtime_hours = int.Parse(this.textBoxTotalOvertime.Text);

                paycheck.Total_sick_leave_days = int.Parse(this.textBoxTotal_sick_days.Text);

                paycheck.Total_vacation_days = int.Parse(this.textBoxTotalVacationdays.Text);

                paycheck.Date_From = this.dateTimePickerFrom.Value;

                paycheck.Date_To = this.dateTimePicker_To.Value;

                paycheck.Gross_salary = decimal.Parse(this.textBoxGrossSalary.Text);

                paycheck.Contributions = decimal.Parse(this.textBoxContributions.Text);

                paycheck.Net_Salary = decimal.Parse(this.textBoxNetSalary.Text);


                PostgreSqlConnector sqlConnector = new PostgreSqlConnector();

                sqlConnector.InsertPaycheck(paycheck);

                this.Close();
            }
            catch (Exception)
            {

                MessageBox.Show("Employee already got salary for this month!","Salary notification:)");
            }
            

        }

        private void dateTimePickerFrom_ValueChanged(object sender, EventArgs e)
        {
            comboBoxEmployees_SelectedIndexChanged(sender, e);
        }

        private void dateTimePicker_To_ValueChanged(object sender, EventArgs e)
        {
            comboBoxEmployees_SelectedIndexChanged(sender, e);
        }
    }
}
