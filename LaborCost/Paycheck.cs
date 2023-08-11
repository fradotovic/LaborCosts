using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaborCost
{
    public class Paycheck
    {
        public int Id { get; set; }

        public Employee Employee { get; set; }

        public DateTime PaymentDate { get; set; }

        public int Total_sick_leave_days { get; set; }

        public int Total_vacation_days { get; set; }

        public int Total_overtime_hours { get; set; }

        public int Total_hours { get; set; }

        public decimal Gross_salary { get; set; }

        public decimal Contributions { get; set; }

        public decimal Net_Salary { get; set; }
        public DateTime Date_From { get; set; }

        public DateTime Date_To { get; set; }












    }
}
