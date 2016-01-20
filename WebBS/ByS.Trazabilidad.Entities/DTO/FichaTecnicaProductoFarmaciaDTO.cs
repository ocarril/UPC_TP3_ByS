using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
   public class FichaTecnicaProductoFarmaciaDTO
    {
        public string codigoFichaTecProducto { get; set; }
        public string nombre { get; set; }
        public string descripcion { get; set; }
        public string etiquetado { get; set; }
        public string procedimientoAlmacen { get; set; }
        public string procedimientoVenta { get; set; }
        public string procedimiemtoDistribucion { get; set; }
        public string posologia { get; set; }
        public string quimicoFarmaceutico { get; set; }
        public string aprobar { get; set; }
        public string codigoProcedimiento { get; set; }
        public string codigoFichaTecProveedor { get; set; }
    }
}
