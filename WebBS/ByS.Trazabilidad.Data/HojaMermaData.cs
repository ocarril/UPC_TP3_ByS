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
   public class HojaMermaData
    {
          private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public HojaMermaData()
		{
            conexion = Util.ConexionBD();
		}
		
     

	   public List<HojaMermaDTO> Listar(Parametro pFiltro)
		{
            List<HojaMermaDTO> lista = new List<HojaMermaDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_HojaMerma(pFiltro.codProducto, pFiltro.fechaIni,pFiltro.fechaFin);
                        
                    foreach (var item in resul)
                    {
                        lista.Add(new HojaMermaDTO()
                        {
                            codigoProducto = item.codigoProducto,
                            fecha = item.fecha,
                            cantidadInsumo = item.cantidadInsumo,
                            motivo = item.motivo,
                            numeroHojaMerma = item.numeroHojaMerma
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


       public List<HojaMermaDTO> ListarMermaTrazabilidad(Parametro pFiltro)
       {
           List<HojaMermaDTO> lista = new List<HojaMermaDTO>();
           try
           {
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   var resul = SQLDC.pa_S_HojaMermaTrazabilidad(pFiltro.codProducto, pFiltro.p_codigoTraza);
                   
                   foreach (var item in resul)
                   {
                       lista.Add(new HojaMermaDTO()
                       {
                           codigoProducto = item.codigoProducto,
                           fecha = item.fecha,
                           cantidadInsumo = item.cantidadInsumo,
                           motivo = item.motivo,
                           numeroHojaMerma = item.numeroHojaMerma
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
