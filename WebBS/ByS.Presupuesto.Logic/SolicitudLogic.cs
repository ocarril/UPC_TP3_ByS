using System;
using System.Collections.Generic;
using System.Configuration;
//using System.Transactions;

using ByS.Presupuesto.Data;
using ByS.Presupuesto.Entities;
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
        private SolicitudEjecucionData objSolicitudEjecucionData = null;
        private ReturnValor objReturnValor = null;

        public SolicitudLogic()
		{
			objReturnValor = new ReturnValor();
		}
	
        /* Solicitud */
        public SolicitudEntity BuscarSolicitud(int pID)
        {
            SolicitudEntity objSolicitudEntity = null;
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

        public ReturnValor RegistrarSolicitud(SolicitudEntity objSolicitud)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudData = new SolicitudData();
                objReturnValor.Exitosa = objSolicitudData.Registrar(objSolicitud);
                foreach (SolicitudDetaEntity solicitudDeta in objSolicitud.lstSolicitudDeta)
                {
                    solicitudDeta.codSolicitud = objSolicitud.Codigo;
                    solicitudDeta.segMaquinaOrigen = objSolicitud.segMaquinaOrigen;
                    solicitudDeta.segUsuarioCrea = objSolicitud.segUsuarioCrea;
                    RegistrarSolicitudDeta(solicitudDeta);
                }

                objReturnValor.Message = HelpMessages.Evento_NEW;

                if (objReturnValor.Exitosa)
                {
                    try
                    {
                        objSolicitud = BuscarSolicitud(objSolicitud.Codigo);
                        List<string> lstCorreos = new List<string>();
                        List<HelpMailDatos> lstHelpMailDatos = new List<HelpMailDatos>();
                        lstHelpMailDatos.Add(new HelpMailDatos { titulo = "Presupuesto", descripcion = objSolicitud.fecSolicitada.Value.Year.ToString() });
                        lstHelpMailDatos.Add(new HelpMailDatos { titulo = "Area", descripcion = objSolicitud.objEmpleadoGenera.objArea.desNombre.ToString() });
                        lstHelpMailDatos.Add(new HelpMailDatos { titulo = "Responsable", descripcion = objSolicitud.objEmpleadoGenera.desNombre.ToString().ToUpper() });
                        lstHelpMailDatos.Add(new HelpMailDatos { titulo = "Descripcion", descripcion = objSolicitud.gloObservacion });
                        decimal decTotal = 0;
                        decimal cntCanti = 0;
                        string strPartidas = string.Empty;
                        foreach (SolicitudDetaEntity item in objSolicitud.lstSolicitudDeta)
                        {
                            decTotal = decTotal + item.objPlantillaDeta.monEstimado;
                            cntCanti = cntCanti + item.objPlantillaDeta.cntCantidad;
                            strPartidas = strPartidas + ", " + item.objPlantillaDeta.objPartida.desNombre.ToUpper();
                        }
                        lstHelpMailDatos.Add(new HelpMailDatos { titulo = "Partida", descripcion = strPartidas });
                        lstHelpMailDatos.Add(new HelpMailDatos { titulo = "Cantidad", descripcion = cntCanti.ToString() });
                        lstHelpMailDatos.Add(new HelpMailDatos { titulo = "Monto Referencial", descripcion = decTotal.ToString("N2") });

                        String strCuerpoMensaje = HelpMail.CrearCuerpo("Solicitud de Ejecucion de Presupuesto",
                                                                       lstHelpMailDatos,
                                                                       "Ejecución de Presupuesto",
                                                                       "BOTICAS & SALUD");

                        lstCorreos.Add(ConfigurationManager.AppSettings["EMAIL_JefeFinanzas"]);
                        lstCorreos.Add(ConfigurationManager.AppSettings["EMAIL_JefeAreas"]);
                        HelpMail.Enviar("Solicitud de Ejecucion de Presupuesto", strCuerpoMensaje, lstCorreos, false);

                    }
                    catch (Exception exc)
                    {

                        objReturnValor.Message = objReturnValor.Message + "\n No se ha podido enviar Correo Electronico." + exc.Message;
                    }
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

        public ReturnValor ActualizarSolicitud(SolicitudEntity objSolicitud)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudData = new SolicitudData();
                objReturnValor.Exitosa = objSolicitudData.Actualizar(objSolicitud);
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

        public ReturnValor RegistrarSolicitudDeta(SolicitudDetaEntity objSolicitudDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudDetaData = new SolicitudDetaData();
                objReturnValor.Exitosa = objSolicitudDetaData.Registrar(objSolicitudDetaEntity);
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

        public ReturnValor ActualizarSolicitudDeta(SolicitudDetaEntity objSolicitudDetaEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{
                objSolicitudDetaData = new SolicitudDetaData();
                objReturnValor.Exitosa = objSolicitudDetaData.Actualizar(objSolicitudDetaEntity);
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

        public ReturnValor ActualizarSolicitudEjecucion(SolicitudEntity objSolicitudEntity)
        {
            try
            {
                //using (TransactionScope tx = new TransactionScope(TransactionScopeOption.Required))
                //{


                objSolicitudEjecucionData = new SolicitudEjecucionData();
                objReturnValor.Exitosa = objSolicitudEjecucionData.ActualizarSolicitudEjecucion(objSolicitudEntity);
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



    } 
} 
