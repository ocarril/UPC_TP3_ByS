using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
namespace ByS.Trazabilidad.Entities.Entities

{
    [DisplayName("HojaMerma")]
   public class HojaMermaEntity
    {
        public HojaMermaEntity()
        {
            this.Trazabilidad = new HashSet<TrazabilidadEntity>();
        }
    
        public string numeroHojaMerma { get; set; }
        public string cantidadInsumo { get; set; }
        public Nullable<System.DateTime> fecha { get; set; }
        public string motivo { get; set; }
        public string codigoProducto { get; set; }
        public virtual ProductoEntity Producto { get; set; }
        public virtual ICollection<TrazabilidadEntity> Trazabilidad { get; set; }
    }
}
