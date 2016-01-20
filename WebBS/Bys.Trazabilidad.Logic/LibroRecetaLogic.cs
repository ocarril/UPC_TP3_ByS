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
   public class LibroRecetaLogic
    {
       private LibroRecetaData oData = null;
        private ReturnValor oReturnValor = null;
        public List<LibroRecetaDTO> Listar(Parametro pLista)
        {
            List<LibroRecetaDTO> lista = new List<LibroRecetaDTO>();
            try
            {
                oData = new LibroRecetaData();
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
