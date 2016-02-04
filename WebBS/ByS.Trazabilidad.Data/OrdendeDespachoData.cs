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
    public class OrdendeDespachoData
    {
     private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public OrdendeDespachoData()
		{
            conexion = Util.ConexionBD();
		}
		
   	   public List<OrdendeDespachoDTO> Listar(Parametro pFiltro)
		{
            List<OrdendeDespachoDTO> lista = new List<OrdendeDespachoDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_OrdenDeDespacho(pFiltro.codProducto, pFiltro.fechaIni,pFiltro.fechaFin);
                        
                    foreach (var item in resul)
                    {
                        lista.Add(new OrdendeDespachoDTO()
                        {
                            codigoProducto = item.codigoProducto,
                            fecha = item.fecha,
                            numeroOrden = item.numeroOrden,
                            observaciones = item.observaciones,
                            pesoTotal = item.pesoTotal,
                            totalPedidos = item.totalPedidos
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lista;
            }

       public List<OrdendeDespachoDTO> ListarOrdenDeDespachoTrazabilidad(Parametro pFiltro)
       {
           List<OrdendeDespachoDTO> lista = new List<OrdendeDespachoDTO>();
           try
           {
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   var resul = SQLDC.pa_S_OrdenDeDespachoTrazabilidad(pFiltro.codProducto, pFiltro.p_codigoTraza);

                   foreach (var item in resul)
                   {
                       lista.Add(new OrdendeDespachoDTO()
                       {
                           codigoProducto = item.codigoProducto,
                           fecha = item.fecha,
                           numeroOrden = item.numeroOrden,
                           observaciones = item.observaciones,
                           pesoTotal = item.pesoTotal,
                           totalPedidos = item.totalPedidos
                       });
                   }
               }
           }
           catch (Exception ex)
           {
               log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
               throw ex;
           }
           return lista;
       }


    }
}
