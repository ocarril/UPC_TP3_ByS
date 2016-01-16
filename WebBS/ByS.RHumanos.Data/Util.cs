namespace ByS.RHumanos.Data
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Configuration;
    using log4net;

    public static class Util
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Util));
        
        public static string ConexionBD()
        {
            string strCnxDB;

            try
            {
                strCnxDB = ConfigurationManager.ConnectionStrings["cnxByS"].ConnectionString;
            }
            catch (Exception ex)
            {
                log.Error(String.Concat("ConexionBD", " | ", ex.Message.ToString() + "\n StackTrace:\n" + ex.StackTrace));
                throw ex;
            }
            return strCnxDB;
        }
    }
}
