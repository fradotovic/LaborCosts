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
    public partial class AllShiftsForm : Form
    {
        public AllShiftsForm()
        {
            InitializeComponent();
        }

        private void AllShiftsForm_Load(object sender, EventArgs e)
        {
            InitializeMyShiftDatagridView();

            PostgreSqlConnector connector = new PostgreSqlConnector();

            List<Shift> Allshifts = new List<Shift>();

            Allshifts = connector.Get_All_Shifts();

           Allshifts = Allshifts.OrderBy(o => o.Date_of_shift).ToList();

            foreach (var shift in Allshifts)
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



    }
}
