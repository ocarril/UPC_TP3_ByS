using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
    public class InformeVentaDTO
    {
        public string codigoVenta { get; set; }
        public DateTime fechaVenta { get; set; }
        public string nombreProducto { get; set; }
        public string cantidad { get; set; }
        public string nombreCliente { get; set; }
        public string precio { get; set; }
        public string codigoProducto { get; set; }

    }
}
