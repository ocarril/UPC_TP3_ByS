//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebBS.Models.Trazabilidad
{
    using System;
    using System.Collections.Generic;
    
    public partial class HojaMerma
    {
        public HojaMerma()
        {
            this.Trazabilidad = new HashSet<Trazabilidad>();
        }
    
        public string numeroHojaMerma { get; set; }
        public string cantidadInsumo { get; set; }
        public Nullable<System.DateTime> fecha { get; set; }
        public string motivo { get; set; }
    
        public virtual ICollection<Trazabilidad> Trazabilidad { get; set; }
    }
}
