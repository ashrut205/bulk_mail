class CreateSentEmailLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :sent_email_logs do |t|
      t.references :email, null: false, foreign_key: true
      t.string :recipient
      t.string :smtp_email

      t.timestamps
    end
  end
end
