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
    
    public partial class DetalleNotaIngreso
    {
        public string NumeroNotaIngreso { get; set; }
        public int IdProducto { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
    
        public virtual NotaIngreso NotaIngreso { get; set; }
    }
}
