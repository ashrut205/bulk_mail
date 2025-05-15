class AddSubjectToSentEmailLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :sent_email_logs, :subject, :string
  end
end
