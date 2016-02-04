using System;
using System.Collections.Generic;
using System.Configuration;
using log4net;

using ByS.Presupuesto.Entities;
namespace ByS.Presupuesto.Data
{

    /// <summary>
    /// Proyecto    :  Modulo de Mantenimiento de : 
    /// Creacion    : Daniel Collazos
    /// Fecha       : 02/02/2016
    /// Descripcion : Capa de Datos 
    /// Archivo     : [Presupuesto.PlantillaData.cs]
    /// </summary>
    public class SolicitudEjecucionData
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(PlantillaData));
        private string conexion = string.Empty;

        //Plantilla data


        public SolicitudEjecucionData()
        {
            conexion = Util.ConexionBD();
        }

        #region /* Proceso de UPDATE RECORD */
        /// <summary>
        /// 
        /// 
        /// <summary>
        /// <param name = >itemPartida</param>
        public bool ActualizarSolicitudEjecucion(SolicitudEntity objSolicitud)
        {
            int codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_U_SolicitudEjecucion(

                        objSolicitud.codSolicitud,
                        //objSolicitud.gloObservacion,
                        //objSolicitud.fecSolicitada,
                        objSolicitud.indTipo,
                        //objSolicitud.fecLimite,
                        // objSolicitud.codEmpleadoGenera,
                        // objSolicitud.codEmpleadoAprueba,
                        //objSolicitud.codPresupuesto,
                        objSolicitud.codRegEstado,
                        objSolicitud.segUsuarioEdita,
                        objSolicitud.segMaquinaOrigen);

                    codigoRetorno = 0;
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ActualizarSolicitudEjecucion", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno == 0 ? true : false;
        }

        #endregion

    }
}
