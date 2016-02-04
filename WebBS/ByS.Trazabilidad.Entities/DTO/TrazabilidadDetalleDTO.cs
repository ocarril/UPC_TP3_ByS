using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
  public  class TrazabilidadDetalleDTO
    {
        public string codigoTraza { get; set; }
        public string codigoVenta { get; set; }
        public string numeroKardex { get; set; }
        public string codigoCompra { get; set; }
        public string numeroOrden { get; set; }
        public string numeroHojaMerma { get; set; }
        public string nombreProducto { get; set; }
        public string codigoFichaTecProducto { get; set; }

        public FichaTecnicaProductoFarmaciaDTO FichaTecnicaProductoFarmacia { get; set; }
        public HojaMermaDTO HojaMerma { get; set; }
        public InformeTrazabilidadDTO InformeTrazabilidad { get; set; }
        public InformeVentaDTO InformeVenta { get; set; }
        public KardexDTO Kardex { get; set; }
        public LibroRecetaDTO LibroReceta { get; set; }
        public OrdenDeCompraDTO OrdenDeCompra { get; set; }
        public OrdendeDespachoDTO OrdenDeDespacho { get; set; }
    }
}
