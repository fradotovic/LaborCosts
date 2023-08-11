using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaborCost
{
   public class Contract
    {
        public int Id { get; set; }

        public Employee Employee { get; set; }

        public JobPosition Job { get; set; }

        public DateTime Start_Contract { get; set; }
        public decimal Price_of_hour { get; set; }

        public int Number_of_Vacation_Days { get; set; }

       


    }
}
