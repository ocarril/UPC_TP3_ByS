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
    public class OrdenDeCompraData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public OrdenDeCompraData()
		{
            conexion = Util.ConexionBD();
		}
		
     

	   public List<OrdenDeCompraDTO> Listar(Parametro pFiltro)
		{
            List<OrdenDeCompraDTO> lista = new List<OrdenDeCompraDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_OrdendeCompra(pFiltro.codProducto, pFiltro.fechaIni,pFiltro.fechaFin);
                        
                    foreach (var item in resul)
                    {
                        lista.Add(new OrdenDeCompraDTO()
                        {
                            codigoProducto = item.codigoProducto,
                            cantidad = item.cantidad,
                            codigoCompra = item.codigoCompra,
                            costo = item.costo,
                            fechaCompra=item.fechaCompra,
                            nombreProducto=item.nombreProducto,
                            nombreProveedor=item.nombreProveedor

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
