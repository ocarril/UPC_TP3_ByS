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
        private PlantillaData oPlantillaData = null;
        private PlantillaDetaData oPlantillaDetaData = null;
        private PartidaData objPartidaData = null;
        private PresupuestoData objPresupuestoData = null;
        private ReturnValor oReturnValor = null;

        public InformeLogic()
        {
            oReturnValor = new ReturnValor();
        }
        #region /* Proceso de SELECT ALL */
        public List<PlantillaDetaEntityDTO> ListarPlantillaDetalle(Parametro pLista)
        {
            List<PlantillaDetaEntityDTO> lstPlantillaDetaEntityDTO = new List<PlantillaDetaEntityDTO>();
            try
            {
                oPlantillaDetaData = new PlantillaDetaData();
                //lstPlantillaDetaEntityDTO = oPlantillaDetaData.Listar(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstPlantillaDetaEntityDTO;
        }

        #endregion
    }
} 
