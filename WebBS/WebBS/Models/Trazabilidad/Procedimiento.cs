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
    
    public partial class Procedimiento
    {
        public Procedimiento()
        {
            this.FichaTecnicaProductoFarmacia = new HashSet<FichaTecnicaProductoFarmacia>();
        }
    
        public string codigoProcedimiento { get; set; }
        public string version { get; set; }
        public Nullable<System.DateTime> fechIniVigencia { get; set; }
        public Nullable<System.DateTime> fechFinVigencia { get; set; }
        public string responsable { get; set; }
        public string unidadPlazo { get; set; }
        public string observaciones { get; set; }
    
        public virtual ICollection<FichaTecnicaProductoFarmacia> FichaTecnicaProductoFarmacia { get; set; }
    }
}
