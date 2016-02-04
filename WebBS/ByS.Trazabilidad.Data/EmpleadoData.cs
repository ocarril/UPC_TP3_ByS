using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ByS.Trazabilidad.Data
{
   public class EmpleadoData
    {

       private static readonly ILog log = LogManager.GetLogger(typeof(InformeVentaData));
		private string conexion = string.Empty;
        public EmpleadoData()
		{
            conexion = Util.ConexionBD();
		}
		
     

	   public string UsuarioTrazabilidad(Parametro pFiltro)
	    {
            string emailTrazabilidad=null;
            try
            {
                using (_DBMLTrazabilidadDataContext SQLDC = new _DBMLTrazabilidadDataContext(conexion))
                {
                    var resul = SQLDC.pa_S_UsuarioTrazabilidad(pFiltro.p_codCargo, pFiltro.p_codArea);
                    
                    foreach (var item in resul)
                    {
                        emailTrazabilidad = item.desLogin;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("Email Trazabilidad", " | ", ex.Message.ToString()));
                throw ex;
            }
            return emailTrazabilidad;
         }  
    }
}
