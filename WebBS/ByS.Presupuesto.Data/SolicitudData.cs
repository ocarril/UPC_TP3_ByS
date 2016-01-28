using System;
using System.Collections.Generic;
using System.Configuration;
using log4net;

using ByS.Presupuesto.Entities;

namespace ByS.Presupuesto.Data
{

    /// <summary>
    /// Proyecto    :  Modulo de Mantenimiento de : 
    /// Creacion    : CROM - Orlando Carril Ramírez
    /// Fecha       : 26/11/2015-12:29:08 a.m.
    /// Descripcion : Capa de Datos 
    /// Archivo     : [Presupuesto.GastoData.cs]
    /// </summary>
    public class SolicitudData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(SolicitudData));
        private string conexion = string.Empty;

        public SolicitudData()
        {
            conexion = Util.ConexionBD();
        }

        #region /* Proceso de SELECT ALL */

        /// <summary>
        /// Retorna un LISTA de registros de la Entidad Presupuesto.Gasto
        /// En la BASE de DATO la Tabla : [Presupuesto.Gasto]
        /// <summary>
        /// <param name="pFiltro"></param>
        /// <returns></returns>
        public List<SolicitudEntity> Listar(Parametro pFiltro)
        {
            List<SolicitudEntity> lstSolicitudEntity = new List<SolicitudEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Solicitud(pFiltro.codSolicitud, pFiltro.numSolicitud, pFiltro.fecInicio, pFiltro.fecFinal, pFiltro.codRegEstado, pFiltro.codPresupuesto);
                    foreach (var item in resul)
                    {
                        SolicitudEntity objSolicitud = new SolicitudEntity();

                        objSolicitud.Codigo = item.codSolicitud;
                        objSolicitud.gloObservacion = item.gloObservacion;
                        objSolicitud.objEmpleadoGenera.desNombre = item.codEmpleadoGeneraNombre;
                        objSolicitud.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;

                        objSolicitud.objEmpleadoGenera.codArea = item.codArea;
                        objSolicitud.objEmpleadoGenera.objArea.desNombre = item.codAreaNombre;
                        objSolicitud.codEmpleadoAprueba = item.codEmpleadoAprueba;
                        objSolicitud.codPresupuesto = item.codPresupuesto;
                        objSolicitud.numSolicitud = item.numSolicitud;
                        objSolicitud.codRegEstado = item.codRegEstado.HasValue ? item.codRegEstado.Value : 0;
                        objSolicitud.codRegEstadoNombre = item.codRegEstadoNombre;
                        objSolicitud.fecLimite = item.fecLimite;
                        objSolicitud.fecSolicitada = item.fecSolicitada;
                        objSolicitud.indTipo = item.indTipo;
                        objSolicitud.segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita;
                        objSolicitud.segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value : item.segFechaCrea;
                        objSolicitud.segMaquinaOrigen = item.segMaquinaOrigen;
                        lstSolicitudEntity.Add(objSolicitud);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstSolicitudEntity;
        }

        public List<SolicitudEntity> ListarPaginado(Parametro pFiltro)
        {
            List<SolicitudEntity> lstSolicitudEntity = new List<SolicitudEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_SolicitudPagina(pFiltro.p_NumPagina,
                                                       pFiltro.p_TamPagina,
                                                       pFiltro.p_OrdenPor,
                                                       pFiltro.p_OrdenTipo,
                                                       pFiltro.codSolicitud,
                                                       pFiltro.numSolicitud,
                                                       pFiltro.fecInicio,
                                                       pFiltro.fecFinal,
                                                       pFiltro.codRegEstado,
                                                       pFiltro.codPresupuesto,
                                                       pFiltro.codArea);
                    foreach (var item in resul)
                    {
                        SolicitudEntity objSolicitud = new SolicitudEntity();
                        objSolicitud.Codigo = item.codSolicitud;
                        objSolicitud.gloObservacion = item.gloObservacion;
                        objSolicitud.codPresupuesto = item.codPresupuesto;
                        objSolicitud.numSolicitud = item.numSolicitud;
                        objSolicitud.codRegEstado = item.codRegEstado.HasValue ? item.codRegEstado.Value : 0;
                        objSolicitud.codRegEstadoNombre = item.codRegEstadoNombre;
                        objSolicitud.fecLimite = item.fecLimite;
                        objSolicitud.fecSolicitada = item.fecSolicitada;
                        objSolicitud.indTipo = item.indTipo;
                        objSolicitud.objEmpleadoGenera.desNombre = item.codEmpleadoGeneraNombre;
                        objSolicitud.codEmpleadoGenera = item.codEmpleadoGenera;
                        objSolicitud.objEmpleadoGenera.codArea = item.codArea;
                        objSolicitud.objEmpleadoGenera.objArea.desNombre = item.codAreaNombre;
                        objSolicitud.codEmpleadoAprueba = item.codEmpleadoAprueba;
                        objSolicitud.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;
                        objSolicitud.segFechaCrea = item.segFechaCrea;
                        objSolicitud.segFechaEdita = item.segFechaEdita;
                        objSolicitud.segUsuarioCrea = item.segUsuarioCrea;
                        objSolicitud.segUsuarioEdita = item.segUsuarioEdita;
                        objSolicitud.segMaquinaOrigen = item.segMaquinaOrigen;

                        objSolicitud.ROW = item.ROWNUM.HasValue ? item.ROWNUM.Value : 0;
                        objSolicitud.TOTALROWS = item.TOTALROWS.HasValue ? item.TOTALROWS.Value : 0;
                        lstSolicitudEntity.Add(objSolicitud);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ListarPaginado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstSolicitudEntity;
        }

        #endregion

        #region /* Proceso de SELECT BY ID CODE */

        /// <summary>
        /// Retorna una ENTIDAD de registro de la Entidad Presupuesto.Solicitud
        /// En la BASE de DATO la Tabla : [Presupuesto.Solicitud]
        /// <summary>
        /// <param name="pcodSolicitud"></param>
        /// <returns></returns>
        public SolicitudEntity Buscar(int pcodSolicitud)
        {
            SolicitudEntity objSolicitud = new SolicitudEntity();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Solicitud(pcodSolicitud, null, null, null, null, null);
                    foreach (var item in resul)
                    {
                        objSolicitud = new SolicitudEntity();


                        objSolicitud.Codigo = item.codSolicitud;
                        objSolicitud.gloObservacion = item.gloObservacion;
                        objSolicitud.codEmpleadoGenera = item.codEmpleadoGenera;
                        objSolicitud.objEmpleadoGenera.codArea = item.codArea;
                        objSolicitud.objEmpleadoGenera.objArea.desNombre = item.codAreaNombre;
                        objSolicitud.codEmpleadoAprueba = item.codEmpleadoAprueba;

                        objSolicitud.codPresupuesto = item.codPresupuesto;
                        objSolicitud.numSolicitud = item.numSolicitud;
                        objSolicitud.codRegEstado = item.codRegEstado.HasValue ? item.codRegEstado.Value : 0;
                        objSolicitud.codRegEstadoNombre = item.codRegEstadoNombre;
                        objSolicitud.fecLimite = item.fecLimite;
                        objSolicitud.fecSolicitada = item.fecSolicitada;
                        objSolicitud.indTipo = item.indTipo;
                        objSolicitud.segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita;
                        objSolicitud.segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value : item.segFechaCrea;
                        objSolicitud.segMaquinaOrigen = item.segMaquinaOrigen;

                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Buscar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return objSolicitud;
        }
        #endregion

        #region /* Proceso de INSERT RECORD */

        /// <summary>
        /// Almacena el registro de una ENTIDAD de registro de Tipo Solicitud
        /// En la BASE de DATO la Tabla : [Presupuesto.Solicitud]
        /// <summary>
        /// <param name="pSolicitud"></param>
        /// <returns></returns>
        public bool Registrar(SolicitudEntity pSolicitud)
        {
            int? codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_I_Solicitud(
                       ref codigoRetorno,
                       pSolicitud.gloObservacion,
                       pSolicitud.fecSolicitada,
                       pSolicitud.indTipo,
                       pSolicitud.fecLimite,
                       pSolicitud.codEmpleadoGenera,
                       pSolicitud.codPresupuesto,
                       pSolicitud.codRegEstado,
                       pSolicitud.segUsuarioCrea,
                       pSolicitud.segMaquinaOrigen);
                    pSolicitud.Codigo = codigoRetorno.HasValue ? codigoRetorno.Value : 0;
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Registrar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno > 0 ? true : false;
        }
        #endregion

        #region /* Proceso de UPDATE RECORD */

        /// <summary>
        /// Almacena el registro de una ENTIDAD de registro de Tipo Solicitud
        /// En la BASE de DATO la Tabla : [Presupuesto.Solicitud]
        /// <summary>
        /// <param name="itemSolicitud"></param>
        /// <returns></returns>
        public bool Actualizar(SolicitudEntity itemSolicitud)
        {
            int codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_U_Solicitud(
                        itemSolicitud.Codigo,
                        itemSolicitud.gloObservacion,
                        itemSolicitud.fecSolicitada,
                        itemSolicitud.indTipo,
                        itemSolicitud.fecLimite,
                        itemSolicitud.codEmpleadoGenera,
                        itemSolicitud.codPresupuesto,
                        itemSolicitud.codRegEstado,
                        itemSolicitud.segUsuarioEdita,
                        itemSolicitud.segMaquinaOrigen);
                    codigoRetorno = 0;
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Actualizar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno == 0 ? true : false;
        }
        #endregion

        #region /* Proceso de DELETE BY ID CODE */

        /// <summary>
        /// ELIMINA un registro de la Entidad Presupuesto.Solicitud
        /// En la BASE de DATO la Tabla : [Presupuesto.Solicitud]
        /// <summary>
        /// <param name="pFiltro"></param>
        /// <returns></returns>
        public bool Eliminar(Parametro pFiltro)
        {
            int codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_D_Solicitud(pFiltro.codSolicitud, pFiltro.segUsuElimina, pFiltro.segMaquinaPC);
                    codigoRetorno = 0;
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Eliminar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno == 0 ? true : false;
        }

        #endregion

    }
}
