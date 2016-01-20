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
   public class KardexLogic
    {
        private KardexData oVentaData = null;
        private ReturnValor oReturnValor = null;
        public List<KardexDTO> Listar(Parametro pLista)
        {
            List<KardexDTO> lista = new List<KardexDTO>();
            try
            {
                oVentaData = new KardexData();
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
