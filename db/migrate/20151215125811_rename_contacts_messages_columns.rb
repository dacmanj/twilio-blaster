class RenameContactsMessagesColumns < ActiveRecord::Migration
  def change
    rename_column :contacts_messages, :contacts_id, :contact_id
    rename_column :contacts_messages, :messages_id, :message_id
  end
end
