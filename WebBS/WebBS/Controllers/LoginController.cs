using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebBS.Models;

namespace WebBS.Controllers
{
    public class LoginController : Controller
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(LoginController));

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(LoginEntity model)
        {
            string plogin = model.Usuario;
            try
            {
                if ((model.Usuario == "admin" ||
                 model.Usuario == "ocr" ||
                 model.Usuario == "wrf" ||
                 model.Usuario == "dcm" ||
                 model.Usuario == "ass" ||
                 model.Usuario == "hcc") && model.Password == "123")
                {
                    switch (model.Usuario)
                    {
                        case "admin":
                            model.Nombre = "Administrador";
                            break;
                        case "ocr":
                            model.Nombre = "Orlando Carril";
                            break;
                        case "wrf":
                            model.Nombre = "Walter Rodriguez";
                            break;
                        case "dcm":
                            model.Nombre = "Danielito Collazos";
                            break;
                        case "ass":
                            model.Nombre = "Aaron Sarmiento";
                            break;
                    }
                    Session["Usuario"] = model;
                    FormsAuthentication.SetAuthCookie(plogin, true);
                    HttpContext.Response.Cookies.Add(new HttpCookie("UserIsAutenticated", plogin));

                    log.Info(String.Concat("Index", " | ", "Se ha ingresado al sistema: Usuario: " + plogin + " - " + model.Nombre));

                    //return RedirectToAction("SeleccionarPedido", "Picking");
                    return RedirectToAction("Plantilla", "Presupuesto");
                }
                else
                {
                    ViewBag.Error = "El usuario y/o contraseña son incorrectos";
                    
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Index", " | ", ex.Message));
            }
            return View();
        }

        public ActionResult CerrarSesion()
        {
            HttpContext.Session.Clear();
            //FormsAuthentication.SignOut();
            log.Info(String.Concat("CerrarSesion", " | ", "Se ha cerrado sesión del sistema: Usuario: " + User.Identity.Name));
            return RedirectToAction("Index", "Login");
        }
	}
}