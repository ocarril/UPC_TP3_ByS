using ByS.Tools;
using ByS.Trazabilidad.Data;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using ByS.Trazabilidad.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bys.Trazabilidad.Logic
{
   public class FichaTecnicaProductoFarmaciaLogic
    {
       private FichaTecnicaProductoFarmaciaData oData = null;
        private ReturnValor oReturnValor = null;
        public List<FichaTecnicaProductoFarmaciaDTO> Listar(Parametro pLista)
        {
            List<FichaTecnicaProductoFarmaciaDTO> lista = new List<FichaTecnicaProductoFarmaciaDTO>();
            try
            {
                oData = new FichaTecnicaProductoFarmaciaData();
                lista = oData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lista;
        }
        public ReturnValor Actualizar(FichaTecnicaProductoFarmaciaEntity objEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oData = new FichaTecnicaProductoFarmaciaData();
                oReturnValor.Exitosa = oData.Actualizar(objEntity);
                if (oReturnValor.Exitosa)
                {
                    oReturnValor.Message = HelpMessages.Evento_NEW;
                    oReturnValor.CodigoRetorno = objEntity.codigoFichaTecProducto;
                    //tx.Complete();
                }
                //}
            }
            catch (Exception ex)
            {
                oReturnValor = HelpException.mTraerMensaje(ex);
            }
            return oReturnValor;
        }

    }
}
