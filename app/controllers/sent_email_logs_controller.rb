class SentEmailLogsController < ApplicationController
  before_action :require_login

  def index
    @smtp_emails = SentEmailLog.distinct.pluck(:smtp_email)
    @selected_smtp_email = params[:smtp_email] || @smtp_emails.first

    @logs = SentEmailLog.where(smtp_email: @selected_smtp_email)
                        .includes(:email)
                        .order(created_at: :desc)
                        .page(params[:page])
                        .per(10) # optional: add pagination or limit
  end
end
