﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using log4net;

using ByS.Presupuesto.Logic;
using ByS.Presupuesto.Entities;
using ByS.RHumanos.Logic;
using ByS.RHumanos.Entities;
using ByS.Tools;

namespace WebBS.Controllers
{
    //[Authorize]
    public class PresupuestoController : BaseController
    {
        private PlantillaLogic objPlantillaLogic = null;
        private EmpleadoLogic objEmpleadoLogic = null;
        private GastoLogic objGastoLogic = null;
        private SolicitudLogic objSolicitudLogic = null;
        private PresupuestoLogic objPresupuestoLogic = null;
        private InformeLogic objInformeLogic = null;

        private ReturnValor returnValor = null;

        private static readonly ILog log = LogManager.GetLogger(typeof(PresupuestoController));

        #region PLANTILLAS PRESUPUESTALES

        public ActionResult Plantilla()
        {
            try
            {
                objEmpleadoLogic = new EmpleadoLogic();
                EmpleadoEntity objEmpleadoEntity = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                ViewBag.codArea = objEmpleadoEntity != null ? objEmpleadoEntity.codArea.ToString() : "0";
                ViewBag.numAnio = (DateTime.Now.Year) + 1;
                ViewBag.cbonumAnio = ListarPresupuestosAnios();
                ViewBag.cboAreas = ListarAreasPresupuestales();
                ViewBag.fechaActual = DateTime.Now.ToShortDateString();
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Plantilla", " | ", ex.Message));
                ModelState.AddModelError("", ex.Message);
            }
            return View();
        }

        [HttpPost]
        public ActionResult BuscarPlantilla(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                var registro = objPlantillaLogic.BuscarPlantilla((DateTime.Now.Year) + 1, pID);

                tipoDevol = "C";
                DataDevol = registro;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("BuscarPlantilla", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult PlantillaTerminarIngreso(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                PlantillaEntity objPlantillaEntity = new PlantillaEntity
                {
                    Codigo = pID,
                    segUsuarioEdita = HttpContext.User.Identity.Name,
                    segUsuarioCrea = HttpContext.User.Identity.Name,
                    segMaquinaOrigen = GetIPAddress(),
                    codRegEstado = Convert.ToInt32(HelpRegEstado.Plantilla.TERMINADA_INGRESO)
                };
                returnValor = objPlantillaLogic.ActualizarPlantillaEstado(objPlantillaEntity);

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("PlantillaTerminarIngreso", " | ", ex.Message));
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
        public ActionResult ListarPlantillaDetalle(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                var lista = objPlantillaLogic.ListarPlantillaDetallePaginado(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    numAnio = parametro.numAnio,
                    codArea = parametro.codArea,
                    codRegEstado = parametro.codRegEstado,
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {"","",""
                                              , item.objPlantilla.objArea.desNombre
                                              , item.objPartida.desNombre
                                              , item.gloDescripcion
                                              , item.cntCantidad.ToString("N2")
                                              , item.monEstimado.ToString("N2")
                                              , item.fecEjecucion.HasValue ? item.fecEjecucion.Value.ToShortDateString() : string.Empty
                                              , item.codRegEstadoNombre
                                              , item.indPlantilla
                                              , item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString()
                                              , item.segUsuarioEdita=string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita
                            }
                        }).ToArray()
                };

                tipoDevol = "C";
                DataDevol = jsonGrid;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarPlantillaDetalle", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult ListarPlantillaDetallePorEjecutar(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                var lista = objPlantillaLogic.ListarPlantillaDetallePorEjecutarPaginado(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    numAnio = parametro.numAnio,
                    codArea = parametro.codArea,
                    codRegEstado = parametro.codRegEstado,
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {"","",""
                                              , item.objPlantilla.objArea.desNombre
                                              , item.objPartida.desNombre
                                              , item.gloDescripcion
                                              , item.cntCantidad.ToString("N2")
                                              , item.monEstimado.ToString("N2")
                                              , item.fecEjecucion.HasValue ? item.fecEjecucion.Value.ToShortDateString() : string.Empty
                                              , item.codRegEstadoNombre
                                              , item.indPlantilla
                                              , item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString()
                                              , item.segUsuarioEdita=string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita
                            }
                        }).ToArray()
                };

                tipoDevol = "C";
                DataDevol = jsonGrid;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarPlantillaDetalle", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult ListarPlantillaDetalleAntes(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                var lista = objPlantillaLogic.ListarPlantillaDetallePaginado(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    numAnio = parametro.numAnio,
                    codArea = parametro.codArea,
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {"","",""
                                              , item.objPlantilla.objArea.desNombre
                                              , item.objPartida.desNombre
                                              , item.gloDescripcion
                                              , item.cntCantidad.ToString("N2")
                                              , item.monEstimado.ToString("N2")
                                              , item.fecEjecucion.HasValue ? item.fecEjecucion.Value.ToShortDateString() : string.Empty
                                              , item.codRegEstadoNombre
                                              , item.indPlantilla
                                              , item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString()
                                              , string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita
                            }
                        }).ToArray()
                };

                tipoDevol = "C";
                DataDevol = jsonGrid;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarPlantillaDetalleAntes", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult BuscarPlantillaDetalle(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object partidas = null;
            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                var registro = objPlantillaLogic.BuscarPlantillaDetalle(pID);
                if (registro == null)
                    registro = InicializarPlantillaDeta(registro);
                registro.indPlantilla = string.IsNullOrEmpty(registro.indPlantilla) ? "1" : registro.indPlantilla;
                partidas = ListarPartidas();

                tipoDevol = "C";
                DataDevol = registro;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("BuscarPlantillaDetalle", " | ", ex.Message));
                DataDevol = ex.Message;
            }
            finally
            {
                jsonResponse = new
                {
                    Type = tipoDevol,
                    Partidas = partidas,
                    Data = DataDevol,
                };
            }
            return Json(jsonResponse);
        }

        private PlantillaDetaEntity InicializarPlantillaDeta(PlantillaDetaEntity registro)
        {
            registro = new PlantillaDetaEntity();
            registro.segUsuarioEdita = User.Identity.Name;
            registro.segFechaEdita = DateTime.Now;
            registro.indPlantilla = "1";
            return registro;
        }

        [HttpPost]
        public ActionResult GuardarPlantillaDetalle(PlantillaDetaEntity pPlantillaDeta)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                pPlantillaDeta.segUsuarioEdita = HttpContext.User.Identity.Name;
                pPlantillaDeta.segUsuarioCrea = HttpContext.User.Identity.Name;
                pPlantillaDeta.segMaquinaOrigen = GetIPAddress();
                if (pPlantillaDeta.Codigo != 0)
                    returnValor = objPlantillaLogic.ActualizarPlantillaDeta(pPlantillaDeta);
                else
                    returnValor = objPlantillaLogic.RegistrarPlantillaDeta(pPlantillaDeta);

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("GuardarPlantillaDetalle", " | ", ex.Message));
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
        public ActionResult EliminarPlantillaDetalle(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                Parametro objParametro = new Parametro
                {
                    codPlantillaDeta = pID,
                    segUsuElimina = User.Identity.Name,
                    segMaquinaPC = GetIPAddress()
                };
                /*Borra el registro de la tabla*/
                returnValor = objPlantillaLogic.EliminarPlantillaDeta(objParametro);
                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("EliminarPlantillaDetalle", " | ", ex.Message));
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
        public ActionResult GuardarPlantillaDetallePorRefer(List<PlantillaDetaEntity> lstPlantillaDeta)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                foreach (PlantillaDetaEntity detalle in lstPlantillaDeta)
                {
                    detalle.segMaquinaOrigen = GetIPAddress();
                    detalle.segUsuarioCrea = User.Identity.Name;
                    detalle.segUsuarioEdita = User.Identity.Name;
                }
                objPlantillaLogic = new PlantillaLogic();
                returnValor = objPlantillaLogic.RegistrarPlantillaDetaPorReferencia(lstPlantillaDeta);

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("GuardarPlantillaDetallePorRefer", " | ", ex.Message));
                DataDevol = ex.Message;
            }
            finally
            {
                jsonResponse = new
                {
                    Type = tipoDevol,
                    Data = DataDevol
                };
            }
            return Json(jsonResponse);
        }

        #endregion

        #region REGISTRO DE GASTOS

        public ActionResult Gastos()
        {
            try
            {
                objEmpleadoLogic = new EmpleadoLogic();
                EmpleadoEntity objEmpleadoEntity = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                ViewBag.cboAreas = ListarAreasPresupuestales();
                ViewBag.numAnio = (DateTime.Now.Year);
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Gastos", " | ", ex.Message));
                ModelState.AddModelError("", ex.Message);
            }
            return View();
        }

        [HttpPost]
        public ActionResult BuscarGasto(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object empleados = null;
            object jsonResponse;
            try
            {
                objGastoLogic = new GastoLogic();
                var registro = objGastoLogic.BuscarGasto(pID);
                if (registro == null)
                    registro = InicializarGasto(registro);
                empleados = ListarEmpleados();

                tipoDevol = "C";
                DataDevol = registro;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("BuscarGasto", " | ", ex.Message));
                DataDevol = ex.Message;
            }
            finally
            {
                jsonResponse = new
                {
                    Type = tipoDevol,
                    Empleados = empleados,
                    Data = DataDevol,
                };
            }
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult GuardarGasto(GastoEntity pGasto)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objGastoLogic = new GastoLogic();
                pGasto.segUsuarioEdita = HttpContext.User.Identity.Name;
                pGasto.segUsuarioCrea = HttpContext.User.Identity.Name;
                pGasto.segMaquinaOrigen = GetIPAddress();
                if (pGasto.Codigo != 0)
                    returnValor = objGastoLogic.ActualizarGasto(pGasto);
                else
                    returnValor = objGastoLogic.RegistrarGasto(pGasto);

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("GuardarGasto", " | ", ex.Message));
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
        public ActionResult ListarGasto(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objGastoLogic = new GastoLogic();
                var lista = objGastoLogic.ListarGastoPaginado(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    numAnio = parametro.numAnio,
                    codArea = parametro.codArea,
                    codPlantillaDeta = parametro.codPlantillaDeta
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {"",""
                                              , item.numDocumento
                                              , item.fecGasto.ToShortDateString()
                                              , item.cntCantidad.ToString("N2")
                                              , item.monTotal.ToString("N2")
                                              , item.objEmpleadoResp.desNombre
                                              , item.gloObservacion
                                              , item.objEmpleadoResp.objArea.desNombre 
                                              , item.objPlantillaDeta.objPlantilla.objPresupuesto.desNombre
                                              , item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString()
                                              , string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioEdita : item.segUsuarioCrea
                            }
                        }).ToArray()
                };

                DataDevol = jsonGrid;
                tipoDevol = "C";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarGasto", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult EliminarGasto(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objGastoLogic = new GastoLogic();
                Parametro objParametro = new Parametro
                {
                    codGasto = pID,
                    segUsuElimina = User.Identity.Name,
                    segMaquinaPC = GetIPAddress()
                };
                /*Borra el registro de la tabla*/
                returnValor = objGastoLogic.EliminarGasto(objParametro);
                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("EliminarGasto", " | ", ex.Message));
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
        public ActionResult BuscarPresupuesto(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objPlantillaLogic = new PlantillaLogic();
                var registro = objPlantillaLogic.BuscarPresupuesto(pID);
                tipoDevol = "C";
                DataDevol = registro;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
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
            return Json(jsonResponse);
        }

        #endregion

        #region REGISTRO DE SOLICITUDES

        public ActionResult Solicitud()
        {
            try
            {
                objEmpleadoLogic = new EmpleadoLogic();
                EmpleadoEntity objEmpleadoEntity = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                ViewBag.codEmpleado = objEmpleadoEntity.Codigo;
                ViewBag.nomEmpleado = objEmpleadoEntity.desApellido + ", " + objEmpleadoEntity.desNombre;
                ViewBag.codArea = objEmpleadoEntity.codArea;
                ViewBag.cboAreas = ListarAreasPresupuestales(true, false, objEmpleadoEntity.codArea);
                ViewBag.numAnio = (DateTime.Now.Year);
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Solicitud", " | ", ex.Message));
                ModelState.AddModelError("", ex.Message);
            }
            return View();
        }

        public ActionResult SolicitudReg(int pID, int? pInd)
        {
            try
            {
                objEmpleadoLogic = new EmpleadoLogic();
                EmpleadoEntity objEmpleadoEntity = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                ViewBag.codEmpleado = objEmpleadoEntity.Codigo.ToString();
                ViewBag.nomEmpleado = objEmpleadoEntity.desApellido + ", " + objEmpleadoEntity.desNombre;
                ViewBag.codArea = objEmpleadoEntity.codArea;
                ViewBag.cboAreas = ListarAreasPresupuestales(false, true, objEmpleadoEntity.codArea);
                ViewBag.numAnio = DateTime.Now.Year.ToString();
                ViewBag.codSolicitud = pID;
                ViewBag.indModo = pInd.HasValue ? pInd.Value : 0;
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("SolicitudReg", " | ", ex.Message));
                ModelState.AddModelError("", ex.Message);
            }
            return View();
        }

        public ActionResult SolicitudActualizar()
        {
            try
            {
                objEmpleadoLogic = new EmpleadoLogic();
                EmpleadoEntity objEmpleadoEntity = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                ViewBag.codEmpleado = objEmpleadoEntity.Codigo;
                ViewBag.nomEmpleado = objEmpleadoEntity.desApellido + ", " + objEmpleadoEntity.desNombre;
                ViewBag.codArea = objEmpleadoEntity.codArea;
                ViewBag.cboAreas = ListarAreasPresupuestales();
                ViewBag.numAnio = (DateTime.Now.Year);
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("SolicitudActualizar", " | ", ex.Message));
                ModelState.AddModelError("", ex.Message);
            }
            return View();
        }

        [HttpPost]
        public ActionResult BuscarSolicitud(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object empleadoGen = null;
            object empleadoApr = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                var registro = objSolicitudLogic.BuscarSolicitud(pID);
                if (registro == null)
                {
                    registro = InicializarSolicitud(registro);
                    objEmpleadoLogic = new EmpleadoLogic();
                    EmpleadoEntity emple = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                    empleadoGen = ListarEmpleados(false, true, emple.Codigo);
                    empleadoApr = ListarEmpleados(true, true, -1);
                }
                else
                {
                    empleadoGen = ListarEmpleados(false, true, registro.codEmpleadoGenera);
                    empleadoApr = ListarEmpleados(false, true, registro.codEmpleadoAprueba.HasValue ? registro.codEmpleadoAprueba.Value : -1);
                }
                tipoDevol = "C";
                DataDevol = registro;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("BuscarSolicitud", " | ", ex.Message));
                DataDevol = ex.Message;
            }
            finally
            {
                jsonResponse = new
                {
                    Type = tipoDevol,
                    EmpleadoGen = empleadoGen,
                    EmpleadoApr = empleadoApr,
                    Data = DataDevol,
                };
            }
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult GuardarSolicitud(SolicitudEntity pSolicitud)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                objPresupuestoLogic = new PresupuestoLogic();
                PresupuestoEntity objPresupuesto = objPresupuestoLogic.BuscarPresupuesto(DateTime.Now.Year);
                pSolicitud.codPresupuesto = objPresupuesto.Codigo;
                pSolicitud.segUsuarioEdita = HttpContext.User.Identity.Name;
                pSolicitud.segUsuarioCrea = HttpContext.User.Identity.Name;
                pSolicitud.segMaquinaOrigen = GetIPAddress();
                if (pSolicitud.Codigo != 0)
                    returnValor = objSolicitudLogic.ActualizarSolicitud(pSolicitud);
                else
                    returnValor = objSolicitudLogic.RegistrarSolicitud(pSolicitud);

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("GuardarSolicitud", " | ", ex.Message));
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
        public ActionResult ListarSolicitud(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                var lista = objSolicitudLogic.ListarSolicitudPaginado(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    codPresupuesto = parametro.numAnio.HasValue ? parametro.numAnio.Value : 0,
                    codArea = parametro.codArea,
                    codRegEstado = parametro.codRegEstado,
                    numSolicitud = parametro.numSolicitud,
                    fecInicio = parametro.fecInicio,
                    fecFinal = parametro.fecFinal,
                    indTipo = parametro.indTipo
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {"",""
                                              , item.numSolicitud
                                              , item.fecSolicitada.ToString()
                                              , item.fecLimite.HasValue?item.fecLimite.Value.ToShortDateString():string.Empty
                                              , item.objEmpleadoGenera.desNombre
                                              , item.objEmpleadoAprueba.desNombre
                                              , item.codRegEstadoNombre
                                              , item.indTipo
                                              , item.codPresupuesto.HasValue?item.codPresupuesto.Value.ToString():string.Empty
                                              , item.segFechaEdita.HasValue?item.segFechaEdita.Value.ToString():item.segFechaCrea.ToString()
                                              , string.IsNullOrEmpty(item.segUsuarioEdita)?item.segUsuarioCrea:item.segUsuarioEdita
                            }
                        }).ToArray()
                };

                tipoDevol = "C";
                DataDevol = jsonGrid;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarSolicitud", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult EliminarSolicitud(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                Parametro objParametro = new Parametro
                {
                    codSolicitud = pID,
                    segUsuElimina = User.Identity.Name,
                    segMaquinaPC = GetIPAddress()
                };
                /*Borra el registro de la tabla*/
                returnValor = objSolicitudLogic.EliminarSolicitud(objParametro);
                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("EliminarSolicitud", " | ", ex.Message));
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
        public ActionResult ListarSolicitudDeta(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                var lista = objSolicitudLogic.ListarSolicitudDeta(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    codSolicitud = parametro.codSolicitud
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {"",""
                                              , item.gloDescripcion
                                              , item.cntCantidad.ToString()
                                              , item.objPlantillaDeta.monEstimado.ToString("N2")
                                              , item.objPlantillaDeta.fecEjecucion.HasValue? item.objPlantillaDeta.fecEjecucion.Value.ToShortDateString():string.Empty
                                              , item.objPlantillaDeta.objPartida.desNombre 
                                              , item.objPlantillaDeta.gloDescripcion 
                                              , item.objPlantillaDeta.objEmpleadoAprueba.desNombre 
                                              , item.segFechaEdita.HasValue?item.segFechaEdita.Value.ToString():item.segFechaCrea.ToString()
                                              , string.IsNullOrEmpty(item.segUsuarioEdita)?item.segUsuarioCrea:item.segUsuarioEdita
                            }
                        }).ToArray()
                };

                tipoDevol = "C";
                DataDevol = jsonGrid;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarSolicitudDeta", " | ", ex.Message));
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
            return Json(jsonResponse);
        }


        [HttpPost]
        public ActionResult EliminarSolicitudDeta(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                Parametro objParametro = new Parametro
                {
                    codSolicitudDeta = pID,
                    segUsuElimina = User.Identity.Name,
                    segMaquinaPC = GetIPAddress()
                };
                /*Borra el registro de la tabla*/
                returnValor = objSolicitudLogic.EliminarSolicitudDeta(objParametro);
                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("EliminarSolicitud", " | ", ex.Message));
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
        public ActionResult BuscarSolicitudDeta(int pID)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                var registro = objSolicitudLogic.BuscarSolicitudDeta(pID);
                if (registro == null)
                    registro = InicializarSolicitudDeta(registro);
                tipoDevol = "C";
                DataDevol = registro;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("BuscarSolicitudDeta", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult GuardarSolicitudDeta(List<SolicitudDetaEntity> plstSolicitudDeta)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                foreach (SolicitudDetaEntity objSolicitudDeta in plstSolicitudDeta)
                {
                    objSolicitudDeta.segUsuarioEdita = HttpContext.User.Identity.Name;
                    objSolicitudDeta.segUsuarioCrea = HttpContext.User.Identity.Name;
                    objSolicitudDeta.segMaquinaOrigen = GetIPAddress();
                    if (objSolicitudDeta.Codigo != 0)
                        returnValor = objSolicitudLogic.ActualizarSolicitudDeta(objSolicitudDeta);
                    else
                        returnValor = objSolicitudLogic.RegistrarSolicitudDeta(objSolicitudDeta);
                }

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("GuardarSolicitud", " | ", ex.Message));
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
        public ActionResult GuardarSolicitudDetaUno(SolicitudDetaEntity objSolicitudDeta)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();

                objSolicitudDeta.segUsuarioEdita = HttpContext.User.Identity.Name;
                objSolicitudDeta.segUsuarioCrea = HttpContext.User.Identity.Name;
                objSolicitudDeta.segMaquinaOrigen = GetIPAddress();
                if (objSolicitudDeta.Codigo != 0)
                    returnValor = objSolicitudLogic.ActualizarSolicitudDeta(objSolicitudDeta);
                else
                    returnValor = objSolicitudLogic.RegistrarSolicitudDeta(objSolicitudDeta);


                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("GuardarSolicitud", " | ", ex.Message));
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


        private SolicitudEntity InicializarSolicitud(SolicitudEntity registro)
        {
            registro = new SolicitudEntity();
            registro.fecSolicitada = DateTime.Now;
            registro.segUsuarioEdita = User.Identity.Name;
            registro.segFechaEdita = DateTime.Now;
            registro.indTipo = "E";
            return registro;
        }

        private SolicitudDetaEntity InicializarSolicitudDeta(SolicitudDetaEntity registro)
        {
            registro = new SolicitudDetaEntity();
            registro.segUsuarioEdita = User.Identity.Name;
            registro.segFechaEdita = DateTime.Now;
            registro.codRegEstadoNombre = "E";
            return registro;
        }

        private GastoEntity InicializarGasto(GastoEntity registro)
        {
            registro = new GastoEntity();
            registro.segUsuarioEdita = User.Identity.Name;
            registro.fecGasto = DateTime.Now;
            registro.segFechaEdita = DateTime.Now;
            return registro;
        }

        #endregion

        #region Generar informe

        public ActionResult Informe()
        {
            try
            {
                objEmpleadoLogic = new EmpleadoLogic();
                EmpleadoEntity objEmpleadoEntity = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                ViewBag.codArea = objEmpleadoEntity != null ? objEmpleadoEntity.codArea.ToString() : "0";
                ViewBag.numAnio = (DateTime.Now.Year);

                ViewBag.cboMesIni = ListarMeses();
                ViewBag.cboEstado = ListarEstados();
                ViewBag.cboMesFin = ListarMeses();
                ViewBag.cboAreas = ListarAreasPresupuestales();
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Informe", " | ", ex.Message));
                ModelState.AddModelError("", ex.Message);
            }
            return View();
        }

        [HttpPost]
        public ActionResult ListarSeguimientoPresupuesto(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objInformeLogic = new InformeLogic();
                var lista = objInformeLogic.ListarSeguimientoPresupuesto(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    numAnio = parametro.numAnio,
                    codArea = parametro.codArea,
                    codRegEstado = parametro.codRegEstado,
                    mesIni = parametro.mesIni == 0 ? 1 : parametro.mesIni,
                    mesFin = parametro.mesFin == 0 ? 12 : parametro.mesFin
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {item.objPlantilla.objArea.desNombre
                                              , item.objPartida.desNombre
                                              , item.gloDescripcion
                                              , item.cntCantidad.ToString("N2")
                                              , item.monEstimado.ToString("N2")
                                              , item.fecEjecucion.HasValue ? item.fecEjecucion.Value.ToShortDateString() : string.Empty
                                              , item.codRegEstadoNombre
                                              , item.indPlantilla
                                              , item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString()
                                              , item.segUsuarioEdita=string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita
                            }
                        }).ToArray()
                };

                tipoDevol = "C";
                DataDevol = jsonGrid;
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarSeguimientoPresupuesto", " | ", ex.Message));
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
            return Json(jsonResponse);
        }

        [HttpPost]
        public ActionResult ListarSeguimientoPresupuestoDetalle(Parametro parametro)
        {
            string tipoDevol = null;
            object DataDevol = null;

            object jsonResponse;
            try
            {
                objInformeLogic = new InformeLogic();
                var lista = objInformeLogic.ListarDetallePaginado(new Parametro
                {
                    p_NumPagina = parametro.p_NumPagina,
                    p_TamPagina = parametro.p_TamPagina,
                    p_OrdenPor = parametro.p_OrdenPor,
                    p_OrdenTipo = parametro.p_OrdenTipo,

                    numAnio = parametro.numAnio,
                    codArea = parametro.codArea,
                    codPlantillaDeta = parametro.codPlantillaDeta
                });
                long totalRecords = lista.Select(x => x.TOTALROWS).FirstOrDefault();
                int totalPages = (int)Math.Ceiling((float)totalRecords / (float)parametro.p_TamPagina);

                var jsonGrid = new
                {
                    PageCount = totalPages,
                    CurrentPage = parametro.p_NumPagina,
                    RecordCount = totalRecords,
                    Items = (
                        from item in lista
                        select new
                        {
                            ID = item.Codigo,
                            Row = new string[] {"",""
                                              , item.numDocumento
                                              , item.fecGasto.ToShortDateString()
                                              , item.cntCantidad.ToString("N2")
                                              , item.monTotal.ToString()
                                              , item.objEmpleadoResp.desNombre
                                              , item.gloObservacion
                                              , item.objEmpleadoResp.objArea.desNombre 
                                              , item.objPlantillaDeta.objPlantilla.objPresupuesto.desNombre
                                              , item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString()
                                              , string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioEdita : item.segUsuarioCrea
                            }
                        }).ToArray()
                };

                DataDevol = jsonGrid;
                tipoDevol = "C";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ListarGasto", " | ", ex.Message));
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
            return Json(jsonResponse);
        }




        #endregion

        #region Aprobar ejecucion de Presupuesto
        [HttpPost]
        public ActionResult ActualizarSolicitudEjecucion(SolicitudEntity pSolicitud)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                objEmpleadoLogic = new EmpleadoLogic();
                EmpleadoEntity objEmpleadoEntity = objEmpleadoLogic.BuscarPorLogin(User.Identity.Name);
                pSolicitud.codEmpleadoAprueba = objEmpleadoEntity.Codigo;
                pSolicitud.segUsuarioEdita = HttpContext.User.Identity.Name;
                pSolicitud.segUsuarioCrea = HttpContext.User.Identity.Name;
                pSolicitud.segMaquinaOrigen = GetIPAddress();
                returnValor = objSolicitudLogic.ActualizarSolicitudEjecucion(pSolicitud);
                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";
            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ActualizarSolicitudEjecucion", " | ", ex.Message));
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
        public ActionResult ActualizarSolicitudDeta(SolicitudDetaEntity plstSolicitudDeta)
        {
            string tipoDevol = null;
            object DataDevol = null;
            object jsonResponse;
            try
            {
                objSolicitudLogic = new SolicitudLogic();
                {
                    plstSolicitudDeta.segUsuarioEdita = HttpContext.User.Identity.Name;
                    plstSolicitudDeta.segUsuarioCrea = HttpContext.User.Identity.Name;
                    plstSolicitudDeta.segMaquinaOrigen = GetIPAddress();
                    //if (objSolicitudDeta.Codigo != 0)
                    returnValor = objSolicitudLogic.ActualizarSolicitudDeta(plstSolicitudDeta);
                    //else
                    //  returnValor = objSolicitudLogic.RegistrarSolicitudDeta(objSolicitudDeta);
                }

                DataDevol = returnValor.Message;
                tipoDevol = returnValor.Exitosa ? "C" : "I";

            }
            catch (Exception ex)
            {
                tipoDevol = "E";
                log.Error(String.Concat("ActualizarSolicitudDeta", " | ", ex.Message));
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

        #endregion

    }



}