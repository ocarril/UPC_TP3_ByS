using ByS.Trazabilidad.Entities.Entities;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Data
{
  public  class TrazabilidadDetalleData
    {


       private static readonly ILog log = LogManager.GetLogger(typeof(TrazabilidadData));
		private string conexion = string.Empty;
        public TrazabilidadDetalleData()
		{
            conexion = Util.ConexionBD();
		}
		

       public bool Insertar(TrazabilidadDetalleEntity objEntity)
       {
           string codigoRetorno = string.Empty;
           try
           {
               
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   SQLDC.pa_I_TrazabilidadDetalle(                       
                       objEntity.codigoTraza,
                       objEntity.codigoVenta,
                       objEntity.numeroKardex,
                       objEntity.codigoCompra,
                       objEntity.numeroOrden,
                       objEntity.numeroHojaMerma,
                       objEntity.nombreProducto,
                       objEntity.codigoFichaTecProducto
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


       public bool Eliminar(string codigotraza)
       {
           string codigoRetorno = string.Empty;
           try
           {

               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   SQLDC.pa_D_TrazabilidadDetalle(codigotraza);
                   
               }
           }
           catch (Exception ex)
           {
               log.Error(String.Concat("Eliminar", " | ", ex.Message.ToString()));
               throw ex;
           }
           return codigoRetorno == string.Empty ? false : true;
       }

    }
}
