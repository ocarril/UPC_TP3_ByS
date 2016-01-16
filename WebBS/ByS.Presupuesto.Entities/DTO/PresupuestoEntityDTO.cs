using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Presupuesto.Entities.DTO
{
    public class PresupuestoEntityDTO
    {
        public int codPresupuesto { get; set; }
        public string desNombre { get; set; }
        public int numAnio { get; set; }
        public string fecInicio { get; set; }
        public string fecCierre { get; set; }
        public int codRegEstado { get; set; }

        public string segFechaEdita { get; set; }
        public string segUsuarioEdita { get; set; }

        public string monTotalPresupuesto { get; set; }
        public string monTotalSolicitado { get; set; }
        public string monTotalGastado { get; set; }

    }
}
