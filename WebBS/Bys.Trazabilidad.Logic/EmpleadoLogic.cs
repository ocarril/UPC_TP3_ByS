using ByS.Trazabilidad.Data;
using ByS.Trazabilidad.Entities;
using System;

namespace Bys.Trazabilidad.Logic
{
    public class EmpleadoLogic
    {
        private EmpleadoData oEmpleadoData = null;
        public string UsuarioTrazabilidad(Parametro pLista)
        {
            string emailTrazabilidad = null;
            try
            {
                oEmpleadoData= new EmpleadoData();
                emailTrazabilidad = oEmpleadoData.UsuarioTrazabilidad(pLista);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return emailTrazabilidad;
        }
    }
}
