using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Presupuesto.Entities.DTO
{
    public class GastoEntityDTO 
    {
        public int codGasto { get; set; }
        public int codPlantillaDeta { get; set; }
        public decimal monTotal { get; set; }
        public decimal cntCantidad { get; set; }
        public string numDocumento { get; set; }
        public string gloObservacion { get; set; }
        public string fecGasto { get; set; }
        public int codEmpleadoResp { get; set; }
        public string codEmpleadoRespNombre { get; set; }
        public string segFechaEdita { get; set; }
        public string segUsuarioEdita { get; set; }
        public string segMaquinaOrigen { get; set; }

        public long ROW { get; set; }
        public int TOTALROWS { get; set; }
        
    }
}
