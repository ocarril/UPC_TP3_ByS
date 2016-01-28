using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.Presupuesto.Entities.Base;
using ByS.RHumanos.Entities;

namespace ByS.Presupuesto.Entities
{
    public class PlantillaDetaEntity : Entity
    {
        public PlantillaDetaEntity()
        {
            objPlantilla = new PlantillaEntity();
            objPartida = new PartidaEntity();
            objEmpleadoAprueba = new EmpleadoEntity();
            objEmpleadoRespon = new EmpleadoEntity();
        }

        public int codPlantilla { get; set; }
        public int codEmpleadoAprueba { get; set; }
        public int codEmpleadoRespon { get; set; }
        
        public string gloDescripcion{ get; set; }
        public decimal monEstimado{ get; set; }
        public decimal cntCantidad{ get; set; }

        public int codRegEstado { get; set; }
        public Nullable<DateTime> fecEjecucion { get; set; }
        public string indPlantilla { get; set; }
        public int codPartida { get; set; }
        public string numPartida { get; set; }

        public PlantillaEntity objPlantilla { get; set; }
        public PartidaEntity objPartida { get; set; }
        public EmpleadoEntity objEmpleadoAprueba { get; set; }
        public EmpleadoEntity objEmpleadoRespon { get; set; }
    }
}
