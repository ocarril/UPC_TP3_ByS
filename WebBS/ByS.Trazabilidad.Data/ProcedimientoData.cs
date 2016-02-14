using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using log4net;
namespace ByS.Trazabilidad.Data
{
   public class ProcedimientoData
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
        private string conexion = string.Empty;
        public ProcedimientoData()
        {
            conexion = Util.ConexionBD();
        }

        public List<ProcedimientoDTO> Listar(Parametro pFiltro)
        {
            List<ProcedimientoDTO> lstGastoEntityDTO = new List<ProcedimientoDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_Procedimiento(pFiltro.codProducto);

                    foreach (var item in resul)
                    {
                        lstGastoEntityDTO.Add(new ProcedimientoDTO()
                        {
                            codigoProcedimiento = item.codigoProcedimiento,
                            fechFinVigencia = item.fechFinVigencia,
                            fechIniVigencia = item.fechIniVigencia,
                            observaciones = item.observaciones,
                            responsable = item.responsable,
                            unidadPlazo = item.unidadPlazo,
                            version = item.version,
                            nombreProducto = item.nombreProducto
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

        public ProcedimientoDTO BuscarProcedimientoById(Parametro pFiltro)
        {
            List<ProcedimientoDTO> lstGastoEntityDTO = new List<ProcedimientoDTO>();
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_ProcedimientoById(pFiltro.P_codigoProcedimiento);

                    foreach (var item in resul)
                    {
                        lstGastoEntityDTO.Add(new ProcedimientoDTO()
                        {
                            codigoProcedimiento = item.codigoProcedimiento,
                            fechFinVigencia = item.fechFinVigencia,
                            fechIniVigencia = item.fechIniVigencia,
                            observaciones = item.observaciones,
                            responsable = item.responsable,
                            unidadPlazo = item.unidadPlazo,
                            version = item.version,
                            actividadProcedimiento=item.actividadProcedimiento,
                            plazoActividad=item.plazoActividad,
                            Tipo=item.tipo
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("BuscarProcedimientoById", " | ", ex.Message.ToString()));
                throw ex;
            }
            return lstGastoEntityDTO.FirstOrDefault();
        }

        public bool Update(ProcedimientoDTO objEntity)
        {
            string codigoRetorno = string.Empty;
            try
            {

                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    SQLDC.pa_U_Procedimiento(
                        objEntity.codigoProcedimiento,
                        objEntity.version,
                        objEntity.fechIniVigencia,
                        objEntity.fechFinVigencia,
                        objEntity.responsable,
                        objEntity.unidadPlazo,
                        objEntity.observaciones,
                        objEntity.actividadProcedimiento,
                        objEntity.plazoActividad,objEntity.Tipo
                        );
                    codigoRetorno = objEntity.codigoProcedimiento;                    
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Insertar", " | ", ex.Message.ToString()));
                throw ex;
            }
            return codigoRetorno == string.Empty ? false : true;
        }
    }
}
