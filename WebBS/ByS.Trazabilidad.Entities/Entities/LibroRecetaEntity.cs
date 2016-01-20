using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities

{
    public class LibroRecetaEntity
    {
        public LibroRecetaEntity()
        {
            this.Trazabilidad = new HashSet<TrazabilidadEntity>();
        }
    
        public string nombreProducto { get; set; }
        public Nullable<System.DateTime> fechaProducto { get; set; }
        public string quimicoLaboratorista { get; set; }
        public string codigoProducto { get; set; }
    
        public virtual ProductoEntity Producto { get; set; }
        public virtual ICollection<TrazabilidadEntity> Trazabilidad { get; set; }
    }
}
