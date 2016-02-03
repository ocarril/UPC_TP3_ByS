using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities
{
    public class OrdenRetiroEntity
    {       
        public string codigoProducto { get; set; }
        public DateTime? fecha { get; set; }
        public string autorizado { get; set; }
        public string motivo { get; set; }
        public string riesgo { get; set; }
    }
}
