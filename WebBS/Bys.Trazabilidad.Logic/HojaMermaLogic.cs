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
   public class HojaMermaLogic
    {
        private HojaMermaData oData = null;
        private ReturnValor oReturnValor = null;
        public List<HojaMermaDTO> Listar(Parametro pLista)
        {
            List<HojaMermaDTO> lista = new List<HojaMermaDTO>();
            try
            {
                oData = new HojaMermaData();
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
