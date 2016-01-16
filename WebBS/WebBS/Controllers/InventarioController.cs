using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebBS.Controllers
{
    public class InventarioController : Controller
    {
        //
        // GET: /Inventario/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Nuevo()
        {
            return View();
        }

        public ActionResult Consultar()
        {
            return View();
        }
	}
}