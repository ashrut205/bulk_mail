class BulkEmailMailer < ApplicationMailer
  def custom_email(to:, subject:, body:, pdf_attachment_path:, smtp_account:)
	  attachments[File.basename(pdf_attachment_path)] = File.read(pdf_attachment_path) if pdf_attachment_path.present?

	  mail(
	    to: to,
	    subject: subject,
	    delivery_method_options: smtp_account
	  ) do |format|
	    format.html { render html: body.html_safe }
	  end
	end
end
