using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBS.Models;

namespace WebBS.Controllers
{
    public class PickingController : Controller
    {
        private BDBoticasEntities db = new BDBoticasEntities();
        //
        // GET: /Picking/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult SeleccionarPedido()
        {
            return View();
        }
        
        public JsonResult ListarPedidos(string param)
        {
            return Json(db.sp_PedidosListar(param).ToList(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult DetallePedido(string NumeroPedido)
        {
            return Json(db.sp_DetallePedido_Productos(NumeroPedido).ToList(), JsonRequestBehavior.AllowGet);
        }
        
        public string CerrarPedido(string NumeroPedido, List<DetalleNotaSalida> Detalle)
        {
            //Nota de salida
            NotaSalida ns = new NotaSalida();
            var ultimo = db.NotaSalida.OrderByDescending(x => x.NumeroSalida).Take(1).FirstOrDefault();
            double numero = 1;
            if (ultimo != null) numero = double.Parse(ultimo.NumeroSalida.Replace("NS-", "")) + 1;            

            ns.NumeroSalida = "NS-" + double.Parse(numero.ToString()).ToString("#000000");
            ns.NumeroPedido = NumeroPedido;
            ns.FechaSalida = DateTime.Now.ToShortDateString();
            //ns.idAlmacen = 1;
            var usuario = (LoginEntity)Session["Usuario"];
            if (usuario != null) ns.UsuarioPicking = usuario.Usuario;                        
            db.NotaSalida.Add(ns);

            //Detalle Nota de salida
            List<DetalleNotaSalida> detalleSalida = new List<DetalleNotaSalida>();
            DetalleNotaSalida objDetalle;

            //Kardex
            Kardex objKardex;
            List<DetalleKardex> detalleKardex = new List<DetalleKardex>();
            DetalleKardex dKardex;

            foreach (var item in Detalle)
            {
                //Detalle de la nota de salida
                objDetalle = new DetalleNotaSalida();
                objDetalle.NumeroSalida = ns.NumeroSalida;
                objDetalle.IdProducto = item.IdProducto;
                objDetalle.Cantidad = item.Cantidad;
                detalleSalida.Add(objDetalle);

                //Detalle del kardex
                objKardex = db.Kardex.FirstOrDefault(x => x.IdProducto == item.IdProducto); //&& x.IdAlmacen == IdAlmacen
                if (objKardex != null)
                {
                    dKardex = new DetalleKardex();
                    dKardex.NumeroKardex = objKardex.NumeroKardex;
                    dKardex.NumeroDocumento = NumeroPedido;
                    dKardex.TipodeMovimiento = 2;
                    dKardex.NumeroSalida = ns.NumeroSalida;
                    dKardex.Fecha = DateTime.Now;
                    dKardex.Cantidad = item.Cantidad;                    
                    detalleKardex.Add(dKardex);
                }
            }
            
            //Detalle de Nota de Salida
            db.DetalleNotaSalida.AddRange(detalleSalida);

            //Kardex
            db.DetalleKardex.AddRange(detalleKardex);

            //Actualizamos el estado del pedido
            var pedido = db.Pedido.Find(NumeroPedido);
            if (pedido != null) pedido.Estado = 3;//Atendido
            db.SaveChanges();

           return ns.NumeroSalida;            
        }
	}
}