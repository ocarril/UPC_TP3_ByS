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
   public class InformeTrazabilidaLogic
    {
       private InformeTrazabilidaData  oData = null;

        private ReturnValor oReturnValor = null;


        public InformeTrazabilidadDTOReporte Listar(Parametro pFiltro)
        {
            InformeTrazabilidadDTOReporte lista = new InformeTrazabilidadDTOReporte();
            try
            {
                oData = new InformeTrazabilidaData();
                lista = oData.Listar(pFiltro);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lista;
        }

       public ReturnValor Insertar(InformeTrazabilidadEntity entity)
       {       
               try
               {

                   oData = new InformeTrazabilidaData();                   
                   oReturnValor = new ReturnValor();
                   oReturnValor.Exitosa = oData.Insertar(entity);                                   
               }
               catch (Exception ex)
               {
                   oReturnValor = HelpException.mTraerMensaje(ex);
               }
      

           return oReturnValor;
       }
    }
}
