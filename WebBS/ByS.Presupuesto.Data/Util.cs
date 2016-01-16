namespace ByS.Presupuesto.Data
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Configuration;

    public static class Util
    {
        public static string ConexionBD()
        {
            string strCnxDB;
            try
            {
                strCnxDB = ConfigurationManager.ConnectionStrings["cnxByS"].ConnectionString;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return strCnxDB;
        }
    }
}
