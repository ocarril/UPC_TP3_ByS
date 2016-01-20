using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
   public class LibroRecetaDTO
    {
        public string nombreProducto { get; set; }
        public Nullable<System.DateTime> fechaProducto { get; set; }
        public string quimicoLaboratorista { get; set; }
        public string codigoProducto { get; set; }
    
    }
}
