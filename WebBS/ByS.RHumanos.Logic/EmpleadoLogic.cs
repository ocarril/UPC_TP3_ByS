using System;
using System.Collections.Generic;
using System.Configuration;
//using System.Transactions;

using ByS.RHumanos.Data;
using ByS.RHumanos.Entities;
using ByS.Tools;

namespace ByS.RHumanos.Logic
{ 
	/// <summary>
	/// Proyecto    :  Modulo de Mantenimiento de : 
	/// Creacion    : CROM - Orlando Carril Ramírez
	/// Fecha       : 26/11/2015-12:29:08 a.m.
	/// Descripcion : Capa de Lógica 
	/// Archivo     : [RecursosHumanos.EmpleadoLogic.cs]
	/// </summary>
	public class EmpleadoLogic
	{ 
		private EmpleadoData oEmpleadoData = null;
        private AreaData objAreaData = null;
		private ReturnValor oReturnValor = null;
		public EmpleadoLogic()
		{
			oEmpleadoData = new EmpleadoData();
			oReturnValor = new ReturnValor();
		}

        #region /* Proceso de SELECT ALL */

        /// <summary>
        /// Retorna un LISTA de registros de la Entidad RecursosHumanos.Empleado
        /// En la BASE de DATO la Tabla : [RecursosHumanos.Empleado]
        /// <summary>
        /// <returns>List</returns>
        public List<EmpleadoEntityDTO> ListarEmpleado(ParametroRH pFiltro)
        {
            List<EmpleadoEntityDTO> lstEmpleadoEntityDTO = new List<EmpleadoEntityDTO>();
            try
            {
                lstEmpleadoEntityDTO = oEmpleadoData.Listar(pFiltro);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstEmpleadoEntityDTO;
        }

        #endregion 

        #region /* Proceso de SELECT BY ID CODE */

        /// <summary>
        /// Retorna una ENTIDAD de registro de la Entidad RecursosHumanos.Empleado
        /// En la BASE de DATO la Tabla : [RecursosHumanos.Empleado]
        /// <summary>
        /// <returns>Entidad</returns>
        public EmpleadoEntity BuscarPorLogin(string codLogin)
        {
            EmpleadoEntity objEmpleadoEntity = new EmpleadoEntity();
            try
            {
                objEmpleadoEntity = oEmpleadoData.BuscarPorLogin(codLogin);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objEmpleadoEntity;
        }

        #endregion 

        #region /* Proceso de LISTAR LAS AREAS DE LA EMPRESA */

        /// <summary>
        /// Retorna un LISTA de registros de la Entidad RecursosHumanos.Empleado
        /// En la BASE de DATO la Tabla : [RecursosHumanos.Empleado]
        /// <summary>
        /// <returns>List</returns>
        public List<AreaEntity> ListarAreas()
        {
            List<AreaEntity> lstAreaEntity = new List<AreaEntity>();
            try
            {
                objAreaData= new AreaData();
                 lstAreaEntity = objAreaData.Listar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstAreaEntity;
        }

        #endregion 

	} 
} 
