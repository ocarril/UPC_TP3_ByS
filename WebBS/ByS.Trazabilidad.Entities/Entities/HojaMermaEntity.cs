using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
namespace ByS.Trazabilidad.Entities.Entities

{
    
   public class HojaMermaEntity
    {
       
       public string numeroHojaMerma { get; set; }
        public string cantidadInsumo { get; set; }
        public Nullable<System.DateTime> fecha { get; set; }
        public string motivo { get; set; }
        public string codigoProducto { get; set; }
        public ProductoEntity Producto { get; set; }
      
    }
}
