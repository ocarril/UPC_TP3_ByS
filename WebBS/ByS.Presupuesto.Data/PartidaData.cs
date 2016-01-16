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
	/// Archivo     : [Presupuesto.PartidaData.cs]
	/// </summary>
	public class PartidaData
	{
        private static readonly ILog log = LogManager.GetLogger(typeof(PartidaData));
        private string conexion = string.Empty;
	
        public PartidaData()
		{
            conexion = Util.ConexionBD();
		}

		#region /* Proceso de SELECT ALL */ 

		/// <summary>
		/// Retorna un LISTA de registros de la Entidad Presupuesto.Partida
		/// En la BASE de DATO la Tabla : [Presupuesto.Partida]
		/// <summary>
		/// <returns>List</returns>
		public List<PartidaEntity> Listar()
		{
            List<PartidaEntity> lstPartidaEntity = new List<PartidaEntity>();
			try
			{
                using (_DBMLPresupuestoDataContext SQLDC = new _DBMLPresupuestoDataContext(conexion))
			{
				var resul = SQLDC.pa_S_Partida();
				foreach (var item in resul)
				{
                    lstPartidaEntity.Add(new PartidaEntity()
					{
					Codigo = item.codPartida,
					desNombre = item.desNombre,
					
					});
				}
			}
		}
		catch (Exception ex)
		{
            log.Error(String.Concat("Listar", " | ", ex.Message.ToString()));
			throw ex;
		}
		return lstPartidaEntity;
}
		#endregion 

        //        #region /* Proceso de SELECT BY ID CODE */ 

//        /// <summary>
//        /// Retorna una ENTIDAD de registro de la Entidad Presupuesto.Partida
//        /// En la BASE de DATO la Tabla : [Presupuesto.Partida]
//        /// <summary>
//        /// <returns>Entidad</returns>
//        public Partida Find(int prm_codPartida)
//        {
//            Partida miEntidad = new Partida();
//            try
//            {
//            using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//            {
//                var resul = SQLDC.omgc_mnt_GetByIdCodePartida(prm_codPartida                );
//                foreach (var item in resul)
//                {
//                    miEntidad = new Partida()
//                    {
//                    codPartida = item.codPartida,
//                    desNombre = item.desNombre,
//                    codNumero = item.codNumero,
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

//        #region /* Proceso de SELECT BY ID CODE FOREIGN KEY*/ 

//        /// <summary>
//        /// Retorna una LISTA de registro de la Entidad Presupuesto.Partida POR FOREIGN KEY
//        /// En la BASE de DATO la Tabla : [Presupuesto.Partida]
//        /// <summary>
//        /// <returns>Entidad</returns>
//        #endregion 

//        #region /* Proceso de INSERT RECORD */ 

//        /// <summary>
//        /// Almacena el registro de una ENTIDAD de registro de Tipo Partida
//        /// En la BASE de DATO la Tabla : [Presupuesto.Partida]
//        /// <summary>
//        /// <param name = >itemPartida</param>
//        public bool Insert( Partida itemPartida )
//        {
//            int codigoRetorno = -1;
//            try
//            {
//                using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//                {
//                    codigoRetorno = SQLDC.omgc_mnt_InsertPartida(
//                        itemPartida.codPartida,
//                        itemPartida.desNombre,
//                        itemPartida.codNumero,
//                        itemPartida.indActivo,
//                        itemPartida.segUsuarioCrea,
//                        itemPartida.segUsuarioEdita,
//                        itemPartida.segFechaCrea,
//                        itemPartida.segFechaEdita,
//                        itemPartida.segMaquinaOrigen,
//                        itemPartida.indEliminado		);
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
//        /// Almacena el registro de una ENTIDAD de registro de Tipo Partida
//        /// En la BASE de DATO la Tabla : [Presupuesto.Partida]
//        /// <summary>
//        /// <param name = >itemPartida</param>
//        public bool Update( Partida itemPartida )
//        {
//            int codigoRetorno = -1;
//            try
//            {
//                using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//                {
//                    codigoRetorno = SQLDC.omgc_mnt_UpdatePartida(
//                        itemPartida.codPartida,
//                        itemPartida.desNombre,
//                        itemPartida.codNumero,
//                        itemPartida.indActivo,
//                        itemPartida.segUsuarioCrea,
//                        itemPartida.segUsuarioEdita,
//                        itemPartida.segFechaCrea,
//                        itemPartida.segFechaEdita,
//                        itemPartida.segMaquinaOrigen,
//                        itemPartida.indEliminado		);
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
//        /// ELIMINA un registro de la Entidad Presupuesto.Partida
//        /// En la BASE de DATO la Tabla : [Presupuesto.Partida]
//        /// <summary>
//        /// <returns>bool</returns>
//        public bool Delete(int prm_codPartida)
//        {
//            int codigoRetorno = -1;
//            try
//            {
//                using (CROMDataContext SQLDC = new CROMDataContext(conexion))
//                {
//                    codigoRetorno = SQLDC.omgc_mnt_DeletePartida(prm_codPartida);
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
