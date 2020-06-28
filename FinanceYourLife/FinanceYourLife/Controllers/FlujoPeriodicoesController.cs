using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FinanceYourLife.Constantes;
using FinanceYourLife.ExternalClasses;
using FinanceYourLife.Models;

namespace FinanceYourLife.Controllers
{
    public class FlujoPeriodicoesController : Controller
    {
        private FinanceYourLifeEntities1 db = new FinanceYourLifeEntities1();

        // GET: FlujoPeriodicoes
        public ActionResult Index()
        {
            var flujoPeriodico = db.FlujoPeriodico.Include(f => f.BonoContrato);
            return View(flujoPeriodico.ToList());
        }

        // GET: FlujoPeriodicoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FlujoPeriodico flujoPeriodico = db.FlujoPeriodico.Find(id);
            if (flujoPeriodico == null)
            {
                return HttpNotFound();
            }
            return View(flujoPeriodico);
        }

        // GET: FlujoPeriodicoes/Create
        public ActionResult Create()
        {
            ViewBag.FK_IDBonoContrato = new SelectList(db.BonoContrato, "IDBonoContrato", "FrecuenciaPago");
            return View();
        }

        // POST: FlujoPeriodicoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDFlujoPeriodico,Bono,BonoIndexado,Cupon,Cuota,Amortizacion,Prima,Escudo,FlujoEmisor,FlujoEmisorEscudo,FlujoBonista,ValorBonoDCP,FK_IDBonoContrato")] FlujoPeriodico flujoPeriodico)
        {
            if (ModelState.IsValid)
            {
                db.FlujoPeriodico.Add(flujoPeriodico);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.FK_IDBonoContrato = new SelectList(db.BonoContrato, "IDBonoContrato", "FrecuenciaPago", flujoPeriodico.FK_IDBonoContrato);
            return View(flujoPeriodico);
        }

        // GET: FlujoPeriodicoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FlujoPeriodico flujoPeriodico = db.FlujoPeriodico.Find(id);
            if (flujoPeriodico == null)
            {
                return HttpNotFound();
            }
            ViewBag.FK_IDBonoContrato = new SelectList(db.BonoContrato, "IDBonoContrato", "FrecuenciaPago", flujoPeriodico.FK_IDBonoContrato);
            return View(flujoPeriodico);
        }

        // POST: FlujoPeriodicoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDFlujoPeriodico,Bono,BonoIndexado,Cupon,Cuota,Amortizacion,Prima,Escudo,FlujoEmisor,FlujoEmisorEscudo,FlujoBonista,ValorBonoDCP,FK_IDBonoContrato")] FlujoPeriodico flujoPeriodico)
        {
            if (ModelState.IsValid)
            {
                db.Entry(flujoPeriodico).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.FK_IDBonoContrato = new SelectList(db.BonoContrato, "IDBonoContrato", "FrecuenciaPago", flujoPeriodico.FK_IDBonoContrato);
            return View(flujoPeriodico);
        }

        // GET: FlujoPeriodicoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            FlujoPeriodico flujoPeriodico = db.FlujoPeriodico.Find(id);
            if (flujoPeriodico == null)
            {
                return HttpNotFound();
            }
            return View(flujoPeriodico);
        }

        // POST: FlujoPeriodicoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            FlujoPeriodico flujoPeriodico = db.FlujoPeriodico.Find(id);
            db.FlujoPeriodico.Remove(flujoPeriodico);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        //------------// 

        public void CalcularFlujosTotalesAmericano(ref List<decimal> listBono_Indexado, ref List<decimal> listCupon,
            ref List<decimal> listCuota, ref List<decimal> listAmortizacion, ref List<decimal> listEscudo,
            ref List<decimal> listFlujoEmisor, ref List<decimal> listFlujoEmisorEscudo, ref List<decimal> listFlujoBonista,
            int periodosTotales, decimal valorNominal, double IR, double prima, double TEP, ref decimal valorPrima)
        {
            for (int i = 0; i < periodosTotales; i++)
            {
                if (i == 0)
                {
                    listBono_Indexado.Add(valorNominal);
                    listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                    listAmortizacion.Add((decimal)0.00);
                    listCuota.Add(listCupon[i] + listAmortizacion[i]);
                    listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                    listFlujoEmisor.Add(listCuota[i] + valorPrima);
                    listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                    listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                }
                else if (i > 0 && i < periodosTotales - 1)
                {
                    listBono_Indexado.Add(listBono_Indexado[i - 1] + listAmortizacion[i - 1]);
                    listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                    listAmortizacion.Add((decimal)0.00);
                    listCuota.Add(listCupon[i] + listAmortizacion[i]);
                    listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                    listFlujoEmisor.Add(listCuota[i] + valorPrima);
                    listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                    listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                }
                else
                {
                    listBono_Indexado.Add(listBono_Indexado[i - 1] + listAmortizacion[i - 1]);
                    listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                    listAmortizacion.Add((-1)*valorNominal);
                    listCuota.Add(listCupon[i] + listAmortizacion[i]);
                    valorPrima = (-1) * (decimal)prima * listBono_Indexado[i];
                    listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                    listFlujoEmisor.Add(listCuota[i] + valorPrima);
                    listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                    listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                }
            }
        }
        public void CalcularFlujosTotalesFrances(ref List<decimal> listBono_Indexado, ref List<decimal> listCupon,
            ref List<decimal> listCuota, ref List<decimal> listAmortizacion, ref List<decimal> listEscudo,
            ref List<decimal> listFlujoEmisor, ref List<decimal> listFlujoEmisorEscudo, ref List<decimal> listFlujoBonista,
            int periodosTotales, decimal valorNominal, double IR, double prima, double TEP, ref decimal valorPrima)
        {
            decimal cuotaConstante = 0M;
            double numerador = TEP * Math.Pow(1 + TEP,periodosTotales);
            double denominador = Math.Pow(1 + TEP, periodosTotales) - 1;
            cuotaConstante = valorNominal * (decimal)((numerador * 1.0) / (denominador * 1.0));
            cuotaConstante = cuotaConstante * (-1);
            for (int i = 0; i < periodosTotales; i++)
            {
                if (i == 0)
                {
                    listBono_Indexado.Add(valorNominal);
                    listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                    listCuota.Add(cuotaConstante);
                    listAmortizacion.Add(listCuota[i]-listCupon[i]);
                    listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                    listFlujoEmisor.Add(listCuota[i] + valorPrima);
                    listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                    listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                }
                else if (i > 0 && i < periodosTotales - 1)
                {
                    listBono_Indexado.Add(listBono_Indexado[i - 1] + listAmortizacion[i - 1]);
                    listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                    listCuota.Add(cuotaConstante);
                    listAmortizacion.Add(listCuota[i] - listCupon[i]);
                    listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                    listFlujoEmisor.Add(listCuota[i] + valorPrima);
                    listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                    listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                }
                else
                {
                    listBono_Indexado.Add(listBono_Indexado[i - 1] + listAmortizacion[i - 1]);
                    listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                    listCuota.Add(cuotaConstante);
                    listAmortizacion.Add(listCuota[i] - listCupon[i]);
                    valorPrima = (-1) * (decimal)prima * listBono_Indexado[i];
                    listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                    listFlujoEmisor.Add(listCuota[i] + valorPrima);
                    listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                    listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                }
            }
        }
        public Results calcularResultados(BonoContrato bonoContrato, CostesIniciales costesIniciales,List<double> listFlujoEmisor,
            List<double> listFlujoEmisorEscudo,List<decimal> listFlujoBonista, decimal valorActualBono)
        {
            Results results = new Results();
            List<double> listFlujoBonistaDouble = listFlujoBonista.ConvertAll(x => (double)x);
            decimal CIEmisor = 0M;
            decimal CIBonista = 0M;
            decimal flujoEmisorCero = 0M;
            decimal flujoBonistaCero = 0M;
            decimal utilidadPerdida = 0M;
            double TIRBonista = 0.0;
            double TIREmisor = 0.00;
            double TIREmisorEscudo = 0.00;
            double TREABonista = 0.00;
            int nroDiasPeriodo = 0;
            double TCEAEmisor = 0.00;
            double TCEAEmisorEscudo = 0.00;

            //Calcular CIEmisor
            CIEmisor = (decimal)((costesIniciales.PorcEstructuracion + costesIniciales.PorcColocacion + costesIniciales.PorcFlotacion +
                costesIniciales.PorcCAVALI)/100)*bonoContrato.ValorComercial;

            //Calcular CIBonista 
            CIBonista = (decimal)((costesIniciales.PorcFlotacion + costesIniciales.PorcCAVALI) / 100) * bonoContrato.ValorComercial;

            //Calcular flujoEmisorCero(Vcom-CIEmisor) flujoEmisorEscudoCero
            flujoEmisorCero = bonoContrato.ValorComercial - CIEmisor;

            //Calcular flujoBonistaCero(-Vcom-CIBonista) 
            flujoBonistaCero = (-1) * bonoContrato.ValorComercial - CIBonista;

            //Calcular TIRBonista 
            listFlujoBonistaDouble.Insert(0, (double)flujoBonistaCero);
            TIRBonista = Excel.FinancialFunctions.Financial.Irr(listFlujoBonistaDouble);

            //Calcular TREABonista 
            switch (bonoContrato.FrecuenciaPago)
            {
                case "Diaria":
                    nroDiasPeriodo = 1;
                    break;
                case "Mensual":
                    nroDiasPeriodo = 30;
                    break;
                case "Bimestral":
                    nroDiasPeriodo = 60;
                    break;
                case "Trimestral":
                    nroDiasPeriodo = 90;
                    break;
                case "Cuatrimestral":
                    nroDiasPeriodo = 120;
                    break;
                case "Semestral":
                    nroDiasPeriodo = 180;
                    break;
                case "Anual":
                    nroDiasPeriodo = 360;
                    break;
            }
            TREABonista = Math.Pow(TIRBonista + 1, 360 * (1.0) / nroDiasPeriodo*(1.0)) - 1; 

            //Calcular TIREmisor 
            listFlujoEmisor.Insert(0, (double)flujoEmisorCero);
            TIREmisor = Excel.FinancialFunctions.Financial.Irr(listFlujoEmisor);

            //Calcular TIREmisorEscudo 
            listFlujoEmisorEscudo.Insert(0, (double)flujoEmisorCero);
            TIREmisorEscudo = Excel.FinancialFunctions.Financial.Irr(listFlujoEmisorEscudo);

            //Calcular TCEAEmisor 
            TCEAEmisor = Math.Pow(TIREmisor + 1, 360 * (1.0) / nroDiasPeriodo * (1.0)) - 1;

            //Calcular TCEAEmisorEscudo
            TCEAEmisorEscudo = Math.Pow(TIREmisorEscudo + 1, 360 * (1.0) / nroDiasPeriodo * (1.0)) - 1;

            //Calcular UtilidadPerdida 
            utilidadPerdida = flujoBonistaCero + valorActualBono;

            results.CIEmisor = Math.Round(CIEmisor,2);
            results.CIBonista = Math.Round(CIBonista,2);
            results.flujoBonistaCero = Math.Round(flujoBonistaCero,2);
            results.flujoEmisorCero = Math.Round(flujoEmisorCero,2);
            results.flujoEmisorEscudoCero = Math.Round(flujoEmisorCero,2);
            results.PrecioActualBono = Math.Round(valorActualBono,2);
            results.TCEAEmisor = Math.Round(TCEAEmisor*100,6);
            results.TCEAEmisorEscudo = Math.Round(TCEAEmisorEscudo*100,6);
            results.TIRBonista = Math.Round(TIRBonista*100,6);
            results.TIREmisor = Math.Round(TIREmisor*100,6);
            results.TIREmisorEscudo = Math.Round(TIREmisorEscudo*100,6);
            results.TREABonista = Math.Round(TREABonista*100,6);
            results.UtilidadPerdida = Math.Round(utilidadPerdida,2);
            

            return results;
        }
        public List<decimal> calcularValorBono(List<double> flujoBonista,double COKP,int periodosTotales)
        {
            List<decimal> listValorBono = new List<decimal>();
            decimal valorBonoDCP = 0M;
            
            for (int i = 0; i < periodosTotales; i++)
            {
                if (i == periodosTotales - 1)
                {
                    valorBonoDCP = 0;
                    listValorBono.Add(valorBonoDCP);
                }
                else
                {
                    flujoBonista.RemoveAt(0);
                    valorBonoDCP = (decimal)Excel.FinancialFunctions.Financial.Npv(COKP, flujoBonista);
                    listValorBono.Add(valorBonoDCP);
                }
            }

            return listValorBono;
        }
        public List<FlujoPeriodico> CalcularFlujosTotales(BonoContrato bonoContrato, CostesIniciales costesIniciales, int periodosTotales,string planPago, string tipoMoneda)
        {
            List<FlujoPeriodico> objLista = new List<FlujoPeriodico>();
            FlujoPeriodico flujoPeriodico;
            List<decimal> listBono_Indexado = new List<decimal>();
            List<decimal> listCupon = new List<decimal>();
            List<decimal> listCuota = new List<decimal>();
            List<decimal> listAmortizacion = new List<decimal>();
            List<decimal> listEscudo = new List<decimal>();
            List<decimal> listFlujoEmisor = new List<decimal>();
            List<decimal> listFlujoEmisorEscudo = new List<decimal>();
            List<decimal> listFlujoBonista = new List<decimal>();
            List<decimal> listValorDelBono = new List<decimal>();

            Results results = new Results();

            //Calculo de la TEP 
            double TEP = 0.00;
            double TEA = bonoContrato.TasaInteresAnual;
            TEA = TEA / 100;
            int nTEP = 0;
            string frecuenciaPago = bonoContrato.FrecuenciaPago;
            switch (frecuenciaPago)
            {
                case "Diaria":
                    nTEP = 1;
                    break;
                case "Mensual":
                    nTEP = 30;
                    break;
                case "Bimestral":
                    nTEP = 60;
                    break;
                case "Trimestral":
                    nTEP = 90;
                    break;
                case "Cuatrimestral":
                    nTEP = 120;
                    break;
                case "Semestral":
                    nTEP = 180;
                    break;
                case "Anual":
                    nTEP = 360;
                    break;
            }

            TEP = Math.Pow(TEA + 1, (nTEP*1.0)/ (360*1.0))-1;
            TEP = Math.Round(TEP, 8);

            //Calculo del COK del periodo 
            double COKP = 0.00;
            double COK = bonoContrato.TasaDescuentoAnual;
            COK = COK / 100;

            COKP = Math.Pow(COK + 1,(nTEP*1.0)/(360*1.0))-1;
            COKP = Math.Round(COKP, 8);

            double IR = bonoContrato.ImpuestoRenta;
            IR = IR / 100;
            double prima = costesIniciales.PorcPrima;
            prima = prima / 100;
            decimal valorNominal = bonoContrato.ValorNominal; 
            //METODO ALEMÁN

            decimal amortizacion = 0M;
            decimal valorPrima = 0M;

            //Calculo de la Amortización 
            if (planPago == "Método Alemán") 
            {
                amortizacion = valorNominal / periodosTotales;
                amortizacion = amortizacion * (-1);
                for (int i = 0; i < periodosTotales; i++)
                {
                    if (i == 0)
                    {
                        listBono_Indexado.Add(valorNominal);
                        listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                        listAmortizacion.Add(amortizacion);
                        listCuota.Add(listCupon[i] + listAmortizacion[i]);
                        listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                        listFlujoEmisor.Add(listCuota[i] + valorPrima);
                        listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                        listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                    }
                    else if (i > 0 && i < periodosTotales - 1)
                    {
                        listBono_Indexado.Add(listBono_Indexado[i - 1] + listAmortizacion[i - 1]);
                        listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                        listAmortizacion.Add(amortizacion);
                        listCuota.Add(listCupon[i] + amortizacion);
                        listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                        listFlujoEmisor.Add(listCuota[i] + valorPrima);
                        listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                        listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                    }
                    else
                    {
                        listBono_Indexado.Add(listBono_Indexado[i - 1] + listAmortizacion[i - 1]);
                        listCupon.Add((-1) * (decimal)TEP * listBono_Indexado[i]);
                        listAmortizacion.Add(amortizacion);
                        listCuota.Add(listCupon[i] + amortizacion);
                        valorPrima = (-1) * (decimal)prima * listBono_Indexado[i];
                        listEscudo.Add((-1) * (decimal)IR * listCupon[i]);
                        listFlujoEmisor.Add(listCuota[i] + valorPrima);
                        listFlujoEmisorEscudo.Add(listEscudo[i] + listFlujoEmisor[i]);
                        listFlujoBonista.Add((-1) * listFlujoEmisor[i]);
                    }
                }
            }  
            else if(planPago== "Método Americano") //METODO AMERICANO
            {
                CalcularFlujosTotalesAmericano(ref listBono_Indexado, ref listCupon, ref listCuota, ref listAmortizacion,
                    ref listEscudo, ref listFlujoEmisor, ref listFlujoEmisorEscudo, ref listFlujoBonista,
                    periodosTotales, valorNominal, IR, prima, TEP, ref valorPrima);
            }
            else //METODO FRANCÉS
            {
                CalcularFlujosTotalesFrances(ref listBono_Indexado, ref listCupon, ref listCuota, ref listAmortizacion,
                    ref listEscudo, ref listFlujoEmisor, ref listFlujoEmisorEscudo, ref listFlujoBonista,
                    periodosTotales, valorNominal, IR, prima, TEP, ref valorPrima);
            }

            for (int i = 0; i < periodosTotales; i++)
            {
                flujoPeriodico = new FlujoPeriodico();
                flujoPeriodico.Bono = listBono_Indexado[i];
                flujoPeriodico.BonoIndexado = listBono_Indexado[i];
                flujoPeriodico.Cupon = listCupon[i];
                flujoPeriodico.Cuota = listCuota[i];
                flujoPeriodico.Amortizacion = listAmortizacion[i];
                if (i == periodosTotales - 1)
                    flujoPeriodico.Prima = valorPrima;
                else
                    flujoPeriodico.Prima = 0M;

                flujoPeriodico.Escudo = listEscudo[i];
                flujoPeriodico.FlujoEmisor = listFlujoEmisor[i];
                flujoPeriodico.FlujoEmisorEscudo = listFlujoEmisorEscudo[i];
                flujoPeriodico.FlujoBonista = listFlujoBonista[i];
                flujoPeriodico.FK_IDBonoContrato = 0;

                objLista.Add(flujoPeriodico);

                flujoPeriodico = null;
            }

            //Conversion de decimal a double 
            List<double> listFlujoBonistaDouble = listFlujoBonista.ConvertAll(x => (double)x);
            List<double> listFlujoEmisorDouble = listFlujoEmisor.ConvertAll(x => (double)x);
            List<double> listFlujoEmisorEscudoDouble = listFlujoEmisorEscudo.ConvertAll(x => (double)x);

            //Calculo del Valor Actual del Bono
            decimal valorActualBono = (decimal)Excel.FinancialFunctions.Financial.Npv(COKP, listFlujoBonistaDouble);

            //Calculo del Valor Actual del Bono en cada periodo 
            listValorDelBono = calcularValorBono(listFlujoBonistaDouble, COKP, periodosTotales);

            //Calculo resultados de la operación
            results = calcularResultados(bonoContrato, costesIniciales, listFlujoEmisorDouble, listFlujoEmisorEscudoDouble, listFlujoBonista, valorActualBono);

            //Redondear resultados de flujos periodicos
            for (int i = 0; i < listValorDelBono.Count; i++)
            {
                listValorDelBono[i] = Math.Round(listValorDelBono[i], 2);
                objLista[i].Bono = Math.Round(objLista[i].Bono,2);
                objLista[i].BonoIndexado = Math.Round(objLista[i].BonoIndexado,2);
                objLista[i].Cupon = Math.Round(objLista[i].Cupon,2);
                objLista[i].Cuota = Math.Round(objLista[i].Cuota,2);
                objLista[i].Amortizacion = Math.Round(objLista[i].Amortizacion, 2);
                objLista[i].Prima = Math.Round(objLista[i].Prima,2);
                objLista[i].Escudo = Math.Round(objLista[i].Escudo,2);
                objLista[i].FlujoEmisor = Math.Round(objLista[i].FlujoEmisor,2);
                objLista[i].FlujoEmisorEscudo = Math.Round(objLista[i].FlujoEmisorEscudo,2);
                objLista[i].FlujoBonista = Math.Round(objLista[i].FlujoBonista,2);
                objLista[i].ValorBonoDCP = listValorDelBono[i];
            } 

            results.COKP = COKP*100;
            results.periodosTotales = periodosTotales;
            results.TEP = TEP*100;
            results.planPago = planPago;
            results.tipoMoneda = tipoMoneda;

            Session[SessionName.Resultados] = results;
            //Session[SessionName.Amortizacion] = amortizacion; 

            return objLista;
        }
        public List<FlujoPeriodico> GenerarFlujosTotales(FormCollection formCollection,int IDUsuarioBonista)
        {
            List<FlujoPeriodico> ListaPrincipalFlujosTotales = new List<FlujoPeriodico>();
            BonoContrato bonoContrato = new BonoContrato();
            string tipoMoneda = formCollection["selectTipoMoneda"];
            bonoContrato.ValorNominal = Convert.ToDecimal(formCollection["valorNominal"]);
            bonoContrato.ValorComercial = Convert.ToDecimal(formCollection["valorComercial"]);
            bonoContrato.NroAños = Convert.ToInt16(formCollection["tiempoTotal"]);
            bonoContrato.FrecuenciaPago = formCollection["selectFrecuenciaPago"];
            bonoContrato.DiasPorAño = Convert.ToInt16(formCollection["diasPorAño"]);
            bonoContrato.TipoTasaInteres = formCollection["selectTipoTasa"];
            int periodoTotal = Convert.ToInt16(formCollection["periodosTotales"]); 

            if (bonoContrato.TipoTasaInteres == "Tasa Efectiva")
            {
                bonoContrato.Capitalizacion = "Ninguno";
            }
            else
            {
                bonoContrato.Capitalizacion = formCollection["selectCap"];
            }

            bonoContrato.TasaInteresAnual = Convert.ToDouble(formCollection["TEA"]);
            bonoContrato.TasaDescuentoAnual = Convert.ToDouble(formCollection["COK"]);
            bonoContrato.ImpuestoRenta = Convert.ToDouble(formCollection["IR"]);
            bonoContrato.FechaEmision = Convert.ToDateTime(formCollection["fechaActual"]);

            //-------//

            CostesIniciales objCostoInicial = new CostesIniciales();
            objCostoInicial.PorcPrima = Convert.ToDouble(formCollection["prima"]);
            objCostoInicial.PorcEstructuracion = Convert.ToDouble(formCollection["estruct"]);
            objCostoInicial.PorcColocacion = Convert.ToDouble(formCollection["col"]);
            objCostoInicial.PorcFlotacion = Convert.ToDouble(formCollection["flot"]);
            objCostoInicial.PorcCAVALI = Convert.ToDouble(formCollection["cav"]);
            db.CostesIniciales.Add(objCostoInicial);
            db.SaveChanges();

            //-------//

            bonoContrato.FK_IDBonista = IDUsuarioBonista;
            bonoContrato.FK_IDCostesIniciales = 1;
            bonoContrato.FK_IDEmpresaEmisora = 1;

            //--------//

            string planPago = formCollection["selectPlanPago"];

            ListaPrincipalFlujosTotales = CalcularFlujosTotales(bonoContrato, objCostoInicial, periodoTotal, planPago, tipoMoneda);
            Session[SessionName.Bono] = bonoContrato;

            return ListaPrincipalFlujosTotales;
        }
        public ActionResult GenerarFlujoPeriodico(FormCollection formCollection)
        {
            UsuarioBonista usuario = (UsuarioBonista)Session[SessionName.User];
            
            var listaFlujoPeriodico = GenerarFlujosTotales(formCollection, usuario.IDUsuarioBonista);
            Session[SessionName.FlujosPeriodicos] = listaFlujoPeriodico;
            return View(listaFlujoPeriodico.ToList());
        }
        public ActionResult AgregarFlujosA_DB(int? id)
        {
            var listaFlujoPeriodico = (List<FlujoPeriodico>)Session[SessionName.FlujosPeriodicos];
            var objBono = (BonoContrato)Session[SessionName.Bono];
            db.BonoContrato.Add(objBono);
            db.SaveChanges(); 

            for (int i = 0; i < listaFlujoPeriodico.Count; i++)
            {
                listaFlujoPeriodico[i].FK_IDBonoContrato = objBono.IDBonoContrato;
                db.FlujoPeriodico.Add(listaFlujoPeriodico[i]);
                db.SaveChanges();
            } 

            if (id == 1)
                return RedirectToAction("SeeBondsIssued", "BonoContratoes");
            else if (id == 2)
                return RedirectToAction("HomeBonista", "Home");
            else
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        } 
        public ActionResult VerFlujoPagosByIDBono(int? IDBono)
        {
            var queryFP = from queryList in db.FlujoPeriodico.Include(q => q.BonoContrato)
                        where queryList.FK_IDBonoContrato==IDBono
                        select queryList;

            List<FlujoPeriodico> objListFlujoPeriodico = queryFP.ToList();
            List<double> listFlujoBonistaDouble = new List<double>();
            for (int i = 0; i < objListFlujoPeriodico.Count; i++)
            {
                listFlujoBonistaDouble.Add((double)objListFlujoPeriodico[i].FlujoBonista);
            }

            var queryBono = from query in db.BonoContrato.Include(q => q.UsuarioBonista).Include(q => q.CostesIniciales)
                            .Include(q => q.EmpresaEmisora)
                            where query.IDBonoContrato == IDBono
                            select query;

            int IDCostesIniciales = queryBono.FirstOrDefault().FK_IDCostesIniciales; 

            var queryCI = from query in db.CostesIniciales
                          where query.IDCostesIniciales == IDCostesIniciales
                          select query; 

            //Calculo de la TEP 
            double TEP = 0.00;
            double TEA = queryBono.FirstOrDefault().TasaInteresAnual;
            TEA = TEA / 100;
            int nTEP = 0;
            string frecuenciaPago = queryBono.FirstOrDefault().FrecuenciaPago;
            switch (frecuenciaPago)
            {
                case "Diaria":
                    nTEP = 1;
                    break;
                case "Mensual":
                    nTEP = 30;
                    break;
                case "Bimestral":
                    nTEP = 60;
                    break;
                case "Trimestral":
                    nTEP = 90;
                    break;
                case "Cuatrimestral":
                    nTEP = 120;
                    break;
                case "Semestral":
                    nTEP = 180;
                    break;
                case "Anual":
                    nTEP = 360;
                    break;
            } 

            //Calculo del COK del periodo 
            double COKP = 0.00;
            double COK = queryBono.FirstOrDefault().TasaDescuentoAnual;
            COK = COK / 100;
            COKP = Math.Pow(COK + 1, (nTEP * 1.0) / (360 * 1.0)) - 1;
            COKP = Math.Round(COKP, 8); 

            //Calculo del Valor Actual del Bono
            decimal valorActualBono = (decimal)Excel.FinancialFunctions.Financial.Npv(COKP, listFlujoBonistaDouble);

            //Calcular CIEmisor
            decimal CIEmisor = (decimal)((queryCI.FirstOrDefault().PorcEstructuracion + queryCI.FirstOrDefault().PorcColocacion + queryCI.FirstOrDefault().PorcFlotacion +
                queryCI.FirstOrDefault().PorcCAVALI) / 100) * queryBono.FirstOrDefault().ValorComercial;

            //Calcular CIBonista 
            decimal CIBonista = (decimal)((queryCI.FirstOrDefault().PorcFlotacion + queryCI.FirstOrDefault().PorcCAVALI) / 100) * queryBono.FirstOrDefault().ValorComercial;

            //Calcular flujoEmisorCero(Vcom-CIEmisor) flujoEmisorEscudoCero
            decimal flujoEmisorCero = queryBono.FirstOrDefault().ValorComercial - CIEmisor;

            //Calcular flujoBonistaCero(-Vcom-CIBonista) 
            decimal flujoBonistaCero = (-1) * queryBono.FirstOrDefault().ValorComercial - CIBonista; 

            for(int i = 0; i < objListFlujoPeriodico.Count; i++)
            {
                objListFlujoPeriodico[i].Bono = Math.Round(objListFlujoPeriodico[i].Bono, 2);
                objListFlujoPeriodico[i].BonoIndexado = Math.Round(objListFlujoPeriodico[i].BonoIndexado, 2);
                objListFlujoPeriodico[i].Cupon = Math.Round(objListFlujoPeriodico[i].Cupon, 2);
                objListFlujoPeriodico[i].Cuota = Math.Round(objListFlujoPeriodico[i].Cuota, 2);
                objListFlujoPeriodico[i].Amortizacion = Math.Round(objListFlujoPeriodico[i].Amortizacion, 2);
                objListFlujoPeriodico[i].Prima = Math.Round(objListFlujoPeriodico[i].Prima, 2);
                objListFlujoPeriodico[i].Escudo = Math.Round(objListFlujoPeriodico[i].Escudo, 2);
                objListFlujoPeriodico[i].FlujoEmisor = Math.Round(objListFlujoPeriodico[i].FlujoEmisor, 2);
                objListFlujoPeriodico[i].FlujoEmisorEscudo = Math.Round(objListFlujoPeriodico[i].FlujoEmisorEscudo, 2);
                objListFlujoPeriodico[i].FlujoBonista = Math.Round(objListFlujoPeriodico[i].FlujoBonista, 2);
                objListFlujoPeriodico[i].ValorBonoDCP = Math.Round(objListFlujoPeriodico[i].ValorBonoDCP, 2);
            }
            Results results = new Results();
            results.flujoEmisorCero = Math.Round(flujoEmisorCero,2);
            results.flujoEmisorEscudoCero = Math.Round(flujoEmisorCero,2);
            results.flujoBonistaCero = Math.Round(flujoBonistaCero,2);
            results.PrecioActualBono = Math.Round(valorActualBono,2);
            Session[SessionName.Resultados] = results;

            return View(objListFlujoPeriodico.ToList());
        }
    }
}