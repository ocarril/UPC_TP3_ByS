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
  public  class KardexData
    {
       private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public KardexData()
		{
            conexion = Util.ConexionBD();
		}
		
     

	   public List<KardexDTO> Listar(Parametro pFiltro)
		{
            List<KardexDTO> lista = new List<KardexDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Kardex(pFiltro.codProducto, pFiltro.fechaIni,pFiltro.fechaFin);
                        
                    foreach (var item in resul)
                    {
                        lista.Add(new KardexDTO()
                        {
                            codigoProducto = item.codigoProducto,
                            fecha = item.fecha,
                            ingreso = item.ingreso,
                            numeroKardex = item.numeroKardex,
                            observaciones = item.observaciones,
                            saldos = item.saldos,
                            salidas=item.salidas                            
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
            
       public List<KardexDTO> ListarKardexTrazabilidad(Parametro pFiltro)
       {
           List<KardexDTO> lista = new List<KardexDTO>();
           try
           {
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   var resul = SQLDC.pa_S_KardexTrazabilidad(pFiltro.codProducto, pFiltro.p_codigoTraza);

                   foreach (var item in resul)
                   {
                       lista.Add(new KardexDTO()
                       {
                           codigoProducto = item.codigoProducto,
                           fecha = item.fecha,
                           ingreso = item.ingreso,
                           numeroKardex = item.numeroKardex,
                           observaciones = item.observaciones,
                           saldos = item.saldos,
                           salidas = item.salidas
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
