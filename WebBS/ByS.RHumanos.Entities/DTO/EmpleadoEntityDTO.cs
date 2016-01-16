using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.RHumanos.Entities
{
    public class EmpleadoEntityDTO 
    {
        public int codEmpleado { get; set; }
        public int codPersona { get; set; }
        public int codCargo { get; set; }
        public string codCargoNombre { get; set; }
        public int codArea { get; set; }
        public string codAreaNombre { get; set; }
        public string desNombre { get; set; }
        public string desApellido { get; set; }
        public string desLogin { get; set; }
        public string clvPassword { get; set; }
        public bool indActivo { get; set; }
        public string segFechaEdita { get; set; }
        public string segUsuarioEdita { get; set; }

    }
}
