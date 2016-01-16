using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBS.Models;
using WebBS.Models.Trazabilidad;

namespace WebBS.Controllers
{
    public class ProductoController : Controller
    {
        private BDBoticasEntities db;
        private ModelGrupo2Entities db2;

        public ProductoController()
        {
            db = new BDBoticasEntities();
            db.Configuration.ProxyCreationEnabled = false;
            db2 = new ModelGrupo2Entities();
            db2.Configuration.ProxyCreationEnabled = false;
        }

        //Funciones para el grupo 1
        public JsonResult BuscarPorId(int IdProducto)
        {
            var producto = db.Productos.FirstOrDefault(x => x.idProducto == IdProducto);
            return Json(producto, JsonRequestBehavior.AllowGet); ;
        }

        public JsonResult ConsultarUbicacion(int IdProducto)
        {
            return Json(db.sp_UbicacionProducto(IdProducto).ToList(), JsonRequestBehavior.AllowGet);
        }

        public decimal? ConsultarStock(int IdProducto)
        {
            return db.UbicacionProducto.Where(x=> x.IdProducto == IdProducto).Sum(x => x.Cantidad);
        }

        //Funciones para el grupo 2
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Trazabilidad()
        {
            return View();
        }

        public JsonResult FichaTecnicaFarmacia(string id)
        {
            var ficha = db2.FichaTecnicaProductoFarmacia.FirstOrDefault(x => x.codigoFichaTecProducto == id);
            return Json(ficha, JsonRequestBehavior.AllowGet);
        }

        public string ActualizarFichaTecnica(FichaTecnicaProductoFarmacia ficha)
        {
            var obj = db2.FichaTecnicaProductoFarmacia.Find(ficha.codigoFichaTecProducto);
            db2.Entry(obj).CurrentValues.SetValues(ficha);
            db2.SaveChanges();
            return ficha.codigoFichaTecProducto;
        }

        public JsonResult ConsultarTrazabilidad(string Codigo, string FechaInicio, string FechaFin)
        {
            DateTime fecha_ini = DateTime.Parse(FechaInicio);
            DateTime fecha_fin = DateTime.Parse(FechaFin);

            //Dictionary<string, object> datos = new Dictionary<string,object>();
            var producto = "Panadol Antigripal 500 mg";//Consultar el nombre de la base de datos
            var ventas = db2.InformeVenta.Where(x => x.codigoProducto == Codigo && x.fechaVenta >= fecha_ini && x.fechaVenta <= fecha_fin).ToList();
            var kardex = db2.Kardex.Where(x => x.codigoProducto == Codigo && x.fecha >= fecha_ini && x.fecha <= fecha_fin).ToList();
            var ordenes_compra = new List<string>();
            var ordenes_pedido = new List<string>();
            var recetas = new List<string>();
            var hoja_merma = new List<string>();

            return Json(new { 
                Producto = producto,
                InformeVenta = ventas, 
                Kardex = kardex,
                OrdenesCompra = ordenes_compra,
                OrdenesPedido = ordenes_pedido,
                Recetas = recetas,
                HojaMerma = hoja_merma
            }, JsonRequestBehavior.AllowGet);
        }
	}
}