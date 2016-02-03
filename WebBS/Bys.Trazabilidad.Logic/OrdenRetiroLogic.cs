using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ByS.Tools;
using ByS.Trazabilidad.Data;
using ByS.Trazabilidad.Entities;
using ByS.Trazabilidad.Entities.DTO;
using ByS.Trazabilidad.Entities.Entities;

namespace Bys.Trazabilidad.Logic
{
    public class OrdenRetiroLogic
    {
        private OrdenRetiroData oData = null;
        public bool RetirarProducto(OrdenRetiroEntity orden) 
        {
            try {
                oData = new OrdenRetiroData();
                return oData.RetirarArticulo(orden);                
            }
            catch (Exception ex) {
                throw ex;
            }            
        }
    }
}
