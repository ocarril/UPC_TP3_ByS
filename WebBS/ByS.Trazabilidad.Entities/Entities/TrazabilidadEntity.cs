using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities
{
   public class TrazabilidadEntity
    {
       public TrazabilidadEntity()
        {
            this.InformeTrazabilidad = new HashSet<InformeTrazabilidadEntity>();
        }
    
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
    
        public virtual FichaTecnicaProductoFarmaciaEntity FichaTecnicaProductoFarmacia { get; set; }
        public virtual HojaMermaEntity HojaMerma { get; set; }
        public virtual ICollection<InformeTrazabilidadEntity> InformeTrazabilidad { get; set; }
        public virtual InformeVentaEntity InformeVenta { get; set; }
        public virtual KardexEntity Kardex { get; set; }
        public virtual LibroRecetaEntity LibroReceta { get; set; }
        public virtual OrdenDeCompraEntity OrdenDeCompra { get; set; }
        public virtual OrdenDeDespachoEntity OrdenDeDespacho { get; set; }
    }
}
