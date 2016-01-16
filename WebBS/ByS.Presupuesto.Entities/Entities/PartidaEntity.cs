using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.Presupuesto.Entities.Base;

namespace ByS.Presupuesto.Entities
{
    /// <summary>
    /// 
    /// </summary>
    public class PartidaEntity : Entity
    {
        //public int codPartida { get; set; }
        public string desNombre { get; set; }
        public string codNumero { get; set; }
        public bool indActivo { get; set; }

    }
}
