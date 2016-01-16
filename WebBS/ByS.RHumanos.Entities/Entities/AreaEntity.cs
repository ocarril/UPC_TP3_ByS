namespace ByS.RHumanos.Entities
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    using ByS.RHumanos.Entities.Base;


    public class AreaEntity : Entity
    {
        //public int codArea { get; set; }
        public string desNombre { get; set; }
        public string gloDescripcion { get; set; }
        public bool indActivo { get; set; }
    }
}
