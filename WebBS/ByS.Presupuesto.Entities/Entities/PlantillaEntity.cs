using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.Presupuesto.Entities.Base;
using ByS.RHumanos.Entities;

namespace ByS.Presupuesto.Entities
{
    public class PlantillaEntity : Entity
    {
        public PlantillaEntity()
        {
            lstPlantillaDeta = new List<PlantillaDetaEntity>();
            objEmpleado = new EmpleadoEntity();
            objArea = new AreaEntity();
            objPresupuesto = new PresupuestoEntity();
            objSolicitud = new SolicitudEntity();
        }

        public string numPlantilla { get; set; }
        public int codRegEstado { get; set; }
        public int codArea { get; set; }
        public int codPresupuesto { get; set; }
        public int codSolicitud { get; set; }
        public int codEmpleadoElabora { get; set; }
        public int numDiasExtemporaneo { get; set; }

        public List<PlantillaDetaEntity> lstPlantillaDeta { get; set; }
        public EmpleadoEntity objEmpleado { get; set; }
        public AreaEntity objArea { get; set; }
        public PresupuestoEntity objPresupuesto { get; set; }
        public SolicitudEntity objSolicitud { get; set; }

        /*Columnas Logicas - Calculadas*/
        public decimal monMaximo { get; set; }
        public decimal monEstimadoTotal { get; set; }
        public string fecCierreExtempor { get; set; }
        public string codRegEstadoNombre { get; set; }
    }
}
