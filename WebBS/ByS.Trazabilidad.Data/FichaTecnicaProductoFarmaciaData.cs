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
   public class FichaTecnicaProductoFarmaciaData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public FichaTecnicaProductoFarmaciaData()
		{
            conexion = Util.ConexionBD();
		}
		
     

	   public List<FichaTecnicaProductoFarmaciaDTO> Listar(Parametro pFiltro)
		{
            List<FichaTecnicaProductoFarmaciaDTO> lista = new List<FichaTecnicaProductoFarmaciaDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_FichaTecnicaProductoFarmacia(pFiltro.codProducto);
                        
                    foreach (var item in resul)
                    {
                        lista.Add(new FichaTecnicaProductoFarmaciaDTO()
                        {
                            aprobar = item.aprobar,
                            codigoFichaTecProducto = item.codigoFichaTecProducto,
                            codigoFichaTecProveedor = item.codigoFichaTecProveedor,
                            codigoProcedimiento = item.codigoProcedimiento,
                            descripcion = item.descripcion,
                            etiquetado = item.etiquetado,
                            nombre = item.nombre,
                            posologia=item.posologia,
                            procedimiemtoDistribucion=item.procedimiemtoDistribucion,
                            procedimientoAlmacen=item.procedimientoAlmacen,
                            procedimientoVenta=item.procedimientoVenta,
                            quimicoFarmaceutico=item.quimicoFarmaceutico
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

       public bool Actualizar(FichaTecnicaProductoFarmaciaEntity objEntity)
       {
           int codigoRetorno = -1;
           try
           {
               using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
               {
                   SQLDC.pa_U_FichaTecnicaProductoFarmacia(
                       objEntity.codigoFichaTecProducto,
                       objEntity.nombre,
                       objEntity.descripcion,
                       objEntity.etiquetado,
                       objEntity.procedimientoAlmacen,
                       objEntity.procedimientoVenta,
                       objEntity.procedimiemtoDistribucion,
                       objEntity.posologia,
                       objEntity.quimicoFarmaceutico,
                       objEntity.aprobar
                       );
                   codigoRetorno = 0;
               }
           }
           catch (Exception ex)
           {
               log.Error(String.Concat("Actualizar", " | ", ex.Message.ToString()));
               throw ex;
           }
           return codigoRetorno == 0 ? true : false;
       }

    }
}
