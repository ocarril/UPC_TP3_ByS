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
using System.Transactions;
namespace Bys.Trazabilidad.Logic
{
   public class TrazabilidadLogic
    {
        private TrazabilidadData oData = null;
        private TrazabilidadDetalleData oDataDetalle=null;
        private ReturnValor oReturnValor = null;

        public TrazabilidadDTO Listar(Parametro pFiltro)
        {
            TrazabilidadDTO lista = new TrazabilidadDTO();
            try
            {
                oData = new TrazabilidadData();
                lista = oData.Listar(pFiltro);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lista;
        }
       public ReturnValor Insertar(TrazabilidadEntity entity)
       {

           using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
           {
               try
               {

                   oData = new TrazabilidadData();
                   oDataDetalle = new TrazabilidadDetalleData();
                   oReturnValor = new ReturnValor();
                   oReturnValor.Exitosa = oData.Insertar(entity);
                   oDataDetalle.Eliminar(entity.codigoTraza);
                   foreach (TrazabilidadDetalleEntity detalle in entity.lstTrazabilidadDeta)
                   {
                       detalle.codigoTraza = entity.codigoTraza;
                       oDataDetalle.Insertar(detalle);                      
                   }
                   tx.Complete();
               }
               catch (Exception ex)
               {
                   oReturnValor = HelpException.mTraerMensaje(ex);
               }

           }

           return oReturnValor;
       }

    }
}
