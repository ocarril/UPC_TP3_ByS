//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebBS.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class NotaIngreso
    {
        public NotaIngreso()
        {
            this.DetalleNotaIngreso = new HashSet<DetalleNotaIngreso>();
        }
    
        public string NumeroNotaIngreso { get; set; }
        public Nullable<System.DateTime> Fecha { get; set; }
        public string NumeroOrdenCompra { get; set; }
        public string UsuarioRecibo { get; set; }
        public Nullable<int> idAlmacen { get; set; }
        public string GuiaRemsion { get; set; }
        public string Observaciones { get; set; }
    
        public virtual ICollection<DetalleNotaIngreso> DetalleNotaIngreso { get; set; }
    }
}
