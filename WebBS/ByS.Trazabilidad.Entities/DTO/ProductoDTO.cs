using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
   public class ProductoDTO
    {
        public string codigoProducto { get; set; }
        public string nombreProducto { get; set; }
        public string descripcion { get; set; }
        public string tipoProducto { get; set; }
        public string presentacion { get; set; }
        public string pesoProducto { get; set; }

        public DateTime fecha { get; set; }
        public String autorizado { get; set; }
        public String motivo { get; set; }
        public String riesgo { get; set; }
    }
}
