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
   public class OrdenDeCompraLogic
    {

        private OrdenDeCompraData oData = null;
        private ReturnValor oReturnValor = null;
        public List<OrdenDeCompraDTO> Listar(Parametro pLista)
        {
            List<OrdenDeCompraDTO> lista = new List<OrdenDeCompraDTO>();
            try
            {
                oData = new OrdenDeCompraData();
                lista = oData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lista;
        }
    }
}
