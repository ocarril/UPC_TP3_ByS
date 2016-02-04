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
    public class LibroRecetaData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public LibroRecetaData()
		{
            conexion = Util.ConexionBD();
		}
		
     

	   public List<LibroRecetaDTO> Listar(Parametro pFiltro)
		{
            List<LibroRecetaDTO> lista = new List<LibroRecetaDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_LibroReceta(pFiltro.codProducto, pFiltro.fechaIni,pFiltro.fechaFin);
                        
                    foreach (var item in resul)
                    {
                        lista.Add(new LibroRecetaDTO()
                        {
                            codigoProducto = item.codigoProducto,
                            fechaProducto = item.fechaProducto,
                            codigolibroreceta = item.codigolibroreceta,
                            quimicoLaboratorista = item.quimicoLaboratorista                        
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

       public List<LibroRecetaDTO> ListarRecetaTrazabilidad(Parametro pFiltro)
       {
           List<LibroRecetaDTO> lista = new List<LibroRecetaDTO>();
           try
           {
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   var resul = SQLDC.pa_S_LibroRecetaTrazabilidad(pFiltro.codProducto, pFiltro.p_codigoTraza);

                   foreach (var item in resul)
                   {
                       lista.Add(new LibroRecetaDTO()
                       {
                           codigoProducto = item.codigoProducto,
                           fechaProducto = item.fechaProducto,
                           codigolibroreceta = item.codigolibroreceta,
                           quimicoLaboratorista = item.quimicoLaboratorista
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
