using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities

{
    public class OrdenDeDespachoEntity
    {
        public OrdenDeDespachoEntity()
        {
            this.Trazabilidad = new HashSet<TrazabilidadEntity>();
        }
    
        public string numeroOrden { get; set; }
        public Nullable<System.DateTime> fecha { get; set; }
        public string totalPedidos { get; set; }
        public string pesoTotal { get; set; }
        public string observaciones { get; set; }
        public string codigoProducto { get; set; }
        public virtual ProductoEntity Producto { get; set; }
        public virtual ICollection<TrazabilidadEntity> Trazabilidad { get; set; }
    }
}
