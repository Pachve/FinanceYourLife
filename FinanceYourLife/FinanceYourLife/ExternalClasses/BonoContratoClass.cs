using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinanceYourLife.ExternalClasses
{
    public class BonoContratoClass
    { 
        public int IDBono { get; set; }
        public decimal ValorComercial { get; set; }
        public decimal ValorNominal { get; set; }
        public int NroAños { get; set; }
        public string FrecuenciaPago { get; set; }
        public int DiasPorAño { get; set; }
        public string TipoTasaInteres { get; set; }
        public string Capitalizacion { get; set; }
        public double TasaInteresAnual { get; set; }
        public double TasaDescuentoAnual { get; set; }
        public double ImpuestoRenta { get; set; }
        public string FechaEmision { get; set; }

        public BonoContratoClass()
        {
        } 

    }
}