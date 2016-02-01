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
	/// Creacion    : WRF - Walter Rodriguez
	/// Fecha       : 26/01/2016-12:29:08 a.m.
	/// Descripcion : Capa de Lógica 
	/// Archivo     : [Presupuesto.InformeLogic.cs]
	/// </summary>
    public class InformeLogic
    {

         private InformeData objInformeData = null;
        private ReturnValor oReturnValor = null;

        public InformeLogic()
        {
            oReturnValor = new ReturnValor();
        }
        #region /* Proceso de SELECT ALL */



        public List<InformeEntity> ListarSeguimientoPresupuesto(Parametro pLista)
        {
            List<InformeEntity> lstPlantillaDetaEntity = new List<InformeEntity>();
            try
            {
                objInformeData = new InformeData();
                lstPlantillaDetaEntity = objInformeData.ListarPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaDetaEntity;
        }


        public List<GastoEntity> ListarDetallePaginado(Parametro pLista)
        {
            List<GastoEntity> lstGastoEntity = new List<GastoEntity>();
            try
            {
                objInformeData = new InformeData();
                lstGastoEntity = objInformeData.ListarDetalladoPaginado(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstGastoEntity;
        }
        #endregion
    }
} 
