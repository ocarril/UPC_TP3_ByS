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
        public List<PlantillaEntityDTO> Listar(Parametro pLista)
        {
            List<PlantillaEntityDTO> lstPlantillaEntityDTO = new List<PlantillaEntityDTO>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Plantilla(null, pLista.numAnio, pLista.codArea);
                    foreach (var item in resul)
                    {
                        lstPlantillaEntityDTO.Add(new PlantillaEntityDTO()
                        {
                            codPlantilla = item.codPlantilla,
                            numPlantilla = item.numPlantilla,
                            desNombrePresupuesto = item.nombrePresupuesto,
                            numAnio = item.numAnio.ToString(),
                            fecCierre = item.fecCierre.HasValue ? item.fecCierre.ToString() : string.Empty,
                            codAreaNombre = item.codAreaNombre,
                            desEmpleadoActual = item.desEmpleadoActual,
                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString(),
                            monEstimadoTotal = item.monEstimadoTotalxArea.HasValue ? item.monEstimadoTotalxArea.Value.ToString("N2") : "0.00",
                            numDiasExtemporaneo = item.numDiasExtemporaneo
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstPlantillaEntityDTO;
        }

        #endregion

        #region /* Proceso de SELECT BY ID CODE */

        /// <summary>
        /// Retorna una ENTIDAD de registro de la Entidad Presupuesto.Plantilla
        /// En la BASE de DATO la Tabla : [Presupuesto.Plantilla]
        /// <summary>
        /// <returns>Entidad</returns>
        public PlantillaEntityDTO Buscar(int? pAnio, int? pIdArea)
        {
            PlantillaEntityDTO objPlantillaEntityDTO = new PlantillaEntityDTO();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Plantilla(null, pAnio, pIdArea);
                    foreach (var item in resul)
                    {
                        objPlantillaEntityDTO = new PlantillaEntityDTO()
                        {
                            codPlantilla = item.codPlantilla,
                            numPlantilla = item.numPlantilla,
                            desNombrePresupuesto = item.nombrePresupuesto,
                            numAnio = item.numAnio.ToString(),
                            fecCierre = item.fecCierre.HasValue ? item.fecCierre.Value.ToShortDateString() : string.Empty,
                            codAreaNombre = item.codAreaNombre,
                            desEmpleadoActual = item.desEmpleadoActual,
                            segUsuarioEdita = item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : string.Empty,
                            codRegEstado = item.EstadoPlantilla,
                            monMaximo = item.monMaximo.HasValue ? item.monMaximo.Value.ToString("N2") : "0.00",
                            monEstimadoTotal = item.monEstimadoTotalxArea.HasValue ? item.monEstimadoTotalxArea.Value.ToString("N2") : "0.00",
                            numDiasExtemporaneo = item.numDiasExtemporaneo,
                            fecCierreExtempor = item.fecCierre.HasValue ? item.fecCierre.Value.AddDays(item.numDiasExtemporaneo).ToShortDateString() : string.Empty,
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Buscar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return objPlantillaEntityDTO;
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
