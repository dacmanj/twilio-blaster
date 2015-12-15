class CreateMessageLogs < ActiveRecord::Migration
  def change
    create_table :message_logs do |t|
      t.string :to
      t.string :from
      t.string :status
      t.string :sid
      t.string :error_code
      t.string :error_message
      t.datetime :date_sent
      t.string :account_sid
      t.string :billing_reference
      t.belongs_to :message, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
