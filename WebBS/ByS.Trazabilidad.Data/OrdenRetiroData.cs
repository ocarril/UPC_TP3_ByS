using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using ByS.Trazabilidad.Entities.Entities;

namespace ByS.Trazabilidad.Data
{
    public class OrdenRetiroData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
        private string conexion = string.Empty;
        public OrdenRetiroData() {
            conexion = Util.ConexionBD();
        }

        public bool RetirarArticulo(OrdenRetiroEntity objEntity) 
        {
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion)) 
                {
                    SQLDC.pa_I_OrdenRetiro(objEntity.codigoProducto, 
                                           objEntity.fecha, 
                                           objEntity.autorizado, 
                                           objEntity.motivo, 
                                           objEntity.motivo);
                }
            }
            catch (Exception ex) 
            {
                log.Error(String.Concat("Retiro de Articulo", " | ", ex.Message.ToString()));
                return false;
            }
            return true;
        }
    }
}
