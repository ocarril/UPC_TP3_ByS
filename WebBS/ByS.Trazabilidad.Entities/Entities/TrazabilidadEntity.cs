using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities
{
   public class TrazabilidadEntity
    {
          
        public string codigoTraza { get; set; }
        public Nullable<System.DateTime> fechaTraza { get; set; }
        public string producto { get; set; }
        public string descripcion { get; set; }
        public List<TrazabilidadDetalleEntity> lstTrazabilidadDeta { get; set; }
        public string estado { get; set; }
        public string comentario { get; set; }

    }
}
