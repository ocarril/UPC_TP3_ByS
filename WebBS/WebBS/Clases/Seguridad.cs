using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBS.Models;

namespace WebBS.Clases
{
    public class Seguridad
    {
        public static LoginEntity ObtenerUsuarioSession()
        {
            LoginEntity usuario = new LoginEntity();
            if (HttpContext.Current.Session["Usuario"] != null)
            {
                usuario = (LoginEntity)HttpContext.Current.Session["Usuario"];
            }
            return usuario;
        }
    }
}