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
    public class BonoContratoesController : Controller
    {
        private FinanceYourLifeEntities1 db = new FinanceYourLifeEntities1();

        // GET: BonoContratoes
        public ActionResult Index()
        {
            var bonoContrato = db.BonoContrato.Include(b => b.CostesIniciales).Include(b => b.EmpresaEmisora).Include(b => b.UsuarioBonista);
            return View(bonoContrato.ToList());
        }

        // GET: BonoContratoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BonoContrato bonoContrato = db.BonoContrato.Find(id);
            if (bonoContrato == null)
            {
                return HttpNotFound();
            }
            return View(bonoContrato);
        }

        // GET: BonoContratoes/Create
        public ActionResult Create()
        {
            ViewBag.FK_IDCostesIniciales = new SelectList(db.CostesIniciales, "IDCostesIniciales", "IDCostesIniciales");
            ViewBag.FK_IDEmpresaEmisora = new SelectList(db.EmpresaEmisora, "IDEmpresaEmisora", "Nombre");
            ViewBag.FK_IDBonista = new SelectList(db.UsuarioBonista, "IDUsuarioBonista", "Nombres");
            return View();
        }

        // POST: BonoContratoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDBonoContrato,ValorComercial,ValorNominal,NroAños,FrecuenciaPago,DiasPorAño,TipoTasaInteres,Capitalizacion,TasaInteresAnual,TasaDescuentoAnual,ImpuestoRenta,FechaEmision,FK_IDBonista,FK_IDCostesIniciales,FK_IDEmpresaEmisora")] BonoContrato bonoContrato)
        {
            if (ModelState.IsValid)
            {
                db.BonoContrato.Add(bonoContrato);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.FK_IDCostesIniciales = new SelectList(db.CostesIniciales, "IDCostesIniciales", "IDCostesIniciales", bonoContrato.FK_IDCostesIniciales);
            ViewBag.FK_IDEmpresaEmisora = new SelectList(db.EmpresaEmisora, "IDEmpresaEmisora", "Nombre", bonoContrato.FK_IDEmpresaEmisora);
            ViewBag.FK_IDBonista = new SelectList(db.UsuarioBonista, "IDUsuarioBonista", "Nombres", bonoContrato.FK_IDBonista);
            return View(bonoContrato);
        }

        // GET: BonoContratoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BonoContrato bonoContrato = db.BonoContrato.Find(id);
            if (bonoContrato == null)
            {
                return HttpNotFound();
            }
            ViewBag.FK_IDCostesIniciales = new SelectList(db.CostesIniciales, "IDCostesIniciales", "IDCostesIniciales", bonoContrato.FK_IDCostesIniciales);
            ViewBag.FK_IDEmpresaEmisora = new SelectList(db.EmpresaEmisora, "IDEmpresaEmisora", "Nombre", bonoContrato.FK_IDEmpresaEmisora);
            ViewBag.FK_IDBonista = new SelectList(db.UsuarioBonista, "IDUsuarioBonista", "Nombres", bonoContrato.FK_IDBonista);
            return View(bonoContrato);
        }

        // POST: BonoContratoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDBonoContrato,ValorComercial,ValorNominal,NroAños,FrecuenciaPago,DiasPorAño,TipoTasaInteres,Capitalizacion,TasaInteresAnual,TasaDescuentoAnual,ImpuestoRenta,FechaEmision,FK_IDBonista,FK_IDCostesIniciales,FK_IDEmpresaEmisora")] BonoContrato bonoContrato)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bonoContrato).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.FK_IDCostesIniciales = new SelectList(db.CostesIniciales, "IDCostesIniciales", "IDCostesIniciales", bonoContrato.FK_IDCostesIniciales);
            ViewBag.FK_IDEmpresaEmisora = new SelectList(db.EmpresaEmisora, "IDEmpresaEmisora", "Nombre", bonoContrato.FK_IDEmpresaEmisora);
            ViewBag.FK_IDBonista = new SelectList(db.UsuarioBonista, "IDUsuarioBonista", "Nombres", bonoContrato.FK_IDBonista);
            return View(bonoContrato);
        }

        // GET: BonoContratoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BonoContrato bonoContrato = db.BonoContrato.Find(id);
            if (bonoContrato == null)
            {
                return HttpNotFound();
            }
            return View(bonoContrato);
        }

        // POST: BonoContratoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            BonoContrato bonoContrato = db.BonoContrato.Find(id);
            db.BonoContrato.Remove(bonoContrato);
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

        //-----// 
        public ActionResult SeeBondsIssued()
        {
            Session[SessionName.ErrorMessage] = null;
            return View();
        } 
        public ActionResult SeeBondsDetail(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            else
            {
                BonoContratoClass bonoContratoClass = new BonoContratoClass();
                CostesInicialesClass costesInicialesClass = new CostesInicialesClass();
                costesInicialesClass.PorcPrima = 1.00;
                costesInicialesClass.PorcEstructuracion = 0.50;
                costesInicialesClass.PorcColocacion = 0.50;
                costesInicialesClass.PorcFlotacion = 0.45;
                costesInicialesClass.PorcCAVALI = 0.50;
                switch (id)
                {
                    case 1:
                        bonoContratoClass.IDBono = 1;
                        bonoContratoClass.ValorNominal = 250000;
                        bonoContratoClass.ValorComercial = 255000;
                        bonoContratoClass.NroAños = 3;
                        bonoContratoClass.FrecuenciaPago = "";
                        bonoContratoClass.DiasPorAño = 360;
                        bonoContratoClass.TipoTasaInteres = "";
                        bonoContratoClass.Capitalizacion = "";
                        bonoContratoClass.TasaInteresAnual = 8.45;
                        bonoContratoClass.TasaDescuentoAnual = 4.50;
                        bonoContratoClass.ImpuestoRenta = 30.000000;
                        bonoContratoClass.FechaEmision ="06/10/18";
                        break;
                    case 2:
                        bonoContratoClass.IDBono = 2;
                        bonoContratoClass.ValorNominal = 300000;
                        bonoContratoClass.ValorComercial = 305000;  
                        bonoContratoClass.NroAños = 5;
                        bonoContratoClass.FrecuenciaPago = "";
                        bonoContratoClass.DiasPorAño = 360;
                        bonoContratoClass.TipoTasaInteres = "";
                        bonoContratoClass.Capitalizacion = "";
                        bonoContratoClass.TasaInteresAnual = 9.50;
                        bonoContratoClass.TasaDescuentoAnual = 4.50;
                        bonoContratoClass.ImpuestoRenta = 30.55565656;
                        bonoContratoClass.FechaEmision = "23/03/19";
                        break;
                    case 3:
                        bonoContratoClass.IDBono = 3;
                        bonoContratoClass.ValorNominal = 400000;
                        bonoContratoClass.ValorComercial = 405000;
                        bonoContratoClass.NroAños = 4;
                        bonoContratoClass.FrecuenciaPago = "";
                        bonoContratoClass.DiasPorAño = 360;
                        bonoContratoClass.TipoTasaInteres = "";
                        bonoContratoClass.Capitalizacion = "";
                        bonoContratoClass.TasaInteresAnual = 7.50;
                        bonoContratoClass.TasaDescuentoAnual = 4.50;
                        bonoContratoClass.ImpuestoRenta = 30.000000;
                        bonoContratoClass.FechaEmision = "05/10/19";
                        break;
                }
                Session[SessionName.Bono] = bonoContratoClass;
                Session[SessionName.CostoInicial] = costesInicialesClass;
                return View();
            }
        } 
        public ActionResult GenerarContrato()
        {
            return View();
        } 
        public ActionResult AllContracts()
        {
            UsuarioBonista objUsuario = (UsuarioBonista)Session[SessionName.User];

            var queryBono = from query in db.BonoContrato.Include(q => q.UsuarioBonista).Include(q => q.CostesIniciales)
                            .Include(q => q.EmpresaEmisora)
                            where query.FK_IDBonista == objUsuario.IDUsuarioBonista
                            select query;

            return View(queryBono.ToList());
        }
    }
}
