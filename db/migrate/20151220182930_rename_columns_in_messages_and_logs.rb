class RenameColumnsInMessagesAndLogs < ActiveRecord::Migration
  def change
    rename_column :messages, :to, :to_phone_number
    rename_column :messages, :from, :from_phone_number
    rename_column :message_logs, :to, :to_phone_number
    rename_column :message_logs, :from, :from_phone_number

  end
end
