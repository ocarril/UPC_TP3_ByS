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
    /// Creacion    : CROM - Orlando Carril Ramírez
    /// Fecha       : 26/11/2015-12:29:08 a.m.
    /// Descripcion : Capa de Datos 
    /// Archivo     : [Presupuesto.SolicitudDetaData.cs]
    /// </summary>
    public class SolicitudDetaData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(SolicitudDetaData));
        private string conexion = string.Empty;

        public SolicitudDetaData()
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
        public List<SolicitudDetaEntity> Listar(Parametro pFiltro)
        {
            List<SolicitudDetaEntity> lstSolicitudDetaEntity = new List<SolicitudDetaEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_SolicitudDeta(pFiltro.codSolicitudDeta, 
                                                         pFiltro.codSolicitud, 
                                                         pFiltro.codPlantillaDeta, 
                                                         pFiltro.codRegEstado, 
                                                         pFiltro.codPresupuesto);
                    foreach (var item in resul)
                    {
                        lstSolicitudDetaEntity.Add(new SolicitudDetaEntity()
                        {
                            Codigo = item.codSolicitudDeta,
                            gloDescripcion = item.gloDescripcion,
                            cntCantidad = item.cntCantidad,
                            codPlantillaDeta = item.codPlantillaDeta,
                            codSolicitud = item.codSolicitud,
                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita : item.segFechaCrea,
                            segMaquinaOrigen = item.segMaquinaOrigen,
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstSolicitudDetaEntity;
        }

        public List<SolicitudDetaEntity> ListarPaginado(Parametro pFiltro)
        {
            List<SolicitudDetaEntity> lstSolicitudDetaEntity = new List<SolicitudDetaEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_SolicitudDetaPagina(pFiltro.p_NumPagina,
                                                       pFiltro.p_TamPagina,
                                                       pFiltro.p_OrdenPor,
                                                       pFiltro.p_OrdenTipo,
                                                       pFiltro.codSolicitudDeta,
                                                       pFiltro.codSolicitud,
                                                       pFiltro.codPlantillaDeta,
                                                       pFiltro.codRegEstado,
                                                       pFiltro.codPresupuesto);
                    foreach (var item in resul)
                    {
                        SolicitudDetaEntity objSolicitudDetaEntity = new SolicitudDetaEntity();
                        objSolicitudDetaEntity.Codigo = item.codSolicitudDeta;
                        objSolicitudDetaEntity.gloDescripcion = item.gloDescripcion;
                        objSolicitudDetaEntity.cntCantidad = item.cntCantidad;
                        objSolicitudDetaEntity.codPlantillaDeta = item.codPlantillaDeta;
                        objSolicitudDetaEntity.objPlantillaDeta.gloDescripcion = item.codPlantillaDetaDescri;
                        objSolicitudDetaEntity.objPlantillaDeta.fecEjecucion = item.fecEjecucion;
                        objSolicitudDetaEntity.objPlantillaDeta.monEstimado = item.monEstimado;
                        objSolicitudDetaEntity.objPlantillaDeta.numPartida = item.numPartida;
                        objSolicitudDetaEntity.objPlantillaDeta.codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0;
                        objSolicitudDetaEntity.objPlantillaDeta.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;

                        objSolicitudDetaEntity.codSolicitud = item.codSolicitud;
                        objSolicitudDetaEntity.segUsuarioCrea = item.segUsuarioCrea;
                        objSolicitudDetaEntity.segFechaCrea = item.segFechaCrea;
                        objSolicitudDetaEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objSolicitudDetaEntity.segFechaEdita = item.segFechaEdita;
                        objSolicitudDetaEntity.segMaquinaOrigen = item.segMaquinaOrigen;
                        objSolicitudDetaEntity.ROW = item.ROWNUM.HasValue ? item.ROWNUM.Value : 0;
                        objSolicitudDetaEntity.TOTALROWS = item.TOTALROWS.HasValue ? item.TOTALROWS.Value : 0;

                        lstSolicitudDetaEntity.Add(objSolicitudDetaEntity);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ListarPaginado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstSolicitudDetaEntity;
        }

        #endregion

        #region /* Proceso de SELECT BY ID CODE */

        /// <summary>
        /// Retorna una ENTIDAD de registro de la Entidad Presupuesto.SolicitudDetaDeta
        /// En la BASE de DATO la Tabla : [Presupuesto.SolicitudDetaDeta]
        /// <summary>
        /// <param name="pcodSolicitudDetaDeta"></param>
        /// <returns></returns>
        public SolicitudDetaEntity Buscar(int pcodSolicitudDeta)
        {
            SolicitudDetaEntity objSolicitudDetaDetaEntityDTO = new SolicitudDetaEntity();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_SolicitudDeta(pcodSolicitudDeta, null, null, null, null);
                    foreach (var item in resul)
                    {
                        objSolicitudDetaDetaEntityDTO = new SolicitudDetaEntity()
                        {
                            Codigo = item.codSolicitudDeta,
                            gloDescripcion = item.gloDescripcion,
                            cntCantidad = item.cntCantidad,
                            codPlantillaDeta = item.codPlantillaDeta,
                            codSolicitud = item.codSolicitud,
                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita : item.segFechaCrea,
                            segMaquinaOrigen = item.segMaquinaOrigen,
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Buscar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return objSolicitudDetaDetaEntityDTO;
        }
        #endregion

        #region /* Proceso de INSERT RECORD */

        /// <summary>
        /// Almacena el registro de una ENTIDAD de registro de Tipo SolicitudDetaDeta
        /// En la BASE de DATO la Tabla : [Presupuesto.SolicitudDetaDeta]
        /// <summary>
        /// <param name="pSolicitudDetaDeta"></param>
        /// <returns></returns>
        public bool Registrar(SolicitudDetaEntity pSolicitudDeta)
        {
            int? codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_I_SolicitudDeta(
                       ref codigoRetorno,
                       pSolicitudDeta.codSolicitud,
                       pSolicitudDeta.codPlantillaDeta,
                       pSolicitudDeta.cntCantidad,
                       pSolicitudDeta.gloDescripcion,
                       pSolicitudDeta.segUsuarioCrea,
                       pSolicitudDeta.segMaquinaOrigen);
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
        /// Almacena el registro de una ENTIDAD de registro de Tipo SolicitudDetaDeta
        /// En la BASE de DATO la Tabla : [Presupuesto.SolicitudDetaDeta]
        /// <summary>
        /// <param name="itemSolicitudDetaDeta"></param>
        /// <returns></returns>
        public bool Actualizar(SolicitudDetaEntity pSolicitudDeta)
        {
            int codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_U_SolicitudDeta(
                        pSolicitudDeta.Codigo,
                        pSolicitudDeta.codSolicitud,
                        pSolicitudDeta.codPlantillaDeta,
                        pSolicitudDeta.cntCantidad,
                        pSolicitudDeta.gloDescripcion,
                        pSolicitudDeta.segUsuarioEdita,
                        pSolicitudDeta.segMaquinaOrigen);
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
        /// ELIMINA un registro de la Entidad Presupuesto.SolicitudDetaDeta
        /// En la BASE de DATO la Tabla : [Presupuesto.SolicitudDetaDeta]
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
                    SQLDC.pa_D_SolicitudDeta(pFiltro.codSolicitudDeta, 
                                             pFiltro.segUsuElimina, 
                                             pFiltro.segMaquinaPC);
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
