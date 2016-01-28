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
	/// Archivo     : [Presupuesto.PlantillaDetaData.cs]
	/// </summary>
	public class PlantillaDetaData
	{
        private static readonly ILog log = LogManager.GetLogger(typeof(PlantillaDetaData));
        private string conexion = string.Empty;

		public PlantillaDetaData()
		{
            conexion = Util.ConexionBD();
		}

		#region /* Proceso de SELECT ALL */ 

		/// <summary>
		/// Retorna un LISTA de registros de la Entidad Presupuesto.PlantillaDeta
		/// En la BASE de DATO la Tabla : [Presupuesto.PlantillaDeta]
		/// <summary>
		/// <returns>List</returns>
        public List<PlantillaDetaEntityDTO> Listar(Parametro pFiltro)
        {
            List<PlantillaDetaEntityDTO> lstPlantillaDetaEntityDTO = new List<PlantillaDetaEntityDTO>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_PlantillaDeta(pFiltro.codPlantillaDeta, 
                                                         pFiltro.numAnio, 
                                                         pFiltro.codArea, 
                                                         pFiltro.codRegEstado);
                    foreach (var item in resul)
                    {
                        lstPlantillaDetaEntityDTO.Add(new PlantillaDetaEntityDTO()
                        {
                            codPlantillaDeta = item.codPlantillaDeta,
                            codPlantilla = item.codPlantilla,
                            codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0,
                            gloDescripcion = item.gloDescripcion,
                            monEstimado = Convert.ToDecimal(item.monEstimado),
                            cntCantidad = Convert.ToDecimal(item.cntCantidad),
                            codRegEstado = item.codRegEstado,
                            fecEjecucion = item.fecEjecucion.HasValue ? item.fecEjecucion.Value.ToShortDateString() : string.Empty,
                            indPlantilla = item.indPlantilla,
                            codPartida = item.codPartida,
                            numPartida = item.numPartida,

                            segMaquinaOrigen = item.segMaquinaOrigen,

                            codEmpleadoApruebaNombre = item.codEmpleadoApruebaNombre,
                            codEmpleadoResponNombre = item.codEmpleadoResponRespon,
                            codEmpleadoRespon = item.codEmpleadoRespon,
                            codPartidaNombre = item.codPartidaNombre,
                            indPlantillaNombre = item.indPlantillaTipo,
                            codRegEstadoNombre = item.codRegEstadoNombre,
                            codArea = item.codArea,
                            codAreaNombre = item.codAreaNombre,

                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString(),
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstPlantillaDetaEntityDTO;
        }

        public List<PlantillaDetaEntityDTO> ListarPaginado(Parametro pFiltro)
        {
            List<PlantillaDetaEntityDTO> lstPlantillaDetaEntityDTO = new List<PlantillaDetaEntityDTO>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_PlantillaDetaPagina(pFiltro.p_NumPagina, 
                                                               pFiltro.p_TamPagina,
                                                               pFiltro.p_OrdenPor,
                                                               pFiltro.p_OrdenTipo, 
                                                               pFiltro.numAnio, 
                                                               pFiltro.codArea,
                                                               pFiltro.codRegEstado);
                    foreach (var item in resul)
                    {
                        lstPlantillaDetaEntityDTO.Add(new PlantillaDetaEntityDTO()
                        {
                            codPlantillaDeta = item.codPlantillaDeta,
                            codPlantilla = item.codPlantilla,
                            codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0,
                            gloDescripcion = item.gloDescripcion,
                            monEstimado = Convert.ToDecimal(item.monEstimado),
                            cntCantidad = Convert.ToDecimal(item.cntCantidad),
                            codRegEstado = item.codRegEstado,
                            fecEjecucion = item.fecEjecucion.HasValue ? item.fecEjecucion.Value.ToShortDateString() : string.Empty,
                            indPlantilla = item.indPlantilla,
                            codPartida = item.codPartida,
                            numPartida = item.numPartida,

                            segUsuarioEdita = string.IsNullOrEmpty(item.segUsuarioEdita) ? item.segUsuarioCrea : item.segUsuarioEdita,
                            segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : item.segFechaCrea.ToString(),

                            segMaquinaOrigen = item.segMaquinaOrigen,

                            codEmpleadoApruebaNombre = item.codEmpleadoResponNombre,
                            codEmpleadoResponNombre = item.codEmpleadoResponRespon,
                            codEmpleadoRespon = item.codEmpleadoRespon,
                            codPartidaNombre = item.codPartidaNombre,
                            indPlantillaNombre = item.indPlantillaTipo,
                            codRegEstadoNombre = item.codRegEstadoNombre,
                            codArea = item.codArea,
                            codAreaNombre = item.codAreaNombre,

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
            return lstPlantillaDetaEntityDTO;
        }
       
        #endregion 

		#region /* Proceso de SELECT BY ID CODE */ 

		/// <summary>
		/// Retorna una ENTIDAD de registro de la Entidad Presupuesto.PlantillaDeta
		/// En la BASE de DATO la Tabla : [Presupuesto.PlantillaDeta]
		/// <summary>
		/// <returns>Entidad</returns>
        public PlantillaDetaEntityDTO Buscar(int pId)
		{
            PlantillaDetaEntityDTO objPlantillaDetaEntityDTO = new PlantillaDetaEntityDTO();
			try
			{
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
			{
				var resul = SQLDC.pa_S_PlantillaDeta(pId,null,null,null);
				foreach (var item in resul)
				{
                    objPlantillaDetaEntityDTO = new PlantillaDetaEntityDTO()
					{
                        codPlantillaDeta = item.codPlantillaDeta,
                        codPlantilla = item.codPlantilla,
                        codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0,
                        gloDescripcion = item.gloDescripcion,
                        monEstimado = Convert.ToDecimal(item.monEstimado),
                        cntCantidad = Convert.ToDecimal(item.cntCantidad),
                        codRegEstado = item.codRegEstado,
                        fecEjecucion = item.fecEjecucion.HasValue ? item.fecEjecucion.Value.ToString() : string.Empty,
                        indPlantilla = item.indPlantilla,
                        codPartida = item.codPartida,
                        numPartida = item.numPartida,
                        segUsuarioCrea = item.segUsuarioCrea,
                        segUsuarioEdita = item.segUsuarioEdita,
                        segFechaCrea = item.segFechaCrea.ToString(),
                        segFechaEdita = item.segFechaEdita.HasValue ? item.segFechaEdita.Value.ToString() : string.Empty,
                        segMaquinaOrigen = item.segMaquinaOrigen,

                        codEmpleadoApruebaNombre = item.codEmpleadoApruebaNombre,
                        codEmpleadoResponNombre = item.codEmpleadoResponRespon,
                        codEmpleadoRespon = item.codEmpleadoRespon,
                        codPartidaNombre = item.codPartidaNombre,
                        indPlantillaNombre = item.indPlantillaTipo,
                        codRegEstadoNombre = item.codRegEstadoNombre
					};
				}
			}
		}
		catch (Exception ex)
		{
            log.Error(String.Concat("Buscar", " | ", ex.Message.ToString()));
			throw ex;
		}
		return objPlantillaDetaEntityDTO;
}
		
        #endregion 

		#region /* Proceso de INSERT RECORD */ 

		/// <summary>
		/// Almacena el registro de una ENTIDAD de registro de Tipo PlantillaDeta
		/// En la BASE de DATO la Tabla : [Presupuesto.PlantillaDeta]
		/// <summary>
		/// <param name = >itemPlantillaDeta</param>
        public bool Registrar(PlantillaDetaEntity objPlantillaDetaEntity)
		{
			int? codigoRetorno = -1;
			try
			{
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
				{
					 SQLDC.pa_I_PlantillaDeta(
                        ref codigoRetorno,
                        objPlantillaDetaEntity.codPlantilla,
                        objPlantillaDetaEntity.gloDescripcion,
                        objPlantillaDetaEntity.monEstimado,
                        objPlantillaDetaEntity.cntCantidad,
                        objPlantillaDetaEntity.fecEjecucion,
                        objPlantillaDetaEntity.indPlantilla,
                        objPlantillaDetaEntity.codPartida,
                        objPlantillaDetaEntity.segUsuarioCrea,
                        objPlantillaDetaEntity.segMaquinaOrigen);

                     objPlantillaDetaEntity.Codigo = codigoRetorno.Value;
				}
			}
			catch (Exception ex)
			{
                log.Error(String.Concat("Registrar", " | ", ex.Message.ToString()));
				throw ex;
			}
			return codigoRetorno > 0 ? true : false;
		}

        /// <summary>
        /// Almacena el registro de una ENTIDAD de registro de Tipo PlantillaDeta
        /// En la BASE de DATO la Tabla : [Presupuesto.PlantillaDeta]
        /// <summary>
        /// <param name = >itemPlantillaDeta</param>
        public bool RegistrarPorReferencia(List<PlantillaDetaEntity> lstPlantillaDetaEntity)
        {
            int? codigoRetorno = -1;
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    foreach (PlantillaDetaEntity objPlantillaDetaEntity in lstPlantillaDetaEntity)
                    {
                        SQLDC.pa_I_PlantillaDetaRefer(
                           ref codigoRetorno,
                           objPlantillaDetaEntity.Codigo,
                           objPlantillaDetaEntity.codPlantilla,
                           objPlantillaDetaEntity.segUsuarioCrea,
                           objPlantillaDetaEntity.segMaquinaOrigen);

                        objPlantillaDetaEntity.Codigo = codigoRetorno.Value;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("RegistrarPorReferencia", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno > 0 ? true : false;
        }
		#endregion 

		#region /* Proceso de UPDATE RECORD */ 

		/// <summary>
		/// Almacena el registro de una ENTIDAD de registro de Tipo PlantillaDeta
		/// En la BASE de DATO la Tabla : [Presupuesto.PlantillaDeta]
		/// <summary>
		/// <param name = >itemPlantillaDeta</param>
        public bool Actualizar(PlantillaDetaEntity itemPlantillaDeta)
		{
			int codigoRetorno = -1;
			try
			{
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
				{
					codigoRetorno = SQLDC.pa_U_PlantillaDeta(
						itemPlantillaDeta.Codigo,
						itemPlantillaDeta.gloDescripcion,
						itemPlantillaDeta.monEstimado,
						itemPlantillaDeta.cntCantidad,
						itemPlantillaDeta.fecEjecucion,
						itemPlantillaDeta.codPartida,
						itemPlantillaDeta.segUsuarioEdita,
						itemPlantillaDeta.segMaquinaOrigen);
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
		/// ELIMINA un registro de la Entidad Presupuesto.PlantillaDeta
		/// En la BASE de DATO la Tabla : [Presupuesto.PlantillaDeta]
		/// <summary>
		/// <returns>bool</returns>
		public bool Eliminar(Parametro pFiltro)
		{
			int codigoRetorno = -1;
			try
			{
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
				{
					  SQLDC.pa_D_PlantillaDeta(pFiltro.codPlantillaDeta, 
                                                             pFiltro.segUsuElimina,
                                                             pFiltro.segMaquinaPC);
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
