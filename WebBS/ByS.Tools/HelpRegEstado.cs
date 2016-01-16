using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ByS.Tools
{
    public static class HelpRegEstado
    {
        public enum Presupuesto
        {
            PENDIENTE = 1,
            APROBADO = 2,
            DESAPROBADO = 3,
            EN_EJECUCION = 4,
            EJECUTADO_CERRADO = 5,
        }

        public enum Plantilla
        {
            PENDIENTE = 1,
            TERMINADA_INGRESO = 2,
            APROBADA = 3,
            DESAPROBADA = 4,
            EJECUTADA = 5
        }

        public enum PlantillaDeta
        {
            POR_APROBAR = 1,
            APROBADA = 2,
            DESAPROBADA = 3,
            EN_EJECUCION = 4,
            EJECUTADA = 5
        }
    }
}
