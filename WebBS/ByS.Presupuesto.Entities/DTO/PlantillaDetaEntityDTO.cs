using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Presupuesto.Entities.DTO
{
    public class PlantillaDetaEntityDTO 
    {
        public int codPlantillaDeta { get; set; }
        public int codPlantilla { get; set; }
        public int codEmpleadoAprueba { get; set; }
        public string codEmpleadoApruebaNombre { get; set; }

        public string gloDescripcion{ get; set; }
        public decimal cntCantidad{ get; set; }
        public decimal monEstimado { get; set; }
        public string fecEjecucion { get; set; }
        
        public int codRegEstado { get; set; }
        public string codRegEstadoNombre { get; set; }

        public int? codEmpleadoRespon { get; set; }
        public string codEmpleadoResponNombre { get; set; }

        public string indPlantilla { get; set; }
        public string indPlantillaNombre { get; set; }

        public int codPartida { get; set; }
        public string codPartidaNombre { get; set; }
        public string numPartida { get; set; }
        public string segFechaEdita { get; set; }
        public string segUsuarioEdita { get; set; }
        public string segFechaCrea { get; set; }
        public string segUsuarioCrea { get; set; }
        public string codPartidaNumero { get; set; }
        public int codArea { get; set; }
        public string codAreaNombre { get; set; }

        public string segMaquinaOrigen{ get; set; }

        public long ROW { get; set; }
        public int TOTALROWS { get; set; }
        
    }
}
