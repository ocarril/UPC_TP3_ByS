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
  public  class OrdendeDespachoLogic
    {


      private OrdendeDespachoData oData = null;
        private ReturnValor oReturnValor = null;
        public List<OrdendeDespachoDTO> Listar(Parametro pLista)
        {
            List<OrdendeDespachoDTO> lista = new List<OrdendeDespachoDTO>();
            try
            {
                oData = new OrdendeDespachoData();
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
