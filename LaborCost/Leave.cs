using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaborCost
{
   public class Leave
    {
        public int Id { get; set; }

        public Employee Employee { get; set; }

        public Mode_of_operation Mode { get; set; }

        public DateTime Start_date { get; set; }

        public DateTime End_date { get; set; }
        public string Reason { get; set; }






    }
}
