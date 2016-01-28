using System;
using System.Collections.Generic;
using System.Configuration;
//using System.Transactions;

using ByS.Presupuesto.Entities;
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
        /// <param name="pLista"></param>
        /// <returns></returns>
        public List<PlantillaEntity> ListarPlantilla(Parametro pLista)
        {
            List<PlantillaEntity> lstPlantillaEntity = new List<PlantillaEntity>();
            try
            {
                oPlantillaData = new PlantillaData();
                lstPlantillaEntity = oPlantillaData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaEntity;
        }

        #endregion

        #region /* Proceso de SELECT BY ID CODE */

        /// <summary>
        /// Retorna una ENTIDAD de registro de la Entidad Presupuesto.Plantilla
        /// En la BASE de DATO la Tabla : [Presupuesto.Plantilla]
        /// <summary>
        /// <param name="pAnio"></param>
        /// <param name="pIdArea"></param>
        /// <returns></returns>
        public PlantillaEntity BuscarPlantilla(int? pAnio, int? pIdArea)
        {
            PlantillaEntity objPlantillaEntity = null;
            try
            {
                oPlantillaData = new PlantillaData();
                objPlantillaEntity = oPlantillaData.Buscar(pAnio, pIdArea);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPlantillaEntity;
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


        public PlantillaDetaEntity BuscarPlantillaDetalle(int pID)
        {
            PlantillaDetaEntity objPlantillaDetaEntity = null;
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                if (pID > 0)
                    objPlantillaDetaEntity = oPlantillaDetaData.Buscar(pID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPlantillaDetaEntity;
        }

        public List<PlantillaDetaEntity> ListarPlantillaDetalle(Parametro pLista)
        {
            List<PlantillaDetaEntity> lstPlantillaDetaEntity = new List<PlantillaDetaEntity>();
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                lstPlantillaDetaEntity = oPlantillaDetaData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaDetaEntity;
        }

        public List<PlantillaDetaEntity> ListarPlantillaDetallePaginado(Parametro pLista)
        {
            List<PlantillaDetaEntity> lstPlantillaDetaEntity = new List<PlantillaDetaEntity>();
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                lstPlantillaDetaEntity = oPlantillaDetaData.ListarPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaDetaEntity;
        }

        public List<PlantillaDetaEntity> ListarPlantillaDetallePorEjecutarPaginado(Parametro pLista)
        {
            List<PlantillaDetaEntity> lstPlantillaDetaEntity = new List<PlantillaDetaEntity>();
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                lstPlantillaDetaEntity = oPlantillaDetaData.ListarPorEjecutarPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaDetaEntity;
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
                objPartidaData = new PartidaData();
                lstPartidaEntity = objPartidaData.Listar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPartidaEntity;
        }

        public List<PresupuestoEntity> ListarPresupuesto(int? pnumAnio)
        {
            List<PresupuestoEntity> lstPresupuestoEntity = new List<PresupuestoEntity>();
            try
            {
                objPartidaData = new PartidaData();
                objPresupuestoData = new PresupuestoData();
                lstPresupuestoEntity = objPresupuestoData.Listar(pnumAnio);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPresupuestoEntity;
        }

        public PresupuestoEntity BuscarPresupuesto(int pnumAnio)
        {
            PresupuestoEntity objPresupuestoEntity = null;
            try
            {
                objPresupuestoData = new PresupuestoData();
                objPresupuestoEntity = objPresupuestoData.Buscar(pnumAnio);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPresupuestoEntity;
        }
    }
}
