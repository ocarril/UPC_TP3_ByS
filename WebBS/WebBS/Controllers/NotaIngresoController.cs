using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.Entity;
using WebBS.Models;
using Newtonsoft.Json;

namespace WebBS.Controllers
{
    public class NotaIngresoController : Controller
    {
        private BDBoticasEntities db;

        public NotaIngresoController()
        {
            db = new BDBoticasEntities();
            db.Configuration.ProxyCreationEnabled = false;
        }
        //
        // GET: /NotaIngreso/
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult ListarAlmacenes()
        {
            return Json(db.Almacen.ToList(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult FiltrarNotaIngreso(string FechaInicio, string FechaFin, int? NumeroNotaIngreso, string Proveedor)
        {
            var result = db.NotaIngreso.AsEnumerable();

            if (FechaInicio != "" && FechaFin != "")
            {
                result = result.Where(x => x.Fecha >= DateTime.Parse(FechaInicio) && x.Fecha <= DateTime.Parse(FechaFin)).AsEnumerable();
            }
            if (NumeroNotaIngreso.HasValue)
            {
                result = result.Where(x => x.NumeroNotaIngreso.Contains(NumeroNotaIngreso.Value.ToString())).AsEnumerable();
            }
            if (Proveedor != "")
            {
                //*******
            }

            return Json(result.ToList(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult DetalleNotaIngreso(string NumeroNotaIngreso)
        {
            var almacenes = db.Almacen.ToList();
            var nota = db.NotaIngreso.FirstOrDefault(x => x.NumeroNotaIngreso == NumeroNotaIngreso);
            var detalle = db.sp_DetalleNotaIngreso(NumeroNotaIngreso).ToList();
            var data = new { Almacenes = almacenes, Nota = nota, Detalle = detalle };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public string GuardarNota(NotaIngreso nota)
        {
            if (nota.NumeroNotaIngreso == null)
            {
                var ultimo = db.NotaIngreso.OrderByDescending(x => x.NumeroNotaIngreso).Take(1).FirstOrDefault();
                double numero = 1;
                if (ultimo != null) numero = double.Parse(ultimo.NumeroNotaIngreso.Replace("NI-", "")) + 1;
                nota.NumeroNotaIngreso = "NI-" + double.Parse(numero.ToString()).ToString("#000000");

                db.NotaIngreso.Add(nota);

                //Agregamos un movimiento al Kardex
                Kardex objKardex;
                List<DetalleKardex> detalleKardex = new List<DetalleKardex>();
                DetalleKardex dKardex;

                foreach (var item in nota.DetalleNotaIngreso)
                {
                    //Detalle del kardex
                    objKardex = db.Kardex.FirstOrDefault(x => x.IdProducto == item.IdProducto); //&& x.IdAlmacen == IdAlmacen
                    if (objKardex != null)
                    {
                        dKardex = new DetalleKardex();
                        dKardex.NumeroKardex = objKardex.NumeroKardex;
                        dKardex.NumeroDocumento = nota.NumeroOrdenCompra;
                        dKardex.TipodeMovimiento = 1;
                        dKardex.NumeroNotaIngreso = nota.NumeroNotaIngreso;
                        dKardex.Fecha = DateTime.Now;
                        dKardex.Cantidad = item.Cantidad;
                        detalleKardex.Add(dKardex);
                    }
                }

                db.DetalleKardex.AddRange(detalleKardex);
            }
            else
            {
                var original = db.NotaIngreso.Find(nota.NumeroNotaIngreso);
                if (original != null)
                {
                    db.Entry(original).CurrentValues.SetValues(nota);

                    ////Ya no actualiza los items, porque tendría que modificar el kardex también

                    //db.DetalleNotaIngreso.RemoveRange(db.DetalleNotaIngreso.Where(x => x.NumeroNotaIngreso == nota.NumeroNotaIngreso));
                    //db.SaveChanges();

                    //DetalleNotaIngreso obj;                

                    //foreach (var item in nota.DetalleNotaIngreso)
                    //{
                    //    obj = new DetalleNotaIngreso();
                    //    obj.Cantidad = item.Cantidad;
                    //    obj.IdProducto = item.IdProducto;
                    //    obj.NumeroNotaIngreso = item.NumeroNotaIngreso;

                    //    db.DetalleNotaIngreso.Add(obj);                    
                    //}   
                }
            }

            db.SaveChanges();
            return nota.NumeroNotaIngreso;
        }

        public JsonResult EliminarNota(string NumeroNotaIngreso)
        {
            var obj = db.NotaIngreso.Find(NumeroNotaIngreso);
            if (obj != null)
            {
                db.DetalleNotaIngreso.RemoveRange(db.DetalleNotaIngreso.Where(x => x.NumeroNotaIngreso == NumeroNotaIngreso));
                db.SaveChanges();
                db.NotaIngreso.Remove(obj);
            }

            db.SaveChanges();
            return Json(new { success = true }, JsonRequestBehavior.AllowGet);
        }
    }
}