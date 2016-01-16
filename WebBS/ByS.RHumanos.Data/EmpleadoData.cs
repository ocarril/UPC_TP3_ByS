using System;
using System.Collections.Generic;
using System.Configuration;
using log4net;

using ByS.RHumanos.Entities;

namespace ByS.RHumanos.Data
{ 
	/// <summary>
	/// Proyecto    :  Modulo de Mantenimiento de : 
	/// Creacion    : CROM - Orlando Carril Ramírez
	/// Fecha       : 26/11/2015-12:29:08 a.m.
	/// Descripcion : Capa de Datos 
	/// Archivo     : [RecursosHumanos.EmpleadoData.cs]
	/// </summary>
	public class EmpleadoData
	{
        private static readonly ILog log = LogManager.GetLogger(typeof(AreaData));
		private string conexion = string.Empty;

		public EmpleadoData()
		{
            conexion = Util.ConexionBD();
		}
       
        #region /* Proceso de SELECT ALL */

        /// <summary>
        /// Retorna un LISTA de registros de la Entidad RecursosHumanos.Empleado
        /// En la BASE de DATO la Tabla : [RecursosHumanos.Empleado]
        /// <summary>
        /// <returns>List</returns>
        public List<EmpleadoEntityDTO> Listar(ParametroRH pFiltro)
        {
            List<EmpleadoEntityDTO> lstEmpleadoEntityDTO = new List<EmpleadoEntityDTO>();
            try
            {
                using (_DBMLRHumanosDataContext SQLDC = new _DBMLRHumanosDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Empleado(pFiltro.codEmpleado,
                                                    pFiltro.codArea,
                                                    pFiltro.desNombre,
                                                    pFiltro.desApellido);
                    foreach (var item in resul)
                    {
                        lstEmpleadoEntityDTO.Add(new EmpleadoEntityDTO()
                        {
                            codEmpleado = item.codEmpleado,
                            codPersona = item.codPersona,
                            codCargo = item.codCargo,
                            codArea = item.codArea,
                            desNombre = item.desNombre,
                            desApellido = item.desApellido,
                            indActivo = item.indActivo,
                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita)?item.segUsuarioCrea:item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue?item.segFechaEdita.Value.ToString():item.segFechaCrea.ToString(),
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
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
                using (_DBMLRHumanosDataContext SQLDC = new _DBMLRHumanosDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_EmpleadoLogin(codLogin);
                    foreach (var item in resul)
                    {
                        objEmpleadoEntity = new EmpleadoEntity()
                        {
                            Codigo = item.codEmpleado,
                            codCargo = item.codCargo,
                            codArea = item.codArea,
                            desNombre = item.desNombre,
                            desApellido = item.desApellido,
                           
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("BuscarPorLogin", " | ", ex.Message.ToString()));
                throw ex;
            }
            return objEmpleadoEntity;
        }
        #endregion 

    } 
} 
