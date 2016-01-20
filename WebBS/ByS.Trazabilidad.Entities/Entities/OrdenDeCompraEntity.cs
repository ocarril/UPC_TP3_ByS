using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities

{
   public class OrdenDeCompraEntity
    {
       public OrdenDeCompraEntity()
        {
            this.Trazabilidad = new HashSet<TrazabilidadEntity>();
        }
    
        public string codigoCompra { get; set; }
        public Nullable<System.DateTime> fechaCompra { get; set; }
        public string nombreProducto { get; set; }
        public string cantidad { get; set; }
        public string nombreProveedor { get; set; }
        public string costo { get; set; }
        public string codigoProducto { get; set; }
    
        public virtual ProductoEntity Producto { get; set; }
        public virtual ICollection<TrazabilidadEntity> Trazabilidad { get; set; }
    }
}
