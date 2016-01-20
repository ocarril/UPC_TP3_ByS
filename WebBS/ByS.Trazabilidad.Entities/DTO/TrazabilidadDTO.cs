using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
  public  class TrazabilidadDTO
    {
        public string codigoTraza { get; set; }
        public Nullable<System.DateTime> fechaTraza { get; set; }
        public string producto { get; set; }
        public string descripcion { get; set; }
        public string codigoVenta { get; set; }
        public string numeroKardex { get; set; }
        public string codigoCompra { get; set; }
        public string numeroOrden { get; set; }
        public string numeroHojaMerma { get; set; }
        public string nombreProducto { get; set; }
        public string codigoFichaTecProducto { get; set; }
    }
}
