using ByS.Trazabilidad.Data;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ByS.Tools;
namespace Bys.Trazabilidad.Logic
{
  public class InformeVentaLogic
    {
      private InformeVentaData oVentaData = null;    
      private ReturnValor oReturnValor = null;
      public List<InformeVentaDTO> ListarInformeVenta(Parametro pLista)
      {
          List<InformeVentaDTO> lstGastoEntityDTO = new List<InformeVentaDTO>();
          try
          {
              oVentaData = new InformeVentaData();
              lstGastoEntityDTO = oVentaData.Listar(pLista);
          }
          catch (Exception ex)
          {
              throw ex;
          }
          return lstGastoEntityDTO;
      }

    }
}
