using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinanceYourLife.ExternalClasses
{
    public class Results
    { 
        public decimal flujoEmisorCero { get; set; } 
        public decimal flujoEmisorEscudoCero { get; set; } 
        public decimal flujoBonistaCero { get; set; }
        public int periodosTotales { get; set; } 
        public double TEP{ get; set; } 
        public double COKP { get; set; } 
        public double TIRBonista { get; set; } 
        public double TREABonista { get; set; } 
        public double TIREmisor { get; set; } 
        public double TIREmisorEscudo { get; set; } 
        public double TCEAEmisor { get; set; } 
        public double TCEAEmisorEscudo { get; set; } 
        public decimal PrecioActualBono { get; set; } 
        public decimal UtilidadPerdida { get; set; } 
        public decimal CIEmisor { get; set; } 
        public decimal CIBonista { get; set; } 
        public string planPago { get; set; } 
        public string tipoMoneda { get; set; }
        public Results()
        {

        }
    }
}