using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;

namespace ByS.Trazabilidad.Data
{
   public  class InformeVentaData
    {
       private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public InformeVentaData()
		{
            conexion = Util.ConexionBD();
		}
		

	   public List<InformeVentaDTO> Listar(Parametro pFiltro)
		{
            List<InformeVentaDTO> lstGastoEntityDTO = new List<InformeVentaDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_InformeVenta(pFiltro.codProducto, pFiltro.fechaIni, pFiltro.fechaFin);
                        
                    foreach (var item in resul)
                    {
                        lstGastoEntityDTO.Add(new InformeVentaDTO()
                        {
                            codigoProducto = item.codigoProducto,
                            cantidad = item.cantidad,
                            codigoVenta = item.codigoVenta,
                            fechaVenta = item.fechaVenta.GetValueOrDefault(),
                            nombreCliente = item.nombreCliente,
                            nombreProducto = item.nombreProducto,
                            precio = item.precio                          
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



       public List<InformeVentaDTO> ListarVentaTrazabilidad(Parametro pFiltro)
       {
           List<InformeVentaDTO> lstGastoEntityDTO = new List<InformeVentaDTO>();
           try
           {
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   var resul = SQLDC.pa_S_InformeVentaTrazabilidad(pFiltro.codProducto,pFiltro.p_codigoTraza);

                   foreach (var item in resul)
                   {
                       lstGastoEntityDTO.Add(new InformeVentaDTO()
                       {
                           codigoProducto = item.codigoProducto,
                           cantidad = item.cantidad,
                           codigoVenta = item.codigoVenta,
                           fechaVenta = item.fechaVenta.GetValueOrDefault(),
                           nombreCliente = item.nombreCliente,
                           nombreProducto = item.nombreProducto,
                           precio = item.precio
                       });
                   }
               }
           }
           catch (Exception ex)
           {
               log.Error(String.Concat("ListarVentaTrazabilidad", " | ", ex.Message.ToString()));
               throw ex;
           }
           return lstGastoEntityDTO;
       }

    }
}
