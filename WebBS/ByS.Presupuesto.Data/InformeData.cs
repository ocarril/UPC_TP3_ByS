using System;
using System.Collections.Generic;
using System.Configuration;
using ByS.Presupuesto.Entities;
using ByS.Presupuesto.Entities.DTO;
using log4net;

namespace ByS.Presupuesto.Data
{
    /// <summary>
    /// Proyecto    :  Modulo de Mantenimiento de : 
    /// Creacion    : WRF - Walter Rodriguez
    /// Fecha       : 26/01/2016-12:29:08 a.m.
    /// Descripcion : Capa de Lógica 
    /// Archivo     : [Presupuesto.InformeData.cs]
    /// </summary>
    public class InformeData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(InformeData));
        private string conexion = string.Empty;

        //Informe data


        public InformeData()
        {
            conexion = Util.ConexionBD();
        }

        public List<InformeEntity> ListarPaginado(Parametro pFiltro)
        {
            List<InformeEntity> lstPlantillaDetaEntity = new List<InformeEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_InformeSeguimiento(pFiltro.p_NumPagina,
                                                               pFiltro.p_TamPagina,
                                                               pFiltro.p_OrdenPor,
                                                               pFiltro.p_OrdenTipo,
                                                               pFiltro.numAnio,
                                                               pFiltro.codArea,
                                                               pFiltro.codRegEstado,
                                                               pFiltro.mesIni,
                                                               pFiltro.mesFin);
                    foreach (var item in resul)
                    {
                        InformeEntity objPlantillaDetaEntity = new InformeEntity();
                        objPlantillaDetaEntity.Codigo = item.codPlantillaDeta;
                        objPlantillaDetaEntity.codPlantilla = item.codPlantilla;
                        objPlantillaDetaEntity.codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0;
                        objPlantillaDetaEntity.gloDescripcion = item.gloDescripcion;
                        objPlantillaDetaEntity.monEstimado = item.monEstimado;
                        objPlantillaDetaEntity.cntCantidad = item.cntCantidad;
                        objPlantillaDetaEntity.codRegEstado = item.codRegEstado;
                        objPlantillaDetaEntity.fecEjecucion = item.fecEjecucion;
                        objPlantillaDetaEntity.codPartida = item.codPartida;
                        objPlantillaDetaEntity.numPartida = item.numPartida;
                        objPlantillaDetaEntity.codEmpleadoRespon = item.codEmpleadoRespon.HasValue ? item.codEmpleadoRespon.Value : 0;
                        objPlantillaDetaEntity.indPlantilla = item.indPlantillaTipo;
                        objPlantillaDetaEntity.segUsuarioCrea = item.segUsuarioCrea;
                        objPlantillaDetaEntity.segFechaCrea = item.segFechaCrea;
                        objPlantillaDetaEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objPlantillaDetaEntity.segFechaEdita = item.segFechaEdita;
                        objPlantillaDetaEntity.segMaquinaOrigen = item.segMaquinaOrigen;
                       // objPlantillaDetaEntity.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;
                        objPlantillaDetaEntity.objEmpleadoAprueba.desNombre = "";
                        objPlantillaDetaEntity.objEmpleadoRespon.desNombre = item.codEmpleadoResponRespon;
                        objPlantillaDetaEntity.objPlantilla.codArea = item.codArea;
                        objPlantillaDetaEntity.objPlantilla.objArea.desNombre = item.codAreaNombre;
                        objPlantillaDetaEntity.objPartida.desNombre = item.codPartidaNombre;
                        objPlantillaDetaEntity.codRegEstadoNombre = item.codRegEstadoNombre;
                        objPlantillaDetaEntity.ROW = item.ROWNUM.HasValue ? item.ROWNUM.Value : 0;
                        objPlantillaDetaEntity.TOTALROWS = item.TOTALROWS.HasValue ? item.TOTALROWS.Value : 0;

                        lstPlantillaDetaEntity.Add(objPlantillaDetaEntity);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ListarPaginado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstPlantillaDetaEntity;
        }

        public List<GastoEntity> ListarDetalladoPaginado(Parametro pFiltro)
        {
            List<GastoEntity> lstGastoEntity = new List<GastoEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_GastoPagina(pFiltro.p_NumPagina,
                                                       pFiltro.p_TamPagina,
                                                       pFiltro.p_OrdenPor,
                                                       pFiltro.p_OrdenTipo,
                                                       pFiltro.codGasto,
                                                       pFiltro.codPlantillaDeta,
                                                       pFiltro.codArea,
                                                       pFiltro.numAnio);
                    foreach (var item in resul)
                    {
                        GastoEntity objGastoEntity = new GastoEntity();
                        objGastoEntity.Codigo = item.codGasto;
                        objGastoEntity.codPlantillaDeta = item.codPlantillaDeta;
                        objGastoEntity.monTotal = item.monTotal;
                        objGastoEntity.cntCantidad = item.cntCantidad;
                        objGastoEntity.numDocumento = item.numDocumento;
                        objGastoEntity.gloObservacion = item.gloObservacion;
                        objGastoEntity.fecGasto = item.fecGasto;
                        objGastoEntity.codEmpleadoResp = item.codEmpleadoResp;
                        objGastoEntity.objEmpleadoResp.desNombre = item.codEmpleadoRespNombre;
                        objGastoEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objGastoEntity.segFechaEdita = item.segFechaCrea;
                        objGastoEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objGastoEntity.segFechaEdita = item.segFechaCrea;
                        objGastoEntity.segMaquinaOrigen = item.segMaquinaOrigen;
                        objGastoEntity.objEmpleadoResp.codArea = item.codArea.HasValue ? item.codArea.Value : 0;
                        objGastoEntity.objEmpleadoResp.objArea.desNombre = item.codAreaNombre;
                        objGastoEntity.objPlantillaDeta.objPlantilla.codPresupuesto = item.codPresupuesto.HasValue ? item.codPresupuesto.Value : 0;
                        objGastoEntity.objPlantillaDeta.objPlantilla.objPresupuesto.desNombre = item.codPresupuestoNombre;

                        objGastoEntity.ROW = item.ROWNUM.HasValue ? item.ROWNUM.Value : 0;
                        objGastoEntity.TOTALROWS = item.TOTALROWS.HasValue ? item.TOTALROWS.Value : 0;
                        lstGastoEntity.Add(objGastoEntity);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ListarPaginado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstGastoEntity;
        }
    }
} 
