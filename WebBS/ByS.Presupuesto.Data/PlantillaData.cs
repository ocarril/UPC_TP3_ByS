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
    /// Archivo     : [Presupuesto.PlantillaData.cs]
    /// </summary>
    public class PlantillaData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(PlantillaData));
        private string conexion = string.Empty;

        //Plantilla data


        public PlantillaData()
        {
            conexion = Util.ConexionBD();
        }
   
        #region /* Proceso de SELECT ALL */

        /// <summary>
        /// Retorna un LISTA de registros de la Entidad Presupuesto.Plantilla
        /// En la BASE de DATO la Tabla : [Presupuesto.Plantilla]
        /// <summary>
        /// <returns>List</returns>
        public List<PlantillaEntity> Listar(Parametro pLista)
        {
            List<PlantillaEntity> lstPlantillaEntity = new List<PlantillaEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Plantilla(null, pLista.numAnio, pLista.codArea);
                    foreach (var item in resul)
                    {
                        PlantillaEntity objPlantillaEntity = new PlantillaEntity();
                        objPlantillaEntity.Codigo = item.codPlantilla;
                        objPlantillaEntity.numPlantilla = item.numPlantilla;
                        objPlantillaEntity.objPresupuesto.desNombre = item.nombrePresupuesto;
                        objPlantillaEntity.objPresupuesto.numAnio = item.numAnio;
                        objPlantillaEntity.objPresupuesto.fecCierre = item.fecCierre;
                        objPlantillaEntity.objArea.desNombre = item.codAreaNombre;
                        objPlantillaEntity.objEmpleado.desNombre = item.desEmpleadoActual;
                        objPlantillaEntity.codRegEstadoNombre = item.EstadoPlantilla;
                        objPlantillaEntity.segUsuarioCrea = item.segUsuarioCrea;
                        objPlantillaEntity.segFechaCrea= item.segFechaCrea;
                        objPlantillaEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objPlantillaEntity.segFechaEdita = item.segFechaEdita;
                        objPlantillaEntity.monEstimadoTotal = item.monEstimadoTotalxArea.HasValue ? item.monEstimadoTotalxArea.Value : 0;
                        objPlantillaEntity.numDiasExtemporaneo = item.numDiasExtemporaneo;
                        objPlantillaEntity.fecCierreExtempor = item.fecCierre.HasValue ? item.fecCierre.Value.AddDays(item.numDiasExtemporaneo).ToShortDateString() : string.Empty;
                        lstPlantillaEntity.Add(objPlantillaEntity);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstPlantillaEntity;
        }

        #endregion

        #region /* Proceso de SELECT BY ID CODE */

        /// <summary>
        /// Retorna una ENTIDAD de registro de la Entidad Presupuesto.Plantilla
        /// En la BASE de DATO la Tabla : [Presupuesto.Plantilla]
        /// <summary>
        /// <returns>Entidad</returns>
        public PlantillaEntity Buscar(int? pAnio, int? pIdArea)
        {
            PlantillaEntity objPlantillaEntity = null;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Plantilla(null, pAnio, pIdArea);
                    foreach (var item in resul)
                    {
                        objPlantillaEntity = new PlantillaEntity();
                        objPlantillaEntity.Codigo = item.codPlantilla;
                        objPlantillaEntity.numPlantilla = item.numPlantilla;
                        objPlantillaEntity.objPresupuesto.desNombre = item.nombrePresupuesto;
                        objPlantillaEntity.objPresupuesto.numAnio = item.numAnio;
                        objPlantillaEntity.objPresupuesto.fecCierre = item.fecCierre;
                        objPlantillaEntity.objArea.desNombre = item.codAreaNombre;
                        objPlantillaEntity.objEmpleado.desNombre = item.desEmpleadoActual;
                        objPlantillaEntity.segUsuarioCrea = item.segUsuarioCrea;
                        objPlantillaEntity.segFechaCrea = item.segFechaCrea;
                        objPlantillaEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objPlantillaEntity.segFechaEdita = item.segFechaEdita;
                        objPlantillaEntity.codRegEstadoNombre = item.EstadoPlantilla;
                        objPlantillaEntity.monMaximo = item.monMaximo.HasValue ? item.monMaximo.Value : 0;
                        objPlantillaEntity.monEstimadoTotal = item.monEstimadoTotalxArea.HasValue ? item.monEstimadoTotalxArea.Value : 0;
                        objPlantillaEntity.numDiasExtemporaneo = item.numDiasExtemporaneo;
                        objPlantillaEntity.fecCierreExtempor = item.fecCierre.HasValue ? item.fecCierre.Value.AddDays(item.numDiasExtemporaneo).ToShortDateString() : string.Empty;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Buscar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return objPlantillaEntity;
        }
    
        #endregion

        #region /* Proceso de UPDATE RECORD */
        /// <summary>
        /// Almacena el registro de una ENTIDAD de registro de Tipo Partida
        /// En la BASE de DATO la Tabla : [Presupuesto.Partida]
        /// <summary>
        /// <param name = >itemPartida</param>
        public bool ActualizarEstado(PlantillaEntity objPlantilla)
        {
            int codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_U_Plantilla_Estado(
                        objPlantilla.Codigo,
                        objPlantilla.codRegEstado,
                        objPlantilla.segUsuarioEdita,
                        objPlantilla.segMaquinaOrigen);

                    codigoRetorno = 0;
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ActualizarEstado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno == 0 ? true : false;
        }

        #endregion
    }
} 
