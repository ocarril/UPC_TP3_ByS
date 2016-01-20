using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
   public class FichaTecnicaProductoProveedorDTO
    {
        public string codigoFichaTecProveedor { get; set; }
        public string nombre { get; set; }
        public string nomTecnico { get; set; }
        public string modoUso { get; set; }
        public string contraIndicacion { get; set; }
        public string condicionesUso { get; set; }
        public string condicionesAlmacen { get; set; }
        public string condicionesComercial { get; set; }
        public string temperaturaMinima { get; set; }
        public string temperaturaMaxima { get; set; }
        public string laboratorioOrigen { get; set; }
    }
}
