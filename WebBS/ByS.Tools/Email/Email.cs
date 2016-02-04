namespace ByS.Tools
{
    using System;
    using System.Collections.Generic;
    using System.Dynamic;
    using System.Linq;
    using System.Net.Mail;

    public class Email
    {
        private SmtpClient client;
        private bool useSsl;

        private Email()
        {
            this.Message = new MailMessage();
            this.client = new SmtpClient();
        }

        public Email Attach(IList<Attachment> attachments)
        {
            foreach (Attachment attachment in from attachment in attachments
                                              where !this.Message.Attachments.Contains(attachment)
                                              select attachment)
            {
                this.Message.Attachments.Add(attachment);
            }
            return this;
        }

        public Email Attach(Attachment attachment)
        {
            if (!this.Message.Attachments.Contains(attachment))
            {
                this.Message.Attachments.Add(attachment);
            }
            return this;
        }

        public Email Attach(string fileUrl)
        {
            if (!string.IsNullOrEmpty(fileUrl))
            {
                Attachment attachment = new Attachment(fileUrl);
                if (!this.Message.Attachments.Contains(attachment))
                {
                    this.Message.Attachments.Add(attachment);
                }
            }
            return this;
        }

        public Email BCC(string emailAddress, string name = "")
        {
            if (!string.IsNullOrWhiteSpace(emailAddress))
            {
                if (emailAddress.Contains(";"))
                {
                    foreach (string str in emailAddress.Split(new char[] { ';' }))
                    {
                        this.Message.Bcc.Add(new MailAddress(str, name));
                    }
                }
                else
                {
                    this.Message.Bcc.Add(new MailAddress(emailAddress, name));
                }
            }
            return this;
        }

        public Email Body(string body, bool isHtml = true)
        {
            this.Message.Body = body;
            this.Message.IsBodyHtml = isHtml;
            return this;
        }

        public Email Cancel()
        {
            this.client.SendAsyncCancel();
            return this;
        }

        public Email CC(string emailAddress, string name = "")
        {
            if (!string.IsNullOrWhiteSpace(emailAddress))
            {
                if (emailAddress.Contains(";"))
                {
                    foreach (string str in emailAddress.Split(new char[] { ';' }))
                    {
                        this.Message.CC.Add(new MailAddress(str, name));
                    }
                }
                else
                {
                    this.Message.CC.Add(new MailAddress(emailAddress, name));
                }
            }
            return this;
        }

        public static Email From(string emailAddress, string name = "")
        {
            return new Email { Message = { From = new MailAddress(emailAddress, name) } };
        }

        public static Email FromDefault()
        {
            return new Email { Message = new MailMessage() };
        }

        public Email HighPriority()
        {
            this.Message.Priority = MailPriority.High;
            return this;
        }

        private void initializeRazorParser()
        {
            dynamic obj2 = new ExpandoObject();
            obj2.Dummy = "";
        }

        public Email LowPriority()
        {
            this.Message.Priority = MailPriority.Low;
            return this;
        }

        public Email ReplyTo(string address)
        {
            this.Message.ReplyToList.Add(new MailAddress(address));
            return this;
        }

        public Email ReplyTo(string address, string name)
        {
            this.Message.ReplyToList.Add(new MailAddress(address, name));
            return this;
        }

        public Email Send()
        {
            this.client.EnableSsl = this.useSsl;
            try {
                this.client.Send(this.Message);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            
            return this;
        }

        public Email SendAsync(SendCompletedEventHandler callback, object token = null)
        {
            this.client.EnableSsl = this.useSsl;
            this.client.SendCompleted += callback;
            this.client.SendAsync(this.Message, token);
            return this;
        }

        public Email Subject(string subject)
        {
            this.Message.Subject = subject;
            return this;
        }

        public Email To(IList<MailAddress> mailAddresses)
        {
            foreach (MailAddress address in mailAddresses)
            {
                this.Message.To.Add(address);
            }
            return this;
        }

        public Email To(string emailAddress)
        {
            if (!string.IsNullOrWhiteSpace(emailAddress))
            {
                if (emailAddress.Contains(";"))
                {
                    foreach (string str in emailAddress.Split(new char[] { ';' }))
                    {
                        this.Message.To.Add(new MailAddress(str));
                    }
                }
                else
                {
                    this.Message.To.Add(new MailAddress(emailAddress));
                }
            }
            return this;
        }

        public Email To(string emailAddress, string name)
        {
            if (emailAddress.Contains(";"))
            {
                string[] strArray = name.Split(new char[] { ';' });
                string[] strArray2 = emailAddress.Split(new char[] { ';' });
                for (int i = 0; i < strArray2.Length; i++)
                {
                    string displayName = string.Empty;
                    if ((strArray.Length - 1) >= i)
                    {
                        displayName = strArray[i];
                    }
                    this.Message.To.Add(new MailAddress(strArray2[i], displayName));
                }
            }
            else
            {
                this.Message.To.Add(new MailAddress(emailAddress, name));
            }
            return this;
        }

        public Email UseSSL()
        {
            this.useSsl = true;
            return this;
        }

        public Email UsingClient(SmtpClient client)
        {
            this.client = client;
            return this;
        }

  

        public Email UsingStringTemplateText(string contenido, bool isHtml = true)
        {
            this.initializeRazorParser();
            this.Message.Body = contenido;
            this.Message.IsBodyHtml = isHtml;
            return this;
        }

        public MailMessage Message { get; set; }
    }
}
