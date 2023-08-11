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
    public partial class AllLeavesForm : Form
    {
        public AllLeavesForm()
        {
            InitializeComponent();
        }

        private void AllLeavesForm_Load(object sender, EventArgs e)
        {
            Intialize_My_Leaves_DatagridView();
            Show_My_Leaves_in_DatagridView();
        }

        public void Show_My_Leaves_in_DatagridView()
        {
            PostgreSqlConnector connector = new PostgreSqlConnector();

            List<Leave> AllLeaves = new List<Leave>();

            AllLeaves = connector.Get_All_Leaves();


           



           AllLeaves = AllLeaves.OrderBy(o => o.Start_date).ToList();

            foreach (var leave in AllLeaves)
            {
                dataGridView1.Rows.Add(leave.Id, leave.Employee.FirstName + " " + leave.Employee.LastName,
                    leave.Mode.Type, leave.Start_date.Date.ToShortDateString(), leave.End_date.Date.ToShortDateString(),
                    leave.Reason);
            }



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
    }
}
