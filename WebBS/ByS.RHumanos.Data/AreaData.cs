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
	/// Archivo     : [RecursosHumanos.AreaData.cs]
	/// </summary>
	public class AreaData
	{
        private static readonly ILog log = LogManager.GetLogger(typeof(AreaData));
		private string conexion = string.Empty;

		public AreaData()
		{
            conexion = Util.ConexionBD();
		}
		#region /* Proceso de SELECT ALL */ 

		/// <summary>
		/// Retorna un LISTA de registros de la Entidad RecursosHumanos.Area
		/// En la BASE de DATO la Tabla : [RecursosHumanos.Area]
		/// <summary>
		/// <returns>List</returns>
        public List<AreaEntity> Listar()
        {
            List<AreaEntity> lstAreaEntity = new List<AreaEntity>();
            try
            {
                using (_DBMLRHumanosDataContext SQLDC = new _DBMLRHumanosDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Area();
                    foreach (var item in resul)
                    {
                        lstAreaEntity.Add(new AreaEntity()
                        {
                            Codigo = item.codArea,
                            desNombre = item.desNombre,
                            gloDescripcion = item.gloDescripcion,
                            indActivo = item.indActivo,
                            segUsuarioCrea = item.segUsuarioCrea,
                            segUsuarioEdita = item.segUsuarioEdita,
                            segFechaCrea = item.segFechaCrea,
                            segFechaEdita = item.segFechaEdita,
                            segMaquinaOrigen = item.segMaquinaOrigen,
                            indEliminado = item.indEliminado,

                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstAreaEntity;
        }

        #endregion 

        //        #region /* Proceso de SELECT BY ID CODE */ 

//        /// <summary>
//        /// Retorna una ENTIDAD de registro de la Entidad RecursosHumanos.Area
//        /// En la BASE de DATO la Tabla : [RecursosHumanos.Area]
//        /// <summary>
//        /// <returns>Entidad</returns>
//        public Area Find(int prm_codArea)
//        {
//            Area miEntidad = new Area();
//            try
//            {
//            using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//            {
//                var resul = SQLDC.omgc_mnt_GetByIdCodeArea(prm_codArea                   );
//                foreach (var item in resul)
//                {
//                    miEntidad = new Area()
//                    {
//                    codArea = item.codArea,
//                    desNombre = item.desNombre,
//                    gloDescripcion = item.gloDescripcion,
//                    indActivo = item.indActivo,
//                    segUsuarioCrea = item.segUsuarioCrea,
//                    segUsuarioEdita = item.segUsuarioEdita,
//                    segFechaCrea = item.segFechaCrea,
//                    segFechaEdita = item.segFechaEdita,
//                    segMaquinaOrigen = item.segMaquinaOrigen,
//                    indEliminado = item.indEliminado,

//                    };
//                }
//            }
//        }
//        catch (Exception ex)
//        {
//            throw ex;
//        }
//        return miEntidad;
//}
//        #endregion 

//        #region /* Proceso de INSERT RECORD */ 

//        /// <summary>
//        /// Almacena el registro de una ENTIDAD de registro de Tipo Area
//        /// En la BASE de DATO la Tabla : [RecursosHumanos.Area]
//        /// <summary>
//        /// <param name = >itemArea</param>
//        public bool Insert( Area itemArea )
//        {
//            int codigoRetorno = -1;
//            try
//            {
//                using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//                {
//                    codigoRetorno = SQLDC.omgc_mnt_InsertArea(
//                        itemArea.codArea,
//                        itemArea.desNombre,
//                        itemArea.gloDescripcion,
//                        itemArea.indActivo,
//                        itemArea.segUsuarioCrea,
//                        itemArea.segUsuarioEdita,
//                        itemArea.segFechaCrea,
//                        itemArea.segFechaEdita,
//                        itemArea.segMaquinaOrigen,
//                        itemArea.indEliminado		);
//                }
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//            return codigoRetorno == 0 ? true : false;
//        }
//        #endregion 

//        #region /* Proceso de UPDATE RECORD */ 

//        /// <summary>
//        /// Almacena el registro de una ENTIDAD de registro de Tipo Area
//        /// En la BASE de DATO la Tabla : [RecursosHumanos.Area]
//        /// <summary>
//        /// <param name = >itemArea</param>
//        public bool Update( Area itemArea )
//        {
//            int codigoRetorno = -1;
//            try
//            {
//                using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//                {
//                    codigoRetorno = SQLDC.omgc_mnt_UpdateArea(
//                        itemArea.codArea,
//                        itemArea.desNombre,
//                        itemArea.gloDescripcion,
//                        itemArea.indActivo,
//                        itemArea.segUsuarioCrea,
//                        itemArea.segUsuarioEdita,
//                        itemArea.segFechaCrea,
//                        itemArea.segFechaEdita,
//                        itemArea.segMaquinaOrigen,
//                        itemArea.indEliminado		);
//                }
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//            return codigoRetorno == 0 ? true : false;
//        }
//        #endregion 

//        #region /* Proceso de DELETE BY ID CODE */ 

//        /// <summary>
//        /// ELIMINA un registro de la Entidad RecursosHumanos.Area
//        /// En la BASE de DATO la Tabla : [RecursosHumanos.Area]
//        /// <summary>
//        /// <returns>bool</returns>
//        public bool Delete(int prm_codArea)
//        {
//            int codigoRetorno = -1;
//            try
//            {
//                using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//                {
//                    codigoRetorno = SQLDC.omgc_mnt_DeleteArea(prm_codArea);
//                }
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//            return codigoRetorno == 0 ? true : false;
//        }
//        #endregion 

	} 
} 
