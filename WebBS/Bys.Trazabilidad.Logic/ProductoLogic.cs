using ByS.Tools;
using ByS.Trazabilidad.Data;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bys.Trazabilidad.Logic
{
   public class ProductoLogic
    {
        private ProductoData oVentaData = null;
        private ReturnValor oReturnValor = null;
        public List<ProductoDTO> Listar(Parametro pLista)
        {
            List<ProductoDTO> lista = new List<ProductoDTO>();
            try
            {
                oVentaData = new ProductoData();
                lista = oVentaData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lista;
        }
    }
}
