    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    using ByS.Presupuesto.Entities.Base;

namespace ByS.Presupuesto.Entities
{
    public class SolicitudPresupuestoEntity : Entity
    {
        //public int codSolicitudPresupuesto { get; set; }
        public string numSolicitud { get; set; }
        public string gloObservacion { get; set; }
        public Nullable<DateTime> fecSolicitada { get; set; }
        public string indTipo { get; set; }
        public Nullable<DateTime> fecLimite { get; set; }

    }
}
