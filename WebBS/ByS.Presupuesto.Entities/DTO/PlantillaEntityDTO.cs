using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Presupuesto.Entities.DTO
{
    public class PlantillaEntityDTO 
    {
        public int codPlantilla { get; set; }
        public string numPlantilla { get; set; }
        public string desNombrePresupuesto { get; set; }
        public string numAnio{ get; set; }
        public string fecCierre { get; set; }
        public string desCargoNombre { get; set; }

        public string codRegEstado { get; set; }
        public string codAreaNombre { get; set; }
        public int codPresupuesto { get; set; }
        public int codSolicitudPresupuesto { get; set; }
        public string desEmpleadoElabora { get; set; }
        public string desEmpleadoActual { get; set; }
        public string monMaximo { get; set; }
        public string monEstimadoTotal { get; set; }
        public string segFechaEdita { get; set; }
        public string segUsuarioEdita { get; set; }

        public int numDiasExtemporaneo { get; set; }
        public string fecCierreExtempor { get; set; }
    }
}
