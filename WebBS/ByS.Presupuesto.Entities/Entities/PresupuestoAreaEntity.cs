using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.Presupuesto.Entities.Base;
using ByS.RHumanos.Entities;

namespace ByS.Presupuesto.Entities
{
    public class PresupuestoAreaEntity : Entity
    {
        public PresupuestoAreaEntity()
        {
            objArea = new AreaEntity();
            objPresupuesto = new PresupuestoEntity();
        }
            
        public int codPresupuesto { get; set; }
        public int codArea { get; set; }
        public float? monMaximo { get; set; }
        public bool indActivo { get; set; }

        public AreaEntity objArea { get; set; }
        public PresupuestoEntity objPresupuesto { get; set; }
    }
}
