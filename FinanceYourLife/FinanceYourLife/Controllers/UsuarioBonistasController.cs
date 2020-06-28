using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FinanceYourLife.Constantes;
using FinanceYourLife.Models;

namespace FinanceYourLife.Controllers
{
    public class UsuarioBonistasController : Controller
    {
        private FinanceYourLifeEntities1 db = new FinanceYourLifeEntities1();

        // GET: UsuarioBonistas
        public ActionResult Index()
        {
            var usuarioBonista = db.UsuarioBonista.Include(u => u.TipoUsuario);
            return View(usuarioBonista.ToList());
        }

        // GET: UsuarioBonistas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UsuarioBonista usuarioBonista = db.UsuarioBonista.Find(id);
            if (usuarioBonista == null)
            {
                return HttpNotFound();
            }
            return View(usuarioBonista);
        }

        // GET: UsuarioBonistas/Create
        public ActionResult Create()
        {
            ViewBag.IDTipoUsuario = new SelectList(db.TipoUsuario, "IDTipoUsuario", "TipoPersona");
            return View();
        }

        // POST: UsuarioBonistas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDUsuarioBonista,Nombres,Apellidos,Correo,Contraseña,RUC,ConfirmarContraseña")] UsuarioBonista usuarioBonista)
        {
            if (ModelState.IsValid)
            {
                if (db.UsuarioBonista.Any(x => x.Correo == usuarioBonista.Correo))
                {
                    ViewBag.DuplicateEmail = "Error, the entered email already exists. Please enter another email.";
                    return View(usuarioBonista);
                }
                usuarioBonista.IDTipoUsuario = 2;
                db.UsuarioBonista.Add(usuarioBonista);
                db.SaveChanges();

                var query = from user in db.UsuarioBonista.Include("TipoUsuario")
                            where user.IDUsuarioBonista==usuarioBonista.IDUsuarioBonista
                            select user;
                if (query.FirstOrDefault().IDTipoUsuario != 1)
                {
                    Session[SessionName.User] = query.FirstOrDefault();
                }

                return RedirectToAction("HomeBonista", "Home");
            }

            ViewBag.IDTipoUsuario = new SelectList(db.TipoUsuario, "IDTipoUsuario", "TipoPersona", usuarioBonista.IDTipoUsuario);
            return View(usuarioBonista);
        }

        // GET: UsuarioBonistas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UsuarioBonista usuarioBonista = db.UsuarioBonista.Find(id);
            if (usuarioBonista == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDTipoUsuario = new SelectList(db.TipoUsuario, "IDTipoUsuario", "TipoPersona", usuarioBonista.IDTipoUsuario);
            return View(usuarioBonista);
        }

        // POST: UsuarioBonistas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(UsuarioBonista usuarioBonista)
        {
            if (usuarioBonista!=null)
            {
                usuarioBonista.IDTipoUsuario = 2;
                db.Entry(usuarioBonista).State = EntityState.Modified;
                db.SaveChanges();
                var query = from user in db.UsuarioBonista.Include("TipoUsuario")
                            where user.IDUsuarioBonista == usuarioBonista.IDUsuarioBonista
                            select user;
                UsuarioBonista objUsuario = query.FirstOrDefault();
                Session[SessionName.User] = objUsuario;
                return RedirectToAction("HomeBonista", "Home");
            }
            ViewBag.IDTipoUsuario = new SelectList(db.TipoUsuario, "IDTipoUsuario", "TipoPersona", usuarioBonista.IDTipoUsuario);
            return View(usuarioBonista);
        }

        // GET: UsuarioBonistas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UsuarioBonista usuarioBonista = db.UsuarioBonista.Find(id);
            if (usuarioBonista == null)
            {
                return HttpNotFound();
            }
            return View(usuarioBonista);
        }

        // POST: UsuarioBonistas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            UsuarioBonista usuarioBonista = db.UsuarioBonista.Find(id);
            db.UsuarioBonista.Remove(usuarioBonista);
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

        //-------------//
        [AllowAnonymous]
        public ActionResult LoginUser()
        {
            return View();
        } 

        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LoginUser(UsuarioBonista usuario)
        {
            if (usuario.Correo!=null && usuario.Contraseña!=null)
            {
                var query = from user in db.UsuarioBonista.Include("TipoUsuario")
                            where user.Correo == usuario.Correo && user.Contraseña == usuario.Contraseña
                            select user;
                UsuarioBonista usuarioBonista = query.FirstOrDefault(); 
                if(usuarioBonista!=null)
                {
                    Session[SessionName.User] = usuarioBonista;
                    if (usuarioBonista.IDTipoUsuario == 2)
                        return RedirectToAction("HomeBonista", "Home");
                    return RedirectToAction("HomeAdministrator", "Home");
                }
                ViewBag.InvalidUser = "Error, user or password entered is incorrect. Please, enter correct information.";
            }
            return View(usuario);
        } 

        [AllowAnonymous] 
        public ActionResult SignOut()
        {
            Session.Clear();
            return RedirectToAction("HomeFinanceYourLife", "Home");
        }
    }
}
