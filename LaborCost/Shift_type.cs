using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaborCost
{
    public class Shift_type
    {

        public int Id { get; set; }
        public string Type { get; set; }

        public decimal Payweight { get; set; }

        public TimeSpan Start_time { get; set; }

        public TimeSpan End_time { get; set; }

    }
}
