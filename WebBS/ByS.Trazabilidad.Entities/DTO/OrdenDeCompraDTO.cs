using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
   public class OrdenDeCompraDTO
    {
        public string codigoCompra { get; set; }
        public Nullable<System.DateTime> fechaCompra { get; set; }
        public string nombreProducto { get; set; }
        public string cantidad { get; set; }
        public string nombreProveedor { get; set; }
        public string costo { get; set; }
        public string codigoProducto { get; set; }
    
    }
}
