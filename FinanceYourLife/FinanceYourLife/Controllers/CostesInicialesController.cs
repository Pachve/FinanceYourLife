using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FinanceYourLife.Models;

namespace FinanceYourLife.Controllers
{
    public class CostesInicialesController : Controller
    {
        private FinanceYourLifeEntities1 db = new FinanceYourLifeEntities1();

        // GET: CostesIniciales
        public ActionResult Index()
        {
            return View(db.CostesIniciales.ToList());
        }

        // GET: CostesIniciales/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CostesIniciales costesIniciales = db.CostesIniciales.Find(id);
            if (costesIniciales == null)
            {
                return HttpNotFound();
            }
            return View(costesIniciales);
        }

        // GET: CostesIniciales/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: CostesIniciales/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDCostesIniciales,PorcPrima,PorcEstructuracion,PorcColocacion,PorcFlotacion,PorcCAVALI")] CostesIniciales costesIniciales)
        {
            if (ModelState.IsValid)
            {
                db.CostesIniciales.Add(costesIniciales);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(costesIniciales);
        }

        // GET: CostesIniciales/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CostesIniciales costesIniciales = db.CostesIniciales.Find(id);
            if (costesIniciales == null)
            {
                return HttpNotFound();
            }
            return View(costesIniciales);
        }

        // POST: CostesIniciales/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDCostesIniciales,PorcPrima,PorcEstructuracion,PorcColocacion,PorcFlotacion,PorcCAVALI")] CostesIniciales costesIniciales)
        {
            if (ModelState.IsValid)
            {
                db.Entry(costesIniciales).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(costesIniciales);
        }

        // GET: CostesIniciales/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CostesIniciales costesIniciales = db.CostesIniciales.Find(id);
            if (costesIniciales == null)
            {
                return HttpNotFound();
            }
            return View(costesIniciales);
        }

        // POST: CostesIniciales/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            CostesIniciales costesIniciales = db.CostesIniciales.Find(id);
            db.CostesIniciales.Remove(costesIniciales);
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
    }
}
