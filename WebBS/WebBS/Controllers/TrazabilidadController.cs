using Bys.Trazabilidad.Logic;
using ByS.Tools;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using ByS.Trazabilidad.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace WebBS.Controllers
{
    public class TrazabilidadController : Controller
    {

        private InformeVentaLogic objVentaLogic = null;
        private KardexLogic objKardexLogic = null;
        private OrdenDeCompraLogic objCompraLogic = null;
        private OrdendeDespachoLogic objDespachoLogic = null;
        private HojaMermaLogic objMermaLogic = null;
        public LibroRecetaLogic objRecetaLogic = null;
        private ReturnValor returnValor = null;
        private ProductoLogic objProductoLogic = null;
        private Parametro filtro = null;
        private FichaTecnicaProductoFarmaciaLogic fichaTecnicaProductoFarmacia = null;
        public TrazabilidadController()
        {

        }


        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Trazabilidad()
        {
            return View();
        }

        public ActionResult OrdenRetiroProducto() {
            return View();
        }

        public JsonResult FichaTecnicaFarmacia(string producto)
        {

            producto = producto.ToLower();
            List<FichaTecnicaProductoFarmaciaDTO> lista = new List<FichaTecnicaProductoFarmaciaDTO>();
            filtro = new Parametro();
            filtro.codProducto = producto;
            fichaTecnicaProductoFarmacia = new FichaTecnicaProductoFarmaciaLogic();

            try
            {
                var codigo = int.Parse(producto);
                lista = fichaTecnicaProductoFarmacia.Listar(filtro);

            }
            catch (Exception)
            {

            }

            return Json(lista, JsonRequestBehavior.AllowGet); ;
        }

        public string ActualizarFichaTecnica(FichaTecnicaProductoFarmaciaEntity ficha)
        {
            fichaTecnicaProductoFarmacia = new FichaTecnicaProductoFarmaciaLogic();
            ReturnValor retorno = fichaTecnicaProductoFarmacia.Actualizar(ficha);

            return ficha.codigoFichaTecProducto;
        }

        public JsonResult BuscarProductoTraza(string producto)
        {
            producto = producto.ToLower();
            filtro = new Parametro();
            objProductoLogic = new ProductoLogic();
            filtro.codProducto = producto;
            filtro.nomProducto = producto;

            var lista = objProductoLogic.Listar(filtro);


            return Json(lista, JsonRequestBehavior.AllowGet); ;
        }

        public JsonResult ConsultarTrazabilidad(string Codigo, string FechaInicio, string FechaFin)
        {
            DateTime fecha_ini = DateTime.Parse(FechaInicio);
            DateTime fecha_fin = DateTime.Parse(FechaFin);
            filtro = new Parametro();
            filtro.codProducto = Codigo;
            filtro.fechaFin = fecha_fin;
            filtro.fechaIni = fecha_ini;

            objVentaLogic = new InformeVentaLogic();
            objKardexLogic = new KardexLogic();
            objMermaLogic = new HojaMermaLogic();
            objCompraLogic = new OrdenDeCompraLogic();
            objDespachoLogic = new OrdendeDespachoLogic();
            objRecetaLogic = new LibroRecetaLogic();
            var ventas = objVentaLogic.ListarInformeVenta(filtro);
            var kardex = objKardexLogic.Listar(filtro);
            var ordenes_compra = objCompraLogic.Listar(filtro);
            var ordenes_pedido = objDespachoLogic.Listar(filtro);
            var recetas = objRecetaLogic.Listar(filtro);
            var hoja_merma = objMermaLogic.Listar(filtro);


            return Json(new
            {
                Producto = "",
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