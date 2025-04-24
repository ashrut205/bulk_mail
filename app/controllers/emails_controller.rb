class EmailsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @email = Email.new
  end

  def create
    @recipients = params[:recipients].split(",").map(&:strip).reject(&:blank?)
    @email = Email.new(email_params)

    if @email.save
      @recipients.each_with_index do |recipient, index|
        smtp = SMTP_ACCOUNTS[index % SMTP_ACCOUNTS.size]

        pdf_file_path = @email.pdf.path

        BulkEmailMailer.custom_email(
          to: recipient,
          subject: @email.subject,
          body: @email.body,
          pdf_attachment_path: pdf_file_path,
          smtp_account: smtp
        ).deliver_later
      end
      redirect_to new_email_path, notice: "✅ Emails sent to #{@recipients.size} recipients!"
    else
      render :new
    end
  end


  private

  def email_params
    params.require(:email).permit(:subject, :body, :pdf, :recipients)
  end
end
