using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using ByS.Trazabilidad.Entities.Entities;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Data
{
   public class InformeTrazabilidaData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(TrazabilidadData));
		private string conexion = string.Empty;
        public InformeTrazabilidaData()
		{
            conexion = Util.ConexionBD();
		}


        public InformeTrazabilidadDTOReporte Listar(Parametro pFiltro)
        {
            InformeTrazabilidadDTOReporte trazabilidad = new InformeTrazabilidadDTOReporte();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_InformeTrazabilidad(pFiltro.codigoInformeTrazabilidad).FirstOrDefault();

                    if (resul != null)
                    {
                        trazabilidad.codigoTraza = resul.codigoTraza;
                        trazabilidad.codigoInformeTrazabilidad = resul.codigoInformeTrazabilidad;
                        trazabilidad.nombreProducto = resul.nombreProducto;
                        trazabilidad.estado = resul.estado;
                        trazabilidad.detalleAnalisis = resul.detalleAnalisis;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return trazabilidad;
        }



       public bool Insertar(InformeTrazabilidadEntity objEntity)
       {
           string codigoRetorno = string.Empty;
           try
           {

               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   SQLDC.pa_I_InformeTrazabilidad(
                       ref codigoRetorno,
                       objEntity.producto,
                       objEntity.detalleAnalisis,
                       objEntity.anexo,
                       objEntity.codigoTraza
                       );
                   objEntity.codigoInformeTrazabilidad = codigoRetorno;
               }
           }
           catch (Exception ex)
           {
               log.Error(String.Concat("Insertar", " | ", ex.Message.ToString()));
               throw ex;
           }
           return codigoRetorno == string.Empty ? false : true;
       }

    }
}
