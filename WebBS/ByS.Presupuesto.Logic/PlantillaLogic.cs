using System;
using System.Collections.Generic;
using System.Configuration;
//using System.Transactions;

using ByS.Presupuesto.Entities;
using ByS.Presupuesto.Entities.DTO;
using ByS.Presupuesto.Data;
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
	public class PlantillaLogic
	{ 
		private PlantillaData oPlantillaData = null;
        private PlantillaDetaData oPlantillaDetaData = null;
        private PartidaData objPartidaData = null;
        private PresupuestoData objPresupuestoData = null;
		private ReturnValor oReturnValor = null;

		public PlantillaLogic()
		{
			oReturnValor = new ReturnValor();
		}
		#region /* Proceso de SELECT ALL */ 

		/// <summary>
		/// Retorna un LISTA de registros de la Entidad Presupuesto.Plantilla
		/// En la BASE de DATO la Tabla : [Presupuesto.Plantilla]
		/// <summary>
		/// <returns>List</returns>
        public List<PlantillaEntityDTO> ListarPlantilla(Parametro pLista)
		{
            List<PlantillaEntityDTO> lstPlantillaEntityDTO = new List<PlantillaEntityDTO>();
			try
			{
                oPlantillaData = new PlantillaData();
                lstPlantillaEntityDTO = oPlantillaData.Listar(pLista);
			}
			catch (Exception ex)
			{
				throw ex;
			}
			return lstPlantillaEntityDTO;
		}
	
        #endregion 

		#region /* Proceso de SELECT BY ID CODE */ 

		/// <summary>
		/// Retorna una ENTIDAD de registro de la Entidad Presupuesto.Plantilla
		/// En la BASE de DATO la Tabla : [Presupuesto.Plantilla]
		/// <summary>
		/// <returns>Entidad</returns>
        public PlantillaEntityDTO BuscarPlantilla(int? pAnio, int? pIdArea)
		{
            PlantillaEntityDTO objPlantillaEntityDTO = new PlantillaEntityDTO();
			try
			{
                oPlantillaData = new PlantillaData();
				objPlantillaEntityDTO = oPlantillaData.Buscar(pAnio, pIdArea);
			}
			catch (Exception ex)
			{
				throw ex;
			}
			return objPlantillaEntityDTO;
		}

		#endregion 

        public ReturnValor ActualizarPlantillaEstado(PlantillaEntity objPlantillaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oPlantillaData = new PlantillaData();
                oReturnValor.Exitosa = oPlantillaData.ActualizarEstado(objPlantillaEntity);
                if (oReturnValor.Exitosa)
                {
                    oReturnValor.Message = HelpMessages.Evento_EDIT;
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


        public PlantillaDetaEntityDTO BuscarPlantillaDetalle(int pID)
        {
            PlantillaDetaEntityDTO objPlantillaDetaEntityDTO= new PlantillaDetaEntityDTO();
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                if (pID > 0)
                    objPlantillaDetaEntityDTO = oPlantillaDetaData.Buscar(pID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPlantillaDetaEntityDTO;
        }

        public List<PlantillaDetaEntityDTO> ListarPlantillaDetalle(Parametro pLista)
        {
            List<PlantillaDetaEntityDTO> lstPlantillaDetaEntityDTO = new List<PlantillaDetaEntityDTO>();
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                lstPlantillaDetaEntityDTO = oPlantillaDetaData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaDetaEntityDTO;
        }

        public List<PlantillaDetaEntityDTO> ListarPlantillaDetallePaginado(Parametro pLista)
        {
            List<PlantillaDetaEntityDTO> lstPlantillaDetaEntityDTO = new List<PlantillaDetaEntityDTO>();
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                lstPlantillaDetaEntityDTO = oPlantillaDetaData.ListarPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaDetaEntityDTO;
        }

        public ReturnValor RegistrarPlantillaDeta(PlantillaDetaEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oPlantillaDetaData = new PlantillaDetaData();
                oReturnValor.Exitosa = oPlantillaDetaData.Registrar(objPlantillaDetaEntity);
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

        public ReturnValor RegistrarPlantillaDetaPorReferencia(List<PlantillaDetaEntity> lstPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oPlantillaDetaData = new PlantillaDetaData();
                oReturnValor.Exitosa = oPlantillaDetaData.RegistrarPorReferencia(lstPlantillaDetaEntity);
                if (oReturnValor.Exitosa)
                {
                    oReturnValor.Message = HelpMessages.Evento_EDIT;
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

        public ReturnValor ActualizarPlantillaDeta(PlantillaDetaEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oPlantillaDetaData = new PlantillaDetaData();
                oReturnValor.Exitosa = oPlantillaDetaData.Actualizar(objPlantillaDetaEntity);
                if (oReturnValor.Exitosa)
                {
                    oReturnValor.Message = HelpMessages.Evento_EDIT;
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

        public ReturnValor EliminarPlantillaDeta(Parametro objParametro)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                oPlantillaDetaData = new PlantillaDetaData();
                oReturnValor.Exitosa = oPlantillaDetaData.Eliminar(objParametro);
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

        public List<PartidaEntity> ListarPartida()
        {
            List<PartidaEntity> lstPartidaEntity = new List<PartidaEntity>();
            try
            {
                objPartidaData = new  PartidaData();
                lstPartidaEntity = objPartidaData.Listar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPartidaEntity;
        }

        public List<PresupuestoEntityDTO> ListarPresupuesto(int? pID)
        {
            List<PresupuestoEntityDTO> lstPresupuestoEntity = new List<PresupuestoEntityDTO>();
            try
            {
                objPartidaData = new PartidaData();
                objPresupuestoData = new PresupuestoData();
                lstPresupuestoEntity = objPresupuestoData.Listar(pID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPresupuestoEntity;
        }

        public PresupuestoEntityDTO BuscarPresupuesto(int pID)
        {
            PresupuestoEntityDTO objPresupuestoEntity = new PresupuestoEntityDTO();
            try
            {
                objPresupuestoData = new PresupuestoData();
                objPresupuestoEntity = objPresupuestoData.Buscar(pID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPresupuestoEntity;
        }
	} 
} 
