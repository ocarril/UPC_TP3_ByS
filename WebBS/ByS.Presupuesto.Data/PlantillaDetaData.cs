using System;
using System.Collections.Generic;
using System.Configuration;
using log4net;

using ByS.Presupuesto.Entities;

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
        public List<PlantillaDetaEntity> Listar(Parametro pFiltro)
        {
            List<PlantillaDetaEntity> lstPlantillaDetaEntity = new List<PlantillaDetaEntity>();
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
                        PlantillaDetaEntity objPlantillaDetaEntity= new PlantillaDetaEntity();
                        objPlantillaDetaEntity.Codigo = item.codPlantillaDeta;
                        objPlantillaDetaEntity.codPlantilla = item.codPlantilla;
                        objPlantillaDetaEntity.codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0;
                        objPlantillaDetaEntity.gloDescripcion = item.gloDescripcion;
                        objPlantillaDetaEntity.monEstimado = item.monEstimado;
                        objPlantillaDetaEntity.cntCantidad = item.cntCantidad;
                        objPlantillaDetaEntity.codRegEstado = item.codRegEstado;
                        objPlantillaDetaEntity.fecEjecucion = item.fecEjecucion;
                        objPlantillaDetaEntity.codPartida = item.codPartida;
                        objPlantillaDetaEntity.numPartida = item.numPartida;
                        objPlantillaDetaEntity.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;
                        objPlantillaDetaEntity.codEmpleadoRespon = item.codEmpleadoRespon.HasValue?item.codEmpleadoRespon.Value:0;
                        objPlantillaDetaEntity.objPlantilla.Codigo = item.codEmpleadoRespon.HasValue?item.codEmpleadoRespon.Value:0;
                        objPlantillaDetaEntity.objPlantilla.objEmpleado.desNombre = item.codEmpleadoResponRespon;
                        objPlantillaDetaEntity.objPartida.desNombre = item.codPartidaNombre;
                        objPlantillaDetaEntity.indPlantilla = item.indPlantillaTipo;
                        objPlantillaDetaEntity.codRegEstadoNombre = item.codRegEstadoNombre;
                        objPlantillaDetaEntity.objPlantilla.codArea = item.codArea;
                        objPlantillaDetaEntity.objPlantilla.objArea.desNombre = item.codAreaNombre;
                        objPlantillaDetaEntity.segUsuarioCrea = item.segUsuarioCrea;
                        objPlantillaDetaEntity.segFechaCrea = item.segFechaCrea;
                        objPlantillaDetaEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objPlantillaDetaEntity.segFechaEdita = item.segFechaEdita;
                        objPlantillaDetaEntity.segMaquinaOrigen = item.segMaquinaOrigen;

                        lstPlantillaDetaEntity.Add(objPlantillaDetaEntity);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstPlantillaDetaEntity;
        }

        public List<PlantillaDetaEntity> ListarPaginado(Parametro pFiltro)
        {
            List<PlantillaDetaEntity> lstPlantillaDetaEntity = new List<PlantillaDetaEntity>();
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
                        PlantillaDetaEntity objPlantillaDetaEntity = new PlantillaDetaEntity();
                        objPlantillaDetaEntity.Codigo = item.codPlantillaDeta;
                        objPlantillaDetaEntity.codPlantilla = item.codPlantilla;
                        objPlantillaDetaEntity.codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0;
                        objPlantillaDetaEntity.gloDescripcion = item.gloDescripcion;
                        objPlantillaDetaEntity.monEstimado = item.monEstimado;
                        objPlantillaDetaEntity.cntCantidad = item.cntCantidad;
                        objPlantillaDetaEntity.codRegEstado = item.codRegEstado;
                        objPlantillaDetaEntity.fecEjecucion = item.fecEjecucion;
                        objPlantillaDetaEntity.codPartida = item.codPartida;
                        objPlantillaDetaEntity.numPartida = item.numPartida;
                        objPlantillaDetaEntity.codEmpleadoRespon = item.codEmpleadoRespon.HasValue ? item.codEmpleadoRespon.Value : 0;
                        objPlantillaDetaEntity.indPlantilla = item.indPlantillaTipo;
                        objPlantillaDetaEntity.segUsuarioCrea = item.segUsuarioCrea;
                        objPlantillaDetaEntity.segFechaCrea = item.segFechaCrea;
                        objPlantillaDetaEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objPlantillaDetaEntity.segFechaEdita = item.segFechaEdita;
                        objPlantillaDetaEntity.segMaquinaOrigen = item.segMaquinaOrigen;
                        objPlantillaDetaEntity.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;
                        objPlantillaDetaEntity.objEmpleadoRespon.desNombre = item.codEmpleadoResponRespon;
                        objPlantillaDetaEntity.objPlantilla.codArea = item.codArea;
                        objPlantillaDetaEntity.objPlantilla.objArea.desNombre = item.codAreaNombre;
                        objPlantillaDetaEntity.objPartida.desNombre = item.codPartidaNombre;
                        objPlantillaDetaEntity.codRegEstadoNombre = item.codRegEstadoNombre;
                        objPlantillaDetaEntity.ROW = item.ROWNUM.HasValue ? item.ROWNUM.Value : 0;
                        objPlantillaDetaEntity.TOTALROWS = item.TOTALROWS.HasValue ? item.TOTALROWS.Value : 0;

                        lstPlantillaDetaEntity.Add(objPlantillaDetaEntity);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ListarPaginado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstPlantillaDetaEntity;
        }

        public List<PlantillaDetaEntity> ListarPorEjecutarPaginado(Parametro pFiltro)
        {
            List<PlantillaDetaEntity> lstPlantillaDetaEntity = new List<PlantillaDetaEntity>();
            try
            {
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_PlantillaDetaPendPagina(pFiltro.p_NumPagina,
                                                               pFiltro.p_TamPagina,
                                                               pFiltro.p_OrdenPor,
                                                               pFiltro.p_OrdenTipo,
                                                               pFiltro.numAnio,
                                                               pFiltro.codArea,
                                                               pFiltro.codRegEstado);
                    foreach (var item in resul)
                    {
                        PlantillaDetaEntity objPlantillaDetaEntity = new PlantillaDetaEntity();
                        objPlantillaDetaEntity.Codigo = item.codPlantillaDeta;
                        objPlantillaDetaEntity.codPlantilla = item.codPlantilla;
                        objPlantillaDetaEntity.codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0;
                        objPlantillaDetaEntity.gloDescripcion = item.gloDescripcion;
                        objPlantillaDetaEntity.monEstimado = item.monEstimado;
                        objPlantillaDetaEntity.cntCantidad = item.cntCantidad;
                        objPlantillaDetaEntity.codRegEstado = item.codRegEstado;
                        objPlantillaDetaEntity.fecEjecucion = item.fecEjecucion;
                        objPlantillaDetaEntity.codPartida = item.codPartida;
                        objPlantillaDetaEntity.numPartida = item.numPartida;
                        objPlantillaDetaEntity.codEmpleadoRespon = item.codEmpleadoRespon.HasValue ? item.codEmpleadoRespon.Value : 0;
                        objPlantillaDetaEntity.indPlantilla = item.indPlantillaTipo;
                        objPlantillaDetaEntity.segUsuarioCrea = item.segUsuarioCrea;
                        objPlantillaDetaEntity.segFechaCrea = item.segFechaCrea;
                        objPlantillaDetaEntity.segUsuarioEdita = item.segUsuarioEdita;
                        objPlantillaDetaEntity.segFechaEdita = item.segFechaEdita;
                        objPlantillaDetaEntity.segMaquinaOrigen = item.segMaquinaOrigen;
                        objPlantillaDetaEntity.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;
                        objPlantillaDetaEntity.objEmpleadoRespon.desNombre = item.codEmpleadoResponRespon;
                        objPlantillaDetaEntity.objPlantilla.codArea = item.codArea;
                        objPlantillaDetaEntity.objPlantilla.objArea.desNombre = item.codAreaNombre;
                        objPlantillaDetaEntity.objPartida.desNombre = item.codPartidaNombre;
                        objPlantillaDetaEntity.codRegEstadoNombre = item.codRegEstadoNombre;
                        objPlantillaDetaEntity.ROW = item.ROWNUM.HasValue ? item.ROWNUM.Value : 0;
                        objPlantillaDetaEntity.TOTALROWS = item.TOTALROWS.HasValue ? item.TOTALROWS.Value : 0;

                        lstPlantillaDetaEntity.Add(objPlantillaDetaEntity);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ListarPaginado", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstPlantillaDetaEntity;
        }
       
        #endregion 

		#region /* Proceso de SELECT BY ID CODE */ 

		/// <summary>
		/// Retorna una ENTIDAD de registro de la Entidad Presupuesto.PlantillaDeta
		/// En la BASE de DATO la Tabla : [Presupuesto.PlantillaDeta]
		/// <summary>
		/// <returns>Entidad</returns>
        public PlantillaDetaEntity Buscar(int pId)
		{
            PlantillaDetaEntity objPlantillaDetaEntity = null;
			try
			{
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
			{
				var resul = SQLDC.pa_S_PlantillaDeta(pId,null,null,null);
				foreach (var item in resul)
				{
                    objPlantillaDetaEntity = new PlantillaDetaEntity();
                    objPlantillaDetaEntity.Codigo = item.codPlantillaDeta;
                    objPlantillaDetaEntity.codPlantilla = item.codPlantilla;
                    objPlantillaDetaEntity.codEmpleadoAprueba = item.codEmpleadoAprueba.HasValue ? item.codEmpleadoAprueba.Value : 0;
                    objPlantillaDetaEntity.gloDescripcion = item.gloDescripcion;
                    objPlantillaDetaEntity.monEstimado = item.monEstimado;
                    objPlantillaDetaEntity.cntCantidad = item.cntCantidad;
                    objPlantillaDetaEntity.codRegEstado = item.codRegEstado;
                    objPlantillaDetaEntity.fecEjecucion = item.fecEjecucion;
                    objPlantillaDetaEntity.indPlantilla = item.indPlantilla;
                    objPlantillaDetaEntity.codPartida = item.codPartida;
                    objPlantillaDetaEntity.numPartida = item.numPartida;
                    objPlantillaDetaEntity.codEmpleadoRespon = item.codEmpleadoRespon.HasValue ? item.codEmpleadoRespon.Value : 0;
                    objPlantillaDetaEntity.segUsuarioCrea = item.segUsuarioCrea;
                    objPlantillaDetaEntity.segFechaCrea = item.segFechaCrea;
                    objPlantillaDetaEntity.segUsuarioEdita = item.segUsuarioEdita;
                    objPlantillaDetaEntity.segFechaEdita = item.segFechaEdita;
                    objPlantillaDetaEntity.segMaquinaOrigen = item.segMaquinaOrigen;

                    objPlantillaDetaEntity.objEmpleadoAprueba.desNombre = item.codEmpleadoApruebaNombre;
                    objPlantillaDetaEntity.objPlantilla.Codigo = item.codEmpleadoRespon.HasValue ? item.codEmpleadoRespon.Value : 0;
                    objPlantillaDetaEntity.objPlantilla.objEmpleado.desNombre = item.codEmpleadoResponRespon;
                    objPlantillaDetaEntity.objPlantilla.codArea = item.codArea;
                    objPlantillaDetaEntity.objPlantilla.objArea.desNombre = item.codAreaNombre;
                    objPlantillaDetaEntity.objPartida.desNombre = item.codPartidaNombre;
                    objPlantillaDetaEntity.codRegEstadoNombre = item.codRegEstadoNombre;
				}
			}
		}
		catch (Exception ex)
		{
            log.Error(String.Concat("Buscar", " | ", ex.Message.ToString()));
			throw ex;
		}
		return objPlantillaDetaEntity;
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
