using System;

namespace ByS.Presupuesto.Entities.Base
{
    /// <summary>
    /// Clase base para las entidades
    /// </summary>
    /// <remarks>
    /// Creación:   20151105 <br />
    /// Modificación:            <br />
    /// </remarks>
    public abstract class Entity
    {
        public Entity()
        {
            this.indEliminado = false;
            this.segFechaCrea = DateTime.Now;
            this.segFechaEdita = DateTime.Now;
        }
        protected int CodigoAuditoria { get; set; }

        public int Codigo { get; set; }
        /// <summary>
        /// Estado de Registro
        /// </summary>
        public bool indEliminado { get; set; }
        /// <summary>
        /// Usuario de Creación
        /// </summary>
        public string segUsuarioCrea { get; set; }
        /// <summary>
        /// Fecha de Creación 
        /// </summary>
        public DateTime segFechaCrea { get; set; }
        /// <summary>
        /// Terminal de Creación 
        /// </summary>
        public string segMaquinaOrigen { get; set; }
        /// <summary>
        /// Usuario de Modificación
        /// </summary>
        public string segUsuarioEdita { get; set; }
        /// <summary>
        /// Fecha de Modificación 
        /// </summary>
        public DateTime? segFechaEdita { get; set; }

        public long ROW { get; set; }
        public int TOTALROWS { get; set; }
    }
}
