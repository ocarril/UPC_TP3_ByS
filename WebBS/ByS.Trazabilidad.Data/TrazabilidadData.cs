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
   public class TrazabilidadData
    {

       private static readonly ILog log = LogManager.GetLogger(typeof(TrazabilidadData));
		private string conexion = string.Empty;
        public TrazabilidadData()
		{
            conexion = Util.ConexionBD();
		}
		
         public TrazabilidadDTO Listar(Parametro pFiltro)
		{
            TrazabilidadDTO trazabilidad = new TrazabilidadDTO();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Trazabilidad(pFiltro.codProducto).FirstOrDefault();
                        
                    if(resul!=null)
                    {                       
                        trazabilidad.codigoTraza = resul.codigoTraza;
                        trazabilidad.fechaTraza = resul.fechaTraza;
                        trazabilidad.nombreProducto = resul.nombreProducto;
                        trazabilidad.estado = resul.estado;                        
                        trazabilidad.estadoinformetrazabilidad = resul.estadoinformetrazabilidad;
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

    


       public bool Insertar(TrazabilidadEntity objEntity)
       {
           string codigoRetorno = string.Empty;
           try
           {
               
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   SQLDC.pa_I_Trazabilidad(
                       ref codigoRetorno,
                       objEntity.producto,
                       objEntity.descripcion,
                       objEntity.estado
                       );
                   objEntity.codigoTraza = codigoRetorno;
               }
           }
           catch (Exception ex)
           {
               log.Error(String.Concat("Insertar", " | ", ex.Message.ToString()));
               throw ex;
           }
           return codigoRetorno == string.Empty ? false : true;
       }

       public bool Actualizar(TrazabilidadEntity objEntity)
       {
           string codigoRetorno = string.Empty;
           try
           {

               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   SQLDC.pa_U_Trazabilidad(
                      objEntity.codigoTraza,
                       objEntity.producto,
                       objEntity.descripcion,
                       objEntity.estado
                       );
                   objEntity.codigoTraza = codigoRetorno;
               }
           }
           catch (Exception ex)
           {
               log.Error(String.Concat("Actualizar", " | ", ex.Message.ToString()));
               throw ex;
           }
           return codigoRetorno == string.Empty ? false : true;
       }


    }
}
