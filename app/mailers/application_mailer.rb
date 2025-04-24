class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@yourdomain.com"
  layout "mailer"

  def set_smtp_settings(smtp_account)
    mail.delivery_method.settings.merge!(smtp_account)
  end
end
