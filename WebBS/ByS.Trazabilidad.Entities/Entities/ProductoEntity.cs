using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
namespace ByS.Trazabilidad.Entities.Entities
{

[DisplayName("Producto")]
    public class ProductoEntity
    {
        public ProductoEntity()
        {
            this.HojaMerma = new HashSet<HojaMermaEntity>();
            this.LibroReceta = new HashSet<LibroRecetaEntity>();
            this.OrdenDeCompra = new HashSet<OrdenDeCompraEntity>();
            this.OrdenDeDespacho = new HashSet<OrdenDeDespachoEntity>();
        }
    
        public string codigoProducto { get; set; }
        public string nombreProducto { get; set; }
        public string descripcion { get; set; }
        public string tipoProducto { get; set; }
        public string presentacion { get; set; }
        public string pesoProducto { get; set; }
    
        public virtual ICollection<HojaMermaEntity> HojaMerma { get; set; }
        public virtual ICollection<LibroRecetaEntity> LibroReceta { get; set; }
        public virtual ICollection<OrdenDeCompraEntity> OrdenDeCompra { get; set; }
        public virtual ICollection<OrdenDeDespachoEntity> OrdenDeDespacho { get; set; }

    }
}
