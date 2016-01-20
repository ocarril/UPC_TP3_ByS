using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities

{
  public  class InformeTrazabilidadEntity
    {
        public string codigoInformeTrazabilidad { get; set; }
        public string producto { get; set; }
        public string detalleAnalisis { get; set; }
        public string anexo { get; set; }
        public string codigoTraza { get; set; }

        public virtual TrazabilidadEntity Trazabilidad { get; set; }
    }
}
