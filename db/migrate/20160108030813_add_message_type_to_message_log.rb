class AddMessageTypeToMessageLog < ActiveRecord::Migration
  def change
    add_column :message_logs, :message_type, :string
  end
end
