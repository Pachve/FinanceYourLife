using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FinanceYourLife.Constantes;
using FinanceYourLife.Models;

namespace FinanceYourLife.Autorización
{
    public class OnlyAdministrators: AuthorizeAttribute
    {
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            if (httpContext.Session[SessionName.User] != null)
            {
                UsuarioBonista objUser = (UsuarioBonista)httpContext.Session["user"];
                if (objUser.TipoUsuario.TipoPersona.ToLower().Equals(UserTypeName.Admin.ToLower()))
                {
                    return true;
                }
            }
            return false;
        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            base.HandleUnauthorizedRequest(filterContext);
            filterContext.HttpContext.Response.Redirect("/Home/Index");
            //base.HandleUnauthorizedRequest(filterContext);
        }
    }
}