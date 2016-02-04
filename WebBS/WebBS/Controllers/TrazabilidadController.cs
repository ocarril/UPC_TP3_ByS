using Bys.Trazabilidad.Logic;
using ByS.Tools;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using ByS.Trazabilidad.Entities.Entities;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
        private TrazabilidadLogic trazabilidadLogic = null;
        private EmpleadoLogic objEmpleadoLogic = null;
        private ProcedimientoLogic objProcedimientoLogic = null;
        private InformeTrazabilidaLogic objInfTrazabilidadLogic = null;
        private OrdenRetiroLogic objOrdenRetiroLogic = null;
        

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

        public ActionResult InformeTrazabilidad()
        {
            return View();
        }

        public ActionResult OrdenRetiroProducto()
        {
            return View();
        }

        public JsonResult GuardarOrdenRetiro(OrdenRetiroEntity parametro)
        {
            objOrdenRetiroLogic = new OrdenRetiroLogic();

            bool retorno = objOrdenRetiroLogic.RetirarProducto(parametro);
            return Json(new { Valor = retorno }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Procedimiento()
        {
            ViewBag.cboProductos = ListarProducto();
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

            return Json(lista, JsonRequestBehavior.AllowGet); 
        }

        public JsonResult ObtenerTrazabilidad(string producto)
        {
            producto = producto.ToLower();
            TrazabilidadDTO lista = new TrazabilidadDTO();
            filtro = new Parametro();
            filtro.codProducto = producto;
            trazabilidadLogic = new TrazabilidadLogic();

            try
            {
                var codigo = int.Parse(producto);
                lista = trazabilidadLogic.Listar(filtro);
            }
            catch (Exception)
            {

            }
            return Json(lista, JsonRequestBehavior.AllowGet); 
        }

          [HttpPost]
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

        public JsonResult BuscarProcediento(string producto)
        {
            producto = producto.ToLower();
            filtro = new Parametro();
            objProcedimientoLogic = new ProcedimientoLogic();
            filtro.codProducto = producto;
            filtro.nomProducto = producto;
            var lista = objProcedimientoLogic.Listar(filtro);


            return Json(lista, JsonRequestBehavior.AllowGet); ;
        }

        [HttpPost]
        public ActionResult BuscarProcedientoPorId(string pcodigoProcedimiento)
        {
            ProcedimientoDTO objProcedimientoDto = null;
            object DataDevol = null;
            object partidas = null;
            object jsonResponse;
            try
            {
                filtro = new Parametro();
                objProcedimientoLogic = new ProcedimientoLogic();
                filtro.P_codigoProcedimiento = pcodigoProcedimiento;
                objProcedimientoDto = objProcedimientoLogic.BuscarProcedimientoById(filtro);

            }
            catch (Exception ex)
            {
                //tipoDevol = "E";
                //log.Error(String.Concat("BuscarPlantillaDetalle", " | ", ex.Message));
                DataDevol = ex.Message;
            }


            return Json(new
            {
                codigoProcedimiento = objProcedimientoDto.codigoProcedimiento,
                fechIniVigencia = objProcedimientoDto.fechIniVigencia.ToString(),
                fechFinVigencia = objProcedimientoDto.fechFinVigencia.ToString(),
                nombreProducto = objProcedimientoDto.nombreProducto,
                observaciones = objProcedimientoDto.observaciones,
                responsable = objProcedimientoDto.responsable,
                unidadPlazo = objProcedimientoDto.unidadPlazo,
                version = objProcedimientoDto.version,
                actividadProcedimiento = objProcedimientoDto.actividadProcedimiento,
                plazoActividad = objProcedimientoDto.plazoActividad

            }, JsonRequestBehavior.AllowGet);
        }
        protected SelectList ListarProducto()
        {
            ProductoLogic objProductoLogic = new ProductoLogic();
            List<ProductoDTO> lstProductoDto = new List<ProductoDTO>();
            Parametro parametro = new Parametro();
            lstProductoDto = objProductoLogic.Listar(parametro);
            SelectList lstParaCombos = new SelectList(lstProductoDto, "codigoProducto", "nombreProducto");
            return lstParaCombos;
        }


        public JsonResult ConsultarTrazabilidad(string Codigo, string FechaInicio, string FechaFin, string NombreProducto)
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

            if (ventas.Count == 0)
            {
                objEmpleadoLogic = new EmpleadoLogic();
                filtro = new Parametro();
                filtro.p_codArea = Convert.ToInt32(ConfigurationManager.AppSettings["CODAREA"]);
                filtro.p_codCargo = Convert.ToInt32(ConfigurationManager.AppSettings["CODCARGO"]); ;
                var emailTrazabilidad = objEmpleadoLogic.UsuarioTrazabilidad(filtro);
                //if (emailTrazabilidad != null)
                //{
                    EnvioCorreoPregunta(ConfigurationManager.AppSettings["EMAIL_DESTINO"], NombreProducto);
              // }
            } 
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

        [HttpPost]
        public ActionResult GuardarTrazabilidad(List<KardexEntity> listakardex, List<OrdenDeCompraEntity> listaOrdenCompra, List<InformeVentaEntity> listaventa, List<HojaMermaEntity> listamerma, List<OrdenDeDespachoEntity> listadespacho, List<LibroRecetaEntity> listareceta, string CodigoProducto) //TrazabilidadEntity pentity)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                trazabilidadLogic = new TrazabilidadLogic();
                TrazabilidadEntity entity = new TrazabilidadEntity();
                TrazabilidadDetalleEntity detalle;
                List<TrazabilidadDetalleEntity> listadetalle= new List<TrazabilidadDetalleEntity>();
                //listadetalle.Add();
                foreach (KardexEntity item in listakardex)
                {
                    detalle = new TrazabilidadDetalleEntity();
                    detalle.numeroKardex = item.numeroKardex;
                    listadetalle.Add(detalle);
                }

                foreach (OrdenDeCompraEntity item in listaOrdenCompra)
                {
                    detalle = new TrazabilidadDetalleEntity();
                    detalle.codigoCompra = item.codigoCompra;
                    listadetalle.Add(detalle);
                }

                foreach (InformeVentaEntity item in listaventa)
                {
                    detalle = new TrazabilidadDetalleEntity();
                    detalle.codigoVenta = item.codigoVenta;
                    listadetalle.Add(detalle);
                }

                foreach (HojaMermaEntity item in listamerma)
                {
                    detalle = new TrazabilidadDetalleEntity();
                    detalle.numeroHojaMerma = item.numeroHojaMerma;
                    listadetalle.Add(detalle);
                }

                foreach (LibroRecetaEntity item in listareceta)
                {
                    detalle = new TrazabilidadDetalleEntity();
                    detalle.nombreProducto = item.codigolibroreceta;
                    listadetalle.Add(detalle);
                }

                foreach (OrdenDeDespachoEntity item in listadespacho)
                {
                    detalle = new TrazabilidadDetalleEntity();
                    detalle.numeroOrden = item.numeroOrden;
                    listadetalle.Add(detalle);
                }

                entity.estado = "CONSULTADO";
                entity.producto = CodigoProducto;
                entity.lstTrazabilidadDeta = listadetalle;

                trazabilidadLogic.Insertar(entity);
               
                //if (pSolicitud.Codigo != 0)
                //    returnValor = objSolicitudLogic.ActualizarSolicitud(pSolicitud);
                //else
                //    returnValor = objSolicitudLogic.RegistrarSolicitud(pSolicitud);

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
               // log.Error(String.Concat("GuardarTrazabilidad", " | ", ex.Message));
                DataDevol = ex.Message;
            }
            finally
            {
                jsonResponse = new
                {
                    Type = tipoDevol,
                    Data = DataDevol,
                };
            }
            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult ActualizarProcedimiento(ProcedimientoDTO entity)
        {        
            object jsonResponse;
            string tipoDevol = null;
            object DataDevol = null;
            try
            {
                objProcedimientoLogic = new ProcedimientoLogic();
                bool valor = objProcedimientoLogic.Update(entity);
                DataDevol = "Se proceso con èxito el procedimiento.";
                tipoDevol = valor ? "C" : "I";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                // log.Error(String.Concat("GuardarTrazabilidad", " | ", ex.Message));
                DataDevol = "Ocurrio un erro al procesar el procedimiento";
            }
            finally
            {
                jsonResponse = new
                {
                    Type = tipoDevol,
                    Data = DataDevol,
                };
            }
            
            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ConsultarInformeTrazabilidad(string Codigo, string codigoTraza)
        {
            filtro = new Parametro();
            filtro.codProducto = Codigo;
            filtro.p_codigoTraza = codigoTraza;
            trazabilidadLogic = new TrazabilidadLogic();
            TrazabilidadDTO informe = trazabilidadLogic.Listar(filtro);
            if(informe!=null)
            filtro.p_codigoTraza = informe.codigoTraza;

            //Obtener Detalle Trazabilidad
            objVentaLogic = new InformeVentaLogic();
            objKardexLogic = new KardexLogic();
            objMermaLogic = new HojaMermaLogic();
            objCompraLogic = new OrdenDeCompraLogic();
            objDespachoLogic = new OrdendeDespachoLogic();
            objRecetaLogic = new LibroRecetaLogic();
            var ventas = objVentaLogic.ListarInformeVentaTrazabilidad(filtro);
            var kardex = objKardexLogic.ListarKardexTrazabilidad(filtro);
            var ordenes_compra = objCompraLogic.ListarOrdenDeCompraTrazabilidad(filtro);
            var ordenes_pedido = objDespachoLogic.ListarOrdenDeDespachoTrazabilidad(filtro);
            var recetas = objRecetaLogic.ListarRecetaTrazabilidad(filtro);
            var hoja_merma = objMermaLogic.ListarMermaTrazabilidad(filtro);            

            return Json(new
            {
                codigoTraza=informe.codigoTraza,
                fechaTraza= Convert.ToDateTime(informe.fechaTraza).ToShortDateString(),
                nombreProducto=informe.nombreProducto,
                estado = informe.estado,                                                                       
                estadoinformetrazabilidad=informe.estadoinformetrazabilidad,
                InformeVenta = ventas,
                Kardex = kardex,
                OrdenesCompra = ordenes_compra,
                OrdenesPedido = ordenes_pedido,
                Recetas = recetas,
                HojaMerma = hoja_merma
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult GuardarInformeTrazabilidad(InformeTrazabilidadEntity entity, string codigoproducto) //TrazabilidadEntity pentity)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            returnValor = new ReturnValor();
            try
            {
                objInfTrazabilidadLogic = new InformeTrazabilidaLogic();
                
                entity.estado = "ACTUALIZADO";
                objInfTrazabilidadLogic.Insertar(entity);
                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";
                Reporte(entity.codigoInformeTrazabilidad, codigoproducto, entity.codigoTraza);

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                // log.Error(String.Concat("GuardarTrazabilidad", " | ", ex.Message));
                DataDevol = ex.Message;
            }
            finally
            {
                jsonResponse = new
                {
                    Type = tipoDevol,
                    Data = DataDevol,
                };
            }
            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        public void EnvioCorreoPregunta(string emailTrazabilidad, string producto)
        {
            string template = CrearTemplateEmailPregunta(producto);
            Email.From(ConfigurationManager.AppSettings["EMAIL_CORREO"], "STOCK PRODUCTO")
               .To(emailTrazabilidad)
               .Subject("STOCK PRODUCTO")
               .UseSSL()
               .UsingStringTemplateText(template)
               .Send();
        }

        private string CrearTemplateEmailPregunta(string producto)
        {

            string template = "<!DOCTYPE html><html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><title>ALERTA DE STOCK</title> " +
        "</head><body><table border='0' style='font-family: Arial; font-size: 14px; width:100%;'><tr><td style='height: 50px; background: #3cb371; color: black; text-align: center; width: 100%; font-weight: bold; '>STOCK PRODUCTO</td> " +
        "</tr></table><table border='0' style='background: #E5E5E5; color: #000; padding: 0px 20px 0px 20px; width:100%;'><tr><td>&nbsp;&nbsp;</td></tr><tr><td><b>MENSAJE :</b> No hay stock para el producto #Producto#, favor de tomar las medidas necesarias </td> " +
        "</tr><tr><td><b>FECHA :</b> #Fecha#</td></tr><tr><td></td></tr><tr><td>&nbsp;&nbsp;</td></tr> </table><table border='0' style='font-family: Arial; font-size: 14px; width:100%;'><tr> " +
        "<td style='height: 30px; background: #3cb371; color: black; text-align: center; width: 100%; font-weight: bold; '>Equipo Trazabilidad</td></tr></table></body></html> ";

            template = template.Replace("#Producto#", producto);
            template = template.Replace("#Fecha#", DateTime.Now.ToString());

            return template;
        }


        #region Trazabilidad

        public void Reporte(string codigoInformTrazabilidad, string codigoproducto, string codigotraza)
        {
            //FilterReport filter = JsonConvert.DeserializeObject<FilterReport>(id);
            //List<StockProductoAlmacenReport> datos = movimientoBL.ReporteStockProductoAlmacen(filter.TipoFamilia, filter.SubFamilia, filter.TipoCorte, filter.TipoProducto, filter.Gramos, filter.AlmacenId, filter.IncluyeStockCero, filter.NombreProducto, filter.EmpresaId);
//            DataSet ds = new DataSet();
            //ds.Tables.Add();
             filtro = new Parametro();
             InformeTrazabilidadDTOReporte InformeTrazabilidad = new InformeTrazabilidadDTOReporte();

             objVentaLogic = new InformeVentaLogic();
             objKardexLogic = new KardexLogic();
             objCompraLogic = new OrdenDeCompraLogic();
             objDespachoLogic = new OrdendeDespachoLogic();
             objMermaLogic = new HojaMermaLogic();

            filtro.codigoInformeTrazabilidad=codigoInformTrazabilidad;
            filtro.codProducto = codigoproducto;
            filtro.p_codigoTraza = codigotraza;

            InformeTrazabilidad = objInfTrazabilidadLogic.Listar(filtro);
            //Detalle
            List<InformeVentaDTO> venta=  objVentaLogic.ListarInformeVentaTrazabilidad(filtro);
            List<KardexDTO> kardex = objKardexLogic.ListarKardexTrazabilidad(filtro);
            List<OrdenDeCompraDTO> ordendecompra = objCompraLogic.ListarOrdenDeCompraTrazabilidad(filtro);
            List<OrdendeDespachoDTO> pedido = objDespachoLogic.ListarOrdenDeDespachoTrazabilidad(filtro);
            List<HojaMermaDTO> merma = objMermaLogic.ListarMermaTrazabilidad(filtro);

            List<InformeTrazabilidadDTOReporte> milista = new List<InformeTrazabilidadDTOReporte>();

            milista.Add(InformeTrazabilidad);
           
            //lista.  (InformeTrazabilidad);
             RenderReportImpresion("Reporte", "InformeTrazabilidad", milista,"Venta",venta,"Kardex", kardex, "Compra",ordendecompra,"Pedido", pedido , "Merma",merma, "PDF", "11in");
        }


        private void RenderReportImpresion(string report, string ds, object data, string ds1, object data1, string ds2, object data2,
            string ds3, object data3, string ds4, object data4, string ds5, object data5, string formato, string orientacion = "")
        {
            string ruta = string.Empty;
            string reportPath = Server.MapPath(string.Format("~/Reporte/{0}.rdlc", report));
            LocalReport localReport = new LocalReport { ReportPath = reportPath };
            ReportDataSource reportDataSource = new ReportDataSource(ds, data);
            ReportDataSource reportDataSource1 = new ReportDataSource(ds1, data1);
            ReportDataSource reportDataSource2 = new ReportDataSource(ds2, data2);
            ReportDataSource reportDataSource3 = new ReportDataSource(ds3, data3);
            ReportDataSource reportDataSource4 = new ReportDataSource(ds4, data4);
            ReportDataSource reportDataSource5 = new ReportDataSource(ds5, data5);

            localReport.DataSources.Add(reportDataSource);
            localReport.DataSources.Add(reportDataSource1);
            localReport.DataSources.Add(reportDataSource2);
            localReport.DataSources.Add(reportDataSource3);
            localReport.DataSources.Add(reportDataSource4);
            localReport.DataSources.Add(reportDataSource5);
            string reportType = string.Empty;
            string deviceInfo = string.Empty;

            switch (formato)
            {
                case "PDF":

                    if (orientacion == "vertical")
                    {
                        reportType = "PDF";
                        deviceInfo =
                           string.Format(
                               "<DeviceInfo><OutputFormat>{0}</OutputFormat><PageWidth>8.27in</PageWidth><PageHeight>11.69in</PageHeight><MarginTop>0in</MarginTop><MarginLeft>0in</MarginLeft><MarginRight>0in</MarginRight><MarginBottom>0in</MarginBottom></DeviceInfo>",
                               reportType);
                    }
                    else
                    {
                        reportType = "PDF";
                        deviceInfo =
                            string.Format(
                                "<DeviceInfo><OutputFormat>{0}</OutputFormat><PageWidth>9.25in</PageWidth><PageHeight>8in</PageHeight><MarginTop>0in</MarginTop><MarginLeft>0in</MarginLeft><MarginRight>0in</MarginRight><MarginBottom>0in</MarginBottom></DeviceInfo>",
                                reportType);
                    }
                    break;

                case "EXCEL":
                    reportType = "Excel";

                    break;
                case "WORD":
                    reportType = "WORD";

                    break;
               // default:
                   // return string.Empty;
            }

            string mimeType = string.Empty;
            string encoding = string.Empty;
            string fileNameExtension = string.Empty;
            Warning[] warnings = null;
            string[] streams = null;


            try
            {
                byte[] renderedBytes = localReport.Render(reportType, deviceInfo, out mimeType, out encoding,
                                                    out fileNameExtension, out streams, out warnings);

                ruta = Server.MapPath("~/Reporte/" + string.Format("{0}.{1}", GetReporteName(report), fileNameExtension));
                ByteArrayToFile(ruta, renderedBytes);
                Response.Clear();
                Response.ContentType = mimeType;
                Response.AddHeader("content-disposition",
                                                       string.Format("attachment; filename={0}.{1}",
                                                                     GetReporteName(report), fileNameExtension));
                Response.BinaryWrite(renderedBytes);
                Response.End();

               
                string targetPath =  ConfigurationManager.AppSettings["RutaReporteTrazabilidad"];
                string fileName = string.Empty;
                string destFile = string.Empty;
                fileName = System.IO.Path.GetFileName(ruta);
                destFile = System.IO.Path.Combine(targetPath, fileName);
                System.IO.File.Copy(ruta, destFile);
                    //(s, destFile, true);
            }
            catch (Exception ex)
            {

                Console.Write(ex);
            }
          
            //return ruta;
        }

        public static string GetReporteName(string name)
        {
            return string.Format("{0}_{1}{2}{3}{4}{5}{6}", name, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
        }

        private bool ByteArrayToFile(string _FileName, byte[] _ByteArray)
        {
            try
            {
                // Open file for reading
                System.IO.FileStream _FileStream =
                   new System.IO.FileStream(_FileName, System.IO.FileMode.Create,
                                            System.IO.FileAccess.Write);
                // Writes a block of bytes to this stream using data from
                // a byte array.
                _FileStream.Write(_ByteArray, 0, _ByteArray.Length);

                // close file stream
                _FileStream.Close();

                return true;
            }
            catch (Exception _Exception)
            {
                // Error
                Console.WriteLine("Exception caught in process: {0}",
                                  _Exception.ToString());
            }

            // error occured, return false
            return false;
        }

        #endregion

    }
}