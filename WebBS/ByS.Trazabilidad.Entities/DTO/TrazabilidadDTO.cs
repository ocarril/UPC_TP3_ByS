using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
  public  class TrazabilidadDTO
    {
        public string codigoTraza { get; set; }
        public Nullable<System.DateTime> fechaTraza { get; set; }
        public string producto { get; set; }
        public string descripcion { get; set; }
        public string estado { get; set; }
        public string comentario { get; set; }
        public List<TrazabilidadDetalleDTO> detalle { get; set; }
        public string estadoinformetrazabilidad { get; set; }

      //Actualizar
        public Nullable<System.DateTime> fechatraza { get; set; }	
        public string nombreProducto { get; set; }
        
        
        
        
        
    }
}
