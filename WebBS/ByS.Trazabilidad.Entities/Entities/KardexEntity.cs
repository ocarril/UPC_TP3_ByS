using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities

{
  public  class KardexEntity
    {
      public KardexEntity()
        {
            this.Trazabilidad = new HashSet<TrazabilidadEntity>();
        }
        public string numeroKardex { get; set; }
        public Nullable<System.DateTime> fecha { get; set; }
        public string ingreso { get; set; }
        public string salidas { get; set; }
        public string saldos { get; set; }
        public string observaciones { get; set; }
        public string codigoProducto { get; set; }
    
        public virtual ICollection<TrazabilidadEntity> Trazabilidad { get; set; }
    }
}
