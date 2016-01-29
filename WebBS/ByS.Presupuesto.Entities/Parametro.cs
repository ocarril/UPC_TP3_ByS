using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Presupuesto.Entities
{
    public class Parametro
    {
        public int? numAnio { get; set; }
        public int? codArea { get; set; }
        public int? codPlantilla { get; set; }
        public int? codPlantillaDeta{ get; set; }
        public int? codGasto { get; set; }
        public int? codRegEstado { get; set; }
        public int? codEmpleado{ get; set; }
        public string desNombre{ get; set; }
        public string desApellido{ get; set; }
        public int codSolicitud{ get; set; }
        public int codSolicitudDeta { get; set; }
        public string numSolicitud{ get; set; }
        public string fecInicio { get; set; }
        public string fecFinal{ get; set; }
        public int codPresupuesto{ get; set; }

        public int p_NumPagina{ get; set; }
        public int p_TamPagina{ get; set; }
        public string p_OrdenPor	{ get; set; }
        public string p_OrdenTipo{ get; set; }
        public string indTipo { get; set; }
        public int p_anio { get; set; }

        public string segUsuElimina { get; set; }
        public string segMaquinaPC { get; set; }
    }
}
