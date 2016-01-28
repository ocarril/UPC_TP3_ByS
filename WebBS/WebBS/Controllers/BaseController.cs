using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;

using ByS.Presupuesto.Logic;
using ByS.Presupuesto.Entities;
using ByS.RHumanos.Logic;
using ByS.RHumanos.Entities;

namespace WebBS.Controllers
{
    public abstract class BaseController : Controller
    {

        protected object ListarPartidas()
        {
            PlantillaLogic objPlantillaLogic = new PlantillaLogic();
            IEnumerable<PartidaEntity> lstPartidas;
            lstPartidas = objPlantillaLogic.ListarPartida();
            object lstParaCombos = from item in lstPartidas
                                   select new
                                   {
                                       value = item.Codigo,
                                       text = item.desNombre
                                   };
            return lstParaCombos;
        }

        protected object ListarEmpleados(bool indTexto = true, bool indSoloUno = false, int codEmpleado = 0)
        {
            EmpleadoLogic objEmpleadoLogic = new EmpleadoLogic();
            List<EmpleadoEntityDTO> lstEmpleados;
            lstEmpleados = objEmpleadoLogic.ListarEmpleado(new ParametroRH { codEmpleado = codEmpleado });
            if (indTexto)
                lstEmpleados.Insert(0, new EmpleadoEntityDTO { codEmpleado = 0, desNombre = "-- Seleccionar/Todos --" });

            object lstParaCombos = from item in lstEmpleados
                                   select new
                                   {
                                       value = item.codEmpleado,
                                       text = item.desNombre + ", " + item.desApellido
                                   };
            return lstParaCombos;
        }

        protected SelectList ListarPresupuestosAnios()
        {
            PlantillaLogic objPlantillaLogic = new PlantillaLogic();
            List<PresupuestoEntity> lstPresupuestoEntity = new List<PresupuestoEntity>();
            lstPresupuestoEntity = objPlantillaLogic.ListarPresupuesto(null);
            List<PresupuestoEntity> lstPresupuestoEntitySelec = new List<PresupuestoEntity>();
            foreach (PresupuestoEntity item in lstPresupuestoEntity)
            {
                if (item.numAnio <= (DateTime.Now.Year))
                    lstPresupuestoEntitySelec.Add(item);
            }
            SelectList lstParaCombos = new SelectList(lstPresupuestoEntitySelec, "numAnio", "desNombre");
            return lstParaCombos;
        }

        protected SelectList ListarAreasPresupuestales(bool indTexto = true, bool indSoloUno = false, int codArea = 0)
        {
            EmpleadoLogic objEmpleadoLogic = new EmpleadoLogic();
            List<AreaEntity> lstAreaEntity = new List<AreaEntity>();
            lstAreaEntity = objEmpleadoLogic.ListarAreas();

            if (indTexto)
                lstAreaEntity.Insert(0, new AreaEntity { Codigo = 0, desNombre = "-- Todos --" });
            if (indSoloUno && codArea > 0)
                lstAreaEntity = lstAreaEntity.FindAll(x => x.Codigo == codArea);
            SelectList lstParaCombos = new SelectList(lstAreaEntity, "Codigo", "desNombre");
            return lstParaCombos;
        }

        #region Métodos relacionados con SEGURIDAD S.I.S.

        protected string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }
            string str1 = context.Request.ServerVariables["REMOTE_USER"];
            string str2 = context.Request.ServerVariables["AUTH_USER"];
            string str3 = context.Request.ServerVariables["REMOTE_HOST"];
            return str3 + "-" + str1 + "-" + str2;
        }

        #endregion
    }
}