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
    public partial class AllContractsForm : Form
    {
        public AllContractsForm()
        {
            InitializeComponent();
        }

        private void AllContractsForm_Load(object sender, EventArgs e)
        {

            InitializeMy_Contract_Datagridview();

            PostgreSqlConnector connector = new PostgreSqlConnector();

            List<Contract> AllContracts = new List<Contract>();

            AllContracts = connector.Get_All_Contracts();

            foreach (var contract in AllContracts)
            {
                dataGridView1.Rows.Add(contract.Id, contract.Employee.FirstName + " " + contract.Employee.LastName,
                    contract.Job.Name, contract.Start_Contract.Date.ToShortDateString(), contract.Price_of_hour,
                    contract.Number_of_Vacation_Days);
            }

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



    }
}
