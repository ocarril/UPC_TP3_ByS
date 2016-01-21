using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ByS.Presupuesto.Entities.Base;

namespace ByS.Presupuesto.Entities
{
    /// <summary>
    /// Proyecto    : Modulo de Presupuesto 
    /// Creacion    : OCR
    /// Fecha       : 26/11/2015-12:29:08 a.m.
    /// Descripcion : Capa de Entidades 
    /// Archivo     : [Presupuesto.Partida.cs]
    /// </summary>
    public class PartidaEntity : Entity
    {
        public string desNombre { get; set; }
        public string codNumero { get; set; }
        public bool indActivo { get; set; }
    }
}
