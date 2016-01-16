using System;
using System.Collections.Generic;
using System.Configuration;
//using System.Transactions;

using ByS.Presupuesto.Data;
using ByS.Presupuesto.Entities;
using ByS.Presupuesto.Entities.DTO;
using ByS.Tools;

namespace ByS.Presupuesto.Logic
{ 
	/// <summary>
	/// Proyecto    :  Modulo de Mantenimiento de : 
	/// Creacion    : CROM - Orlando Carril Ramírez
	/// Fecha       : 26/11/2015-12:29:08 a.m.
	/// Descripcion : Capa de Lógica 
	/// Archivo     : [Presupuesto.PlantillaLogic.cs]
	/// </summary>
	public class GastoLogic
	{
        private GastoData oGastoData = null;
        private ReturnValor oReturnValor = null;

        public GastoLogic()
		{
			oReturnValor = new ReturnValor();
		}
	
        /* Gastos */
        public GastoEntityDTO BuscarGasto(int pID)
        {
            GastoEntityDTO objGastoEntityDTO = new GastoEntityDTO();
            try
            {
                oGastoData = new  GastoData();
                if (pID > 0)
                    objGastoEntityDTO = oGastoData.Buscar(pID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objGastoEntityDTO;
        }

        public List<GastoEntityDTO> ListarGasto(Parametro pLista)
        {
            List<GastoEntityDTO> lstGastoEntityDTO = new List<GastoEntityDTO>();
            try
            {
                oGastoData = new GastoData();
                lstGastoEntityDTO = oGastoData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstGastoEntityDTO;
        }

        public List<GastoEntityDTO> ListarGastoPaginado(Parametro pLista)
        {
            List<GastoEntityDTO> lstGastoEntityDTO = new List<GastoEntityDTO>();
            try
            {
                oGastoData = new GastoData();
                lstGastoEntityDTO = oGastoData.ListarPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstGastoEntityDTO;
        }

        public ReturnValor RegistrarGasto(GastoEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oGastoData = new GastoData();
                oReturnValor.Exitosa = oGastoData.Registrar(objPlantillaDetaEntity);
                    if (oReturnValor.Exitosa)
                    {
                        oReturnValor.Message = HelpMessages.Evento_NEW;
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

        public ReturnValor ActualizarGasto(GastoEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oGastoData = new GastoData();
                oReturnValor.Exitosa = oGastoData.Actualizar(objPlantillaDetaEntity);
                if (oReturnValor.Exitosa)
                {
                    oReturnValor.Message =HelpMessages.Evento_EDIT;
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

        public ReturnValor EliminarGasto(Parametro objParametro)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oGastoData = new GastoData();
                oReturnValor.Exitosa = oGastoData.Eliminar(objParametro);
                if (oReturnValor.Exitosa)
                {
                    oReturnValor.Message = HelpMessages.Evento_DELETE;
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
