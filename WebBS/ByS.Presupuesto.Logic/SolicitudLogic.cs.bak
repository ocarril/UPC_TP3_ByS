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
	/// Archivo     : [Presupuesto.SolicitudLogic.cs]
	/// </summary>
	public class SolicitudLogic
	{
        private SolicitudData objSolicitudData = null;
        private SolicitudDetaData objSolicitudDetaData = null;
        private ReturnValor objReturnValor = null;

        public SolicitudLogic()
		{
			objReturnValor = new ReturnValor();
		}
	
        /* Solicitud */
        public SolicitudEntity BuscarSolicitud(int pID)
        {
            SolicitudEntity objSolicitudEntity = new SolicitudEntity();
            try
            {
                objSolicitudData = new SolicitudData();
                if (pID > 0)
                {
                    objSolicitudEntity = objSolicitudData.Buscar(pID);
                    objSolicitudEntity.lstSolicitudDeta = ListarSolicitudDeta(new Parametro { codSolicitud = pID });
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objSolicitudEntity;
        }

        public List<SolicitudEntity> ListarSolicitud(Parametro pLista)
        {
            List<SolicitudEntity> lstSolicitudEntity = new List<SolicitudEntity>();
            try
            {
                objSolicitudData = new SolicitudData();
                lstSolicitudEntity = objSolicitudData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstSolicitudEntity;
        }

        public List<SolicitudEntity> ListarSolicitudPaginado(Parametro pLista)
        {
            List<SolicitudEntity> lstSolicitudEntity = new List<SolicitudEntity>();
            try
            {
                objSolicitudData = new SolicitudData();
                lstSolicitudEntity = objSolicitudData.ListarPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstSolicitudEntity;
        }

        public ReturnValor RegistrarSolicitud(SolicitudEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudData = new SolicitudData();
                objReturnValor.Exitosa = objSolicitudData.Registrar(objPlantillaDetaEntity);
                    if (objReturnValor.Exitosa)
                    {
                        objReturnValor.Message = HelpMessages.Evento_NEW;
                        //tx.Complete();
                    }
                //}
            }
            catch (Exception ex)
            {
                objReturnValor = HelpException.mTraerMensaje(ex);
            }
            return objReturnValor;
        }

        public ReturnValor ActualizarSolicitud(SolicitudEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudData = new SolicitudData();
                objReturnValor.Exitosa = objSolicitudData.Actualizar(objPlantillaDetaEntity);
                if (objReturnValor.Exitosa)
                {
                    objReturnValor.Message =HelpMessages.Evento_EDIT;
                    //tx.Complete();
                }
                //}
            }
            catch (Exception ex)
            {
                objReturnValor = HelpException.mTraerMensaje(ex);
            }
            return objReturnValor;
        }

        public ReturnValor EliminarSolicitud(Parametro objParametro)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudData = new SolicitudData();
                objReturnValor.Exitosa = objSolicitudData.Eliminar(objParametro);
                if (objReturnValor.Exitosa)
                {
                    objReturnValor.Message = HelpMessages.Evento_DELETE;
                    //tx.Complete();
                }
                //}
            }
            catch (Exception ex)
            {
                objReturnValor = HelpException.mTraerMensaje(ex);
            }
            return objReturnValor;
        }

        /* SolicitudDeta */
        public SolicitudDetaEntity BuscarSolicitudDeta(int pID)
        {
            SolicitudDetaEntity objSolicitudDetaEntity = new SolicitudDetaEntity();
            try
            {
                objSolicitudDetaData = new SolicitudDetaData();
                if (pID > 0)
                    objSolicitudDetaEntity = objSolicitudDetaData.Buscar(pID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objSolicitudDetaEntity;
        }

        public List<SolicitudDetaEntity> ListarSolicitudDeta(Parametro pLista)
        {
            List<SolicitudDetaEntity> lstSolicitudDetaEntity = new List<SolicitudDetaEntity>();
            try
            {
                objSolicitudDetaData = new SolicitudDetaData();
                lstSolicitudDetaEntity = objSolicitudDetaData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstSolicitudDetaEntity;
        }

        public List<SolicitudDetaEntity> ListarSolicitudDetaPaginado(Parametro pLista)
        {
            List<SolicitudDetaEntity> lstSolicitudDetaEntity = new List<SolicitudDetaEntity>();
            try
            {
                objSolicitudDetaData = new SolicitudDetaData();
                lstSolicitudDetaEntity = objSolicitudDetaData.ListarPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstSolicitudDetaEntity;
        }

        public ReturnValor RegistrarSolicitudDeta(SolicitudDetaEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudDetaData = new SolicitudDetaData();
                objReturnValor.Exitosa = objSolicitudDetaData.Registrar(objPlantillaDetaEntity);
                if (objReturnValor.Exitosa)
                {
                    objReturnValor.Message = HelpMessages.Evento_NEW;
                    //tx.Complete();
                }
                //}
            }
            catch (Exception ex)
            {
                objReturnValor = HelpException.mTraerMensaje(ex);
            }
            return objReturnValor;
        }

        public ReturnValor ActualizarSolicitudDeta(SolicitudDetaEntity objPlantillaDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudDetaData = new SolicitudDetaData();
                objReturnValor.Exitosa = objSolicitudDetaData.Actualizar(objPlantillaDetaEntity);
                if (objReturnValor.Exitosa)
                {
                    objReturnValor.Message = HelpMessages.Evento_EDIT;
                    //tx.Complete();
                }
                //}
            }
            catch (Exception ex)
            {
                objReturnValor = HelpException.mTraerMensaje(ex);
            }
            return objReturnValor;
        }

        public ReturnValor EliminarSolicitudDeta(Parametro objParametro)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudDetaData = new SolicitudDetaData();
                objReturnValor.Exitosa = objSolicitudDetaData.Eliminar(objParametro);
                if (objReturnValor.Exitosa)
                {
                    objReturnValor.Message = HelpMessages.Evento_DELETE;
                    //tx.Complete();
                }
                //}
            }
            catch (Exception ex)
            {
                objReturnValor = HelpException.mTraerMensaje(ex);
            }
            return objReturnValor;
        }

    } 
} 
