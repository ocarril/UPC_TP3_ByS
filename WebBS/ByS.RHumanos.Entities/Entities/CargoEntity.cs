using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.RHumanos.Entities.Base;

namespace ByS.RHumanos.Entities
{
    public class CargoEntity : Entity
    {
        //public int codCargo { get; set; }
        public string desNombre { get; set; }
        public string gloDescripcion { get; set; }
        public  bool indActivo{ get; set; }
    }
}
