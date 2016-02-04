using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities
{
    public class Parametro
    {

        public string codProducto { get; set; }
        public string nomProducto { get; set; }
        public DateTime? fechaIni { get; set; }
        public DateTime? fechaFin { get; set; }
        public string desNombre{ get; set; }
        public string desApellido{ get; set; }

        public int p_NumPagina{ get; set; }
        public int p_TamPagina{ get; set; }
        public string p_OrdenPor	{ get; set; }
        public string p_OrdenTipo{ get; set; }
        public int p_anio { get; set; }

        public string segUsuElimina { get; set; }
        public string segMaquinaPC { get; set; }
        //Trazabilidad
        public int p_codArea { get; set; }
        public int p_codCargo { get; set; }
        public string P_codigoProcedimiento { get; set; }
        public string p_codigoTraza { get; set; }
        public string codigoInformeTrazabilidad { get; set; }


    }
}
