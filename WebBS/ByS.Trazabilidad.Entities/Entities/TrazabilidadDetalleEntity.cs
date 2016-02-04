using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.Entities
{
    public class TrazabilidadDetalleEntity
    {

       
        public string codigoTraza { get; set; }
        public string codigoVenta { get; set; }
        public string numeroKardex { get; set; }
        public string codigoCompra { get; set; }
        public string numeroOrden { get; set; }
        public string numeroHojaMerma { get; set; }
        public string nombreProducto { get; set; }
        public string codigoFichaTecProducto { get; set; }

        public  FichaTecnicaProductoFarmaciaEntity FichaTecnicaProductoFarmacia { get; set; }
        public  HojaMermaEntity HojaMerma { get; set; }
        public  InformeTrazabilidadEntity InformeTrazabilidad { get; set; }
        public  InformeVentaEntity InformeVenta { get; set; }
        public  KardexEntity Kardex { get; set; }
        public  LibroRecetaEntity LibroReceta { get; set; }
        public  OrdenDeCompraEntity OrdenDeCompra { get; set; }
        public  OrdenDeDespachoEntity OrdenDeDespacho { get; set; }
    }
}
