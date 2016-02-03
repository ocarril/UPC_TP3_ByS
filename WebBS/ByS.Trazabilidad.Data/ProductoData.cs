using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Data
{
   public class ProductoData
    {

       private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public ProductoData()
		{
            conexion = Util.ConexionBD();
		}
		
     

	   public List<ProductoDTO> Listar(Parametro pFiltro)
	    {
            List<ProductoDTO> lstGastoEntityDTO = new List<ProductoDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Producto(pFiltro.codProducto, pFiltro.nomProducto);
                        
                    foreach (var item in resul)
                    {
                        lstGastoEntityDTO.Add(new ProductoDTO()
                        {
                            codigoProducto = item.codigoProducto,
                            nombreProducto = item.nombreProducto,
                            descripcion = item.descripcion,
                            pesoProducto = item.pesoProducto,
                            tipoProducto = item.tipoProducto,
                            presentacion = item.presentacion,
                     
                            fecha = item.fecha,
                            autorizado = item.autorizado,
                            motivo = item.motivo,
                            riesgo = item.riesgo
                            
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
		    return lstGastoEntityDTO;
         }  
    }
}
