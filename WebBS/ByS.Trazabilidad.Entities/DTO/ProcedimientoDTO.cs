using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
   public class ProcedimientoDTO
    {
        public string codigoProcedimiento { get; set; }
        public string version { get; set; }
        public DateTime? fechIniVigencia { get; set; }
        public DateTime? fechFinVigencia { get; set; }
        public string responsable { get; set; }
        public string unidadPlazo { get; set; }
        public string observaciones { get; set; }
        public string nombreProducto { get; set; }
        public string actividadProcedimiento { get; set; }
        public string plazoActividad { get; set; }
        public string Tipo { get; set; }
        public string IdTipo { get; set; }

    }
}
