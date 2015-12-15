class RenameGroupsMessagesColumns < ActiveRecord::Migration
  def change
    rename_column :groups_messages, :groups_id, :group_id
    rename_column :groups_messages, :messages_id, :message_id
  end
end
