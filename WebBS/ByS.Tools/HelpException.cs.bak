using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;

namespace ByS.Tools
{
    public static class HelpException
    {
        private static string TExcep = ConfigurationManager.AppSettings["Default_TipoException"];
        public static ReturnValor mTraerMensaje(Exception ex)
        {
            ReturnValor oReturn = new ReturnValor();
            switch (ex.GetType().FullName)
            {
                case "System.Data.SqlClient.SqlException":
                    oReturn = mSqlException(ex);
                    break;
                case "System.IO.DirectoryNotFoundException":
                    oReturn = mDirectoryNotFoundException(ex);
                    break;
                case "System.ApplicationException":
                    oReturn = mApplicationException(ex);
                    break;
                default:
                    oReturn = mException(ex);
                    break;
            }
            oReturn.Exitosa = false;
            return oReturn;
        }
        private static ReturnValor mSqlException(Exception ex)
        {

            ReturnValor oReturn = new ReturnValor();
            SqlException sqlex = (SqlException)ex;

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(sqlex.GetType().FullName);
            sb.AppendLine("Error Number: " + sqlex.Number.ToString());
            sb.AppendLine("Source SQL: " + sqlex.Source);
            sb.AppendLine("Server: " + sqlex.Server);
            sb.AppendLine("Procedure: " + sqlex.Procedure);
            sb.AppendLine("LineNumber: " + sqlex.LineNumber.ToString());
            sb.AppendLine(sqlex.Message.ToString());
            if (TExcep == "USER")
            {
                oReturn.Message = HelpMessages.ResourceManager.GetString(sqlex.Number.ToString());
                if (string.IsNullOrEmpty(oReturn.Message))
                    oReturn.Message = ex.Message.ToString();
            }
            else if (TExcep == "ADMIN")
                oReturn.Message = sb.ToString();
            return oReturn;
        }

        private static ReturnValor mDirectoryNotFoundException(Exception ex)
        {

            ReturnValor oReturn = new ReturnValor();
            System.IO.DirectoryNotFoundException ioex = (System.IO.DirectoryNotFoundException)ex;

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(ioex.GetType().FullName);
            sb.AppendLine("Error Number: " + ioex.GetHashCode().ToString());
            sb.AppendLine("Source IO: " + ioex.Source);
            sb.AppendLine("StackTrace: " + ioex.StackTrace.ToString());
            sb.AppendLine(ioex.Message.ToString());

            if (TExcep == "USER")
            {
                oReturn.Message = HelpMessages.ResourceManager.GetString(ioex.GetHashCode().ToString());
                if (string.IsNullOrEmpty(oReturn.Message))
                    oReturn.Message = sb.ToString();
            }
            else if (TExcep == "ADMIN")
                oReturn.Message = sb.ToString();

            return oReturn;
        }

        private static ReturnValor mException(Exception ex)
        {
            ReturnValor oReturn = new ReturnValor();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(ex.GetType().FullName);
            sb.AppendLine("Error Number: " + ex.GetHashCode().ToString());
            sb.AppendLine("Source GEN: " + ex.Source);
            sb.AppendLine("StackTrace: " + ex.StackTrace.ToString());
            sb.AppendLine(ex.Message.ToString());

            if (TExcep == "USER")
            {
                oReturn.Message = HelpMessages.ResourceManager.GetString(ex.GetHashCode().ToString());
                if (string.IsNullOrEmpty(oReturn.Message))
                    oReturn.Message = ex.Message.ToString();
            }
            else if (TExcep == "ADMIN")
                oReturn.Message = sb.ToString();
         
            return oReturn;
        }

        private static ReturnValor mApplicationException(Exception ex)
        {
            ReturnValor oReturn = new ReturnValor();
            oReturn.Message = ex.Message;
            return oReturn;

        }
    }
}
