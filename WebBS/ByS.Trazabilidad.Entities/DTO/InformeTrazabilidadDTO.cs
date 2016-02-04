using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByS.Trazabilidad.Entities.DTO
{
    public class InformeTrazabilidadDTO
    {
        public string codigoInformeTrazabilidad { get; set; }
        public string producto { get; set; }
        public string detalleAnalisis { get; set; }
        public string anexo { get; set; }
        public string codigoTraza { get; set; }
        public string nombreProducto { get; set; }
        public string estado { get; set; }
        //public List<InformeVentaDTO> venta { get; set; }
        //public List<OrdenDeCompraDTO> compra { get; set; }
        //public List<KardexDTO> kardex { get; set; }
        //public List<LibroRecetaDTO> libroreceta { get; set; }
    }
    public class InformeTrazabilidadDTOReporte
    {
        public string codigoInformeTrazabilidad { get; set; }        
        public string detalleAnalisis { get; set; }
        public string anexo { get; set; }
        public string codigoTraza { get; set; }
        public string nombreProducto { get; set; }
        public string estado { get; set; }

        public string fechaTrazastring { get; set; }
        //public List<InformeVentaDTO> venta { get; set; }
        //public List<OrdenDeCompraDTO> compra { get; set; }
        //public List<KardexDTO> kardex { get; set; }
        //public List<LibroRecetaDTO> libroreceta { get; set; }
    }
  

}
