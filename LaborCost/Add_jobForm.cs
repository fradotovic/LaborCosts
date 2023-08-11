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
    public partial class Add_jobForm : Form
    {
        public Add_jobForm()
        {
            InitializeComponent();
        }

        private void buttonSaveJob_Click(object sender, EventArgs e)
        {
            JobPosition job = new JobPosition();

            job.Name = this.textBoxJobTitle.Text;

            PostgreSqlConnector connector = new PostgreSqlConnector();

            connector.Insert_Job(job);
            this.Close();

        }
    }
}
