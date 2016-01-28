using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.RHumanos.Entities.Base;

namespace ByS.RHumanos.Entities
{
    public class EmpleadoEntity : Entity
    {
        public EmpleadoEntity()
        {
            objArea = new AreaEntity();
            objCargo = new CargoEntity();
        }

        //public int codEmpleado { get; set; }
        public int codPersona { get; set; }
        public int codCargo { get; set; }
        public int codArea { get; set; }
        public string desNombre { get; set; }
        public string desApellido { get; set; }
        public string desLogin { get; set; }
        public string clvPassword { get; set; }
        public  bool indActivo{ get; set; }

        public CargoEntity objCargo { get; set; }
        public AreaEntity objArea { get; set; }
    }
}
