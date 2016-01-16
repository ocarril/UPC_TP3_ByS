using System;
using System.Collections.Generic;
using System.Configuration;

using ByS.Presupuesto.Entities;
using ByS.Presupuesto.Entities.DTO;
using log4net;

namespace ByS.Presupuesto.Data
{ 

	/// <summary>
	/// Proyecto    :  Modulo de Mantenimiento de : 
	/// Creacion    : CROM - Orlando Carril Ramírez
	/// Fecha       : 26/11/2015-12:29:08 a.m.
	/// Descripcion : Capa de Datos 
	/// Archivo     : [Presupuesto.GastoData.cs]
	/// </summary>
	public class GastoData
	{
        private static readonly ILog log = LogManager.GetLogger(typeof(GastoData));
		private string conexion = string.Empty;
		public GastoData()
		{
            conexion = Util.ConexionBD();
		}
		
        #region /* Proceso de SELECT ALL */ 

		/// <summary>
		/// Retorna un LISTA de registros de la Entidad Presupuesto.Gasto
		/// En la BASE de DATO la Tabla : [Presupuesto.Gasto]
		/// <summary>
		/// <returns>List</returns>
        public List<GastoEntityDTO> Listar(Parametro pFiltro)
        {
            List<GastoEntityDTO> lstGastoEntityDTO = new List<GastoEntityDTO>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Gasto(pFiltro.codGasto, pFiltro.codPlantillaDeta);
                    foreach (var item in resul)
                    {
                        lstGastoEntityDTO.Add(new GastoEntityDTO()
                        {
                            codGasto = item.codGasto,
                            codPlantillaDeta = item.codPlantillaDeta,
                            monTotal = item.monTotal,
                            cntCantidad = item.cntCantidad,
                            numDocumento = item.numDocumento,
                            gloObservacion = item.gloObservacion,
                            fecGasto = item.fecGasto.ToShortDateString(),
                            codEmpleadoResp = item.codEmpleadoResp,
                            codEmpleadoRespNombre = item.codEmpleadoRespNombre,
                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString(),
                            segMaquinaOrigen = item.segMaquinaOrigen,
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstGastoEntityDTO;
        }

        public List<GastoEntityDTO> ListarPaginado(Parametro pFiltro)
        {
            List<GastoEntityDTO> lstGastoEntityDTO = new List<GastoEntityDTO>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_GastoPagina(pFiltro.p_NumPagina, 
                                                       pFiltro.p_TamPagina, 
                                                       pFiltro.p_OrdenPor, 
                                                       pFiltro.p_OrdenTipo, 
                                                       pFiltro.codGasto, 
                                                       pFiltro.codPlantillaDeta);
                    foreach (var item in resul)
                    {
                        lstGastoEntityDTO.Add(new GastoEntityDTO()
                        {
                            codGasto = item.codGasto,
                            codPlantillaDeta = item.codPlantillaDeta,
                            monTotal = item.monTotal,
                            cntCantidad = item.cntCantidad,
                            numDocumento = item.numDocumento,
                            gloObservacion = item.gloObservacion,
                            fecGasto = item.fecGasto.ToShortDateString(),
                            codEmpleadoResp = item.codEmpleadoResp,
                            codEmpleadoRespNombre = item.codEmpleadoRespNombre,
                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString(),
                            segMaquinaOrigen = item.segMaquinaOrigen,

                            ROW = item.ROWNUM.HasValue ? item.ROWNUM.Value : 0,
                            TOTALROWS = item.TOTALROWS.HasValue ? item.TOTALROWS.Value : 0
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ListarPaginado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstGastoEntityDTO;
        }
		
        #endregion 

		#region /* Proceso de SELECT BY ID CODE */ 

		/// <summary>
		/// Retorna una ENTIDAD de registro de la Entidad Presupuesto.Gasto
		/// En la BASE de DATO la Tabla : [Presupuesto.Gasto]
		/// <summary>
		/// <returns>Entidad</returns>
		public GastoEntityDTO Buscar(int pcodGasto)
		{
            GastoEntityDTO objGastoEntityDTO = new GastoEntityDTO();
			try
			{
			using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
			{
				var resul = SQLDC.pa_S_Gasto(pcodGasto,null);
				foreach (var item in resul)
				{
                    objGastoEntityDTO = new GastoEntityDTO()
					{
                        codGasto = item.codGasto,
                        codPlantillaDeta = item.codPlantillaDeta,
                        monTotal = item.monTotal,
                        cntCantidad = item.cntCantidad,
                        numDocumento = item.numDocumento,
                        gloObservacion = item.gloObservacion,
                        fecGasto = item.fecGasto.ToShortDateString(),
                        codEmpleadoResp = item.codEmpleadoResp,
                        codEmpleadoRespNombre = item.codEmpleadoRespNombre,
                        segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                        segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString(),
                        segMaquinaOrigen = item.segMaquinaOrigen,
					};
				}
			}
		}
		catch (Exception ex)
		{
            log.Error(String.Concat("Buscar", " | ", ex.Message.ToString()));
            throw ex;
		}
		return objGastoEntityDTO;
}
		#endregion 

		#region /* Proceso de INSERT RECORD */ 

		/// <summary>
		/// Almacena el registro de una ENTIDAD de registro de Tipo Gasto
		/// En la BASE de DATO la Tabla : [Presupuesto.Gasto]
		/// <summary>
		/// <param name = >itemGasto</param>
		public bool Registrar( GastoEntity pGasto )
		{
			int? codigoRetorno = -1;
			try
			{
				using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
				{
					 SQLDC.pa_I_Gasto(
						ref codigoRetorno,
						pGasto.codPlantillaDeta,
						pGasto.monTotal,
						pGasto.cntCantidad,
						pGasto.numDocumento,
						pGasto.gloObservacion,
						pGasto.fecGasto,
						pGasto.codEmpleadoResp,
						pGasto.segUsuarioCrea,
						pGasto.segMaquinaOrigen);
				}
			}
			catch (Exception ex)
			{
                log.Error(String.Concat("Registrar", " | ", ex.Message.ToString()));
                throw ex;
			}
			return codigoRetorno > 0 ? true : false;
		}
		#endregion 

		#region /* Proceso de UPDATE RECORD */ 

		/// <summary>
		/// Almacena el registro de una ENTIDAD de registro de Tipo Gasto
		/// En la BASE de DATO la Tabla : [Presupuesto.Gasto]
		/// <summary>
		/// <param name = >itemGasto</param>
        public bool Actualizar(GastoEntity itemGasto)
        {
            int codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    SQLDC.pa_U_Gasto(
                        itemGasto.Codigo,
                        itemGasto.monTotal,
                        itemGasto.cntCantidad,
                        itemGasto.numDocumento,
                        itemGasto.gloObservacion,
                        itemGasto.fecGasto,
                        itemGasto.codEmpleadoResp,
                        itemGasto.segUsuarioEdita,
                        itemGasto.segMaquinaOrigen);
                    codigoRetorno = 0;
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Actualizar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno == 0 ? true : false;
        }
		#endregion 

		#region /* Proceso de DELETE BY ID CODE */ 

		/// <summary>
		/// ELIMINA un registro de la Entidad Presupuesto.Gasto
		/// En la BASE de DATO la Tabla : [Presupuesto.Gasto]
		/// <summary>
		/// <returns>bool</returns>
        public bool Eliminar(Parametro pFiltro)
		{
			int codigoRetorno = -1;
			try
			{
				using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
				{
                     SQLDC.pa_D_Gasto(pFiltro.codGasto, pFiltro.segUsuElimina, pFiltro.segMaquinaPC);
                     codigoRetorno = 0;
				}
			}
			catch (Exception ex)
			{
				log.Error(String.Concat("Eliminar", " | ", ex.Message.ToString()));
                throw ex;
			}
			return codigoRetorno == 0 ? true : false;
		}

		#endregion 

	} 
} 
