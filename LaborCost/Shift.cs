using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaborCost
{
    public class Shift
    {
        public int Id { get; set; }

        public Employee Employee { get; set; }

        public DateTime Date_of_shift { get; set; }

        public Shift_type Type_of_shift { get; set; }

        
    }
}
