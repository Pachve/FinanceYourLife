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
    public class EmpresaEmisorasController : Controller
    {
        private FinanceYourLifeEntities1 db = new FinanceYourLifeEntities1();

        // GET: EmpresaEmisoras
        public ActionResult Index()
        {
            var empresaEmisora = db.EmpresaEmisora.Include(e => e.AgenteExterno);
            return View(empresaEmisora.ToList());
        }

        // GET: EmpresaEmisoras/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpresaEmisora empresaEmisora = db.EmpresaEmisora.Find(id);
            if (empresaEmisora == null)
            {
                return HttpNotFound();
            }
            return View(empresaEmisora);
        }

        // GET: EmpresaEmisoras/Create
        public ActionResult Create()
        {
            ViewBag.FK_IDAgenteExterno = new SelectList(db.AgenteExterno, "IDAgenteExterno", "Nombre");
            return View();
        }

        // POST: EmpresaEmisoras/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDEmpresaEmisora,Nombre,RUC,SedePrincipal,Rubro,FK_IDAgenteExterno")] EmpresaEmisora empresaEmisora)
        {
            if (ModelState.IsValid)
            {
                db.EmpresaEmisora.Add(empresaEmisora);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.FK_IDAgenteExterno = new SelectList(db.AgenteExterno, "IDAgenteExterno", "Nombre", empresaEmisora.FK_IDAgenteExterno);
            return View(empresaEmisora);
        }

        // GET: EmpresaEmisoras/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpresaEmisora empresaEmisora = db.EmpresaEmisora.Find(id);
            if (empresaEmisora == null)
            {
                return HttpNotFound();
            }
            ViewBag.FK_IDAgenteExterno = new SelectList(db.AgenteExterno, "IDAgenteExterno", "Nombre", empresaEmisora.FK_IDAgenteExterno);
            return View(empresaEmisora);
        }

        // POST: EmpresaEmisoras/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDEmpresaEmisora,Nombre,RUC,SedePrincipal,Rubro,FK_IDAgenteExterno")] EmpresaEmisora empresaEmisora)
        {
            if (ModelState.IsValid)
            {
                db.Entry(empresaEmisora).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.FK_IDAgenteExterno = new SelectList(db.AgenteExterno, "IDAgenteExterno", "Nombre", empresaEmisora.FK_IDAgenteExterno);
            return View(empresaEmisora);
        }

        // GET: EmpresaEmisoras/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EmpresaEmisora empresaEmisora = db.EmpresaEmisora.Find(id);
            if (empresaEmisora == null)
            {
                return HttpNotFound();
            }
            return View(empresaEmisora);
        }

        // POST: EmpresaEmisoras/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EmpresaEmisora empresaEmisora = db.EmpresaEmisora.Find(id);
            db.EmpresaEmisora.Remove(empresaEmisora);
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
