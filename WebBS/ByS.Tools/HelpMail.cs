using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ByS.Tools
{
    public class HelpMail
    {
        public static string CrearCuerpo(string pTitulo, List<HelpMailDatos> pMailDatos, string pNota, string pEmpresa)
        {
            string body = ResourceIconos.Body.ToString();
            StringBuilder lsDatos = new StringBuilder();
            body = body.Replace("@titulo", pTitulo);
            body = body.Replace("@fecha", DateTime.Today.ToShortDateString());
            foreach (var item in pMailDatos)
            {
                if (item.titulo == "" || item.titulo == null)
                {
                    lsDatos.AppendLine("<tr><td colspan='2' >" + item.descripcion + "</td></tr>");

                }
                else
                {
                    lsDatos.AppendLine("<tr><td >" + item.titulo + "</td><td style='width:80%;'>" + item.descripcion + "</td></tr>");
                }
            }
            body = body.Replace("@datos", lsDatos.ToString());
            body = body.Replace("@nota", pNota);
            body = body.Replace("@empresa", pEmpresa);
            body = body.Replace("@anio", DateTime.Now.Year.ToString());
            return body;
        }

        /// <summary>
        ///Estos valores en el Config para su configuracion
        ///add key="CorreoDE" value="desarrollo@oxinet.com.pe" 
        ///add key="CredencialUser" value="desarrollo@oxinet.com.pe" 
        ///add key="CredencialPass" value="oxinet" 
        ///add key="Host" value="mail.oxinet.com.pe" 
        /// </summary>
        /// <param name="pSubject">Asunto</param>
        /// <param name="pBody">Cuerpo del mensaje</param>
        /// <param name="pEmail">Correo destino</param>
        public static void Enviar(string pSubject, string pBody, List<string> lstEmails, bool indEnvioOculto)
        {
            string strEMAIL_DeEnvio = ConfigurationManager.AppSettings["EMAIL_DeEnvio"].ToString();
            string strEMAIL_SSL = ConfigurationManager.AppSettings["EMAIL_SSL"].ToString();
            string strEMAIL_Server = ConfigurationManager.AppSettings["EMAIL_Server"].ToString();
            string strEMAIL_CredUsuario = ConfigurationManager.AppSettings["EMAIL_CredUsuario"].ToString();
            string strEMAIL_CredClave = ConfigurationManager.AppSettings["EMAIL_CredClave"].ToString();
            int strEMAIL_Puerto = Convert.ToInt32(ConfigurationManager.AppSettings["EMAIL_Puerto"].ToString());

            MailMessage correo = new MailMessage
            {
                From = new MailAddress(strEMAIL_DeEnvio, "Sistemas: Boticas & Salud", Encoding.UTF8),
                Subject = pSubject,
                SubjectEncoding = System.Text.Encoding.UTF8,
                Body = pBody,
                IsBodyHtml = true,
                Priority = System.Net.Mail.MailPriority.High,
            };
            foreach (string strCorreo in lstEmails)
            {
                if (indEnvioOculto)
                    correo.Bcc.Add(strCorreo);
                else
                    correo.To.Add(strCorreo);
            }
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient
            {
                Credentials = new NetworkCredential(strEMAIL_CredUsuario, strEMAIL_CredClave),
                //Port = strEMAIL_Puerto,
                Host = strEMAIL_Server,
                EnableSsl = (strEMAIL_SSL == "S" ? true : false),
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
            };
            try
            {
                smtp.Send(correo);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
            }
            correo = null;
        }

        public static bool EsEmailValido(String strEmail)
        {
            return Regex.IsMatch(strEmail, @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
        }
    }

    public class HelpMailDatos
    {
        public string titulo { get; set; }
        public string descripcion { get; set; }
    }

    public class HelpCrypto
    {
        public static string GenerarClaveUsuario()
        {
            string strClaveGenerada = string.Empty;
            Random objRanDom = new Random();
            for (int i = 1; i <= 6; ++i)
            {
                int strCaracter = objRanDom.Next(33, 90);
                strClaveGenerada = strClaveGenerada + Convert.ToChar(strCaracter).ToString();
            }

            return strClaveGenerada;
        }
    }
}
