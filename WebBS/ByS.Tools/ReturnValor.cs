using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ByS.Tools
{
    /// <summary>
    /// Este objeto representa una respuesta de un servicio dado, en caso de una transaccion exitosa 
    /// se debe retornar el valor de Exitosa = true; en caso contrario la propiedad Exitosa debe ser false.
    /// 
    /// Opcionalmente se puede setear un mensaje de error el cual sera mostrado al usuario en la pantalla.
    /// </summary>
    public class ReturnValor
    {
        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="Respuesta"/> is exitosa.
        /// </summary>
        /// <value><c>true</c> if exitosa; otherwise, <c>false</c>.</value>
        public bool Exitosa { get; set; }

        /// <summary>
        /// Gets or sets the error message.
        /// </summary>
        /// <value>The error message.</value>
        public string Message { get; set; }

        /// <summary>
        /// Gets or sets the el codigo de retorno.
        /// </summary>
        public string CodigoRetorno { get; set; }

        /// <summary>
        /// Gets or sets the el codigo de retorno Int.
        /// </summary>
        public int codRetorno { get; set; }

        /// <summary>
        /// Gets or sets the el Codigo de error.
        /// </summary>
        public string ErrorCode { get; set; }
    }
}
