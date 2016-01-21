    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    using ByS.Presupuesto.Entities.Base;
    using ByS.RHumanos.Entities;

namespace ByS.Presupuesto.Entities
{
    public class SolicitudEntity : Entity
    {
        public SolicitudEntity()
        {
            lstSolicitudDeta = new List<SolicitudDetaEntity>();
            objEmpleadoGenera = new EmpleadoEntity();
            objEmpleadoAprueba = new EmpleadoEntity();
        }
        
        public string numSolicitud { get; set; }
        public string gloObservacion { get; set; }
        public Nullable<DateTime> fecSolicitada { get; set; }
        public string indTipo { get; set; }
        public Nullable<DateTime> fecLimite { get; set; }
        public int codEmpleadoGenera { get; set; }
        public int? codEmpleadoAprueba { get; set; }
        public int? codPresupuesto { get; set; }
        public int codRegEstado { get; set; }

        public List<SolicitudDetaEntity> lstSolicitudDeta { get; set; }
        public EmpleadoEntity objEmpleadoGenera { get; set; }
        public EmpleadoEntity objEmpleadoAprueba { get; set; }
    }
}
