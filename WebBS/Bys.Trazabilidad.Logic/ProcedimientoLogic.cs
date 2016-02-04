using ByS.Tools;
using ByS.Trazabilidad.Data;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using System;
using System.Collections.Generic;


namespace Bys.Trazabilidad.Logic
{
    public class ProcedimientoLogic
    {
        private ProcedimientoData oProcedimientoData = null;
        private ReturnValor oReturnValor = null;
        public List<ProcedimientoDTO> Listar(Parametro pLista)
        {
            List<ProcedimientoDTO> lista = new List<ProcedimientoDTO>();
            try
            {
                oProcedimientoData = new ProcedimientoData();
                lista = oProcedimientoData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lista;
        }

        public ProcedimientoDTO BuscarProcedimientoById(Parametro pLista)
        {
            ProcedimientoDTO lista = new ProcedimientoDTO();
            try
            {
                oProcedimientoData = new ProcedimientoData();
                lista = oProcedimientoData.BuscarProcedimientoById(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lista;
        }


        public bool Update(ProcedimientoDTO objEntity)
        {
            bool codigoRetorno = false;
            try
            {
                oProcedimientoData = new ProcedimientoData();
                codigoRetorno = oProcedimientoData.Update(objEntity);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return codigoRetorno;
        }
    }
}
