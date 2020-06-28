using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinanceYourLife.ExternalClasses
{
    public class CostesInicialesClass
    {
        public double PorcPrima { get; set; }
        public double PorcEstructuracion { get; set; }
        public double PorcColocacion { get; set; }
        public double PorcFlotacion { get; set; }
        public double PorcCAVALI { get; set; }

        public CostesInicialesClass()
        {
        }
    }
}