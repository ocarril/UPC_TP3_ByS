using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using ByS.Presupuesto.Entities.Base;
using ByS.RHumanos.Entities;

namespace ByS.Presupuesto.Entities
{ 
	/// <summary>
	/// Proyecto    : Modulo de Presupuesto 
	/// Creacion    : OCR
	/// Fecha       : 26/11/2015-12:29:08 a.m.
	/// Descripcion : Capa de Entidades del Presupuesto 
	/// Archivo     : [Presupuesto.Gasto.cs]
	/// </summary>
    public class GastoEntity : Entity
    {
        public GastoEntity()
        {
            objPlantillaDeta = new PlantillaDetaEntity();
            objEmpleadoResp = new EmpleadoEntity();
        }

        public int codPlantillaDeta { get; set; }
        public decimal monTotal { get; set; }
        public decimal cntCantidad { get; set; }
        public string numDocumento { get; set; }
        public string gloObservacion { get; set; }
        public DateTime fecGasto { get; set; }
        public int codEmpleadoResp { get; set; }

        public PlantillaDetaEntity objPlantillaDeta { get; set; }
        public EmpleadoEntity objEmpleadoResp { get; set; }
    }
} 
