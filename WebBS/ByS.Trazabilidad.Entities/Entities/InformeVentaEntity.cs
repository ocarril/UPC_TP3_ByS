using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities
{
    public class InformeVentaEntity
    {
        public InformeVentaEntity()
        {
            this.Trazabilidad = new HashSet<TrazabilidadEntity>();
        }
    
        public string codigoVenta { get; set; }
        public Nullable<System.DateTime> fechaVenta { get; set; }
        public string nombreProducto { get; set; }
        public string cantidad { get; set; }
        public string nombreCliente { get; set; }
        public string precio { get; set; }
        public string codigoProducto { get; set; }
    
        public virtual ICollection<TrazabilidadEntity> Trazabilidad { get; set; }
    }
}
