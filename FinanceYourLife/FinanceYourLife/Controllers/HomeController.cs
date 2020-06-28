using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FinanceYourLife.Constantes;

namespace FinanceYourLife.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        } 
        public ActionResult HomeFinanceYourLife()
        {
            return View();
        }
        public ActionResult HomeAdministrator()
        {
            return View();
        } 
        public ActionResult HomeBonista()
        {
            return View();
        } 
        public ActionResult EditProfileCustomer()
        {
            int IDCustomer = (int)Session[SessionName.User];
            return RedirectToAction("Edit", "UsuarioBonistas", IDCustomer);
        }
        public ActionResult EditProfileAdministrator()
        {
            int IDCustomer = (int)Session[SessionName.User];
            return RedirectToAction("Edit", "UsuarioBonistas", IDCustomer);
        }
    }
}