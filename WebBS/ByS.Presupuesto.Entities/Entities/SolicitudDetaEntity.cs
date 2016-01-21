using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.Presupuesto.Entities.Base;

namespace ByS.Presupuesto.Entities
{
    public class SolicitudDetaEntity : Entity
    {
        public SolicitudDetaEntity()
        {
            objSolicitud = new SolicitudEntity();
            objPlantillaDeta = new PlantillaDetaEntity();
        }

        public int codSolicitud { get; set; }
        public int codPlantillaDeta { get; set; }
        public decimal cntCantidad { get; set; }
        public string gloDescripcion { get; set; }

        public SolicitudEntity objSolicitud { get; set; }
        public PlantillaDetaEntity objPlantillaDeta { get; set; }
    }
}
