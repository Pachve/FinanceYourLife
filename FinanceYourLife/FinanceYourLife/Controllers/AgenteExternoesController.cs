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
    public class AgenteExternoesController : Controller
    {
        private FinanceYourLifeEntities1 db = new FinanceYourLifeEntities1();

        // GET: AgenteExternoes
        public ActionResult Index()
        {
            return View(db.AgenteExterno.ToList());
        }

        // GET: AgenteExternoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AgenteExterno agenteExterno = db.AgenteExterno.Find(id);
            if (agenteExterno == null)
            {
                return HttpNotFound();
            }
            return View(agenteExterno);
        }

        // GET: AgenteExternoes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: AgenteExternoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDAgenteExterno,Nombre,SedePrincipal")] AgenteExterno agenteExterno)
        {
            if (ModelState.IsValid)
            {
                db.AgenteExterno.Add(agenteExterno);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(agenteExterno);
        }

        // GET: AgenteExternoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AgenteExterno agenteExterno = db.AgenteExterno.Find(id);
            if (agenteExterno == null)
            {
                return HttpNotFound();
            }
            return View(agenteExterno);
        }

        // POST: AgenteExternoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDAgenteExterno,Nombre,SedePrincipal")] AgenteExterno agenteExterno)
        {
            if (ModelState.IsValid)
            {
                db.Entry(agenteExterno).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(agenteExterno);
        }

        // GET: AgenteExternoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AgenteExterno agenteExterno = db.AgenteExterno.Find(id);
            if (agenteExterno == null)
            {
                return HttpNotFound();
            }
            return View(agenteExterno);
        }

        // POST: AgenteExternoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            AgenteExterno agenteExterno = db.AgenteExterno.Find(id);
            db.AgenteExterno.Remove(agenteExterno);
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
